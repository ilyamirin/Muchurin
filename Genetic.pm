package Genetic;
use Moose;

use Chromosome;

use random qw/ integer /;

has survival => ( is => 'rw', isa => 'Int' );

has population => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

has fitness_func => ( is => 'rw', isa => 'Ref' );

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;

    my %params = ( @_ );

    $params{ genome } = [];

    my $population = $params{ population }-1;
    $params{ population } = [];

    for ( 0..$population ) {
        $params{ population }->[ $_ ] = \Genetic::Chromosome->new(
            genes_count => $params{ genes_count },
            gene_digit  => $params{ gene_digit },
        );
    }

    @_ = ( %params );

    return $class->$orig( @_ );

};#BUILDARGS

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

sub roulette {
    my $self = shift;

    my $size = scalar @{ $self->population };
    my $whole_fitness = 0;
    my $fit_func = $self->fitness_func;
    
    foreach ( @{ $self->population } ) {
        $whole_fitness += $$_->fitness( &$fit_func( $$_->get_values ) );         
    }

    my @roulette;
    foreach my $c ( @{ $self->population } ) {
        #print $c->fitness / $self->whole_fitness * $size . "\n";
        push( @roulette, $c ) foreach 1..( $$c->fitness / $whole_fitness * $size );
    }

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

sub winner {
    my $self = shift;

    my $best = $self->population->[ 0 ];

    my @fitness = map { $_->fitness } @{ $self->population };

    print 'fit ' . @fitness . "\n";
    
    return $self->population->[ $fitness[ 0 ] ];
    
    #$best = $_ if $_->fitness > $best->fitness for @{ $self->population };    

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
    map { print $$_->print . "\n" } @{ $self->population };
}

1;
