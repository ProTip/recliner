$:.push File.expand_path('../lib', __FILE__)
require 'recliner/version'

Gem::Specification.new do |s|
  s.name = 'recliner'
  s.author = 'Greg Zapp'
  s.version = Recliner::VERSION
  s.license = 'MIT'
  s.summary = %q{Couchbase management.}
  s.description = %q{Couchbase management gem.}

  s.files = `git ls-files `.split("\n")
  s.require_paths = %w(lib)

end