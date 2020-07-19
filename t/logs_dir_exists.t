use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( logs_dir_exists logs_dir );

BEGIN {
  plan(tests => 2);
}

my $logs_dir = 'non/existent/path';
ok !logs_dir_exists( { logs_dir=>$logs_dir } ), "the directory $logs_dir does not exists";

$logs_dir = logs_dir();
ok logs_dir_exists( { logs_dir=>$logs_dir } ), "the directory $logs_dir exists";
