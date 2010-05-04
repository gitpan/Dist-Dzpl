package Dist::Dzpl::Plugin::Prune;
BEGIN {
  $Dist::Dzpl::Plugin::Prune::VERSION = '0.0010';
}

use Moose;
with qw/ Dist::Zilla::Role::FilePruner /;

has pruner => qw/ is ro lazy_build 1 isa CodeRef /;
sub _build_pruner { die "Missing prune" }

sub prune_files {
    my $self = shift;

    my $prune = $self->pruner;
    my $files = $self->zilla->files;
    @$files = grep {
        my $file = $_;
        local $_ = $file->name;
        if ( $prune->( $file ) ) {
            $self->log_debug([ 'pruning %s', $file->name ]);
            0;
        }
        else {
            1;
        }
    } @$files;

    return;

}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Dzpl::Plugin::Prune

=head1 VERSION

version 0.0010

=head1 AUTHOR

  Robert Krimen <robertkrimen@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

