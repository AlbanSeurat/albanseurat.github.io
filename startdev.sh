#!/usr/bin/env bash
docker run -i -t -v .:/root -p 4000:4000 alkpone/jekyll jekyll serve
