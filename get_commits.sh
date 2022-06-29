#!/bin/bash

echo "sha,message" > tmp/commits.csv
gh api repos/angular/angular/commits --field per_page=100 --method GET --paginate --template '{{range .}}{{.sha}}{{","}}{{"#~#"}}{{.commit.message}}{{"#~#"}}{{"\n"}}{{end}}' >> tmp/commits.csv
sed -i '.1.bak' 's/"/""/g' tmp/commits.csv
sed -i '.2.bak' 's/\#\~\#/"/g' tmp/commits.csv
