# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hash-from_mysql_query_result/version"

Gem::Specification.new do |s|
  s.name        = "hash-from_mysql_query_result"
  s.version     = Hash::FromMysqlQueryResult::VERSION
  s.authors     = ["koyachi"]
  s.email       = ["rtk2106@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Create Hash from MySQL query result text.}
  s.description = %q{Create Hash from MySQL query result text.}

  s.rubyforge_project = "hash-from_mysql_query_result"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
