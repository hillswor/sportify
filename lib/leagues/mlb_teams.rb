class Sportify::MLBteams

  def initialize
    @scraper = Sportify::MLBscraper.new
  end

  def teams
    @scraper.teams.zip(@scraper.team_urls).map { |team, team_url| {team_name: team, team_url: team_url} }.sort_by { |team| team[:team_name] }
  end

  def roster(team)
     @scraper.player_names(team).zip(@scraper.player_urls(team)).map { |player_name, player_url| {player_name: player_name, player_url: player_url}}
  end

  def player_builder(player)
    {
      name: @scraper.name(player),
      number: @scraper.number(player),
      position: @scraper.position(player),
      bats_and_throws: @scraper.bats_and_throws(player),
      height_weight: @scraper.height_weight(player),
      age: @scraper.age(player)
    }
  end

end
