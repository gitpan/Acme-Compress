package Acme::Compress;

use Compress::LZMA::External qw(compress decompress);

use strict qw(vars subs);

=head1 NAME

Acme::Compress - When free space is not enough

=head1 VERSION

Version 0.04

=cut

our $VERSION = '0.04';

=head1 SYNOPSIS

  use Acme::Compress;

  print "Hello world";

The first time the script is run, it is compressed, then it can be used
as normal.

=cut

my $TIE = "\t\t\t\t\t\t\t\t\n";
my $err = "Can't compress '$0'\n";

sub minify { "$TIE".compress $_[0] }
sub deminify { $_[0] =~ s/.*^$TIE//; decompress $_[0]; } 

sub is_compressed { $_[0] =~ /^$TIE/ }

local $SIG{__WARN__} = \&is_compressed;

open 0 or print $err and exit;
(my $code = join "", <0>) =~ s/.*^\s*use\s+Acme::Compress\s*;\n//sm;

local $SIG{__WARN__} = \&is_compressed;
do {eval deminify $code; exit} if is_compressed $code;

open 0, ">$0" or print $err and exit;
print {0} "use ".__PACKAGE__.";\n", minify $code and exit;

=head1 DESCRIPTION

When used inside a script, L<Acme::Compress> compresses all the code,
making it working normally, but in less space.

Due to the compression algorithm, the compression rate is noticeable only
for very big scripts.

=head1 AUTHOR

Alessandro Ghedini, C<< <alexbio at cpan.org> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::Compress

You can also look for information at:

=over 4

=item * Homepage

L<http://alexlog.co.cc/projects/acme-compress>

=item * Git Repository

L<http://github.com/AlexBio/Acme-Compress>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Acme-Compress>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Acme-Compress>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Acme-Compress>

=item * Search CPAN

L<http://search.cpan.org/dist/Acme-Compress/>

=back

=head1 SEE ALSO

L<Acme::Bleach> 
L<Acme::Palindrome>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Acme::Compress
