require 'pry'
require 'optparse'
require 'csv'
require_relative './helpers/benchmark_runner'
require_relative './helpers/match_finder'

COMMIT_FILE_PATH = 'tmp/commits.csv'

raise 'No commits.csv found. Run ./get_commits.sh first' unless File.exist?(COMMIT_FILE_PATH)

options = {}
OptionParser.new do |opt|
  opt.on('--benchmark')  { |_| options[:benchmark] = true }
  opt.on('--optimized')  { |_| options[:optimized] = true }
  opt.on('--commits number or all') { |o| options[:commits] = o }
end.parse!

raise 'Option --commits only accepts number or all' unless options[:commits].nil? || options[:commits] == 'all' || options[:commits].to_i.to_s == options[:commits]

options[:commits] ||= 10

commits = CSV.read(COMMIT_FILE_PATH, liberal_parsing: true)
commits.shift
commits = commits[0..[options[:commits].to_i - 1, commits.size].min] unless options[:commits] == 'all'

puts "Commits: #{commits.size}"

if options[:benchmark]
    BenchmarkRunner.run_benchmark(commits, optimized: options[:optimized])
else
    MatchFinder.find_matches(commits, 'regex', optimized: options[:optimized])
    MatchFinder.find_matches(commits, 'glob', optimized: options[:optimized])
end