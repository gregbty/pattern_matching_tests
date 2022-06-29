require 'benchmark'
require_relative './match_finder'

class BenchmarkRunner
    def self.run_benchmark(commits, optimized: false)
        Benchmark.bmbm do |x|
            x.report("regex")  { MatchFinder.find_matches(commits, "regex", optimized: optimized, include_log: false) }
            x.report("glob") { MatchFinder.find_matches(commits, "glob", optimized: optimized, include_log: false) }
        end
    end
end