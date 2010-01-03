#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

require 'bixbite/command'
require 'bixbite/create'

module Bixbite
  def self.version
    File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).strip
  end
end
