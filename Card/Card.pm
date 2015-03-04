package Card::Card;


sub new {
  my $type  = shift;
  my $class = ref( $type ) || $type;
  my %f = @_;
  my $self = { 'rank' => 'A', 'suit' => 'S', 'up' => 0 };
  for ( keys %f ){
    $self->{$_} = $f{$_} if $self->{$_};
  }
  bless $self, $class;
  return $self;
}

sub AUTOLOAD {
  my $self = shift;
  my $name = $AUTOLOAD;
  $name =~ s/.*://;
  if( @_ ){
    return $self->{$name} = shift;
  } else {
    return $self->{$name};
  }
}

1;
