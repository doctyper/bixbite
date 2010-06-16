			<!-- Start [#footer] -->
			<div id="footer">
				
			</div>
			<!-- End [#footer] -->
			
		</div>
		<!-- End [#wrapper] -->
		
		<!-- Start [JavaScript Includes] -->
		
		<script type="text/javascript">
			// Global Includes
			// Loaded using LABjs
			$LAB
			
<?php if ($this->minify()) : ?>
			// Global Minified JS
			.script("/js/cmn/global-min.js")<?php else: ?>
			// jQuery
			.script("/js/cmn/lib/__JS_LIB_LOWERCASE__-latest.js").wait()
			
			// Global JS
			.script("/js/cmn/global.js")<?php endif; 
			if (count($this->getScripts())) {
				echo ".wait()"; ?>


			// Page-level Includes
			<?php 
			
				$scripts = $this->getScripts();
				$count = count($scripts);
				$i = 0;
			
				foreach ($scripts as $script) {
					$i++;
					$output = ".script(\"$script\")";
				
					if ($count != $i) {
						$output .= ".wait()\n\t\t\t";
					}
				
					echo $output;
				}
			} ?>


			// Fire when everything is loaded
			.wait(function() {
				__PROJECT_NAMESPACE__.utils.init();
			});
		</script>

	</body>
</html>