package Genetic::Chromosome;
use Moose;

use random qw/ integer /;
use Gene;

has fitness => ( is => 'rw', isa => 'Num' );

has genes => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $genes_count, $gene_digit ) = @_;
    my $genes = [];
    $genes->[ $_ ] = Genetic::Gene->new->init( $gene_digit ) for 0..$genes_count-1;
    $self->genes( $genes );
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
