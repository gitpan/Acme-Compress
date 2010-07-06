use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::Compress',
    AUTHOR              => q{Alessandro Ghedini <alexbio@cpan.org>},
    VERSION_FROM        => 'lib/Acme/Compress.pm',
    ABSTRACT_FROM       => 'lib/Acme/Compress.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' 		   => 0,
        'Compress::LZMA::External' => 0,
	'URI::Escape' 		   => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-Compress-*' },
);
