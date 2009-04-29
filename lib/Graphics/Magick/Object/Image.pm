package Graphics::Magick::Object::Image;

use warnings;
use strict;

use Carp;
use Moose;

use Scalar::Util qw(looks_like_number);
use Method::Signatures;

=head1 NAME

Graphics::Magick::Object::Image - An individual image to play around with. 

=head1 VERSION

Version 0.01_01

=cut

our $VERSION = '0.01_01';

=head1 STATUS

This is a completely experimental module, so I<all> interfaces will very
likely change. Please don't rely on it until version 1.0!

=head1 SYNOPSIS

A single image available for manipulation.

    use Graphics::Magick::Object::Image;

    my $image1 = new Graphics::Magick::Object::Image();
    my $image2 = new Graphics::Magick::Object::Image(filename => 'filename.png');
    
Or, alternately:
    use Graphics::Magick::Object;
    my $magick =    new Graphics::Magick::Object();
    my $image =     $magick->read('filename.png');

=head1 ATTRIBUTES 

=head2 magick

The Graphics::Magick object we're a wrapper around.

=cut

has 'magick' => (
    isa =>      'Graphics::Magick',
    is =>       'ro',
    default =>  sub { new Graphics::Magick(); }
);

=head2 filename

The filename that this image is to be loaded from.

=cut

has 'filename' => (
    isa =>  'Str',
    is =>   'ro'
);

=head2 width

The width of this image.

=cut

method width() {
    croak "No image loaded yet."    unless defined $self->magick->[0];

    return $self->magick->[0]->Get('width');
}

=head2 height

The height of this image.

=cut

method height() {
    croak "No image loaded yet."    unless defined $self->magick->[0];

    return $self->magick->[0]->Get('height');
}

=head2 format

The format of this image, as described by Graphics::Magick.

=cut

method format() {
    croak "No image loaded yet."        unless defined $self->magick->[0];

    return $self->magick->[0]->Get('format');
}

=head2 mimetype 

The format of this image, as represented by a MIME type. 

=cut

method mimetype {
    croak "No image loaded yet."        unless defined $self->magick->[0];

    my $magick_code = $self->magick->[0]->Get('magick');
    return 'image/png'      if($magick_code eq 'PNG');
    return 'image/jpeg'     if($magick_code eq 'JPEG');

    # When all else fails ...
    return 'application/octet-stream';
}

=head1 METHODS

=head2 BUILD

We read off the filename on load.

=cut

method BUILD() {
    if(defined $self->filename) {
        $self->load_from_file($self->filename);
    }

    return 0;
}

=head2 load_from_file

    $magick->load_from_file($filename)

Loads a file and sets up all the variables.

=cut

method load_from_file($filename) {
    croak "We do not support '%' delimiters in filenames yet" if($filename =~ /\%/);

    my $response =  $self->magick->Read($filename);
    if($response == 1) {
        return;
    } elsif(Scalar::Util::looks_like_number($response)) {
        croak "Sorry, this module can only handle image files containing a single image at the moment";
    }

    if($response =~ /^Exception (\d+): (.*)$/) {
        croak "Graphics::Magick exception $1 thrown: $2";
    }

    croak "Graphics::Magick response un-understandable: $response";
}

=head2 export

    $magick->export($filename)

Exports to the filename specified. As with Graphics::Magick, you
can use the file extension to export to a particular file type.

=cut

method export($filename) {
    croak "No image loaded"     unless defined $self->magick->[0];

    my $response = $self->magick->[0]->Write($filename);

    if($response == 1) {
        return;
    } elsif(Scalar::Util::looks_like_number($response)) {
        croak "$response images were exported, when only one should have been!";
    }

    if($response =~ /^Exception (\d+): (.*)$/) {
        croak "Graphics::Magick exception $1 thrown: $2";
    }

    croak "Graphics::Magick response un-understandable: $response";
}

=head1 AUTHOR

Gaurav Vaidya, C<< <gaurav at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-graphics-magick-object-image at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Graphics-Magick-Object>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Graphics::Magick::Object


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Graphics-Magick-Object>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Graphics-Magick-Object>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Graphics-Magick-Object>

=item * Search CPAN

L<http://search.cpan.org/dist/Graphics-Magick-Object>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Gaurav Vaidya, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Graphics::Magick::Object::Image
