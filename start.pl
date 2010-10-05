package Start;
use Moose;

use Genetic;
use Diofant;

BEGIN {

    #my $g = Genetic::Gene->new();
    #$g->init( 4 );
    #$g->print;
    #$g->mutate( 50 );
    #$g->print;
    #print "v= " . $g->get_value . "\n";

    #my $c = Genetic::Chromosome->new();
    #$c->init( 3, 4 );
    #$c->print; print " \n";
    #$c->mutate( 50 );
    #$c->print;
    #print $_ . " " foreach @{ $c->get_values };
    #$c->get_values;

    #my $c1 = Genetic::Chromosome->new();
    #$c1->init( 3, 4 );
    #$c1->print;print " \n";

    my $d = Genetic::Diofant->new();
    $d->init( 3 );
    $d->print;

    my $genetic = Genetic->new();
    $genetic->init( 100, 3, 16 );
    #$genetic->roulette;
    #$genetic->cross( \$c, \$c1 )->print;



    print " \n";

}
