#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use utf8;

use List::Util qw(first);
use Test::More tests => 7;

BEGIN {
	use_ok('Travel::Status::DE::URA');
}
require_ok('Travel::Status::DE::URA');

my ($s, @results);

$s = Travel::Status::DE::URA->new(
	ura_base  => 'file:t/in',
	ura_version => 1,
	datetime  => DateTime->new(
		year   => 2013,
		month  => 12,
		day    => 23,
		hour   => 12,
		minute => 42,
		time_zone => 'Europe/Berlin'
	),
	hide_past => 0,
);

@results = $s->results;

# results[0]: "Kohlscheid Bahnhof","210717","34","34",1,"Kohlscheid Bahnhof","586"

is($results[0]->countdown, 2, '->countdown: 2');
is($results[0]->countdown_sec, 120, '->countdown_sec with sec 0 -> sec 0 : 120');
is($results[0]->date, '23.12.2013', '->date');
isa_ok($results[0]->datetime, 'DateTime', '->datetime is DateTime');
is($results[0]->time, '12:44:00', '->time');
