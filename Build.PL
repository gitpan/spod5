use Module::Build;
my $build = Module::Build->new(
    module_name       => 'spod5',
    dist_version_from => 'script/spod5',
    license           => 'perl',
    requires          => {
        'Pod::POM'                     => '0.17',
        'Pod::POM::View::HTML::Filter' => '0.05',
        'Test::More'                   => 0,
    },
    script_files       => glob('script/*'),
    create_makefile_pl => 'traditional',
    add_to_cleanup      => [ 'spod5-*', 't/zamm.html' ],
);
$build->create_build_script;

