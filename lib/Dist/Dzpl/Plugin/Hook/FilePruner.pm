package Dist::Dzpl::Plugin::Hook::FilePruner;
BEGIN {
  $Dist::Dzpl::Plugin::Hook::FilePruner::VERSION = '0.0001';
}

use Moose;
with qw/ Dist::Zilla::Role::FilePruner /;

has callback => qw/ is ro required 1 isa CodeRef /;

sub prune_files {
    my $self = shift;
    return $self->callback->( $self->zilla, $self );
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Dzpl::Plugin::Hook::FilePruner

=head1 VERSION

version 0.0001

=head1 AUTHOR

  Robert Krimen <robertkrimen@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

