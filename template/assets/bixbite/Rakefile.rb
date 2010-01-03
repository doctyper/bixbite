#!/usr/bin/ruby

require "yaml"
require "fileutils"
require "highline/import"
  
# YAML Files
@config = YAML.load_file(File.join("src", "yaml", "config.yml"))
@deploy = YAML.load_file(File.join("src", "yaml", "deploy.yml"))

@dirs = @config["directories"]
@project = File.expand_path(File.dirname(__FILE__)).split(@dirs["assets"]["root"][0])[0]

# Globals
@globs = {
  :project => @project,
  :utilities => @dirs["assets"]["utilities"][0],
  :deploy => @dirs["deploy"]["public_html"]["root"][0],
  :source => @dirs["src"][0],
  :html => @dirs["src"]["html"][0],
  :yaml => @dirs["src"]["yaml"][0],
  :template_path => @dirs["src"]["templates"][0],
  :name => @config["name"][0],
  :namespace => @config["namespace"][0],
  :natdocs => @dirs["assets"]["natural-docs"][0],
  :jsdocs => @dirs["documentation"]["js-docs"][0]
}

@globs[:files] = Dir[File.join(@globs[:project], @globs[:template_path], "**/*.*")]

desc "Prep deploy files"
task :prep => ["files:generate", "documentation:generate", "svn:prep"] do
  puts "Ready for commit!"
end

namespace :bixbite do
  
  desc "Generates a new HTML page and its associated CSS/JS files"
  task :page do
    
    def make_new_files
      name = @globs[:page_name]
      fname = @globs[:page_filename]

      @globs[:files].each do |file|
        new_file = File.join(@globs[:html], file.split(@globs[:template_path])[1].gsub(/template/, fname))
        dest = File.dirname(new_file)
        
        puts "Creating #{new_file}"
        
        FileUtils.mkpath(dest)
        FileUtils.cp(file, new_file) unless File.directory?(file)
        
        caps = name.split(" ").each{|word| word.capitalize!}.join(" ")
        File.open(new_file, "r+") do |f|
          lines = f.readlines
          lines.each do |line|
            line.gsub!(/__PAGE_TEMPLATE_UPPERCASE__/, fname.upcase);
            line.gsub!(/__PAGE_TEMPLATE_LOWERCASE__/, fname.downcase);
            line.gsub!(/__PAGE_TEMPLATE_CAPITALIZE__/, fname.capitalize);
            line.gsub!(/__PAGE_NAME_CAPITALIZE__/, caps);
            line.gsub!(/__PROJECT_NAME__/, @globs[:name]);
            line.gsub!(/__PROJECT_NAMESPACE__/, @globs[:namespace]);
          end
          f.pos = 0
          f.print lines
          f.truncate(f.pos)
        end
      end
      
      puts "Done!"
    end
    
    @globs[:page_name] = ask('Name of page? (i.e. "Foo Page")  ')
    @globs[:page_filename] = ask('Page file name? (i.e. foo-page)  ')
    
    make_new_files
  end
end

