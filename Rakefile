require "bundler/gem_tasks"
require "rspec/core/rake_task"

desc "Run RSpec code examples (unit test)"
RSpec::Core::RakeTask.new("spec:unit") do |task|
  task.rspec_opts = "--tag ~type:integration"
end

desc "Run RSpec code examples (integration test)"
RSpec::Core::RakeTask.new("spec:integration") do |task|
  task.rspec_opts = "--tag type:integration"
end

task :spec => ["spec:unit", "spec:integration"]

task :default => :spec
