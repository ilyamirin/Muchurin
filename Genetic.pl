package Genetic;
use Moose;

use Gene;
use Chromosome;

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
