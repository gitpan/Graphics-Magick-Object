use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Graphics::Magick::Object',
    license             => 'perl',
    dist_author         => 'Gaurav Vaidya <gaurav@cpan.org>',
    dist_version_from   => 'lib/Graphics/Magick/Object.pm',
    build_requires => {
        'Test::More' =>         0,
        'Moose' =>              0,
        'Method::Signatures' => 0,
        'Graphics::Magick' =>   0
    },
    add_to_cleanup      => [ 'Graphics-Magick-Object-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
