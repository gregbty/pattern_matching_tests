require 'benchmark'
require_relative './match_finder'

class BenchmarkRunner
    def self.run_benchmark(commits, optimized: false)
        Benchmark.bmbm do |x|
            x.report("re2")  { MatchFinder.find_matches(commits, "re2", optimized: optimized, include_log: false) }
            x.report("Regexp")  { MatchFinder.find_matches(commits, "Regexp", optimized: optimized, include_log: false) }
            x.report("File.fnmatch?") { MatchFinder.find_matches(commits, "glob", optimized: optimized, include_log: false) }
        end
    end
end