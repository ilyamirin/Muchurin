package Start;
use Moose;

use Genetic;

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
    print " \n";
    #$c->mutate( 50 );
    #$c->print;
    #print $_ . " " foreach @{ $c->get_values };
    #$c->get_values;

    my $c1 = Genetic::Chromosome->new();
    $c1->init( 3, 4 );
    $c1->print;
    print " \n";

    my $genetic = Genetic->new();
    $genetic->init( 5, 3, 8 );

    $genetic->cross( \$c, \$c1 )->print;

    print " \n";

}
