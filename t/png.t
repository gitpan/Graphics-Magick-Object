#!/usr/bin/perl -w

use strict;
use warnings;

=head1 NAME

images.t - Tests loading and processing of images.

=head1 GOALS

This file tests whether we can handle files which
Graphics::Magick can support.

=head1 TESTS

=over 4

=cut

use Test::More tests => 8;

=item - Load up an Graphics::Magick::Object

=cut

use Graphics::Magick::Object;

my $magick =    new_ok('Graphics::Magick::Object');
my $image;

=item - Try loading a couple of files which don't work.

=cut

eval {
    $image =    $magick->read('t/files/%03d.png');
};
ok(defined $@,  "Checking for an error on '%' delimiters");

=item - Try to load an actual PNG.

=cut

eval {
    $image =     $magick->read('t/files/graphics-magick-object.png');
};

if($@ ne '') {
    BAIL_OUT "Exception $@ thrown while reading a testing image file";
}

=item - Make sure you got a proper G::M::O::I object.

=cut

isa_ok($image, 'Graphics::Magick::Object::Image');

is($image->width(),     360,    "Checking test image's width");
is($image->height(),    120,    "Checking test image's height");

is($image->format(),    'Portable Network Graphics',     
                                "Checking the test image's format");

is($image->mimetype(),  'image/png',
                                "Checking the test image's MIME type");

=item - Try to export this image as a JPEG.

=cut

my $image2;
eval {
    $image->export("t/files/graphics-magick-object.jpg");

=item - Make sure this JPEG can be read in by G::M::O.

=cut

    $image2 = $magick->read("t/files/graphics-magick-object.jpg");
    
    is($image2->mimetype(), 'image/jpeg', "Checking the test image's MIME type");
};
if($@ ne '') {
    BAIL_OUT "Exception $@ thrown while reading a testing image file";
}
