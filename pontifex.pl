#!/usr/bin/perl -s
use strict;
use warnings;

my $usage = <<USAGE;
usage:
 ./pontifex.pl [-d] <key> <input_file>
 or inputcommand | ./pontifex.pl [-d] <key>

 -d means decrypt
USAGE
if ( -t STDIN and not @ARGV ) {
    die $usage;
}

my ($d, $v) = ($::d, $::v); # get -d option, or verbose
my $encrypt_decrypt = $::d ? -1 : 1;
my $deck = pack('C*',33..86); # define a deck ending with UV (the jokers);
my $key = shift;
die "Must provide a key" if not $key;
$key =~ y/a-z/A-Z/;

# deck 'joker' swap functions
# swap things after U, except for the top of the deck (spot 0);
my $U = '$deck=~s/(.*)U$/U$1/;$deck=~s/U(.)/$1U/;';
(my $V=$U) =~ s/U/V/g;

my $pointer;
# setup the deck according to the input key
$key =~ s/[A-Z]/$pointer=ord($&)-64,&execute/eg;
$pointer = 0; # reset the pointer

# read plaintext or cyphertext from stdin
my $data;
while(<>){
    # force uppercase, only get letters, ignore spaces/punctuation
    y/a-z/A-Z/;
    y/A-Z//dc;
    $data .= $_;
}
# pad the input with X's so that it is in blocks of 5
# (also X does not exist in our deck)
$data .= 'X' while length($data) % 5 && !$d;
print "input: $data\n" if $::v;

$data =~ s/./chr(($encrypt_decrypt*&execute+ord($&)-13)%26+65)/eg;
$data =~ s/X*$/ / if $d; # remove trailing X's if we decrypted
$data =~ s/.{5}/$& /g; # print out data in blocks of 5
print "$data\n";

sub getCardinalValueAt {
    my $val = ord(substr($deck,$_[0])) - 32;
    $val > 53 ? 53 : $val # jokers [UV] are both 53
}

sub pivot { 
    $deck =~ s/(.{$_[0]})(.*)(.)/$2$1$3/
}

sub execute {
    # do a triple cut?
    eval "$U$V$V";
    # move the joker if UV are next to each other
    $deck =~ s/(.*)([UV].*[UV])(.*)/$3$2$1/;
    &pivot(&getCardinalValueAt(53)); #pivot at the end of the deck
    my $current;
    my $ret = $pointer #if pointer is defined and greater than 0?
	 ? (&pivot($pointer)) 
	 : ( $current = &getCardinalValueAt(
		 &getCardinalValueAt(0)
	     ), $current > 52 ? &execute : $current
	 );
    return $ret;
}
