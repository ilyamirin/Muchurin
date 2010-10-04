package Genetic::Chromosome;
use Moose;

use random qw/ integer /;

use Gene;

has fitness => ( is => 'rw', isa => 'Int' );

has genes => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $genes, $gene_digit ) = @_;

    my @genes;
    for ( my $i = 0; $i < $genes ; $i++ ) {
        my $gene = Genetic::Gene->new();
        $gene->init( $gene_digit );
        push @genes, \$gene;
    }

    $self->genes( \@genes );

}

sub get_values {
    my $self = shift;

    my @values;
    push @values, $$_->get_value foreach @{ $self->genes };

    return \@values;

}

sub mutate {
    my ( $self, $prob ) = @_;
    $$_->mutate( $prob ) foreach @{ $self->genes };

}


sub print {
    my $self = shift;
    foreach my $gene ( @{ $self->genes } ) {
        $$gene->print;
    }
    print 'f= ' . $self->fitness . "\n" if defined $self->fitness;

}

1;
