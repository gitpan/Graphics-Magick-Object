package Graphics::Magick::Object;

# We're such a classically Moose object that
# it seems a shame to pass this up.
use Moose;

# The class we're wrapping around.
use Graphics::Magick;

# Other classes in our library
use Graphics::Magick::Object::Image;

# Helpers
use Carp; 
use Data::Dumper;

=head1 NAME

Graphics::Magick::Object - An object representing the Graphics::Magick engine.

=head1 VERSION

Version 0.01_01

=cut

our $VERSION = '0.01_01';

=head1 STATUS

This is a completely experimental module, so I<all> interfaces will very
likely change. Please don't rely on it until version 1.0!

=head1 SYNOPSIS

Allows you to create Graphics::Magick::Object::Image objects from input files,
streams or other image providers.

    use Graphics::Magick::Object;

    my $magick =    Graphics::Magick::Object->new();

    # An Graphics::Magick::Object can create an I::M::Object::Image from a file.
    my $image =     $magick->read("test.jpeg");

=head1 ATTRIBUTES 

=head2 magick

Stores the Graphics::Magick object we're wrapping around.

=cut

has 'magick' => (
    isa =>      'Graphics::Magick',
    is =>       'ro',
    default =>  sub { new Graphics::Magick(); }
);

=head1 METHODS 

=head2 read

  my $image = $magick->read($filename);

Reads from a file to create a Graphics::Magick::Object::Image.

=cut

sub read($$) {
    my $self =  shift;
    my $file =  shift;

    if( (not ref $file) && (-r $file) ) {
        # If it's a scalar, it must be a filename.
        return new Graphics::Magick::Object::Image(filename => $file);
    } else {
        croak "I can't read from " . Dumper($file);
    }
}

=head1 AUTHOR

Gaurav Vaidya, C<< <gaurav at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-graphics-magick-object at rt.cpan.org>, or through
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

1; # End of Graphics::Magick::Object
