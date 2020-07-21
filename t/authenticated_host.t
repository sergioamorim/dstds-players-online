use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( authenticated_host );

BEGIN {
  plan(tests => 5);
}

my $log_line = '[15:00:11]: Received (KU_d4ddm9-w) from TokenPurpose';
ok !authenticated_host( { log_line=>$log_line } ), "$log_line does not have host authentication";

$log_line = "[00:05:51]: [Steam] SendUserDisconnect for '76561198125299762'";
ok !authenticated_host( { log_line=>$log_line } ), "$log_line does not have host authentication";

$log_line = '[00:05:33]: [Shard] Stopping shard mode';
ok !authenticated_host( { log_line=>$log_line } ), "$log_line does not have host authentication";

my $steam_id = '76561198012345678';
$log_line = "[00:05:32]: [Steam] Authenticated host '$steam_id'";
is authenticated_host( { log_line=>$log_line } ), $steam_id, "log line has host authentication for $steam_id";

$steam_id = '76561198123456789';
$log_line = "[00:05:33]: [Steam] Authenticated host '$steam_id'";
is authenticated_host( { log_line=>$log_line } ), $steam_id, "log line has host authentication for $steam_id";
