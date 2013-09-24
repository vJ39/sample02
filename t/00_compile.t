use strict;
use warnings;
use Test::More;

use_ok $_ for qw(
    Bigsite
    Bigsite::PC
    Bigsite::PC::Dispatcher
    Bigsite::PC::C::Root
    Bigsite::PC::C::Account
    Bigsite::PC::ViewFunctions
    Bigsite::PC::View
    Bigsite::Admin
    Bigsite::Admin::Dispatcher
    Bigsite::Admin::C::Root
    Bigsite::Admin::ViewFunctions
    Bigsite::Admin::View
);

done_testing;
