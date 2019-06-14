Gem::Specification.new do |s|
  s.name        = 'sportify'
  s.version     = '0.0.0'
  s.date        = '2019-06-14'
  s.summary     = "Sportify"
  s.description = "A command line app that scrapes rosters for all 30 MLB teams"
  s.authors     = ["Bruce Hillsworth"]
  s.email       = 'bruce.hillsworth@gmail.com'
  s.files       = ["lib/sportify.rb", "lib/cli/cli.rb", "lib/leagues/mlb_teams.rb",
  "lib/scrapers/mlb_scraper.rb", "config/environment.rb"]
  s.homepage    =
    'https://rubygems.org/gems/sportify'
  s.license       = 'MIT'
  s.executables << 'sportify'

  s.add_development_dependency 'bundler', '~> 2.0', '>= 2.0.2'
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.2'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'nokogiri', '~> 1.10', '>= 1.10.2'
  s.add_development_dependency 'pry', '~> 0.12.2'
end
