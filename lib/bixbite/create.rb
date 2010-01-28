module Bixbite
  class Create
    attr_accessor :source, :destination, :options

    def initialize options
      @options = options
      @config = @options[:config]
      
      copy @options[:source], @options[:destination]
      download @options[:lib], @options[:destination]
      parse @config["parse"], @options[:destination], @options[:title], @options[:namespace]
    end

    def parse list, source, name, namespace
      puts "Building project..."
      list.each do |glob|
        files = Dir[File.join(source, "template", glob)]
        files.each do |file|
          File.open(file, "r+") do |f|
              lines = f.readlines
              lines.each do |line|
                line.gsub!(/__PROJECT_NAME__/, name);
                line.gsub!(/__PROJECT_NAMESPACE__/, namespace);
                line.gsub!(/__JS_LIB__/, @options[:lib]);
                line.gsub!(/__JS_LIB_LOWERCASE__/, @options[:lib].downcase);
              end
              f.pos = 0
              f.print lines
              f.truncate(f.pos)
          end unless File.directory?(file)
          
          File.rename(file, file.gsub(/__PROJECT_NAME__/, name)) if file.match(/__PROJECT_NAME__/)
          File.rename(file, file.gsub(/__JS_LIB_LOWERCASE__/, @options[:lib].downcase)) if file.match(/__JS_LIB_LOWERCASE__/)
        end
      end
      puts "All done!"
    end
    
    def copy source, destination
      puts "Copying to #{destination}..."
      FileUtils.cp_r(source, destination)
      puts "Done!"
    end
    
    def download lib, destination
      require 'net/http'
      
      def get domain, source, destination
        Net::HTTP.start(domain) do |http|
          resp = http.get(source)
          open(destination, "wb") do |file|
            file.write(resp.body)
            puts "Done!"
          end
        end
      end
      
      google = 'ajax.googleapis.com'
      file = '__JS_LIB_LOWERCASE__-latest.js'
      dest = File.join(destination, "template", @config["directories"]["src"]["html"][0], "js/cmn/lib", file)
      
      puts "Downloading #{lib} from #{google}"
      
      case lib
        when 'jQuery'
          get google, '/ajax/libs/jquery/1/jquery.js', dest
        when 'YUI'
          get google, '/ajax/libs/yui/2/build/yuiloader/yuiloader.js', dest
        when 'MooTools'
          get google, '/ajax/libs/mootools/1.2/mootools.js', dest
        else
      end
      
    end
    
  end
end