package Genetic::Chromosome;
use Moose;

use random qw/ integer /;
use Gene;

has fitness => ( is => 'rw', isa => 'Num' );

has genes => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my ( $self, $genes_count, $gene_digit ) = @_;
    $self->genes( [] );
    $self->genes->[ $_ ] = Genetic::Gene->new->init( $gene_digit ) for 0..$genes_count-1;
    return \$self;
}

sub get_values {
    my $self = shift;
    map { $$_->get_value } @{ $self->genes };
}

sub mutate {
    my ( $self, $prob ) = @_;
    $$_->mutate( $prob ) for @{ $self->genes };
}

sub print {
    my $self = shift;
    map { $$_->print } @{ $self->genes };
    print 'f= ' . $self->fitness if defined $self->fitness;
    print "\n";
}

1;
