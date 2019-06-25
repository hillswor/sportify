class Sportify::MLBteam

  attr_accessor :name, :team_url, :roster_url

  @@teams = []

  def initialize(name = nil, team_url = nil)
    @name = name
    @team_url = team_url
    @@teams << self
    @players = []
  end

  def self.teams
    @@teams.sort_by(&:name)
  end

  def add_player(player)
    @players << player
    player.team = self
  end

  def players
    @players
  end

end
