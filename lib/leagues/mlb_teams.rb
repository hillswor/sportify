class Sportify::MLBteams

  def initialize
    @scraper = Sportify::MLBscraper.new
  end

  def teams
    @scraper.teams.zip(@scraper.team_urls).map { |team, team_url| {team_name: team, team_url: team_url} }.sort_by { |team| team[:team_name] }
  end

  def roster(team)
     @scraper.player_numbers(team).zip(@scraper.player_names(team)).map { |player_number, player_name| {player_number: player_number, player_name: player_name}}
  end


end
