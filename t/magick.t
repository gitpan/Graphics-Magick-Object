#!/usr/bin/perl -w 

use strict;
use warnings;

=head1 NAME

magick.t - Makes sure we can still get at Graphics::Magick.

=head1 GOALS

We're a shell - the user must always be able to get at
the underlying Graphics::Magick and use it normally.

=head1 TESTS

=over 4

=item - Make sure we can create a Graphics::Magick::Object.

=cut

use Test::More tests => 2;

use Graphics::Magick::Object;

my $obj =   new_ok('Graphics::Magick::Object');

=item - Check that Graphics::Magick::Object has an underlying
Graphics::Magick.

=cut

isa_ok($obj->magick, 'Graphics::Magick');
diag("Underlying Graphics::Magick is " . $obj->magick->VERSION);

