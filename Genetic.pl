package Genetic;
use Moose;

use Chromosome;

BEGIN {

    my $c = Genetic::Chromosome->new({ gene_count => 3, gene_capacity => 4 });
    $c->init;

    foreach my $gene ( @{ $c->genes } ) {
        foreach ( @{ $gene } ) {
            print $_ . " ";
        }
        print " \n";
    }

}

1;
