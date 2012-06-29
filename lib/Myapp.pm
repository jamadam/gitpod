package Myapp;
use strict;
use warnings;
use Mojo::Base 'Marquee';

use File::Basename 'dirname';
use File::Spec;
use Mojo::UserAgent;
use Marquee::Plugin::PODViewer;

    sub new {
        my $self = shift->SUPER::new(@_);
        
        $self->document_root(join '/', File::Spec->splitdir(dirname(__FILE__)), './');
        my $pv = $self->plugin('PODViewer', {no_route => 1, no_see_also => 1});
        
        $self->plugin(Router => sub {
            shift->route(qr{^/$})->to(sub {
                my $url = Marquee->c->tx->req->param('u');
                
                if ($url !~ m{https?://github.com/}) {
                   exit;
                }
                
                my $ua = Mojo::UserAgent->new;
                $ua->max_redirects(5);
                $pv->serve_pod($ua->get($url)->res->body);
            });
        });
        
        return $self;
    }

1;
