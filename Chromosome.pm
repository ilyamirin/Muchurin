package Genetic::Chromosome;
use Moose;

use random qw/ integer /;

has gene_count => ( is => 'rw', isa => 'Int' );

has gene_capacity => ( is => 'rw', isa => 'Int' );

has genes => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my $self = shift;

    my @genes;
    for ( my $i = 0; $i < $self->gene_count ; $i++ ) {
        my @gene;
        for ( my $j = 0; $j < $self->gene_capacity ; $j++ ) {
            $gene[ $j ] = rand 2;
        }
        push @genes, \@gene;
    }

    $self->genes( \@genes );

}

sub cross {
    my $self = shift;
}

sub mutate {
    my $self = shift;

    foreach ( split( //, $self->value ) ) {

    }

}

1;
