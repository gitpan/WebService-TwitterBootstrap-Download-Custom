package WebService::TwitterBootstrap::Download::Custom::Zip;

use strict;
use warnings;
use File::Temp ();
use Archive::Zip ();
use Path::Class qw( dir );
use Moose;

# ABSTRACT: Zip file containing Twitter Bootstrap
our $VERSION = '0.03'; # VERSION


has file => (
  is      => 'rw',
  isa     => 'File::Temp',
  lazy    => 1,
  default => sub { 
    # TODO: does this need to be binmoded for Win32?
    File::Temp->new(
      TEMPLATE => "bootstrapXXXXXX", 
      SUFFIX   => '.zip',
      DIR      => File::Spec->tmpdir,
    );
  }, 
);

has archive => (
  is      => 'rw',
  isa     => 'Archive::Zip',
  lazy    => 1,
  default => sub {
    Archive::Zip->new(shift->file->filename);
  },
);


has member_names => (
  is      => 'ro',
  isa     => 'ArrayRef[Str]',
  lazy    => 1,
  default => sub {
    [grep !m{/$}, shift->archive->memberNames],
  },
);


sub member_content
{
  my($self, $name) = @_;
  my($content, $status) = $self->archive->contents($name);
  die "$status" unless $status == Archive::Zip::AZ_OK;
  return $content;
}


sub extract_all
{
  my($self, $dir) = @_;
  foreach my $member_name (@{ $self->member_names })
  {
    my $member_file = dir($dir)->file($member_name);
    $member_file->dir->mkpath(0,0755);
    $member_file->spew($self->member_content($member_name));
  }
  $self;
}

sub spew
{
  my($self, $content) = @_;
  if(ref($content) eq 'Path::Class::File')
  {
    $self->archive(
      Archive::Zip->new($content->stringify),
    );
  }
  else
  {
    $self->file->print($content);
    $self->file->close;
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

WebService::TwitterBootstrap::Download::Custom::Zip - Zip file containing Twitter Bootstrap

=head1 VERSION

version 0.03

=head1 DESCRIPTION

This class represents the zip file downloaded from the 
Twitter Bootstrap website.

=head1 ATTRIBUTES

=head2 $zip-E<gt>member_names

Returns a list reference containing the name of all the members inside
the zip file.

=head1 METHODS

=head2 $zip-E<gt>member_content( $name )

Returns the content of the given members name.

=head2 $zip-E<gt>extract_all( $dir )

Extract all members of the zip to the given directory.

=head1 CAVEATS

This class uses L<Archive::Zip> internally, but that may
change in the future so only use the documented methods.

=cut

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
