use strict;
use warnings;
$\ = "\n"; # So print add new line character by default

use File::Path qw(make_path);
use File::Copy qw(copy);

# Reading args
my $folder = $ARGV[0];
if(not defined $folder) {
    die "USAGE: perl generate.pl dayXX";
}

# Adding new solution directory
if(!-d $folder) {
    print "Creating new solution folder: $folder";
    make_path($folder) or die "Failed to create solution folder: $!";
}

# Adding new solution default template
my $src_file = "templates/default.pl";
my $dest_file = "$folder/solution.pl";
if(!-e $dest_file) {
    print "Creating new default template: $dest_file";
    copy($src_file, $dest_file) or die "Failed to create new default template: $!";
}

# Adding new solution input file
my $input_file = "$folder/input.txt";
if(!-e $input_file) {
    print "Creating new empty input file: $input_file";
    {
        open(my $file_handle, '>', $input_file) or die "Failed to create new default input file: $!";
    }
}