
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Download a customized version of Twitter Bootstrap",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {
    "File::HomeDir::Test" => 0,
    "FindBin" => 0,
    "Mojo::Message::Response" => 0,
    "Test::Differences" => 0,
    "Test::More" => 0,
    "YAML" => 0,
    "base" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "WebService-TwitterBootstrap-Download-Custom",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "WebService::TwitterBootstrap::Download::Custom",
  "PREREQ_PM" => {
    "Archive::Zip" => 0,
    "DBD::SQLite" => 0,
    "DBI" => 0,
    "File::HomeDir" => 0,
    "File::Temp" => 0,
    "Mojo::DOM" => 0,
    "Mojo::JSON" => 0,
    "Mojo::UserAgent" => 0,
    "Moose" => 0,
    "Path::Class" => "0.26",
    "Scalar::Util" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



