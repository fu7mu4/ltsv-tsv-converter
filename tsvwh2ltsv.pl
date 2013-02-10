#!perl
#

=head1 name

tsvwh2ltsv

=head1 abstruct

convert tsv with header to ltsv

ltsv is super ! but tsv with header is useful for spreadsheet tool like MS Excel, or LibreOffice.

ltsv format
foo:1\tbar:2\tbaz:3
foo:4\tbar:5\tbaz:6
foo:7\tbar:8\tbaz:9

tsv with header
foo\tbar\tbaz
1\t2\t3
4\t5\t6

=head1 usage

tsvwh2ltsv.pl foo.tsv > foo.ltsv

=head1 author

fu7mu4@gmail.com

=head1 License

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 version

0.50 first release

=cut

use strict;
use warnings;
use utf8;

our $LABEL_SPLITER = ":";
our $VALUE_SPLITER = "\t";
our @head_keys = ();
while(<>){
    chomp;
    my @body_values = ();

    if ($. eq 1){
        @head_keys = split(/\t/);     # first line must be header of tsv
    } else {
        @body_values = split(/\t/);

        for( my $i = 0; $i <= $#head_keys ; $i++){
            print("$head_keys[$i]" . $LABEL_SPLITER . defined($body_values[$i]) ? $body_values[$i] : "" . $VALUE_SPLITER);
        }
        print("\n");
    }
}
