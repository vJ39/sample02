package Bigsite::PC::C::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) =@_;
    my $page = $c->req->param('page') || 1;
    my ($entries, $pager) = $c->db->search_with_pager('entry' => {},
        {order_by => 'id desc', page => $page, rows => 5});
    warn ref($entries->[0]);
    $c->render('index.tt', {entries => $entries, pager => $pager});
}

1;
