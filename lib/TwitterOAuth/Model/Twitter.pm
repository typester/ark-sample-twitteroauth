package TwitterOAuth::Model::Twitter;
use Ark 'Model::Adaptor';

use YAML::Syck qw/LoadFile/;

__PACKAGE__->config(
    class => 'Net::Twitter::OAuth',
    args  => LoadFile(TwitterOAuth->path_to('twitter.yaml')),
    deref => 1,
);

1;

