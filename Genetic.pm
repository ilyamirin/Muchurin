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

sub get_fitnesses {
    my $self = shift;

    $_->fitness( $self->environment( $_->get_values ) ) foreach
        @{ $self->population };

}#get_fitnesses

sub roulette {
    my $self = shift;

    my @roulette;
    foreach ( @{ $self->population } ) {
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

sub get_best {
    my $self = shift;

    my $best;
    foreach ( @{ $self->population } ) {
        $self->roulette;
    }
}

sub start {
    my ( $self, $max_epochs ) = @_;

    foreach ( 1..$max_epochs) {
        $self->get_fitnesses;
    }

}

1;
