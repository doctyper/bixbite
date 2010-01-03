/*
File: global.js

About: Version
	1.0

Project: __PROJECT_NAME__

Description:
	A common file that includes all globally shared functionality for __PROJECT_NAMESPACE__

Requires:
	- LABjs <http://labjs.com/>
	- __JS_LIB__

Requires:
	- <bootstrap.js>
	
*/

/*
Class: __PROJECT_NAMESPACE__
	Scoped to the __PROJECT_NAMESPACE__ Global Namespace
*/
var __PROJECT_NAMESPACE__ = window.__PROJECT_NAMESPACE__ || {};

// When the DOM is ready.
(function () {
	
	// Storing a variable to reference
	var $self = __PROJECT_NAMESPACE__;
	
	/*
	Namespace: __PROJECT_NAMESPACE__.vars
		Shared global variables
	*/
	$self.vars = {
		
		/*
		variable: queue
			Contains the functions ready to be fired on DOM ready
		*/
		queue : []
	};
	
	/*
	Namespace: __PROJECT_NAMESPACE__.legacy
		A legacy namespace to be used if __PROJECT_NAMESPACE__ has any legacy dependencies
	*/
	$self.legacy = {};
	
	/*
	Namespace: __PROJECT_NAMESPACE__.utils
		Shared global utilities
	*/
	$self.utils = {
		
		/*
		sub: ie6Check
		 	Adds an IE6 flag to jQuery
		*/
		ie6Check : function() {
			// Let's set a flag for IE 6
			$.extend($.browser, {
				ie6 : function () {
					return !!($.browser.msie && $.browser.version == 6);
				}()
			});
		}(),
		
		/*
		sub: queue
		 	A global initializer. Takes a function argument and queues it until <init> is fired
		
		Parameters:
			object - The function to initialize when the DOM is ready
			
		Example:
			>__PROJECT_NAMESPACE__.utils.queue(function() {
			>	// Add code here
			>});
		*/
		queue : function (object) {
			$self.vars.queue.push(object);
		},
		
		/*
		sub: init
		 	When fired, loops through $self.vars.queue and fires each queued function
		*/
		init : function() {
			var queue = $self.vars.queue;

			$.each(queue, function(i, object) {
				for (var key in object) {
					if (object.hasOwnProperty(key) && (typeof object[key] === "function")) {
						object[key]();
					}
				}
				
			});
		}
	};
	
	/*
	Namespace: __PROJECT_NAMESPACE__
		Under the __PROJECT_NAMESPACE__ Local Namespace
	*/
	
	/*
	Function: global
	 	Takes care of a few global functionalities:
		- Fires __PROJECT_NAMESPACE__.unqueue
		- Overrides the default jQuery easing
		- Adds the IE BackgroundImageCache fix
	*/
	$self.global = function () {
		
		// Unqueue inline functions
		__PROJECT_NAMESPACE__.unqueue();
		
		if ($.browser.msie) {
			try {
				// Enable background image cache
			    document.execCommand("BackgroundImageCache", false, true);
			} catch (ex) {}
		}
	};
	
	/*
	Function: header
	 	Encapsulates functionality found in the #header space
	*/
	$self.header = function() {};
	
	/*
	Callback: init
		Sends local functions to a global queuer for initialization See: <__PROJECT_NAMESPACE__.utils.queue>
	*/
	$self.utils.queue($self);
	
}).call(__PROJECT_NAMESPACE__);