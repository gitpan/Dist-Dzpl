package Dist::Dzpl::Plugin::DynamicManifest;
BEGIN {
  $Dist::Dzpl::Plugin::DynamicManifest::VERSION = '0.0001';
}

use Moose;
extends qw/ Dist::Dzpl::Plugin::Prune /;

sub _build_pruner {
    return sub { m{^(?!
        bin/|
        script/|
        TODO$|
        lib/.+(?<!ROADMAP)\.p(m|od)$|
        inc/|
        t/|
        Makefile.PL$|
        README$|
        MANIFEST$|
        Changes$|
        META.yml$
    )}x }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Dzpl::Plugin::DynamicManifest

=head1 VERSION

version 0.0001

=head1 AUTHOR

  Robert Krimen <robertkrimen@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

