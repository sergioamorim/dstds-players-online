use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( find_players );

BEGIN {
  plan(tests => 7);
}

# this set of tests involves integration and various subroutines are not mocked
# the data for each server tested must be in test_data/dst_server_<server>_screenlog.log
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

$server = 'Test4';
ok !find_players( { server=>$server } ), "no players online on $server";
