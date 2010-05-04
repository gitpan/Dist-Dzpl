package Dist::Dzpl::Plugin::CopyReadmeFromBuild;
BEGIN {
  $Dist::Dzpl::Plugin::CopyReadmeFromBuild::VERSION = '0.0010';
}

use Moose;
with qw/ Dist::Zilla::Role::AfterBuild /;

use File::Copy qw/ copy /;

sub after_build {
    my $self = shift;
    my $data = shift;

    my $build_root = $data->{build_root};
    my $src;
    for(qw/ README README.md README.txt README.markdown /) {
        my $file = $build_root->file( $_ );
        $src = $file and last if -e $file;
    }

    die "Missing README file" unless $src;

    my $dest = $self->zilla->root->file( $src->basename );

    copy "$src", "$dest" or die "Unable to copy $src to $dest: $!";
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Dzpl::Plugin::CopyReadmeFromBuild

=head1 VERSION

version 0.0010

=head1 AUTHOR

  Robert Krimen <robertkrimen@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

