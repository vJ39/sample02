package Bigsite::PC::C::Image;
use strict;
use warnings;
use utf8;
use Imager;
use Image::Info qw/image_type/;
use File::Copy qw/copy move/;
use String::Random;

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
    $c->render('/image/index.tt', {entries => $entries, pager => $pager});
}

sub back {
    my ($class, $c) = @_;
    my $rand = $c->session->get('body');
    unlink(File::Spec->catfile($c->base_dir, "static/pc/image/tmp/$rand.png"));
    $c->session->remove('body');
    $class->index($c);
}

sub confirm {
    my ($class, $c) = @_;

    my $body = $c->req->upload('body');
    open my $fh, '<',  $body->tempname;
    my $imager = Imager->new()->read(fh => $fh);
    my $rand = String::Random->new()->randregex('[A-Za-z0-9]{8}');
    my $newname = File::Spec->catfile($c->base_dir, "static/pc/image/tmp/$rand.png");
    $imager->scale(xpixels => 240)->write(file => $newname, type => 'png');
    close $fh;
    $c->session->set('body' => $rand);
    return $c->render('/image/confirm.tt', { req => $c->req, rand => $rand });
}

sub complete {
    my ($class, $c) = @_;
    if(my $rand = $c->session->get('body')) {
        my $oldname = File::Spec->catfile($c->base_dir, "static/pc/image/tmp/$rand.png");
        my $newname = File::Spec->catfile($c->base_dir, "static/pc/image/$rand.png");
        move $oldname, $newname;
        $c->db->insert('entry' => {
            body => $rand,
        });
        $c->session->remove('body');
    }
    return $c->render('/image/complete.tt');
}

1;
