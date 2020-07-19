use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( starting_up );

BEGIN {
  plan(tests => 4);
}

my $log_line = '[15:00:11]: Received (KU_d4ddm9-w) from TokenPurpose';
ok !starting_up( { log_line=>$log_line } ), "$log_line does not have starting up";

$log_line = "[00:05:32]: [Steam] Authenticated host '76561198125299762'";
ok !starting_up( { log_line=>$log_line } ), "$log_line does not have starting up";

$log_line = "[00:05:51]: [Steam] SendUserDisconnect for '76561198125299762'";
ok !starting_up( { log_line=>$log_line } ), "$log_line does not have starting up";

$log_line = '[00:00:00]: Starting Up';
ok starting_up( { log_line=>$log_line } ), "log line has starting up";
