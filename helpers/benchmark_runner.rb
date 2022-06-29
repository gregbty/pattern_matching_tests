require 'benchmark'
require_relative './match_finder'

class BenchmarkRunner
    def self.run_benchmark(commits)
        Benchmark.bmbm do |x|
            x.report("regex")  { MatchFinder.find_matches(commits, "regex", include_log: false) }
            x.report("glob") { MatchFinder.find_matches(commits, "glob", include_log: false) }
        end
    end
end