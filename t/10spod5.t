# there is not much we can test for,
# so we test that the include works correctly

use strict;
use Test::More tests => 2;
use IPC::Open3;
use File::Spec::Functions;

my $script = catfile( 'script', 'spod5' );
my $pod    = catfile( 't',      'zamm.pod' );

local ( *IN, *OUT, *ERR );
my $pid = open3( \*IN, \*OUT, \*ERR, "$^X $script -f $pod" );
wait;

@ARGV = catfile( 't', 'zamm.html' );
my $html = join '', <>;

like( $html, qr/<ul class="incremental">/, "Incremental support" );
like( $html, qr/I'm inserted!/, "Blurp included" );

