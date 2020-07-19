use warnings;
use strict;
use Test::More;
use Test::Exception;
use Mock::Sub;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( run logs_dir );

BEGIN {
  plan(tests => 7);
}

my $mock = Mock::Sub->new;
my $online_players = $mock->mock('DSTDSPlayersOnline::online_players');
my $logs_dir_exists = $mock->mock('DSTDSPlayersOnline::logs_dir_exists');

$logs_dir_exists->return_value(0);
dies_ok { run( { server=>57, logs_dir=>65 } ) } 'run dies if logs directory does not exists';
ok !$online_players->called, "online_players was called once";
ok $logs_dir_exists->called, "logs_dir_exists was called once";

$logs_dir_exists->return_value(1);
run( { server=>57, logs_dir=>65 } );
ok $online_players->called, "online_players was called once";
ok $logs_dir_exists->called, "logs_dir_exists was called once";

$online_players->return_value((43));
run( { server=>57, logs_dir=>65 } );
ok $online_players->called, "online_players was called once";
ok $logs_dir_exists->called, "logs_dir_exists was called once";
