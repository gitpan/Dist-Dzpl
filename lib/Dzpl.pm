package Dzpl;
BEGIN {
  $Dzpl::VERSION = '0.0001';
}

use strict;
use warnings;

BEGIN {
    use vars qw/ @ISA @EXPORT /;
    @ISA = qw/ Exporter /;
    @EXPORT = qw/ plugin run prune /;
}

use Dist::Dzpl;

our $dzpl;

sub import {
    my @arguments = splice @_, 1;

    strict->import;
    warnings->import;

    die "Already initialized Dist::Dzpl!" if $dzpl;
    $dzpl ||= Dist::Dzpl->prepare( @arguments );

    
    @_ = ( $_[0] );
    goto &Exporter::import;
}

sub plugin {
    $dzpl->plugin( @_ );
}

sub prune (&) {
    $dzpl->prune( @_ );
}

sub run (;&) {

    $dzpl->zilla->_setup_default_plugins;

    my $default = sub {
        my @arguments = @_;
        return unless @arguments;
        my $command = shift @arguments;
        if ( $command eq 'dzil' ) {
            require Dist::Zilla::App;
            my $app = Dist::Zilla::App->new;
            $app->{__chrome__} = $dzpl->zilla->chrome;
            $app->{__PACKAGE__}{zilla} = $dzpl->zilla;
            local @ARGV = @arguments;
            $app->run;
        }
        else {
            $dzpl->zilla->$command;
        }
    };

    if ( my $run = shift ) {
        $run->( $default, $dzpl );
    }
    else {
        $default->( @ARGV );
    }
}

1;

__END__
=pod

=head1 NAME

Dzpl

=head1 VERSION

version 0.0001

=head1 AUTHOR

  Robert Krimen <robertkrimen@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

