# there is not much we can test for,
# so we test that the include works correctly

use strict;
use Test::More tests => 7;
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

# test the --multi option
local ( *IN, *OUT, *ERR );
$pid = open3( \*IN, \*OUT, \*ERR, "$^X $script --multi -f $pod" );
wait;

ok( -e 'zamm0000.html', 'slide 0' );
ok( -e 'zamm0001.html', 'slide 1' );
ok( ! -e 'zamm0002.html', 'no slide 2' );

@ARGV = ( 'zamm0000.html' );
$html = join '', <>;
like( $html, qr/<ul class="incremental">/, "Incremental support" );

@ARGV = ( 'zamm0001.html' );
$html = join '', <>;
like( $html, qr/I'm inserted!/, "Blurp included" );

# clean up
unlink(  catfile( 't', 'zamm.html' ), 'zamm0000.html', 'zamm0001.html' ); 
