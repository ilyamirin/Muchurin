package Genetic;
use Moose;

use Chromosome;

use random qw/ integer /;

has survival => ( is => 'rw', isa => 'Int' );

has population => ( is => 'rw', isa => 'ArrayRef' );

has environment => ( is => 'rw', isa => 'Object' );

sub init {
    my ( $self, $chromosomes, $genes, $gene_digit ) = @_;

    my @population;
    foreach ( 1..$chromosomes ) {
        my $chromosome = Genetic::Chromosome->new();
        $chromosome->init( $genes, $gene_digit );
        push @population, $chromosome;
    }

    $self->population( \@population );

}

sub cross {
    my ( $self, $father, $mother ) = @_;

    my $len = scalar @{ $$father->genes };

    my $descendant = $$father;

    for ( my $i = 0; $i < $len; $i++) {
        if ( rand 2 ) {
            $descendant->genes->[ $i ] = $$father->genes->[ $i ];
        } else {
            $descendant->genes->[ $i ] = $$mother->genes->[ $i ];
        }#else if
    }#for

    return $descendant;

}#cross

sub roulette {
    my ( $self ) = @_;

    my @roulette;
    foreach my $c ( @{ $self->population } ) {
        $c->fitness( $self->environment( $c->get_values ) );
        push( @roulette, \$c ) foreach 1..$c->fitness;
    }

    my $size = scalar @{ $self->population };

    my @new_generation;
    foreach ( 1..$size ) {
        my $father = $roulette[ rand $size ];
        my $mother = $roulette[ rand $size ];
        push @new_generation, $self->cross( $father, $mother );
    }

    $self->population( \@new_generation );

}

1;
