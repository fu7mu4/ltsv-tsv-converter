#!perl

=head1 name

ltsv2tsvwh

=head1 abstruct

convert ltsv to tsv with header

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

ltsv2tsvwh.pl foo.ltsv > foo.tsv

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

our @body = ();
our @header = ();

our $VALUE_SPLITER = "\t";

while(<>){
    chomp;
    my @labeled_values = split(/\t/);
    my %lvhash ;
    foreach my $lv (@labeled_values) {
        if($lv =~ m/(^[^:]+):(.*$)/){
            my ($label, $value) = ($1, $2);
            $lvhash{$label} = $value;

            my $found = 0;
            foreach my $el (@header){
                if($el eq $label){
                    $found = 1;
                }
            }
            if( $found eq 0){
                push @header, $label;
            }
        }
    }

    push @body, \%lvhash;
}

foreach my $label (@header){
    print $label.$VALUE_SPLITER;
}
print "\n";

foreach my $hash (@body){
    foreach my $label (@header){
        print defined($hash->{$label}) ? $hash->{$label} : "" ;
        print $VALUE_SPLITER;
    }
    print "\n";
}
