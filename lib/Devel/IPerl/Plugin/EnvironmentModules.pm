package Devel::IPerl::Plugin::EnvironmentModules;

use strict;
use warnings;
use Env::Modulecmd ();

our $VERSION = '0.01';

sub load { shift; Env::Modulecmd::_modulecmd('load', @_); }
sub list { shift; Env::Modulecmd::_modulecmd('list');     }
sub new  { bless {}, $_[0]; }

sub register {
    my ($class, $iperl) = @_;
    my $self = $class->new;
    for my $name(qw{load unload list show}) {
      $iperl->helper("module_$name" => sub {
          my ($ip, $ret) = (shift, -1);
          return $ret if @_ == 0;
          my $cb = $self->can($name);
          return $self->$cb(@_);
      });
    }
    return 1;
}

sub show   { shift; Env::Modulecmd::_modulecmd('show', @_);   }
sub unload { shift; Env::Modulecmd::_modulecmd('unload', @_); }

1;

=pod

=head1 NAME

Devel::IPerl::Plugin::EnvironmentModules - Environment Modules

=begin html

<!-- Travis -->
<a href="https://travis-ci.org/kiwiroy/Devel-IPerl-Plugin-EnvironmentModules">
  <img src="https://travis-ci.org/kiwiroy/Devel-IPerl-Plugin-EnvironmentModules.svg?branch=master"
       alt="Build Status" />
</a>

<!-- Coveralls -->
<a href="https://coveralls.io/github/kiwiroy/Devel-IPerl-Plugin-EnvironmentModules?branch=master">
  <img src="https://coveralls.io/repos/github/kiwiroy/Devel-IPerl-Plugin-EnvironmentModules/badge.svg?branch=master"
       alt="Coverage Status" />
</a>

<!-- Kritika -->
<a href="https://kritika.io/users/kiwiroy/repos/6049167555239475/heads/master/">
  <img src="https://kritika.io/users/kiwiroy/repos/6049167555239475/heads/master/status.svg"
       alt="Kritika Analysis Status" />
</a>

=end html

=head1 DESCRIPTION

When you have environment modules to work with.

=head1 SYNOPSIS

  IPerl->load_plugin('EnvironmentModules') unless IPerl->can('module_load');
  IPerl->module_load('git');
  IPerl->module_unload('git');

=head1 INSTALLATION AND REQUISITES

=head1 IPerl Interface Method

=head2 register

Called by C<<< IPerl->load_plugin('EnvironmentModules') >>>.

=head1 REGISTERED METHODS

=head2 module_load

=head2 module_list

=head2 module_show

=head2 module_unload

=head1 INTERNAL METHODS

Not for end user consumption.

=head2 load

=head2 list

=head2 new

=head2 show

=head2 unload

=cut
