<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		
		<!-- Meta Elements Required to pass WAI Priority 2 -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<!-- Treat IE8 as IE8, Fall back to Google Chrome Frame -->
		<meta http-equiv="X-UA-Compatible" content="IE=8,chrome=1" />
		
		<title>__PROJECT_NAME__ - <?php echo $this->getPageTitle(); ?></title>
		
		<!-- Meta Elements Required to pass WAI Priority 2 -->
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		
		<!-- Start [CSS Includes] -->
		<!-- Global CSS -->
		<link rel="stylesheet" href="/css/cmn/global.css" type="text/css" media="all" />

<?php
		foreach($this->getStyles() as $style) {
			echo '		<link rel="stylesheet" href="' . $style . '" type="text/css" media="all" />' . "\n";
		}
?>
		
		<!-- IE Specific Code -->
		<!--[if IE]><link rel="stylesheet" href="/css/cmn/ie.css" type="text/css" media="all" /><![endif]-->
		<!--[if IE 6]><link rel="stylesheet" href="/css/cmn/ie6.css" type="text/css" media="all" /><![endif]-->
		<!-- End [CSS Includes] -->
		
	</head>
	<body<?php $cn = $this->getBodyClassNames(); echo (isset($cn) ? ' class="' . $cn . '"' : ''); ?>>
		
		<!-- Start [Bootstrap] -->
		<!-- Allows for JavaScript to exist at the bottom of the page, while still including inline JavaScript -->
<?php if ($this->minify()) : ?>
		<script src="/js/cmn/bootstrap-min.js" type="text/javascript"></script>
<?php else: ?>
		<script src="/js/cmn/bootstrap.js" type="text/javascript"></script>
		<script src="/js/cmn/lib/LAB.js" type="text/javascript"></script>
<?php endif; ?>
		<!-- End [Bootstrap] -->
		
		<!-- Start [#wrapper] -->
		<div id="wrapper">
			<!-- Start [#header] -->
			<div id="header">
	
				<!-- Skip Navigation Link -->
				<a class="skiplink" href="#content">Skip over navigation</a>
				
				<!-- Start [#logo] -->
				<div id="logo">
					<a href="/">__PROJECT_NAME__</a>
				</div>
				<!-- End [#logo] -->
				
			</div>
			<!-- End [#header] -->
