## DSTDSPlayersOnline 
[![Build Status](https://travis-ci.com/sergioamorim/dstds-players-online.svg?branch=master)](https://travis-ci.com/sergioamorim/dstds-players-online)
[![codecov](https://codecov.io/gh/sergioamorim/dstds-players-online/branch/master/graph/badge.svg)](https://codecov.io/gh/sergioamorim/dstds-players-online)

This module checks the logs files for players connected to a Dedicated Server 
of the game Don't Starve Together. 

### Requirements 
The only requirement to run this software is to have Perl installed on the 
device where the logs of the server are stored. It was tested with Perl5 
versions 28 and 30. To check if it can run with a different version simply 
run `prove t/*` on the root directory of the project to get the tests results; 
if everything passes then it is good to go. Perl is present by default in most 
Linux distributions and can run in a variety of other systems - you can get 
more information on [Perl's official page](https://perl.org/).
Note: you are going to need the modules 
[Mock::Sub](https://github.com/stevieb9/mock-sub) and 
[Test::Exception](https://github.com/Test-More/test-exception) on your Perl 
installation library to run the tests mentioned above.

### Instructions 
The log file names must follow the pattern 
`dst_server_ShardName_screenlog.log`, where ShardName is the name of the 
Shard, for example: `dst_server_Master_screenlog.log` or 
`dst_server_Caves_screenlog.log` 
If the log filename does not match this pattern, **the script will assume the 
file log does not exist and will exit silently**. This is important because 
this same output is given when no players were found connected by the log 
files.  

Running the `players_online.pl` script will return to stdout the steam id of 
the players that are still connected to the server. Note that this specific 
module will only look for the log files mentioned above and that is the only 
resource available to it, so it can not be too accurate when ran by itself. 

At least two arguments must be passed when running: the logs directory 
(without the trailing slash) and the shard name of the server. 

`perl players_online.pl <logs_directory> <shard>` 

More than one shard could be passed at the same time, just appending it to the 
end of the command: `perl players_online.pl <logs_directory> <shardA> <shardB>`

Running the check with more than one shard requires that all logs are in the 
same given logs directory. 

Example:

`perl players_online.pl /logs/directory Master Caves AnotherWorld AnotherCave` 

If any of the shards have connected players (according to the logs), the steam 
id of these players will be written to stdout separated by new line characters 
(\n). 

### Feedback

If you found a bug or got any difficulties with this module - or if you are 
looking for another feature or functionality, please 
[open an issue here](https://github.com/sergioamorim/dstds-players-online/issues). 

You are more than welcome to contribute to the development of this project if 
that is your thing, just get the code and enhance it! :) 
