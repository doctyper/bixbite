/*
File: bootstrap.js

About: Version
	1.0

Project: __PROJECT_NAME__

Description:
	This should be included directly after the opening <body> tag.
	
	If a module required a <script> tag in the middle of the page
	markup, queue up the code in a function so that jQuery and other
	dependencies are available for the code runs.

Example:
	><script type="text/javascript">
	>	__PROJECT_NAMESPACE__.queue(function() {
	>		// do something with jQuery, etc
	>	});
	></script>
	> 
	>...
	> 
	>$(document).ready(function() {
	>	__PROJECT_NAMESPACE__.unqueue();
	>})
	
*/

/*
Class: __PROJECT_NAMESPACE__
	Scoped to the __PROJECT_NAMESPACE__ Global Namespace
*/
var __PROJECT_NAMESPACE__ = window.__PROJECT_NAMESPACE__ || {};

(function(__PROJECT_NAMESPACE__) {
	
	document.body.className += " js-enabled";
	
	var queue = [];
	
	/*
	method: queue
	 	Adds functions to a queuer to be deployed once the DOM is ready
	
	Parameters:
		arguments - the function (or functions) to add to the queue
	*/
	__PROJECT_NAMESPACE__.queue = function() {
		for (var i = -1, func; func = arguments[++i];) {
			queue[queue.length] = func;
		}
	};
	
	/*
	method: unqueue
	 	Fires each queued function
	*/
	__PROJECT_NAMESPACE__.unqueue = function() {
		var func;
		while (queue != null && (func = queue.shift())) {
			func();
		}
		
		// Nullify
		for (var i = (queue != null) ? queue.length - 1 : -1; i >= 0; i--) {
			queue[i] = null;
		}
		
		queue = null;
	};
	
}(__PROJECT_NAMESPACE__));