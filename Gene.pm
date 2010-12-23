package Genetic::Gene;
use Moose;

use random qw/ integer /;

has prob => ( is => 'rw', isa => 'HashRef' );

has bits => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $digit ) = @_;
    $self->bits( [] );
    $self->bits->[ $_ ] = rand( 2 ) for 0..$digit-1;
}#init

sub get_value {
    my $self = shift;

    my @grey = @{ $self->bits };
    my @unshifted = @grey;

    my $digit = scalar @grey;

    for ( 2..$digit ) {
        unshift @unshifted, 0;
        $grey[ $_ ] ^= $unshifted[ $_ ] for 0..$digit-1;
    }

    my $value = 0;
    $digit--;
    $value += ( 2 ** ( $digit - $_ ) ) * $grey[ $_ ] for 0..$digit;

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
