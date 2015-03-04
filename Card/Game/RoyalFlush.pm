package Card::Game::RoyalFlush;

use Card::Game;
use Carp;
@ISA = qw(Card::Game);

sub play {
  my $self = shift;
  my $suit;          # Royal suit we're looking for
  my $DEBUG = 1;
  for my $i (qw[ deck 0 1 2 3 4 discard ]){
    $self->{piles}->{$i} = Card::Pile->new;
  }

  $self->makedeck( 'deck', 52 );
  $self->{piles}->{deck}->shuffle;
  print 'Deck: ', $self->{piles}->{deck}->as_string, "\n\n";

  for my $turn ( 5,4,3,2 ){
    my $c = 0;
    while( $self->{piles}->{deck}->number ){
      $self->move( 'deck', $c%$turn, 'top', 'top', 1 );
      $c++;
    }

    # Find royal suit and remove cards from piles
    for my $p (0..($turn-1)){
      print "P$p: ", $self->{piles}->{$p}->as_string, "\n\n";
      $self->{piles}->{$p}->reverse;
      while( my $card = $self->{piles}->{$p}->read ){
	if( $suit ){
	  if( $card->rank =~ /[TJQKA]/ and $card->suit eq $suit ){
	    last;
	  } else {
	    $self->move( $p, 'discard' );
	  }
	} else {
	  if( $card->rank =~ /[TJQKA]/ ){
	    $suit = $card->suit;
	    last;
	  } else {
	    $self->move( $p, 'discard' );
	  }
	}
      }
      print "P$p: ", $self->{piles}->{$p}->as_string, "\n\n";
    }

    # rebuild deck from piles -- reverse order!
    for my $p (0..($turn-1)){
      while( $self->{piles}->{$p}->number ){
	$self->move( $p, 'deck', 'bottom', 'top' );
      }
    }
    $self->{piles}->{deck}->reverse;
    print 'Deck: ', $self->{piles}->{deck}->as_string, "\n\n";
  }
  # Did we get down to five cards?  Count it as a winner or loser
  if( $self->{piles}->{deck}->number == 5 ){
    print "Winner!!!\n" if $DEBUG;
  } else {
    print "Loser -- ", $self->{piles}->{deck}->number, " cards.\n" if $DEBUG;
  }
}

1;
