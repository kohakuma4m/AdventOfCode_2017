use strict;
use warnings;
use List::Util qw( min max sum );

# Arguments
my ($solution_number, @args) = @ARGV;

# Reading input file
open(my $file_handle, '<', "./input.txt") or die $!;
chomp(my @lines = <$file_handle>);
close $file_handle;

###########################################
my %solutions = (
    1 => \&solution1,
    2 => \&solution2
);
###########################################

# Executing solution
if(exists $solutions{$solution_number}) {
    $solutions{$solution_number}->(\@lines, \@args);
}
else {
    die "No solution found for \"$solution_number\"";
}

###########################################

sub solution1 {
    my ($lines_ref, $args_ref) = @_;
    my @lines = @$lines_ref;

    # Computing checksum
    my @rows = map { [map { int($_) } split(" ", $_)] } @lines;
    my @values = map { (max @$_) - (min @$_) } @rows;
    my $checksum = sum(@values);

    print "====================\n";
    print join("\n", @values) . "\n";
    print "====================\n";
    print "Solution #1: $checksum\n";
    print "====================\n";
}

sub solution2 {
    my ($lines_ref, $args_ref) = @_;

    # Computing checksum
    my @rows = map { [map { int($_) } split(" ", $_)] } @lines;
    my @values = map { find_evenly_divisible_values_quotient(@$_) } @rows;
    my $sum = sum(@values) || 0;

    print "====================\n";
    print join("\n", @values) . "\n";
    print "====================\n";
    print "Solution #2: $sum\n";
    print "====================\n";
}

###########################################

sub find_evenly_divisible_values_quotient {
    my (@row) = @_;

    my @values = sort { $a <=> $b } @row;
    my $nb_values = scalar(@values);

    foreach my $i (0..$nb_values - 1) {
        foreach my $j ($i + 1..$nb_values - 1) {
            my $n1 = $values[$nb_values - 1 - $i];
            my $n2 = $values[$nb_values - 1 - $j];
            if($n1 % $n2 == 0) { # n1 >= n2
                return $n1 / $n2;
            }
        }
    }

    return 0; # No evenly divisible values found
}