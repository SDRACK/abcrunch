require "bundler/gem_tasks"

Dir[File.join(File.dirname(__FILE__), "lib/**/*.rb")].each { |f| require f }

Dir[File.join(File.dirname(__FILE__), "lib/**/*.rake")].
  concat(Dir[File.join(File.dirname(__FILE__), "spec/tasks/**/*.rake")]).
  concat(Dir[File.join(File.dirname(__FILE__), "tasks/**/*.rake")]).
  concat(Dir[File.join(File.dirname(__FILE__), "{test,spec}/*.rake")]).each  { |rake| load(rake) }

task default: [:spec]
