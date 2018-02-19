package main;

use strict;
use warnings;
use Test::More;
use Devel::IPerl;
use IPerl;
use lib 't/lib';
use FindBin;
use File::Spec::Functions qw{catfile};

$ENV{PERL_MODULECMD} = catfile $FindBin::Bin, qw{bin modulecmd};

my $iperl = new_ok('IPerl');

is $iperl->load_plugin('EnvironmentModules'), 1, 'loaded';

can_ok $iperl, qw{module_avail module_load module_list module_show module_unload};

for my $name(qw{avail list}){
  my $cb = $iperl->can("module_$name");
  is $iperl->$cb(), "$name\n", 'returns stderr';
}

my $cb = $iperl->can("module_show");
is $iperl->$cb(), -1, 'empty args == -1';
is $iperl->$cb('modulename'), "show\n", 'returns stderr';


done_testing
