package Bigsite::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Bigsite::DB::Row';

table {
    name 'entry';
    pk 'id';
    columns qw(id body ctime);
};

# table {
#     name 'member';
#     pk 'id';
#     columns qw(id name);
# };

1;
