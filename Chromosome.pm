package Genetic::Chromosome;
use Moose;

#TODO:: написать получалку чисел из двоичного
#TODO:: написать получалку чисел из грея
#TODO:: написать мутацию
#TODO:: написать кроссовер
#TODO:: написать поиск лучшего решения в спсике

use random qw/ integer /;

has gene_count => ( is => 'rw', isa => 'Int' );

has gene_capacity => ( is => 'rw', isa => 'Int' );

has genes => ( is => 'rw', isa => 'ArrayRef' );

sub init {
    my $self = shift;

    my @genes;
    for ( my $i = 0; $i < $self->gene_count ; $i++ ) {
        my @gene;
        for ( my $j = 0; $j < $self->gene_capacity ; $j++ ) {
            $gene[ $j ] = rand 2;
        }
        push @genes, \@gene;
    }

    $self->genes( \@genes );

}

sub get_values {
    my $self = shift;

    #my @grey = ;

    for ( my $i = 0; $i < $self->gene_count ; $i++ ) {
        my @shifted = @{ $self->genes->[ $i ] };

        for ( my $j = 0; $j < $self->gene_capacity ; $j++ ) {
            push @shifted, 0;
            for ( my $k = 0; $k < $self->gene_capacity; $k++ ) {
                $self->genes->[ $i ]->[ $k ] ^= $shifted[ $k ];
            }#for
        }#for

    }#for

    my @values;

    for ( my $i = 0; $i < $self->gene_count ; $i++ ) {
        my $value = 0;
        for ( my $j = 0; $j < $self->gene_capacity ; $j++ ) {
            if ( $self->genes->[ $i ]->[ $j ] ) {
                $value += 2 ** ( $self->gene_capacity - $j - 1 );
            }#if
        }#for
        print $value . "\n";
        #push @values, $value;
    }#for

    return @values;

}

sub print {
    my $self = shift;

    foreach my $gene ( @{ $self->genes } ) {
        foreach ( @$gene ) {
            print $_ . " ";
        }
        print " \n";
    }
}

sub cross {
    my $self = shift;
}

sub mutate {
    my $self = shift;
}

1;
