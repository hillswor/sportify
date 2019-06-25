class Sportify::MLBplayer

  attr_accessor :name, :player_url, :team, :number, :position, :bats_and_throws, :height_weight, :age

  @@all = []

  def initialize(name = nil, player_url = nil, team = nil)
    @name = name
    @player_url = player_url
    @team = team
    @@all << self
  end

  def self.all
    @@all
  end

end
