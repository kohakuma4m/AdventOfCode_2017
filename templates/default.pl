use strict;
use warnings;

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

    print "====================\n";
    print "Solution #1: \n";
    print "====================\n";
}

sub solution2 {
    my ($lines_ref, $args_ref) = @_;
    my @lines = @$lines_ref;
    my @args = @$args_ref;

    print "====================\n";
    print "Solution #2: \n";
    print "====================\n";
}

###########################################