package Bigsite::Admin;
use strict;
use warnings;
use utf8;
use parent qw(Bigsite Amon2::Web);
use File::Spec;

# dispatcher
use Bigsite::Admin::Dispatcher;
sub dispatch {
    return (Bigsite::Admin::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# setup view
use Bigsite::Admin::View;
{
    my $view = Bigsite::Admin::View->make_instance(__PACKAGE__);
    sub create_view { $view }
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::CSRFDefender' => {
        post_only => 1,
    },
);

sub show_error {
    my ( $c, $msg, $code ) = @_;
    my $res = $c->render( 'error.tt', { message => $msg } );
    $res->code( $code || 500 );
    return $res;
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
