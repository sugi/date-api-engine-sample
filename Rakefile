# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DateApiEngine'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Load all tasks from the tasks directory
DIR = File.dirname(__FILE__)
rake_files = Dir.glob(File.join(DIR, 'lib/tasks/**/*.rake'))
rake_files.each { |rake_file| load rake_file }

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'bundler/gem_tasks'

task :default => :spec
