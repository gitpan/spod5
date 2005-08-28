use strict;
use Test::More;
use IPC::Open3;

my @scripts = grep { -f } glob 'script/*';
plan tests => scalar @scripts;

for my $script (@scripts) {
    local ( *IN, *OUT, *ERR );
    my $pid = open3( \*IN, \*OUT, \*ERR, "$^X -c $script" );
    wait;

    local $/ = undef;
    my $errput = <ERR>;
    like( $errput, qr/syntax OK/, "$script compiles" );
}

