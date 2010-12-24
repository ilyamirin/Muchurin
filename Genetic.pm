package Genetic;
use Moose;

use Chromosome;

use random qw/ integer /;

has survival => ( is => 'rw', isa => 'Int' );

has whole_fitness => ( is => 'rw', isa => 'Num' );

has genome => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

sub BUILDARGS {
    my $self = shift;

    my %params = ( @_ );

    $params{ genome } = [];

    for ( 0..$params{ chromosomes_count }-1 ) {
        $params{ genome }->[ $_ ] = \Genetic::Chromosome->new(
            genes_count => $params{ genes_count },
            gene_digit  => $params{ gene_digit },
        );
    }

    return \%params;

}#BUILDARGS

sub cross {
    my ( $self, $father, $mother ) = @_;

    my $len = scalar @{ $$father->genes };

    my $descendant = $$father;

    for my $gene ( 0..$len-1 ) {
        for my $bit ( 0..${ $descendant->genes->[ $gene ] }->digit-1 ) {
            ${ $descendant->genes->[ $gene ] }->bits->[ $bit ] =
                ${ $$mother->genes->[ $gene ] }->bits->[ $bit ] if rand 2;
        }
    }

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

sub print {
    my $self = shift;
    map { print $$_->print . "\n" } @{ $self->genome };
}

1;
