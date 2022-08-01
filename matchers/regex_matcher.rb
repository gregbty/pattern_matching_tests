require 're2'

class RegexMatcher
    @@cache = {}

    def self.generate_variant_class(variant, pattern)
        case variant
        when 're2'
            RE2::Regexp.new(pattern)
        else
            Regexp.new(pattern)
        end
    end

    def self.compile_pattern(variant, pattern, persist_in_cache: false)
        cache_key = "#{variant}__#{pattern}"
        return @@cache[cache_key] if @@cache[cache_key]

        compiled_expression = generate_variant_class(variant, pattern)

        return compiled_expression unless persist_in_cache
        
        @@cache[cache_key] = compiled_expression
        @@cache[cache_key]
    end

    def self.is_match?(variant, pattern, candidate)
        r = compile_pattern(variant, pattern)

        r =~ candidate
    end
end