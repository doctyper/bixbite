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
			.script("/js/cmn/global-min.js").wait()<?php else: ?>
			// __JS_LIB__
			.script("/js/cmn/lib/__JS_LIB_LOWERCASE__-latest.js").wait()
			
			// Global JS
			.script("/js/cmn/global.js").wait()<?php endif; ?><?php if (count($this->getScripts())) { echo "
			
			// Page-level Includes"; } ?>
				
			<?php 
			
			$scripts = $this->getScripts();
			$count = count($scripts);
			$i = 0;
			
			foreach ($scripts as $script) {
				$i++;
				$output = ".script(\"$script\")";
				
				if ($count == $i) {
					$output .= "\n\t\t\t\n\t\t\t// Fire when everything is loaded\n\t\t\t.wait(function() {\n\t\t\t\t__PROJECT_NAME__.utils.init();\n\t\t\t});";
				} else {
					$output .= ".wait()\n\t\t\t";
				}
				
				echo $output;
			}
			
			?>

		</script>

	</body>
</html>