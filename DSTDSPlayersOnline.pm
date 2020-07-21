package DSTDSPlayersOnline {

  my $LOGS_DIR = 'tests_data';  # this must be overwritten by the write_online_players() subroutine

  use warnings;
  use strict;

  use Exporter;
  our @ISA = qw( Exporter );

  our @EXPORT = qw( write_online_players online_players );

  our @EXPORT_OK = qw(
    find_players log_file_exists make_log_filepath authenticated_host disconnected_user is_starting_up is_shutting_down
    file_exists logs_dir_exists remove_player player_index contains_player logs_dir
  );

  sub write_online_players {
    my $opts = shift;
    my $server = $opts->{server};
    $LOGS_DIR = $opts->{logs_dir};

    unless ( !logs_dir_exists( { logs_dir=>$LOGS_DIR } ) ) {
      foreach my $player (online_players({ server => $server })) {
        if (defined($player)) {
          print "$player\n"
        }
      }
    }
    else {
      die "The given logs directory could not be found: $LOGS_DIR";
    }
  }

  sub online_players {
    my $opts = shift;
    my $server = $opts->{server};

    if (log_file_exists( { server=>$server } )) {
      return find_players( { server=>$server } );
    }
    return ();
  }

  sub find_players {
    my $opts = shift;
    my $server = $opts->{server};

    my @players = ();
    my $filepath = make_log_filepath( { server=>$server } );
    open(FH, '<', $filepath);
    while(<FH>){
      my $connected_player = authenticated_host( { log_line=>$_ } );
      my $disconnected_player = disconnected_user( { log_line=>$_ } );

      if (is_starting_up( { log_line=>$_ } ) || is_shutting_down( { log_line=>$_ } )) {
        @players = ();
      }
      elsif (
        defined $connected_player &&
        !contains_player( { player=>$connected_player, players=>\@players } )
      ) {
        push @players, $connected_player;
      }
      elsif (defined $disconnected_player) {
        @players = remove_player( { player=>$disconnected_player, players=>\@players } );
      }

    }
    close(FH);
    return @players;
  }

  sub log_file_exists {
    my $opts = shift;
    my $server = $opts->{server};

    my $filepath = make_log_filepath( { server=>$server } );
    return file_exists( { filepath=>$filepath } );
  }

  sub make_log_filepath {
    my $opts = shift;
    my $server = $opts->{server};

    my $logs_dir = logs_dir();
    return "${logs_dir}/dst_server_${server}_screenlog.log";
  }

  sub authenticated_host {
    my $opts = shift;
    my $log_line = $opts->{log_line};

    ($log_line =~ m/ \[Steam] Authenticated host '(?<steamid>.*)'/);
    return $+{steamid};
  }

  sub disconnected_user {
    my $opts = shift;
    my $log_line = $opts->{log_line};

    ($log_line =~ m/ \[Steam] SendUserDisconnect for '(?<steamid>.*)'/);
    return $+{steamid};
  }

  sub is_starting_up {
    my $opts = shift;
    my $log_line = $opts->{log_line};

    return ($log_line =~ m/ Starting Up/);
  }

  sub is_shutting_down {
    my $opts = shift;
    my $log_line = $opts->{log_line};

    return ($log_line =~ m/ \[Shard] Stopping shard mode/);
  }

  sub file_exists {
    my $opts = shift;
    my $filepath = $opts->{filepath};

    return (-s $filepath);
  }

  sub logs_dir_exists {
    my $opts = shift;
    my $logs_dir = $opts->{logs_dir};

    return (-d $logs_dir);
  }

  sub remove_player {
    my $opts = shift;
    my $player = $opts->{player};
    my @players = @{$opts->{players}};

    my $index_of_player = player_index( { player=>$player, players=>\@players } );
    splice(@players, $index_of_player, 1);
    return @players;
  }

  sub player_index {
    my $opts = shift;
    my $player = $opts->{player};
    my @players = @{$opts->{players}};

    my $index = 0;
    if (contains_player( { player=>$player, players=>\@players } )) {
      $index++ until $players[$index] eq $player;
      return $index;
    }
    die "Log file is corrupted - unable to check for players online.";
  }

  sub contains_player {
    my $opts = shift;
    my $player = $opts->{player};
    my %players = map { $_ => 1 } @{$opts->{players}};

    return exists($players{$player})
  }

  sub logs_dir {
    return $LOGS_DIR;
  }

}
