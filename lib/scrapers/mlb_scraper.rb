class Sportify::MLBscraper

  @@team_data = Nokogiri::HTML(open("https://www.mlb.com/team")).css("div.p-featured-content__body")

  def self.team_builder
    @@team_data.each do |data|
      Sportify::MLBteam.new(name = data.css("a").css("div.u-text-h4.u-text-flow").text, team_url = data.css("div.p-wysiwyg").css("a")[0]["href"])
    end
  end

  def self.roster_url(team)
    team_home_page = Nokogiri::HTML(open(team.team_url))
    if team.team_url == "https://www.mlb.com/reds" || team.team_url == "https://www.mlb.com/dodgers" || team.team_url == "https://www.mlb.com/giants"
      roster_url = team_home_page.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--roster").attribute("href").value
    else
      roster_url = team_home_page.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--team").attribute("href").value
    end
    team.roster_url = roster_url
  end

  def self.player_builder(team)
    @team =  team
    Nokogiri::HTML(open(@team.roster_url)).css("td.dg-name_display_first_last").css("a").each do |data|
      @team.add_player(Sportify::MLBplayer.new(player_name = data.text, player_url = team.team_url + data["href"], team = @team))
    end
  end

  def self.add_player_data(player)
    data = Nokogiri::HTML(open(player.player_url))
    player.number = data.css("span.player-header--vitals-number").text
    player.position = data.css("div.player-header--vitals").css("ul").css("li")[0].text
    player.bats_and_throws = data.css("div.player-header--vitals").css("ul").css("li")[1].text
    player.height_weight = data.css("div.player-header--vitals").css("ul").css("li.player-header--vitals-height").text
    player.age = data.css("div.player-header--vitals").css("ul").css("li.player-header--vitals-age").text
  end

end
