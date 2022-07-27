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

    def self.compile_pattern(dialect, pattern, persist_in_cache: false)
        cache_key = "#{dialect}__#{pattern}"
        return @@cache[cache_key] if @@cache[cache_key]

        compiled_expression = generate_dialect_class(dialect, pattern)

        return compiled_expression unless persist_in_cache
        
        @@cache[cache_key] = compiled_expression
        @@cache[cache_key]
    end

    def self.is_match?(dialect, pattern, candidate)
        r = compile_pattern(dialect, pattern)

        unless r
            r = generate_dialect_class(dialect, pattern)
        end

        r =~ candidate
    end
end