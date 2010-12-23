package Genetic::Gene;
use Moose;

use random qw/ integer /;

has bits => ( is => 'rw', isa => 'ArrayRef' );

has digit => ( is => 'rw', isa => 'Int', default => 0 );

sub BUILD {
    my ( $self ) = @_;
    $self->bits( [] );
    $self->bits->[ $_ ] = rand( 2 ) for 0..$self->digit-1;
    return \$self;
}#BUILD

sub get_value {
    my $self = shift;

    my @grey = @{ $self->bits };
    my @unshifted = @grey;

    for ( 2..$self->digit ) {
        unshift @unshifted, 0;
        $grey[ $_ ] ^= $unshifted[ $_ ] for 0..$self->digit-1;
    }

    my $value = 0;
    $value += ( 2 ** ( $self->digit - $_ - 1  ) ) * $grey[ $_ ] for 0..$self->digit-1;

    return $value;

}#get_value

sub mutate {
    my ( $self, $prob ) = @_;
    map { $_ = $_ ? 0 : 1 if rand( 101 ) < $prob } @{ $self->bits };
}#mutate

sub print {
    my $self = shift;
    print $_ foreach @{ $self->bits };
    print " | " . $self->get_value . " \n";

}#print

1;
