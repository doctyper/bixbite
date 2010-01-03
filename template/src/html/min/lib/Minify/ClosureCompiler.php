<?php
/**
 * Class Minify_ClosureCompiler 
 * @package Minify
 */

/**
 * Compress Javascript using the Google Closure Compiler
 * 
 * You must set $jarFile and $tempDir before calling the minify functions.
 * Also, depending on your shell's environment, you may need to specify
 * the full path to java in $javaExecutable or use putenv() to setup the
 * Java environment.
 * 
 * <code>
 * Minify_ClosureCompiler::$jarFile = '/path/to/yuicompressor-2.3.5.jar';
 * Minify_ClosureCompiler::$tempDir = '/tmp';
 * $code = Minify_ClosureCompiler::minifyJs(
 *   $code
 *   ,array('nomunge' => true, 'line-break' => 1000)
 * );
 * </code>
 * 
 * @package Minify
 * @author Richard Herrera <rich@doctyper.com>
 */
class Minify_ClosureCompiler {

    /**
     * Filepath of the Closure Compiler jar file. This must be set before
     * calling minifyJs()
     *
     * @var string
     */
    public static $jarFile = null;
    
    /**
     * Writable temp directory. This must be set before calling minifyJs()
     *
     * @var string
     */
    public static $tempDir = null;
    
    /**
     * Filepath of "java" executable (may be needed if not in shell's PATH)
     *
     * @var string
     */
    public static $javaExecutable = 'java';
    
    /**
     * Minify a Javascript string
     * 
     * @param string $content
     * 
     * @param array $options (verbose is ignored)
     * 
     * @return string 
     */
    public static function minifyJs($content, $options = array())
    {
        self::_prepare();
        if (!($tmpFile = tempnam(self::$tempDir, 'gc_'))) {
            throw new Exception('Minify_ClosureCompiler : could not create temp file.');
        }
        file_put_contents($tmpFile, $content);
        $output = exec(self::_getCmd($options, $tmpFile));
        exec(self::_getCmd($options, $tmpFile), $output);
        unlink($tmpFile);
        return implode("", $output);
    }
    
    private static function _getCmd($userOptions, $tmpFile)
    {
        $cmd = self::$javaExecutable . ' -jar ' . escapeshellarg(self::$jarFile);
        return $cmd . ' --js ' . escapeshellarg($tmpFile);
    }
    
    private static function _prepare()
    {
        if (!is_file(self::$jarFile) || !is_dir(self::$tempDir) || !is_writable(self::$tempDir)) {
            throw new Exception('Minify_ClosureCompiler : $jarFile and $tempDir must be set.');
        }
    }
}