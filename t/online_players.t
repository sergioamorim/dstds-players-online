use warnings;
use strict;
use Test::More;
use Mock::Sub;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( online_players );

BEGIN {
  plan(tests => 3);
}

my $mock = Mock::Sub->new;

my $file_exists = $mock->mock('DSTDSPlayersOnline::file_exists');
$file_exists->return_value(0);
my $server = 'NonExistent';
ok !online_players( { server=>$server } ), 'log file for $server does not exists';


$file_exists->return_value(1);
my $find_players = $mock->mock('DSTDSPlayersOnline::find_players');

$find_players->return_value(0);
$server = 'Caves';
ok !online_players( { server=>$server } ), "no players online on $server";

my @players = (76561198012345678, 76561198123456789);
$find_players->return_value(@players);
$server = 'Master';
is online_players( { server=>$server } ), @players, "players online on $server: @players";