namespace :svn do
  
  desc "Prepares directory for svn commit"
  task :prep => [:add, :remove, :diff]
  
  desc "Adds files with an svn status flag of '?'"
  task :add do
    puts "Adding new files to version control..."
    system %(svn status | awk '/\\?/ {print $2}' | xargs svn add)
  end

  desc "Removes files with an svn status flag of '!'"
  task :remove do
    puts "Removing missing files from version control..."
    system %(svn status | awk '/\\!/ {print $2}' | xargs svn remove)
  end
  
  desc "Generates diff file with current committed revision"
  task :diff do
    puts "Generating diff..."
    diff = File.join(@globs[:deploy], @globs[:name] + ".diff")
    system %(svn diff -r COMMITTED #{@globs[:deploy]} > '#{diff}')
  end
end

namespace :documentation do
  desc "Render NaturalDocs documentation"
  task :generate do
    def render_documentation(executable, input, output, project_path)
      system %(#{executable} -i #{input} -o HTML #{output} -p #{project_path})
    end

    puts "Parsing JavaScript documentation..."
    render_documentation File.join(@globs[:natdocs], "NaturalDocs", "NaturalDocs"), File.join(@globs[:deploy], "js"), @globs[:jsdocs], @globs[:natdocs]
  end
end

namespace :png do
  desc "Compresses PNGs with pngout"
  task :compress do
    pngs = Dir[File.join(@globs[:html], "**/*.png")]
    original_total = new_total = 0
    pngs.each do |png|
      original = File.size(png)
      original_total += original
      system %(#{File.join(@globs[:utilities], "pngout")} #{png} -kbKGD -y)
      new_size = File.size(png)
      new_total += new_size
      puts "\n"
    end
    puts %(Original Size: #{original_total})
    puts %(New Size: #{new_total})
    puts %(Change: #{original_total - new_total})
  end
  
  desc "Adds a white background fallback for < IE 6 support. Files render with full transparency in all other browsers."
  task :ie6 do
    error = "This task requires ImageMagick. Download at http://www.imagemagick.org/"
    pngs = Dir[File.join(@globs[:html], "**/*.png")]
    pngs.each do |png|
      result = system "convert #{png} -background 'rgb(255,255,255)' #{png}"
      if result
        puts "Converted #{png}"
      else
        raise Exception.new(error)
      end
    end
    
    puts "All PNGs converted."
  end
end

namespace :files do
  
  desc "Generate files for delivery"
  task :generate => [:empty, :copy, :render] do
    puts "All files generated!"
  end

  desc "Copy files"
  task :copy do
    puts "Copying static files..."
    
    def copy_files list, parent, from, to
      list.each do |glob|
        filelist = Dir[File.join(parent, from, glob)]

        filelist.each do |file|
          new_file = parent + to + file.split(from)[1];
          dest = File.dirname(new_file)
          FileUtils.mkpath(dest)
          FileUtils.cp file, new_file unless File.directory?(file)
        end
      end unless !list
    end

    copy_files @deploy["files"], @globs[:project], @globs[:html], @globs[:deploy]
    
  end

  desc "Render files"
  task :render do
    puts "Rendering dynamic files..."
    
    def render_php_file file, output
      system %(php -f #{file} true > #{output})
    end
    
    def render_files list, from, to
      list.each do |glob|
        filelist = Dir[File.join(from, glob)]

        filelist.each do |file|
          new_file = to + file.gsub(from, "");
          dest = File.dirname(new_file)
          
          FileUtils.mkpath(dest)
          render_php_file file, new_file unless File.directory?(file)
        end
      end unless !list
    end
    
    render_files @deploy["render"], @globs[:html], @globs[:deploy]
    
  end

  desc "Empty folders"
  task :empty do
    puts "Emptying delivery folder..."
    
    def remove_files directory
      all = Dir[File.join(directory, "**/**")]
      all.each do |entry|
        unless File.directory?(entry)
          FileUtils.rm entry
        end
      end
      
    end
    
    remove_files @globs[:deploy]
  end

  desc "Compress files"
  task :compress do
    require "closure-compiler"
    require "yui/compressor"
    
    JS_FILES = @deploy["compress"]["js"]
    CSS_FILES = @deploy["compress"]["css"]
    
    PUB = @dirs["deploy"]["public_html"]
    
    JS_DIR = File.join(@globs[:deploy], JS_FILES["min-dir"][0]).sub(PUB["js"][0], "")
    CSS_DIR = File.join(@globs[:deploy], CSS_FILES["min-dir"][0]).sub(PUB["css"][0], "")
    
    JS_FILES.delete("min-dir")
    CSS_FILES.delete("min-dir")
    
    def minify parse
      code = String.new
      files = Dir[File.join(@globs[:deploy], parse)]
      files.each do |file|
        if file.include?(".js")
          code << Closure::Compiler.new.compile(File.open(file, "r"))
        else
          code << YUI::CssCompressor.new.compress(File.open(file, "r"))
        end
      end
      code
    end
    
    def combine files, destination
      code = String.new
      files.each do |file|
        code << minify(file)
      end
      write code, destination
    end
    
    def write code, destination
      FileUtils.mkpath(File.dirname(destination))
      new_file = File.new(destination, "w")
      new_file.puts(code)
      puts "Compressed #{destination}"
    end
    
    def compress type, array, dir
      array.each_pair do |key, value|
        case key
          when "standalone"
            value.each do |parse|
              files = Dir[File.join(@globs[:deploy], parse)]
              files.each do |file|
                if type.include?("js")
                  code = Closure::Compiler.new.compile(File.open(file, "r"))
                else
                  code = YUI::CssCompressor.new.compress(File.open(file, "r"))
                end
                  
                dest =  File.join(PUB[type][0], dir, file.split(PUB[type][0])[1])
                write code, dest
              end
            end
          else combine value, File.join(PUB[type][0], dir, key)
        end
      end
    end
    
    puts "Compressing JavaScript files (might take a bit)"
    compress "js", JS_FILES, JS_DIR
    
    puts "Compressing CSS files"
    compress "css", CSS_FILES, CSS_DIR
    
  end
end
