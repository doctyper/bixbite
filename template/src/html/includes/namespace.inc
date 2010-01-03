<?php

class __PROJECT_NAMESPACE__ {}

define('SITE_ROOT', dirname(__FILE__) . '/../');
define('INCLUDES_DIR', SITE_ROOT . 'includes/');

// Required Files
require_once('page.inc');
require_once('html.inc');

// Debug Enabled
require_once('debug.inc');

// Begin template
$page = Page::getInstance();
$page->enableCompression(false);

?>