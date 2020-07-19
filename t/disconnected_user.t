use warnings;
use strict;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/..";

use DSTDSPlayersOnline qw( disconnected_user );

BEGIN {
  plan(tests => 4);
}

my $log_line = '[15:00:11]: Received (KU_d4ddm9-w) from TokenPurpose';
ok !disconnected_user( { log_line=>$log_line } ), "$log_line does not have user disconnection";

$log_line = "[00:05:32]: [Steam] Authenticated host '76561198125299762'";
ok !disconnected_user( { log_line=>$log_line } ), "$log_line does not have user disconnection";

my $steam_id = '76561198012345678';
$log_line = "[00:05:51]: [Steam] SendUserDisconnect for '$steam_id'";
is disconnected_user( { log_line=>$log_line } ), $steam_id, "log line has user disconnection for $steam_id";

$steam_id = '76561198123456789';
$log_line = "[00:05:51]: [Steam] SendUserDisconnect for '$steam_id'";
is disconnected_user( { log_line=>$log_line } ), $steam_id, "log line has user disconnection for $steam_id";
