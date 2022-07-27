require './matchers/glob_matcher'
require './matchers/regex_matcher'
require_relative './pattern_constants'

class MatchFinder
    def self.find_matches(commits, matcher, optimized: false, include_log: true)
        match_count = 0

        RegexMatcher.compile_pattern(matcher, REGEX_PATTERN, persist_in_cache: true) if optimized && ['re2', 'Regexp'].include?(matcher)

        commits.each do |(sha, message)|
            case matcher
            when 're2', 'Regexp'
                matches = RegexMatcher.is_match?(matcher, REGEX_PATTERN, message)
            when 'glob'
                matches = GlobMatcher.is_match?(GLOB_PATTERN, message)
            end
        
            match_count += 1 if matches
        end 
    
        puts "#{matcher}: Matched #{match_count} out of #{commits.size} commits" if include_log
    end
end