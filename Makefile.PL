use inc::Module::Install;
name 'TwitterOAuth';
all_from 'lib/TwitterOAuth.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
