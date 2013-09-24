package Bigsite::Admin::C::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    $c->render('index.tt');
}

sub whatsnew {
    my ($class, $c) = @_;
    $c->render('whatsnew.tt' => { params => $c->args });
}

1;
