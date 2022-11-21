use strict;
use warnings;
use File::chdir;
use Time::HiRes qw(gettimeofday tv_interval);

# Reading args
my ($folder, $solution_number, @args) = @ARGV;

# Running day folder solution
$CWD = "./$folder";
my $t0 = [gettimeofday];
print `perl solution.pl $solution_number @args`;
my $time = tv_interval($t0, [gettimeofday]);
print "Done in $time\n";