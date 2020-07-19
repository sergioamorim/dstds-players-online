use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( player_index );

BEGIN {
  plan(tests => 4);
}

my $player = 99;
my @players = (99, 1);
ok !player_index( { player=>$player, players=>\@players } ), "$player index is zero";

@players = (1, 99);
is player_index( { player=>$player, players=>\@players } ), 1, "$player index is one";

@players = (1, 98, 0, 2, 99, 9);
is player_index( { player=>$player, players=>\@players } ), 4, "$player index is four";

@players = (1, 98, 0, 2, 95, 9, 3, 92, 6, 8, 92, 87, 99, 44, 31);
is player_index( { player=>$player, players=>\@players } ), 12, "$player index is twelve";
