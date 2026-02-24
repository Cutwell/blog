.PHONY: help install serve dev build clean

# Ensure rbenv Ruby is used
SHELL := /bin/bash
export PATH := $(HOME)/.rbenv/shims:$(PATH)

help:
	@echo "Available commands:"
	@echo "  make install    - Install dependencies"
	@echo "  make serve      - Start local development server"
	@echo "  make dev        - Alias for serve"
	@echo "  make build      - Build the site"
	@echo "  make clean      - Clean build artifacts"

install:
	@export PATH="$$HOME/.rbenv/shims:$$PATH" && bundle install

serve:
	@export PATH="$$HOME/.rbenv/shims:$$PATH" && bundle exec jekyll serve --livereload

dev: serve

build:
	@export PATH="$$HOME/.rbenv/shims:$$PATH" && bundle exec jekyll build

clean:
	@export PATH="$$HOME/.rbenv/shims:$$PATH" && bundle exec jekyll clean
