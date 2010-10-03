package Genetic;
use Moose;

use Chromosome;

has chromosomes => ( is => 'rw', isa => 'ArrayRef' );

sub cross {
    my ( $self, $prob ) = @_;

    my $father = $self->chromosomes->[ rand scalar $self->chromosomes ];
    my $mother = $self->chromosomes->[ rand scalar $self->chromosomes ];



}

BEGIN {

    #my $g = Genetic::Gene->new();
    #$g->init( 4 );
    #$g->print;
    #$g->mutate( 50 );
    #$g->print;
    #print "v= " . $g->get_value . "\n";

    my $c = Genetic::Chromosome->new();
    $c->init( 3, 4 );
    $c->print;
    $c->mutate( 50 );
    $c->print;
    print $_ . " " foreach @{ $c->get_values };
    #$c->get_values;

    print " \n";

}

1;
