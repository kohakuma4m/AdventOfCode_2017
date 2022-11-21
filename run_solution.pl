use strict;
use warnings;
use File::chdir;
use Benchmark qw(:all);

# Reading args
my ($folder, $solution_number, @args) = @ARGV;

# Running day folder solution
$CWD = "./$folder";
my $result = timeit(1, print `perl solution.pl $solution_number @args`);
my $time = timestr($result);
print "Done in $time\n";