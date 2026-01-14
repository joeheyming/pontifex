#!/usr/bin/perl
# ═══════════════════════════════════════════════════════════════════════════
#
#   T̷͈̓ H̸̰̄ E̵̗͐   R̷̨̈́ I̵̬̔ T̶̗̈ E̸̥͠ S̷̱̈́   O̴̧̓ F̷̣̈́   P̶̣̈ O̴̗͝ N̴̰̈́ T̵͔͝ I̴̗̓ F̵̨̛ E̷̝͐ X̴̣̌
#
#   "He had learned that a machine, simple in its design, 
#    could produce results of infinite complexity."
#
#                    ą̷̛̛̻̝̪̱̟̙̗̲̠̥̼̖̌͌͐̊͑̀̓̆͂̚̕͝ṃ̴̨̧̻͖̤̭̩̹͙̩̦̈́̓̅̑̄̈́̿̚͜ȩ̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅn̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝
#
# ═══════════════════════════════════════════════════════════════════════════

use strict;
use warnings;
use Test::More;

my $PONTIFEX = './pontifex.pl';

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   First, we must verify the bridge exists                               │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

ok(-x $PONTIFEX, 'the bridge stands');

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̸̨̺h̷̘̾e̵̟͝ ̸̣̈́S̷̰̈a̷̗͊c̶̣̓r̴͙̈́e̴̗͒d̷̨̛ ̵͕̀T̶̰͝e̸̱͐x̷̣̌t̷̨̆s̸͓̈́                                                      │
# │                                                                         │
# │   These are the known truths, inscribed in the appendix                 │
# │   of the Cryptonomicon. They must remain eternal.                       │
# │                                                                         │
# │              t̵̰̀h̷̰̆ë̴͇́ ̵̧̛c̷̣̈́ą̴̛r̴̗̈́d̴̨̚s̷̰̈́ ̷̣̓r̴̨̈́ë̷̝m̵̰̌ë̷̥m̸̗̌b̸̧̛e̵̱̓r̷̰̈́                                │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'the appendix speaks truth' => sub {
    # As written in the book, so shall it be
    my $cipher = `echo 'solitaire' | $PONTIFEX cryptonomicon`;
    chomp $cipher;
    is($cipher, 'KIRAK SFJAN ', 'solitaire becomes kirak sfjan');
    
    # What is hidden shall be revealed
    my $plain = `echo 'kirak sfjan' | $PONTIFEX -d cryptonomicon`;
    chomp $plain;
    is($plain, 'SOLIT AIRE  ', 'kirak sfjan returns to solitaire');
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̶̗̾h̷͙̓e̸̥͝ ̷̣̈́L̵̨̛a̷̗͊w̴̰̌ ̵̧̛o̸̱͐f̷̣̓ ̸̨̈́R̴̝̈́e̵̗̓v̷̰̈́e̴̥̚ṛ̷̌s̸̨̛ḭ̵̓b̶̧̛i̷̱͐l̴̨̛ị̷̓t̸̰̆y̵̗̌                                              │
# │                                                                         │
# │   That which is concealed must be revealed.                             │
# │   That which is revealed must be concealed.                             │
# │   T̷̨̛h̸̰̄e̵̗͐ ̶̣̈c̷̱̓y̴̧͝c̵̰̈́ľ̸̗e̷̥͐ ̴̣̓į̵̛s̸̰̈́ ̷̗̌u̶̧͝n̵̰̈́ḇ̸̓ṛ̷̈́o̴̗̚k̵̨̛ḛ̸͐ň̷̥.                                                │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'the cycle is unbroken' => sub {
    my @mantras = (
        'AAAAA',                          # the void
        'DONOTUSE PC',                    # the warning
        'THECARDSKNOW',                   # the truth
        'TRUSTNOONE',                     # the wisdom
        'FIFTYTWOCARDS ANDTWOJOKERS',     # the count
    );
    
    for my $mantra (@mantras) {
        my $key = 'ENOCHROOT';
        my $concealed = `echo '$mantra' | $PONTIFEX $key`;
        chomp $concealed;
        my $revealed = `echo '$concealed' | $PONTIFEX -d $key`;
        chomp $revealed;
        
        # Strip all spaces, compare the essence
        (my $revealed_core = $revealed) =~ s/\s//g;
        (my $mantra_core = $mantra) =~ s/\s//g;
        
        # Padding X's are the void between
        $revealed_core =~ s/X+$//;
        
        is($revealed_core, $mantra_core, "what is concealed is revealed: $mantra");
    }
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̵̰̾h̸̗̄ȇ̷͙ ̶̣̈́D̴̨̛ë̷̥t̵̰̓ẹ̶͐ŗ̷̈́m̸̗̌ị̵̓n̶̰̈́ị̷̓ş̸͝m̵̗̌ ̶̰̄Ṣ̷̈́ȕ̸̥t̵̰̓r̷̨̈́ą̴̛                                                 │
# │                                                                         │
# │   The same key, applied to the same plaintext,                          │
# │   produces the same ciphertext. A̵̧͝l̸̰̈́w̷̗̌ḁ̶̈y̵̨̛s̸̱̓.                                 │
# │   This is the nature of the universe.                                   │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'the universe is deterministic' => sub {
    my $message = 'THESAM ERIVER TWICE';
    my $key = 'HERACLITUS';
    
    my @results;
    for (1..3) {
        my $result = `echo '$message' | $PONTIFEX $key`;
        chomp $result;
        push @results, $result;
    }
    
    is($results[0], $results[1], 'first stepping yields second stepping');
    is($results[1], $results[2], 'second stepping yields third stepping');
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̵̗̾h̸̰̄e̵̱͐ ̷̣̈́K̶̨̛e̷̥͝y̴̗̌ ̸̧̛C̷̰̓ḥ̴̓ą̵̈́n̶̗͝g̷̰̈́ė̸̥s̵̨̛ ̷̱̌E̶̗͐v̷̰̈́ẹ̴̓ṟ̸̈́y̵̧͝ť̷̗h̶̰̄ị̷̓n̵̥̈́g̸̨̛                                            │
# │                                                                         │
# │   A single letter, added or removed,                                    │
# │   transforms the output utterly.                                        │
# │   T̸͇̓ȟ̵̗ȇ̷̥ ̴̣̈́b̵̰̌u̶̧͝ť̷̗t̸̰̓e̵̥͐r̴̨̈́f̷̱̓ḷ̵̈́y̸̗͝ ̶̰̄e̷̥͐f̴̧̛f̸̗̓ḛ̵͝c̶̣̈́t̷̨̛ ̴̱̌ḭ̵̓n̸̗̈́ ̷̣͐5̴̥͝4̵̧̛ ̶̰̄c̷̗̓ą̸̈́ṛ̵͐d̴̰̈́š̸̥.                                     │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'the butterfly stirs' => sub {
    my $message = 'SMALL CHANG ESMAT TER';
    
    my $result_a = `echo '$message' | $PONTIFEX BUTTERFLY`;
    my $result_b = `echo '$message' | $PONTIFEX BUTTERFLYA`;
    
    chomp $result_a;
    chomp $result_b;
    
    isnt($result_a, $result_b, 'a single letter transforms all');
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̷̰̾h̸̗̄ë̵͙́ ̶̣̈́P̴̨̛ą̷̈́d̵̰̓d̶̥͐ị̷̈́n̸̗̈́ǧ̵̰ ̶̧̛Ẉ̷̓ị̸̈́ş̵͝d̴̗̓ǫ̶̈́m̷̰̌                                                    │
# │                                                                         │
# │   X̴̧̛ marks the absence.                                                  │
# │   Messages are extended to groups of five.                              │
# │   Ë̸̥́m̵̰̌p̷̨̛t̶̗̓ị̷̈́n̸̰̈́ẹ̴̓ş̵͝ş̶̈́ ̷̣̓b̵̗̌ë̸͙́c̶̰̓ǫ̵̈́m̷̥̌ę̸̛ş̵̈́ ̶̗̓f̷̰̈́ǫ̴̛r̵̨̈́m̸̱̌.                                               │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'emptiness becomes form' => sub {
    my $key = 'PADDING';
    
    # A message of 1 becomes a message of 5
    my $short = `echo 'A' | $PONTIFEX $key`;
    chomp $short;
    like($short, qr/^[A-Z]{5} $/, 'one becomes five');
    
    # A message of 6 becomes a message of 10
    my $longer = `echo 'ABCDEF' | $PONTIFEX $key`;
    chomp $longer;
    like($longer, qr/^[A-Z]{5} [A-Z]{5} $/, 'six becomes ten');
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̷̰̾h̸̗̄ë̵͙́ ̶̣̈́C̴̨̛ą̷̈́ş̵̓ę̶͐ ̷̥̈́K̵̗̓ǫ̸̈́ą̵͝ň̴̰                                                         │
# │                                                                         │
# │   Upper and lower, they are the same.                                   │
# │   The cipher sees no distinction.                                       │
# │   A̸̧͝l̵̰̈́ľ̶̗ ̷̨̛ị̸̓ş̵̈́ ̶̣̓ḛ̷͐l̴̥̈́ë̵̗v̶̰̓ą̷̈́t̸̨̛ë̵̱́d̶̗̈́.                                                      │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

