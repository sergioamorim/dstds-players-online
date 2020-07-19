use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( find_players );

BEGIN {
  plan(tests => 6);
}

my $server = 'Caves';
ok !find_players( { server=>$server } ), "no players online on $server";

my @players = (76561198012345678, 76561198123456789);
$server = 'Master';
is find_players( { server=>$server } ), @players, "players online on $server: @players";

@players = (76561198012345678, 76561198123456789);
$server = 'Test0';
is find_players( { server=>$server } ), @players, "players online on $server: @players";

@players = (76561198123456789);
$server = 'Test1';
is find_players( { server=>$server } ), @players, "players online on $server: @players";

$server = 'Test2';
ok !find_players( { server=>$server } ), "no players online on $server";

$server = 'Test3';
ok !find_players( { server=>$server } ), "no players online on $server";
