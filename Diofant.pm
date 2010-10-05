package Genetic::Diofant;
use Moose;

use random qw/ integer /;

has 'k' => ( is => 'rw', isa => 'ArrayRef' );

has 'x' => ( is => 'rw', isa => 'ArrayRef' );

has 'c' => ( is => 'rw', isa => 'Int' );

sub init {
    my ( $self, $var_count ) = @_;

    my ( @k, @x, $sum );
    foreach ( 0..$var_count-1 ) {
        push @k, rand 10;
        push @x, rand 10;
        $sum += $k[ $_ ] * $x[ $_ ];
    }

    $self->k( \@k );
    $self->k( \@x );
    $self->c( -1 * $sum );

}

sub fitness {
    my ( $self, $values ) = @_;

    my $result;
    for ( my $i = 0; $i < scalar @$values; $i++ ) {
        $result += $values->[ $i ] * $self->k->[ $i ];
    }

    return 1 / abs( $self->c - $result );

}

sub print {
    my $self = shift;
    print $_ . ' ' foreach @{ $self->k };
    print "\nc= " . $self->c . "\n";
}

1;
