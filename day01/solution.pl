use strict;
use warnings;
use List::Util qw( sum );

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
    my @args = @$args_ref;

    # Input (appending first character at the end to simulate circular string...)
    my $input = scalar @args > 0
        ? $args[0] . substr($args[0], 0, 1) # Test input
        : $lines[0] . substr($lines[0], 0, 1); # Real input

    # Finding all matching digits and sum
    my @captured = $input =~ m/(\d)(?=\1)/g;
    my $sum = sum(@captured);

    print "====================\n";
    print "Solution #1: $sum\n";
    print "====================\n";
}

sub solution2 {
    my ($lines_ref, $args_ref) = @_;

    # Input
    my $data = scalar @$args_ref > 0 ? @$args_ref[0] : @$lines_ref[0]; # Test input or real input
    my $input = $data . substr($data, 0, length($data) / 2); # Appending first half of input to simulate circular string...

    # Finding all matching digits and sum
    my $pattern = '(\d)(?=\d{' . (length($data) / 2 - 1) . '}\1)';
    my @captured = $input =~ m/$pattern/g;
    my $sum = sum(@captured);

    print "====================\n";
    print "Solution #2: $sum\n";
    print "====================\n";
}