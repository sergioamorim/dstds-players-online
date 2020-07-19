use strict;
use warnings;
use Test::More;
use Mock::Sub;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( log_file_exists );

BEGIN {
  plan(tests => 3);
}

my $mock = Mock::Sub->new;
my $file_exists = $mock->mock('DSTDSPlayersOnline::file_exists');
my $make_log_filepath = $mock->mock('DSTDSPlayersOnline::make_log_filepath');

my $server = 'NonExistent';
$file_exists->return_value(0);
ok !log_file_exists( { server=> $server } ), "log file for $server does not exists";
ok $make_log_filepath->called, "make_log_filepath called";

$server = 'Master';
$file_exists->return_value(1);
ok log_file_exists( { server=> $server } ), "log file for $server exists";
