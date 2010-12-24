package Start;
use Moose;

use Genetic;
use Diofant;

BEGIN {

    #my $g = Genetic::Gene->new( digit => 4 );
    #$g->print;
    #$g->mutate( 50 );
    #$g->print;

    #my $c = Genetic::Chromosome->new( genes_count => 3, gene_digit => 4 );
    #$c->print;
    #$c->mutate( 50 );
    #$c->print;
    #print "$_ " for $c->get_values;

    #my $c1 = Genetic::Chromosome->new();
    #$c1->init( 3, 4 );
    #$c1->print;

    #my $d = Genetic::Diofant->new();
    #$d->init( 3 );
    #$d->print;

    my $genetic = Genetic->new(
        chromosomes_count => 2,
        genes_count       => 3,
        gene_digit        => 4,
    );

    $genetic->print;

    #$genetic->roulette;
    #$genetic->cross( \$c, \$c1 )->print;

    #my $best = $genetic->start( 50 );

    #print $best;

    #print $_ . " " foreach @{ $best->get_values };

    print " \n";

}