subtest 'case is illusion' => sub {
    my $key = 'CASELESS';
    
    my $upper = `echo 'HELLO' | $PONTIFEX $key`;
    my $lower = `echo 'hello' | $PONTIFEX $key`;
    my $mixed = `echo 'HeLLo' | $PONTIFEX $key`;
    
    chomp($upper, $lower, $mixed);
    
    is($lower, $upper, 'lower rises to upper');
    is($mixed, $upper, 'mixed finds unity');
};

# ┌─────────────────────────────────────────────────────────────────────────┐
# │                                                                         │
# │   T̶̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ḩ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚ȩ̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅ ̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝F̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̿̊͌͐̊͑̀̓̆͂̚̕͝ĩ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚n̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅa̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝l̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚M̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅë̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝d̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ĩ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚t̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅą̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝t̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ĩ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚ǫ̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅn̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝                                  │
# │                                                                         │
# │   "It is elegant, is it not?"                                           │
# │                                                                         │
# │          ṱ̶̢̧̛̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝h̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ȩ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚ ̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅc̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝ą̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ŗ̵̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚d̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅs̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝ ̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ḩ̵̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚a̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅv̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝ȩ̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ ̵̧̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚s̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅp̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝ǫ̷̨̛͓̝̗̱̟̙̲̠̥̼̖̻̪̿̊͌͐̊͑̀̓̆͂̚̕͝ķ̵̛̻͖̤̭̩̹͙̩̦̯͇̈́̓̅̑̄̈́̿̚ȩ̸̡̨̯͇̹͉͈̤̤̹̐̑̂̃͐͒͆̆͘͜͝ͅn̴̢̧̛̪̥͚͙̹̗̘͚̳̜̿̊͊̀̓̏͂̚͜͝                      │
# │                                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

