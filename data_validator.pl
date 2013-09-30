#!/usr/bin/perl
use strict;
use warnings;
use feature 'state';
use Test::More

use Data::Validator;

my $v = Data::Validator->new(
    foo => 'Num',
);

ok $v->find_rule('foo');

__END__

sub Foo::add {
    state $rule = Data::Validator->new(
        a => 'Int',
        b => 'Int',
    )->with('Method');
    my ($self, $args) = $rule->validate(@_);
        return $args->{a} + $args->{b};
    if($rule->has_errors) {
        return 'hogehoge';
    }
}
print Foo->add(a => 10, b => 20);

# sub add {
#     state $rule = Data::Validator->new(
#         a => 'Int',
#         b => 'Int',
#     )->with('Sequenced');
#     my $args = $rule->validate(@_);
#     return $args->{a} + $args->{b};
# }
# print add(10, 20);
# print add({a => 10, b => 20});
# print add(10, { b => 20 });

# sub foo {
#     state $rule = Data::Validator->new(
#         a => 'Int',
#         b => 'Int',
#     )->with('AllowExtra');
#     my ($args, %extra)  = $rule->validate(@_);
# }
# use Data::Dumper;
# print Dumper foo(a => 10, b => 20, c => 30);
