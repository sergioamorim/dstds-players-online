#!/usr/bin/env perl

use warnings;
use strict;
use warnings FATAL => 'all';
use FindBin;
use lib "$FindBin::RealBin/.";

use DSTDSPlayersOnline qw( write_online_players );

my $logs_dir = shift;

foreach(@ARGV) {
  write_online_players( { server=>$_, logs_dir=> $logs_dir} );
}
