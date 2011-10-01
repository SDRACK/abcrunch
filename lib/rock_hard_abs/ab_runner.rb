require 'open3'
require 'pp'
require 'colorize'

module RockHardAbs
  class AbRunner
    def self.validate_options(options)
      raise "AB Options missing :url" unless options.has_key? :url
      RockHardAbs::Config.ab_options.merge(options)
    end

    def self.ab_command(options)
      options = validate_options(options)
      "ab -c #{options[:concurrency]} -n #{options[:num_requests]} #{options[:url]}"
    end

    def self.ab(options)
      cmd = ab_command(options)
      result = nil

      Open3.popen3(cmd) do |stdin, stdout, stderr|
        err_lines = stderr.readlines
        if err_lines.length > 0
          cmd = cmd.cyan
          err = "AB command failed".red
          err_s = err_lines.reduce {|line, memo| memo += line}.red
          raise "#{err}\nCommand: #{cmd}\n#{err_s}"
        end
        result = RockHardAbs::AbResult.new stdout.readlines.reduce {|line, memo| memo += line}, options
      end

      result
    end
  end
end