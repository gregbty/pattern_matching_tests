# Pattern Matching Tests

Rudimentary tests for comparing the different pattern matching techniques in Ruby

## Getting Started

- `bundle install`
- `./get_commits.sh` - This takes a few seconds as it downloads the entire history of the repository.
- `ruby ./match_commits.rb --benchmark agg --commits all --optimized`

## CLI Arguments (match_commits)

- `benchmark` - Executes the benchmark tests. When this is omitted, the program will just output the number of matches for each technique. Accepts either `agg` or `ips`.
- `commits` - The number of commits to evaluate. Specifying `all` will evaluate of the downloaded commits.
- `optimized` - Executes using pre-compiled patterns (only applies to regex).