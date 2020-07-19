use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( file_exists );

BEGIN {
  plan(tests => 3);
}

my $filepath = 'tests_data/NonExistent.log';
ok !file_exists( { filepath=>$filepath } ), "file $filepath does not exists";

$filepath = 'tests_data/Master.log';
ok !file_exists( { filepath=>$filepath } ), "file $filepath exists but it is empty";

$filepath = 'tests_data/Caves.log';
ok file_exists( { filepath=>$filepath } ), "file $filepath exists";
