# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'LeakTest'
  app.services = %w(
    .DataFetcher
  )
  app.application_class = 'LeakTest'
  app.api_version = '19'

  app.vendor_project jar: "vendor/android-support-v4.jar"
end
