#!/usr/bin/php

<?php

define('MINIFY_MIN_DIR', dirname(__FILE__));

// load config
require MINIFY_MIN_DIR . '/config.php';

// setup include path
set_include_path($min_libPath . PATH_SEPARATOR . get_include_path());

require_once 'Minify.php'; 

array_shift($argv);
$out = Minify::combine($argv); 
// file_put_contents($outputPath, $out); 
echo $out;
?>
