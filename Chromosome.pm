package Genetic::Chromosome;
use Moose;

use random qw/ integer /;
use Gene;

has fitness => ( is => 'rw', isa => 'Num' );

has genes => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

sub BUILDARGS {
    my $self = shift;

    my %params = ( @_ );
    $params{ genes } = [ ];

    for ( 0..$params{ genes_count }-1 ) {
        $params{ genes }->[ $_ ] = \Genetic::Gene->new(
            digit => $params{ gene_digit }
        );
    }

    return \%params;

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

}

1;
