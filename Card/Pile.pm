package Card::Pile;

use strict;
use Carp;

sub new {
  my $type  = shift;
  my $class = ref( $type ) || $type;
  my %f = @_;
  my $self = { 'style' => 'squared', 'down' => 'all', 'cards' => [] };
  for ( keys %f ){
    $self->{$_} = $f{$_} if $self->{$_};
  }
  bless $self, $class;
  return $self;
}

sub shuffle {
  my $self = shift;
  $self->{cards} = [ sort { rand() <=> rand() } @{$self->{cards}} ];
  return 1;
}

sub reverse {
  my $self = shift;
  $self->{cards} = [ reverse @{$self->{cards}} ];
  return 1;
}

sub number {
  my $self = shift;
  return scalar @{$self->{cards}};
}

sub as_string {
  my $self = shift;
  my $m = shift || 0;
  if( $m eq 'rank' ){
    return join ' ', map { $_->rank } @{$self->{cards}};
  } elsif( $m eq 'suit' ){
    return join ' ', map { $_->suit } @{$self->{cards}};
  } else {
    return join ' ', map { $_->rank . $_->suit } @{$self->{cards}};
  }
}

sub read {
  my $self = shift;
  my $m = shift || 'top';
  if( $m eq 'top' ){
    return $self->{cards}->[0];
  } elsif ( $m eq 'bottom' ){
    return $self->{cards}->[scalar @{$self->{cards}} - 1];
  } elsif ( $m =~ /^\d+$/ ){
    return $self->{cards}->[$m];
  } else {
    croak "Bad argument '$m' given to Cards::Pile->read";
  }
}

sub get {
  my $self = shift;
  my $m = shift || 'top';
  if( $m eq 'top' ){
    return shift @{$self->{cards}};
  } elsif ( $m eq 'bottom' ){
    return pop @{$self->{cards}};
  } elsif ( $m =~ /^\d+$/ ){
    return splice @{$self->{cards}}, $m, 1;
  } else {
    croak "Bad argument '$m' given to Cards::Pile->get";
  }
}

sub put {
  my $self = shift;
  my $card = shift;
  croak "No card reference given to Card::Pile->put" unless ref($card);
  my $m = shift || 'top';
  if( $m eq 'top' ){
    return unshift @{$self->{cards}}, $card;
  } elsif ( $m eq 'bottom' ){
    return push @{$self->{cards}}, $card;
  } elsif ( $m =~ /^\d+$/ ){
    return splice @{$self->{cards}}, $m, 0, $card;
  } else {
    croak "Bad argument '$m' given to Cards::Pile->put";
  }
}


1;
