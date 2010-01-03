/*
File: __PAGE_TEMPLATE_LOWERCASE__.js

About: Version
	1.0

Project: __PROJECT_NAME__

Description:
	Includes all __PAGE_TEMPLATE_CAPITALIZE__ functionality

Requires:
	- jQuery 1.3.2 - <http://jquery.com>
	- jQuery Flash - <jquery.flash.js>
	- jQuery Easing - <jquery.easing.js>

Requires:
	- <bootstrap.js>
	- <global.js>
	
*/

/*
Class: __PROJECT_NAMESPACE__
	Scoped to the __PROJECT_NAMESPACE__ Global Namespace
*/
var __PROJECT_NAMESPACE__ = window.__PROJECT_NAMESPACE__ || {};

/*
Namespace: __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__
	Under the __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__ Local Namespace
*/
__PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__ = __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__ || {};

(function () {
	
	// Storing a variable to reference
	var $space = __PROJECT_NAMESPACE__;
	var $self = $space.__PAGE_TEMPLATE_CAPITALIZE__;
	
	/*
	Namespace: __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__.vars
		Shared local variables
	*/
	$self.vars = $.extend($space.vars, {});
	
	/*
	Namespace: __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__.utils
		Shared local utilities
	*/
	$self.utils = $.extend($space.utils, {});
	
	/*
	Namespace: __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__
		Under the __PROJECT_NAMESPACE__.__PAGE_TEMPLATE_CAPITALIZE__ Local Namespace
	*/
	
	/*
	Function: sample
	 	A sample function
	*/
	$self.sample = function() {
		
	};
	
	/*
	Callback: queue
		Sends local functions to a global queuer for initialization See: <__PROJECT_NAMESPACE__.utils.queue>
	*/
	$space.utils.queue($self);
	
})();