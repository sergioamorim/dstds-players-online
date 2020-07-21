use warnings;
use strict;

use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( is_shutting_down );

BEGIN {
  plan(tests => 5);
}

my $log_line = '[15:00:11]: Received (KU_d4ddm9-w) from TokenPurpose';
ok !is_shutting_down( { log_line=>$log_line } ), "$log_line is not shutting down";

$log_line = "[00:05:32]: [Steam] Authenticated host '76561198125299762'";
ok !is_shutting_down( { log_line=>$log_line } ), "$log_line is not shutting down";

$log_line = "[00:05:51]: [Steam] SendUserDisconnect for '76561198125299762'";
ok !is_shutting_down( { log_line=>$log_line } ), "$log_line is not shutting down";

$log_line = '[00:00:00]: Starting Up';
ok !is_shutting_down( { log_line=>$log_line } ), "$log_line is not shutting down";

$log_line = '[00:05:33]: [Shard] Stopping shard mode';
ok is_shutting_down( { log_line=>$log_line } ), "$log_line is shutting down";
