# encoding: utf-8

module Zing
  module DbHelper

    def self.connect_db(models_file_path)
      begin

        if File.exist?(models_file_path)

            # check if db connection can be made
            require models_file_path
            if ActiveRecord::Base.connection and ActiveRecord::Base.connected?
              puts "passed".green + " Database Connection"
            else
              puts "errors".red + " Database Connection not exist"
              raise
            end
        else
          raise
        end

      rescue 
        puts "ERROR: Are you sure DB is properly configured in #{models_file_path}?".red
        raise
      end
    end

    def self.create_admin_user_table

      if ActiveRecord::Base.connection.table_exists?(:admin_users)
        puts "exists".yellow + " AdminUser Table"
      else
         ActiveRecord::Base.connection.create_table :admin_users do |t|
           t.string :username, :limit => 40, :null => false
           t.string :password, :limit => 40
           t.integer :utime, :limit => 16
           t.timestamps
        end
        if ActiveRecord::Base.connection.table_exists?(:admin_users)
          puts "passed".green + " AdminUser Table Creation"
        else
          puts "failed".red + " AdminUser Table Creation"
          raise
        end
      end

    end

    def self.create_token_table

      if ActiveRecord::Base.connection.table_exists?(:tokens)
        puts "exists".yellow + " Token Table"
      else
         ActiveRecord::Base.connection.create_table :tokens do |t|
           t.string :udid, :limit => 40, :null => false
           t.string :owner, :limit => 40
           t.string :token, :limit => 255, :null => false
           t.boolean :buuuk, :default => 0
           t.boolean :valid_udid, :default => 1
           t.string :carrier
           t.integer :utime, :limit => 16
           t.string :network_code, :limit => 12
           t.string :country_code, :limit => 12
           t.string :device, :limit => 32
           t.string :country
           t.string :version, :limit => 16
           t.timestamps
        end
        if ActiveRecord::Base.connection.table_exists?(:tokens)
          puts "passed".green + " Token Table Creation"
        else
          puts "failed".red + " Token Table Creation"
          raise
        end
      end

    end

    def self.create_notification_table

      if ActiveRecord::Base.connection.table_exists?(:notifications)
        puts "exists".yellow + " Notification Table"
      else
         ActiveRecord::Base.connection.create_table :notifications do |t|
           t.string :message
           t.string :btn_name, :limit => 64
           t.string :sound, :limit => 64
           t.string :url
           t.string :category, :limit => 64
           t.string :carrier, :limit => 64
           t.string :test_udids, :limit => 512
           t.integer :utime, :limit => 16
           t.timestamps
        end
        if ActiveRecord::Base.connection.table_exists?(:notifications)
          puts "passed".green + " Notification Table Creation"
        else
          puts "failed".red + " Notification Table Creation"
          raise
        end
      end

    end

    def self.create_apn_log_table

      if ActiveRecord::Base.connection.table_exists?(:apn_logs)
        puts "exists".yellow + " ApnLog Table"
      else
         ActiveRecord::Base.connection.create_table :apn_logs do |t|
           t.integer :notification_id
           t.integer :notification_size, :limit => 16
           t.text    :log_text
           t.integer :utime, :limit => 16
           t.timestamps
        end
        if ActiveRecord::Base.connection.table_exists?(:apn_logs)
          puts "passed".green + " ApnLog Table Creation"
        else
          puts "failed".red + " ApnLog Table Creation"
          raise
        end
      end

    end

  end
end
