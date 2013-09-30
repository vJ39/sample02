package Bigsite::PC::C::Entry;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    my $v = $c->validator(rule => +{
        page => {isa => 'Int', default => 1},
    });
#    $v->validate({ page => $c->req->param('page') });

    my $cond;
    if($v->is_success) {
        $cond = $v->valid_data;
    } else {
        $cond = {page => 1};
    }

    my ($entries, $pager) = $c->db->search_with_pager('entry' => {},
        {order_by => 'id desc', rows => 5, %$cond});
#    warn ref($entries->[0]);
    $c->render('/entry/index.tt', {entries => $entries, pager => $pager});
}

sub back {
    my ($class, $c) = @_;
    $c->req->param('body' => $c->session->set('body'));
    $c->session->remove('body');
    $class->index($c);
}

sub confirm {
    my ($class, $c) = @_;

#    my $result = $c->validator(+{
#        body => {isa => 'Int'},
#    })->validate();
#    if(!$result->is_success) {
#        return $c->render('/entry/index.tt', {errors => $result->get_errors});
#    }

    if(my $body = $c->req->param('body')) {
        $c->session->set('body' , $body);
    }
    return $c->render('/entry/confirm.tt', { req => $c->req });
}

sub complete {
    my ($class, $c) = @_;
    if(my $body = $c->session->get('body')) {
        $c->db->insert(
            'entry' => {
                body => $body,
            }
        );
        $c->session->remove('body');
    }
    return $c->render('/entry/complete.tt');
}

1;
