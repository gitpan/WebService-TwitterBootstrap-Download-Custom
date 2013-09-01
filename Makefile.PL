
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Download a customized version of Twitter Bootstrap",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {},
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
    "Mojolicious" => "4.29",
    "Moose" => 0,
    "Path::Class" => "0.26",
    "Scalar::Util" => 0
  },
  "TEST_REQUIRES" => {
    "EV" => 0,
    "File::HomeDir::Test" => 0,
    "FindBin" => 0,
    "Mojo::Message::Response" => 0,
    "Test::Differences" => 0,
    "Test::More" => 0,
    "YAML" => 0,
    "base" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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



