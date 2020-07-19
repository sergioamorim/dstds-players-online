use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( make_log_filepath logs_dir );
my $logs_dir = logs_dir();

BEGIN {
  plan(tests => 2);
}

my $server = 'NonExistent';
is
  make_log_filepath( { server=> $server } ),
  "${logs_dir}/dst_server_${server}_screenlog.log",
  "log filepath is ${logs_dir}/dst_server_${server}_screenlog.log"
;

$server = 'Master';
is
  make_log_filepath( { server=> $server } ),
  "${logs_dir}/dst_server_${server}_screenlog.log",
  "log filepath is ${logs_dir}/dst_server_${server}_screenlog.log"
;
