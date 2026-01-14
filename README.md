pontifex
========

A refactored implementation of the Pontifex cipher from Neal Stephenson's novel *Cryptonomicon* (1999).

## About

Pontifex (also known as "Solitaire") is a cryptographic algorithm designed by [Bruce Schneier](https://en.wikipedia.org/wiki/Bruce_Schneier) specifically for the novel. It's a hand cipher that uses a deck of playing cards as its key, making it possible to encrypt and decrypt messages without any electronic devices—perfect for spies, paranoids, and cryptography enthusiasts.

The cipher appears throughout *Cryptonomicon*, used by characters to communicate securely. Schneier designed it to be genuinely secure while remaining simple enough to perform by hand with just a deck of cards.

## Quotes from the novel

> "It's so simple," Randy says.
>
> "It is elegant, is it not?" Enoch replies.

> "...simple, elegant, and completely unbreakable."

> "Pontifex is a nice word... It sounds like something from the NSA, does it not? But the literal meaning of the word is 'bridge builder.'"

> "He had learned that a machine, simple in its design, could produce results of infinite complexity."

## Usage

Results match the appendix of the book:

```bash
$ echo 'solitaire' | ./pontifex.pl cryptonomicon
KIRAK SFJAN 

$ echo 'kirak sfjan' | ./pontifex.pl -d cryptonomicon
SOLIT AIRE  
```

---

## 🤓 Deeply Unnecessary Technical Analysis

### Complexity Analysis

| Operation | Time | Space |
|-----------|------|-------|
| Key setup | O(k) | O(1) |
| Per character | O(1) amortized | O(1) |
| Total encryption | O(k + m) | O(m) |

Where `k` = key length, `m` = message length.

**The pedantic version:** Each `execute()` call performs regex substitutions on the 54-card deck. Technically O(n) per operation where n=54, but since a deck is *always* 54 cards, this is O(1) by the "constants don't matter" doctrine that algorithms professors invoke when convenient.

**Space:** The deck is stored as a 54-byte packed string (`pack('C*',33..86)`). ASCII characters `!` through `V` represent cards 1-52, with `U` and `V` as jokers. Total memory footprint: ~54 bytes for deck + O(m) for message buffer. Your smartwatch has more RAM than this cipher needs.

**The recursion trap:** `execute()` can recurse when a joker appears as the output card (line 71: `$current > 52 ? &execute : $current`). Worst case? Theoretically unbounded, but statistically you'd need to be *phenomenally* unlucky. Expected recursion depth ≈ 1.04 calls per character.

### 🔐 Security Analysis (Tinfoil Hat Edition)

**The Good:**
- **Keyspace:** 54! ≈ 2²²⁶ possible deck configurations. That's more than the number of atoms in the observable universe (≈2²⁶⁵... okay, it's fewer, but still incomprehensibly large)
- **No electronics required:** Can't be detected by RF sweeps, leaves no digital forensics, survives EMP
- **Plausible deniability:** It's just a deck of cards, officer

**The Bad:**
- **Key derivation is cursed:** The passphrase→deck transformation processes characters sequentially (line 30). Early characters have less influence on final deck state than later ones. `AAAAAB` and `AAAAAC` produce more similar decks than `BAAAAA` and `CAAAAA`
- **Deterministic:** Same key + same plaintext = same ciphertext. Always. No IV, no nonce, no salt. Frequency analysis is theoretically possible on large corpuses
- **Padding oracle:** Messages are padded with `X` to 5-character blocks. An attacker knows your message length mod 5

**The Paranoid:**
- **Timing side-channel:** The recursive `execute()` creates variable-time encryption. A sufficiently motivated attacker with a very precise clock could theoretically extract information about your deck state
- **Perl interpreter state:** Regex operations leave breadcrumbs in perl's internal memory. The `$&` match variable, compiled regex caches, string temporaries—your plaintext echoes in RAM
- **Joker position leak:** If encryption is suspiciously fast, the jokers might be near the top of the deck (fewer operations needed). This reveals ~2 bits of key state per suspiciously-fast character
- **Cosmic ray bit flips:** A single bit flip in your deck representation corrupts all subsequent output. Consider lead shielding

**Bruce Schneier's own assessment:** He designed it to be "secure against all but the most well-funded military cryptanalysis organizations." So, y'know, you're probably fine unless you've angered the NSA specifically.

### 🃏 The Deck Representation

```
Position:  0  1  2  3  4  ... 51 52 53
ASCII:     !  "  #  $  %  ... R  U  V
Card:      A♣ 2♣ 3♣ 4♣ 5♣ ... K♠ 🃏A 🃏B
Value:     1  2  3  4  5  ... 52 53 53
```

The jokers (`U` and `V`) both evaluate to 53, maintaining the mathematical properties Schneier specified while fitting in a printable ASCII range. It's elegant, in the same way that storing booleans as the strings "true" and "false" is elegant (it isn't, but it works).

### 📜 Running the Tests

```bash
prove -v t/pontifex.t
```

The tests are... *atmospheric*. You have been warned.
