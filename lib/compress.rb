#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "blueprint", "blueprint")
Blueprint::Compressor.new.generate!
