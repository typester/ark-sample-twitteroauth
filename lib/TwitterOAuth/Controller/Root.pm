package TwitterOAuth::Controller::Root;
use Ark 'Controller';

has '+namespace' => default => '';

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
}

sub require_auth :Local :Args(0) {
    my ($self, $c) = @_;
}

sub make_tweet :Local :Args(0) {
    my ($self, $c) = @_;

    my $access_token        = $c->session->get('access_token');
    my $access_token_secret = $c->session->get('access_token_secret');

    $c->redirect_and_detach( $c->uri_for('/require_auth') )
        unless $access_token_secret && $access_token_secret;

    my $client = $c->model('Twitter');
    $client->oauth->access_token( $access_token );
    $client->oauth->access_token_secret( $access_token_secret );

    my $status = join '', shuffle(split //, 'うんこ');
    $client->update({ status => $status });
}

sub twitter_authorize :Local :Args(0) {
    my ($self, $c) = @_;

    my $client = $c->model('Twitter');
    my $url    = $client->oauth->get_authorization_url;

    $c->session->set( request_token => $client->oauth->request_token );
    $c->session->set( request_token_secret => $client->oauth->request_token_secret );

    $c->redirect_and_detach($url);
}

sub twitter_auth_callback :Local :Args(0) {
    my ($self, $c) = @_;

    my $request_token        = $c->session->get('request_token');
    my $request_token_secret = $c->session->get('request_token_secret');

    $c->detach( $c->uri_for('/default') )
        unless $request_token && $request_token_secret;

    my $client = $c->model('Twitter');
    $client->oauth->request_token( $request_token );
    $client->oauth->request_token_secret( $request_token_secret );

    my ($access_token, $access_token_secret) = $client->oauth->request_access_token;
    $c->session->set( access_token => $access_token );
    $c->session->set( access_token_secret => $access_token_secret );

    $c->redirect_and_detach( $c->uri_for('/twitter_auth_complete') );
}

sub twitter_auth_complete :Local :Args(0) {
    my ($self, $c) = @_;
}

sub end :Private {
    my ($self, $c) = @_;

    $c->res->header('Content-Type' => 'text/html; charset=utf-8');
    $c->res->header('Cache-Control' => 'private');

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        $c->forward( $c->view('MT') );
    }
}

# copy and paste from List::Util
sub shuffle (@) {
  my @a=\(@_);
  my $n;
  my $i=@_;
  map {
    $n = rand($i--);
    (${$a[$n]}, $a[$n] = $a[$i])[0];
  } @_;
}

1;
