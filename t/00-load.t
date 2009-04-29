#!perl -T

use Test::More tests => 2;

BEGIN {
	use_ok( 'Graphics::Magick::Object' );
	use_ok( 'Graphics::Magick::Object::Image' );
}

diag( "Testing Graphics::Magick::Object $Graphics::Magick::Object::VERSION, Perl $], $^X" );
