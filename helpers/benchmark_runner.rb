require 'benchmark'
require_relative './match_finder'

class BenchmarkRunner
    def self.run_matches_benchmark(commits, optimized: false)
        Benchmark.bmbm do |x|
            x.report("re2")  { MatchFinder.find_matches(commits, "re2", optimized: optimized, include_log: false) }
            x.report("Regexp")  { MatchFinder.find_matches(commits, "Regexp", optimized: optimized, include_log: false) }
            x.report("File.fnmatch?") { MatchFinder.find_matches(commits, "glob", optimized: optimized, include_log: false) }
        end
    end

    def self.run_compilation_benchmark(interval)
        Benchmark.bmbm do |x|
            x.report("re2")  { for i in 1..interval; RegexMatcher.compile_pattern("re2", REGEX_PATTERN) end }
            x.report("Regexp")  { for i in 1..interval; RegexMatcher.compile_pattern("Regexp", REGEX_PATTERN) end }
        end
    end
end