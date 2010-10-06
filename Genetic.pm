package Genetic;
use Moose;

use Chromosome;

use random qw/ integer /;

has survival => ( is => 'rw', isa => 'Int' );

has whole_fitness => ( is => 'rw', isa => 'Num' );

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

    my $len = scalar @{ $father->genes };

    my $descendant = $father;

    for ( my $i = 0; $i < $len; $i++ ) {
        if ( rand 2 ) {
            $descendant->genes->[ $i ] = $father->genes->[ $i ];
        } else {
            $descendant->genes->[ $i ] = $mother->genes->[ $i ];
        }#else if
    }#for

    return $descendant;

}#cross

sub get_fitnesses {
    my $self = shift;

    $self->whole_fitness( 0 );

    foreach ( @{ $self->population } ) {
        $_->fitness( $self->environment->get_fitness( $_->get_values ) );
        $self->whole_fitness( $self->whole_fitness + $_->fitness );
    }

}#get_fitnesses

sub roulette {
    my $self = shift;

    my $size = scalar @{ $self->population };

    #my $places_per_fit = $size / $self->whole_fitness;
    print 'size= ' . $size . "\n";
    print 'whole_fitness= ' . $self->whole_fitness . "\n";

    my @roulette;
    foreach my $c ( @{ $self->population } ) {
        #print $c->fitness / $self->whole_fitness * $size . "\n";
        push( @roulette, $c ) foreach 1..( $c->fitness / $self->whole_fitness * $size );
    }

    #print @roulette . "\n";
    $size = scalar @roulette;

    my @new_generation;
    foreach ( 1..$size ) {
        my $father = $roulette[ rand $size ];
        my $mother = $roulette[ rand $size ];
        #print $self->cross( $father, $mother );
        push @new_generation, $self->cross( $father, $mother );
    }

    #print @new_generation . "sdf \n";

    $self->population( \@new_generation );

}

sub get_best {
    my $self = shift;

    my $best = $self->population->[ 0 ];
    foreach ( @{ $self->population } ) {
        #print $best->fitness ." \n";
        $best = $_ if $_->fitness > $best->fitness;
    }

    return $best;

}#get_best

sub start {
    my ( $self, $max_epochs ) = @_;

    my $best;
    foreach ( 1..$max_epochs) {
        $self->get_fitnesses;
        $best = $self->get_best;
        #last if $$best->fitness
        $self->roulette;
    }

    return $best;

}#start

1;
