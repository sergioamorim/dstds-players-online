use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( contains_player );

BEGIN {
  plan(tests => 8);
}


my $player = 99;
my @players = (1);
ok !contains_player( { player=>$player, players=>\@players } ), "empty list does not contains $player";

@players = (1);
ok !contains_player( { player=>$player, players=>\@players } ), "@players does not contains $player";

@players = (1, 2);
ok !contains_player( { player=>$player, players=>\@players } ), "@players does not contains $player";

@players = (99);
ok contains_player( { player=>$player, players=>\@players } ), "@players contains $player";

@players = (99, 2);
ok contains_player( { player=>$player, players=>\@players } ), "@players contains $player";

@players = (3, 99);
ok contains_player( { player=>$player, players=>\@players } ), "@players contains $player";

@players = (1, 99, 9);
ok contains_player( { player=>$player, players=>\@players } ), "@players contains $player";

@players = (1, 2, 3, 4, 5, 6, 7, 8, 9, 99, 11);
ok contains_player( { player=>$player, players=>\@players } ), "@players contains $player";
