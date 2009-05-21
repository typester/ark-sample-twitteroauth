package TwitterOAuth;
use Ark;

our $VERSION = '0.01';

use_plugins qw/
    Session
    Session::State::Cookie
    Session::Store::Model
    /;

conf 'Plugin::Session::Store::Model' => {
    model => 'Session',
};

1;
