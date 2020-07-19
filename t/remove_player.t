use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( remove_player );

BEGIN {
  plan(tests => 4);
}

my $player = 99;
my @players = (99, 1);
@players = remove_player( { player=>$player, players=>\@players } );
is @players, 1, "$player is not in @players anymore";

@players = (1, 99);
@players = remove_player( { player=>$player, players=>\@players } );
is @players, 1, "$player is not in @players anymore";

@players = (1, 98, 0, 2, 99, 9);
@players = remove_player( { player=>$player, players=>\@players } );
is @players, 5, "$player is not in @players anymore";

@players = (1, 98, 0, 2, 95, 9, 3, 92, 6, 8, 92, 87, 99, 44, 31);
@players = remove_player( { player=>$player, players=>\@players } );
is @players, 14, "$player is not in @players anymore";
