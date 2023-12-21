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
    my $input = scalar @$args_ref > 0 ? int(@$args_ref[0]) : int(@$lines_ref[0]); # Test input or real input

    ##
    # After x layer, we have a square with n**2 values where n = (2*x-1), with the highest layer value at the bottom right corner
    #
    # We can just find the layer with our target value and go back from bottom right corner
    # to find position of target value relative to central value, then calculate the manhathan distance
    ##
    my $n = 1;
    until($n**2 >= $input) { $n += 2; } # Square of side n (odd value)
    my ($dx, $dy) = find_position($n, $input);
    my $distance = abs($dx) + abs($dy);

    print "====================\n";
    print "Solution #1: $distance\n";
    print "====================\n";
}

sub solution2 {
    my ($lines_ref, $args_ref) = @_;
    my $input = scalar @$args_ref > 0 ? int(@$args_ref[0]) : int(@$lines_ref[0]); # Test input or real input

    ##
    #   Here, it's simpler to calculate all values in order until > max
    ##
    my $n = 1;
    my $value = 1;
    my $nb_values = 1;
    my $x = 0; my $y = 0;
    my %locations = ( "$x;$y" => 1 );
    until($value > $input) {
        $nb_values++;

        if($nb_values > $n**2) {
            $n += 2;
        }

        # Next position compared to origin
        ($x, $y) = find_position($n, $nb_values); # Would be more efficient with a new custom method... TODO

        # Find next value
        my @adjacent_values = find_adjacent_values($x, $y, %locations);
        $value = sum(@adjacent_values);
        $locations{"$x;$y"} = $value;
    }

    print "====================\n";
    print "Solution #2: $value\n";
    print "====================\n";
}

###########################################

sub find_position {
    my ($n, $target) = @_;

    # Center position reference on each axis
    my $center = int($n/2) + 1;

    # Corner position values
    my $bottom_right = $n**2;
    my $bottom_left = $bottom_right - $n + 1;
    my $top_left = $bottom_left - $n + 1;
    my $top_right = $top_left - $n + 1;

    my $dx; my $dy;
    if($target <= $bottom_right && $target >= $bottom_left) {
        # Bottom side
        $dx = abs(($bottom_right - $target) - ($center - 1));
        $dx *= -1 if $target < $bottom_right - ($center - 1); # Because we compare with right value
        $dy = -($center - 1);
    }
    elsif($target < $bottom_left && $target > $top_left) {
        # Left side
        $dx = -($center - 1);
        $dy = ($bottom_left - $target) - ($center - 1);
    }
    elsif($target <= $top_left && $target >= $top_right) {
        # Top side
        $dx = ($top_left - $target) - ($center - 1);
        $dy = $center - 1;
    }
    else {
        # Right side
        $dx = $center - 1;
        $dy = abs(($top_right - $target) - ($center - 1));
        $dy *= -1 if $target < $top_right - ($center - 1); # Because we compare with top value
    }

    return ($dx, $dy);
}

sub find_adjacent_values {
    my ($x, $y, %locations) = @_;

    my @adjacent_values = (
        $locations{"${\($x-1)};${\($y-1)}"},
        $locations{"${\($x-1)};${\($y)}"},
        $locations{"${\($x-1)};${\($y+1)}"},
        $locations{"${\($x)};${\($y-1)}"},
        $locations{"${\($x)};${\($y+1)}"},
        $locations{"${\($x+1)};${\($y-1)}"},
        $locations{"${\($x+1)};${\($y)}"},
        $locations{"${\($x+1)};${\($y+1)}"}
    );

    return grep { defined } @adjacent_values;
}