done_testing();

# ═══════════════════════════════════════════════════════════════════════════
#
#      "P̷̨̛͓̝̗̿̊͌͐ơ̵̧̻͖̤̈́̓̅̑n̸̡̨̯͇̹̐̑̂̃t̴̢̧̛̪̥̿̊͊̀į̷̛͓̝̗̿̊͌͐f̵̧̛̻͖̤̈́̓̅̑ȩ̸̡̨̯͇̐̑̂̃x̴̢̧̛̪̥̿̊͊̀ is a nice word... 
#       the literal meaning is 'b̷̨̛͓̝̗̿̊͌͐ŗ̵̛̻͖̤̈́̓̅̑ị̸̡̨̯͇̐̑̂̃d̴̢̧̛̪̥̿̊͊̀ǵ̷̨̛͓̝̗̊͌͐ę̵̧̛̻͖̈́̓̅̑ ̸̡̨̯͇̹̐̑̂̃b̴̢̧̛̪̥̿̊͊̀ų̷̛̣͓̝̿̊͌͐ĩ̵̧̛̻͖̈́̓̅̑ľ̸̡̨̯͇̹̑̂̃d̴̢̧̛̪̥̿̊͊̀ȩ̷̨̛͓̝̿̊͌͐ŗ̵̛̻͖̤̈́̓̅̑.'"
#
#                   ∴ s̷̨̛͓̿̊͌ơ̵̧̻̈́̓̅ ̸̡̨̯̐̑̂m̴̢̧̛̿̊͊ǫ̷̛͓̿̊͌ţ̵̛̻̈́̓̅ę̸̡̨̐̑̂ ̴̢̧̛̿̊͊į̷̛̣̿̊͌ţ̵̛̻̈́̓̅ ̸̡̨̯̐̑̂b̴̢̧̛̿̊͊ȩ̷̨̛̿̊͌ ∴
#
# ═══════════════════════════════════════════════════════════════════════════

