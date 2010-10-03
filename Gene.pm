package Genetic::Gene;
use Moose;

use random qw/ integer /;

has bits => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $digit ) = @_;

    my @bits;
    for ( my $i = 0; $i < $digit ; $i++ ) {
        push @bits , rand 2;
    }

    $self->bits( \@bits );

}

sub get_value {
    my $self = shift;

    my @grey = @{ $self->bits };
    my @unshifted = @grey;

    for ( my $i = 0; $i < ( scalar @grey ) - 1; $i++ ) {
        unshift @unshifted, 0;
        for ( my $j = 0; $j < scalar @grey; $j++ ) {
            $grey[ $j ] ^= $unshifted[ $j ];
        }#for
    }#for

    print "grey \n";
    print $_ . " " foreach @grey;
    print " \n";

    my $value = 0;
    for ( my $i = 0; $i < scalar @grey; $i++ ) {
        if ( $grey[ $i ] ) {
            #print $grey[ $i ] . "+ \n";
            $value += 2 ** ( scalar @grey - $i - 1 );
        }
        #$value += 2 ** ( $grey[ $j ] - $j - 1 ) if $grey[ $j ] ;
    }#for

    return $value;

}

sub print {
    my $self = shift;
    print $_ . " " foreach @{ $self->bits };
    print " \n";
}

sub mutate {
    my $self = shift;
}

1;
