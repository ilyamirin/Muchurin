package Genetic;
use Moose;

use Gene;
use Chromosome;

BEGIN {

    my %prob;
    $prob{ mutation } = 50;

    my $g = Genetic::Gene->new( prob => \%prob );

    $g->init( 4 );

    $g->print;

    $g->mutate;

    $g->print;

    print "v= " . $g->get_value . "\n";

    #my $c = Genetic::Chromosome->new({ gene_count => 3, gene_capacity => 4 });

    #$c->init;

    #$c->print;

    #print $_ . " " foreach @{ $c->get_values };
    #$c->get_values;

    print " \n";

}

1;
