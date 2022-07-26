require 're2'

class RegexMatcher
    @@cache = {}

    def self.generate_dialect_class(dialect, pattern)
        case dialect
        when 're2'
            RE2::Regexp.new(pattern)
        else
            Regexp.new(pattern)
        end
    end

    def self.generate_dialect_pattern_cache_key(dialect, pattern)
        "#{dialect}__#{pattern}"
    end

    def self.pre_compile_pattern(dialect, pattern)
        cache_key = generate_dialect_pattern_cache_key(dialect, pattern)
        return @@cache[cache_key] if @@cache[cache_key]

        @@cache[cache_key] = generate_dialect_class(dialect, pattern)
        @@cache[cache_key]
    end

    def self.is_match?(dialect, pattern, candidate)
        cache_key = generate_dialect_pattern_cache_key(dialect, pattern)
        r = @@cache[cache_key]

        unless r
            r = generate_dialect_class(dialect, pattern)
        end

        r =~ candidate
    end
end