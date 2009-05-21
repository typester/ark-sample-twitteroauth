package TwitterOAuth::Model::Session;
use Ark 'Model::Adaptor';

__PACKAGE__->config(
    class => 'Cache::FastMmap',
    args  => {
        share_file => TwitterOAuth->path_to('tmp/session')->stringify,
    },
);

1;

