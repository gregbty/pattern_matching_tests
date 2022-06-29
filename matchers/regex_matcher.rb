require 're2'

class RegexMatcher
    @@cache = {}

    def self.pre_compile_pattern(pattern)
        @@cache[pattern] ||= RE2::Regexp.new(pattern) 
    end

    def self.is_match?(pattern, candidate)
        r = @@cache[pattern] || RE2::Regexp.new(pattern)        
        r =~ candidate
    end
end