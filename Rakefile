#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end

Rake::TestTask.new(:jenkins) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test*.rb']
  t.options = '--junit --junit-filename=test/junit.xml --junit-jenkins'
  t.verbose = true
end
