#!/usr/bin/env ruby
if __FILE__==$0
  root_path = File.expand_path(File.dirname(__FILE__))
  require 'resque'
  require 'pp'
  require root_path+"/../url_worker.rb"

  cfgfile = "#{root_path}/../../../config/database.yml"
  rails_env = ENV['RAILS_ENV'] || 'development'
  g_config = YAML::load(File.open(cfgfile))
  config = g_config[rails_env]['redis']

  Resque.redis = "#{config['host']}:#{config['port']}"
  pp Resque.enqueue(Processor, ARGV[0], false)
end

