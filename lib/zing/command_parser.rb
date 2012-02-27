# encoding: utf-8

require 'optparse'
require 'fileutils'

module Zing

  module CommandParser

    def self.parse(args, options)

      # prepare parsing of command line arguments
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: zing [options]"

        opts.separator " "
        opts.separator "Specific options:"

        opts.on("-b", "--base",
                "Zing base CMS") do |lib|
          options.base = true
        end

        opts.on("-p", "--push",
                "Zing push module on top of base CMS") do |lib|
          options.push = true
        end

        opts.on("-m", "--model MODEL_NAME",
                "Zing CRUD for individual MODEL_NAME, use commas for multiple models") do |ver|
          if ver.split(",").class == Array
            options.model = ver.split(",").map(&:strip)
          elsif ver.class == String
            options.model = var
          else
            options.model = nil
          end
        end

        # No argument, shows at tail. This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          raise
        end

      end

      opts.parse!(args)

      # NOTE: 
      # We assume that zing is run at the root app folder
      #
      # set current dir as project absolute dir
      options.project_absolute_dir = FileUtils.pwd

      # set app name as the project folder
      options.project_name = FileUtils.pwd.split("/").last
      options.app_name = options.project_name

    rescue Exception => e
      if e.message.match(/invalid option/i) or e.message.match(/missing argument/i)
        puts "ERROR: #{e.message}".red
        puts ""
        puts opts
      end
      raise
    end

  end

end
