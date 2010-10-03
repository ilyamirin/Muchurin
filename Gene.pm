package Genetic::Gene;
use Moose;

use random qw/ integer /;

has prob => ( is => 'rw', isa => 'HashRef' );

has bits => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $digit ) = @_;

    my @bits;
    push @bits, rand 2 for 1..$digit;

    $self->bits( \@bits );

}

sub get_value {
    my $self = shift;

    my @grey = @{ $self->bits };
    my @unshifted = @grey;

    my $digit = scalar @grey;

    for ( 2..$digit ) {
        unshift @unshifted, 0;
        for ( my $j = 0; $j < $digit; $j++ ) {
            $grey[ $j ] ^= $unshifted[ $j ];
        }
    }

    my $value = 0;
    for ( my $i = 0; $i < scalar @grey; $i++ ) {
        $value += 2 ** ( scalar @grey - $i - 1 ) if $grey[ $i ];
    }

    return $value;

}#get_value

sub mutate {
    my ( $self, $prob ) = @_;

    foreach ( @{ $self->bits } ) {
        $_ = !$_ if ( rand 101 ) < $prob;
    }

}

sub print {
    my $self = shift;
    print $_ foreach @{ $self->bits };
    print " | " . $self->get_value . " \n";

}

1;
