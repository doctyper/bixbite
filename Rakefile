require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bixbite"
    gem.summary = %Q{A project initializer for dynamic to static publishing}
    gem.description = %Q{Bixbite is a project initializer for dynamic to static publishing}
    gem.email = "rich@doctyper.com"
    gem.homepage = "http://github.com/doctyper/bixbite"
    gem.authors = ["Richard Herrera", "Lenny Burdette"]
    gem.executables = ["bixbite"]
    gem.require_paths << "template"
    gem.files = [
      "lib/**/*",
      "template/assets/utilities/.bix",
      "template/deploy/public_html/.htaccess",
      "template/documentation/js/.htaccess",
      "template/**/*",
      "template/**/.htaccess",
      "LICENSE",
      "README.rdoc",
      "VERSION"
    ]
    gem.add_dependency("closure-compiler", ">= 0.1.5")
    gem.add_dependency("yui-compressor", ">= 0.9.1")
    gem.add_dependency("highline", ">= 1.5.1")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bixbite #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
