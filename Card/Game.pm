package Card::Game;

use Carp;

sub new {
  my $type  = shift;
  my $class = ref( $type ) || $type;
  my %f = @_;
  my $self = { 'piles' => {} };
  for ( keys %f ){
    $self->{$_} = $f{$_} if $self->{$_};
  }
  bless $self, $class;
  return $self;
}

sub makedeck {
  my $self = shift;
  my $pile = shift || croak "No pile given to Card::Game->makedeck";
  my $m = shift || 52;

  if( $m == 52 ){
    for my $r ( 2..9, qw[ A T J Q K ]){
      for my $s ( qw[ S D H C ] ){
	my $card = Card::Card->new( 'rank' => $r, 'suit' => $s, 'up' => 0 );
	$self->{piles}->{deck}->put( $card, 'top' );
      }
    }
  } else {
    croak "Impossible option given to Card::Game->makedeck";
  }
}

sub move {
  my $self = shift;
  my $s = shift;
  my $d = shift;
  croak "Pile names not passed to Card::Game->move" unless defined($s) and defined($d);
  my $sm = shift || 'top';
  my $dm = shift || 'top';
  my $up = shift || undef;

  my $card = $self->{piles}->{$s}->get($sm);
  $card->up($up) if defined $up;
  $self->{piles}->{$d}->put( $card, $dm );
  return 1;
}

sub play {
  my $self = shift;
  print "Overload this routine with your game's specific playing routine";
  exit;
}

1;
