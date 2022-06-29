class GlobMatcher
    def self.is_match?(pattern, candidate)
        File.fnmatch?(pattern, candidate, File::FNM_EXTGLOB)
    end
end