<?php
class Page extends __PROJECT_NAMESPACE__ {
	
	private static $instance;
	
	public function __construct() {
		$this->html  = new html($this);
	}
	
	public static function getInstance() {
		if (! self::$instance) {
			self::$instance = new Page();
		}
		return self::$instance;
	}
	
	public function output($contents, $template = false) {
		$dir = '';
		
		if ($template) {
			$dir = $template . '/';
		}
		
		include(INCLUDES_DIR . $dir . 'header.inc');
		echo $contents;
		include(INCLUDES_DIR . $dir . 'footer.inc');
	}
	
	public function enableCompression($status = true) {
		$this->compression = $status;
	}
	
	public function minify() {
		$status = (isset($this->compression)) ? $this->compression : false;
		return $status;
	}
	
	public function delayAjaxRequest($argv) {
		if ($argv == false) {
			
			set_time_limit(0); // Remove the time limit for command-line usage;
			
			// 100000 = 100ms
			usleep(500000);
			
		}
	}
	
	public function setPageTitle($title) {
		$this->title = $title;
	}
	
	public function getPageTitle() {
		$title = $this->title;
		return (isset($title)) ? $title : '';
	}
	
	public function setLoginStatus($status) {
		$this->status = $status;
	}
	
	public function isLoggedIn() {
		return (isset($this->status)) ? $this->status : false;
	}
	
	public function isNotLoggedIn() {
		return (isset($this->status)) ? false : true;
	}
	
	public function setStyles($styles) {
		$this->styles = $styles;
	}
	
	public function getStyles() {
		$styles = isset($this->styles) ? $this->styles : array();
		return $styles;
	}
	
	public function setScripts($scripts) {
		$this->scripts = $scripts;
	}
	
	public function setInlineScript($script) {
		if (!isset($this->inlineJS)) {
			$this->inlineJS = array();
		}
		
		$this->inlineJS[] = $script;
	}
	
	public function getInlineScripts() {
		return isset($this->inlineJS) ? $this->inlineJS : array();
	}
	
	public function getScripts() {
		$scripts = isset($this->scripts) ? $this->scripts : array();
		return $scripts;
	}
	
	public function setBodyClassNames($array) {
		$this->classnames = join(' ', $array);
	}
	
	public function getBodyClassNames() {
		return (isset($this->classnames)) ? $this->classnames : null;
	}
	
	public function setSectionName($string) {
		$this->section = $string;
	}
	
	public function getSectionName() {
		return $this->section;
	}
	
	public function listFilesInDirectory($directory, $extension = false) {

		// create an array to hold directory list
		$results = array();

		// create a handler for the directory
		$handler = opendir($directory);

		// keep going until all files in directory have been read
		while ($file = readdir($handler)) {

			// if $file isn't this directory or its parent, 
			// add it to the results array
			if ($file != '.' && $file != '..') {
				
				if ($extension) {
					$match = strstr($file, $extension);
					
					if ($match) {
						$results[] = $file;
					}
				} else {
					$results[] = $file;
				}
			}
		}

		// tidy up: close the handler
		closedir($handler);

		// done!
		return $results;
	}
}

?>