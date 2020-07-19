#!/usr/bin/env perl

use warnings;
use strict;
use warnings FATAL => 'all';
use FindBin;
use lib "$FindBin::RealBin/.";

use DSTDSPlayersOnline qw( run );

my $logs_dir = shift;

foreach(@ARGV) {
  run( { server=>$_, logs_dir=> $logs_dir} );
}
