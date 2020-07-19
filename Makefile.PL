use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'DSTDSPlayersOnline',
  AUTHOR       => 'Sergio <github.com/sergioamorim>',
  test => {TESTS => 't/*.t'}
);
