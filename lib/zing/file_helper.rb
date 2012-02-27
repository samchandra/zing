# encoding: utf-8

require 'erb'

module Zing
  module FileHelper

    def self.create_directory(dir_path)
      if File.exist?(dir_path)
        puts "exists".yellow + " #{dir_path}"
      else
        FileUtils.mkdir_p(dir_path)
        puts "create".green + " #{dir_path}"
      end
    end

    def self.create_file(file_path, file_content)
      if File.exist?(file_path)
        puts "exists".yellow + " #{file_path}"
      else
        File.open("#{file_path}", "w") do |file|
          file.puts file_content
        end
        puts "create".green + " #{file_path}"
      end
    end

    def self.copy_file_templates(options, feature)
      project_absolute_dir = options.project_absolute_dir

      # get the template directories based on the params used
      directories = if feature[/options_base/i]
        Dir.glob(File.dirname(__FILE__) + "/file_templates/base/**")
      elsif feature[/options_push/i]
        Dir.glob(File.dirname(__FILE__) + "/file_templates/push/**")
      else
        []
      end
      
      # traverse each directory and copy the template files
      directories.each do |dir_name|

        dir_name_last = dir_name.split("/").last

        Dir.glob("#{dir_name}/*").each do |file|

          filename = file.split("/").last.gsub(".erb", "")

          # read file as ERB templates
          content = File.open(file, "r").read
          template = ERB.new content

          # file copy location
          file_location = "#{project_absolute_dir}/#{dir_name_last}/#{filename}"

          # write the contents of each file to the project directory
          create_file(file_location, template.result(binding))

        end

      end

    end

  end

end
