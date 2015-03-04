package Card::Game::Patience;

use Card::Game;
use Card::Pile;
use Card::Card;
use Carp;
@ISA = qw(Card::Game);

sub play {
  my $self = shift;
  my $DEBUG = 1;
  for my $i (qw[ deck 0 1 2 3 discard ]){
    $self->{piles}->{$i} = Card::Pile->new;
  }

  $self->makedeck( 'deck', 52 );
  $self->{piles}->{deck}->shuffle;
  print 'Deck: ', $self->{piles}->{deck}->as_string, "\n\n" if $DEBUG;

  for my $deal ( 1..200 ){
    print "Deal # $deal\n";
    my $round = 0;
    while( $self->{piles}->{deck}->number ){  # while cards remain in deck
      $round++;
      for (0..3){                             # deal one to each pile
		$self->move( 'deck', $_, 'top', 'top', 1 );
      }
      while(              # if all four cards' ranks match, discard them
	    $self->{piles}->{0}->number and
	    $self->{piles}->{1}->number and
	    $self->{piles}->{2}->number and
	    $self->{piles}->{3}->number and
	    $self->{piles}->{0}->read->rank eq $self->{piles}->{1}->read->rank and
	    $self->{piles}->{0}->read->rank eq $self->{piles}->{2}->read->rank and
	    $self->{piles}->{0}->read->rank eq $self->{piles}->{3}->read->rank ){
	print "Matching set of ", $self->{piles}->{0}->read->rank, "s!\n";
	$self->move( $_, 'discard', 'top', 'top', 1 ) for (0..3);
      }

      my $match;
      do {   # Check for matching rank, and move matching to left
	$match = 0;
	for my $x (3,2,1){
	  for my $y (0..($x-1)){
	    if( $self->{piles}->{$x}->read and $self->{piles}->{$y}->read and 
		$self->{piles}->{$x}->read->rank eq $self->{piles}->{$y}->read->rank ){
	      $self->move( $x, $y, 'top', 'top', 1 );
	      $match = 1;
	    }
	  }
	}
      } while( $match );
    }
    # rebuild deck from piles -- reverse order!
    for my $p (0..3){
      while( $self->{piles}->{$p}->number ){
	$self->move( $p, 'deck', 'bottom', 'bottom' );
      }
    }
#    $self->{piles}->{deck}->reverse;
    print 'Deck: ', $self->{piles}->{deck}->as_string, "\n\n";
    if( $self->{piles}->{deck}->number == 0 ){
      print "Winner!!!\n";
      exit;
    }
  }
  # Did we get down to five cards?  Count it as a winner or loser
  if( $self->{piles}->{deck}->number == 0 ){
    print "Winner!!!\n" if $DEBUG;
  } else {
    print "Loser -- ", $self->{piles}->{deck}->number, " cards.\n" if $DEBUG;
  }

}

1;
