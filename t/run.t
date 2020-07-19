use warnings;
use strict;
use Test::More;
use Mock::Sub;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( run logs_dir );

BEGIN {
  plan(tests => 2);
}

my $mock = Mock::Sub->new;
my $online_players = $mock->mock('DSTDSPlayersOnline::online_players');
my $logs_dir_exists = $mock->mock('DSTDSPlayersOnline::logs_dir_exists');
$logs_dir_exists->return_value(1);

run( { server=>57, logs_dir=>65 } );

is $online_players->called, 1, "online_players was called once";
is $logs_dir_exists->called, 1, "logs_dir_exists was called once";
