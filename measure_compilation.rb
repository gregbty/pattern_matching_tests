require 'pry'
require 'optparse'
require_relative './helpers/benchmark_runner'

interval = 10

options = {}
OptionParser.new do |opt|
  opt.on('--interval number')  { |o| options[:interval] = o }
end.parse!

unless options[:interval].nil?
    raise 'Option --interval must be a number' unless options[:interval].to_i.to_s == options[:interval]
    raise 'Option --interval must be greater than 0' unless options[:interval].to_i > 0
end

options[:interval] ||= 10

BenchmarkRunner.run_compilation_benchmark(options[:interval].to_i)