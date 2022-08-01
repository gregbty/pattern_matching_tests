require 'benchmark'
require 'benchmark/ips'
require_relative './match_finder'

class BenchmarkRunner
    def self.run_matches_benchmark(commits, ips: false, optimized: false)
        if ips
            Benchmark.ips do |x|
                report_matches_benchmarks(x, commits, optimized: optimized)

                x.compare!
            end
        else
            Benchmark.bmbm do |x|
                report_matches_benchmarks(x, commits, optimized: optimized)
            end
        end
    end

    def self.run_compilation_benchmark(interval)
        Benchmark.bmbm do |x|
            x.report("re2")  { for i in 1..interval; RegexMatcher.compile_pattern("re2", REGEX_PATTERN) end }
            x.report("Regexp")  { for i in 1..interval; RegexMatcher.compile_pattern("Regexp", REGEX_PATTERN) end }
        end
    end

    private_class_method def self.report_matches_benchmarks(reporter, commits, optimized: false)
        reporter.report("re2")  { MatchFinder.find_matches(commits, "re2", optimized: optimized, include_log: false) }
        reporter.report("Regexp")  { MatchFinder.find_matches(commits, "Regexp", optimized: optimized, include_log: false) }
        reporter.report("File.fnmatch?") { MatchFinder.find_matches(commits, "glob", optimized: optimized, include_log: false) } 
    end
end