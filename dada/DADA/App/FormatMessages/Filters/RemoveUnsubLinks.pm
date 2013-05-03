package DADA::App::FormatMessages::Filters::RemoveUnsubLinks;
use strict; 

use lib qw(
	../../../../
	../../../../DADA/perllib
); 

use vars qw($AUTOLOAD); 
use DADA::Config qw(!:DEFAULT);

use Carp qw(croak carp); 
use HTML::LinkExtor; 
use URI::file; 
use URI; 

# Need to ship with: 
use DADA::App::Guts; 

my $t = 0; 

my %allowed = (

);

sub new {

	my $that = shift; 
	my $class = ref($that) || $that; 
	
	my $self = {
		_permitted => \%allowed, 
		%allowed,
	};
	
	bless $self, $class;
	
	my $args = (@_); 
    
   $self->_init($args); 
   return $self;

}




sub AUTOLOAD { 
    my $self = shift; 
    my $type = ref($self) 
    	or croak "$self is not an object"; 
    	
    my $name = $AUTOLOAD;
       $name =~ s/.*://; #strip fully qualifies portion 
    
    unless (exists  $self -> {_permitted} -> {$name}) { 
    	croak "Can't access '$name' field in object of class $type"; 
    }    
    if(@_) { 
        return $self->{$name} = shift; 
    } else { 
        return $self->{$name}; 
    }
}





sub _init  {

	my $self    = shift; 
	my ($args)  = @_;
	
}


sub filter { 
	my $self   = shift; 
	my ($args) = @_; 
	my $html;
	
	if(exists($args->{-data})){ 
		$args->{-html_msg} = $self->remove_unsub_links($args->{-data}); 
		return $args->{-html_msg}; 
	}
	else { 
		croak "you MUST pass your HTML message in, 'html_msg'!"; 
	}

}


sub remove_unsub_links { 
	my $self = shift; 
	my $str  = shift; 
	# list mid hash
	
	$str =~ s{$DADA::Config::PROGRAM_URL/u/([a-zA-Z0-9_]*?)/([0-9].*)/([a-zA-Z0-9_]*?)/}{$DADA::Config::PROGRAM_URL/u/$1/$2/REMOVED/}g;
	
	return $str; 
	
}




1;