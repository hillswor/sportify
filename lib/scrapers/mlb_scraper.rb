class Sportify::MLBscraper

  @@root_url = "https://www.mlb.com/team"
  @@root_html = open(@@root_url)
  @@root_doc = Nokogiri::HTML(@@root_html)

  def teams
    teams = []
    @@root_doc.css("div.u-text-h4.u-text-flow").each do |team|
      teams << team.text
    end
    teams
  end

  def team_urls
    team_urls = []
    @@root_doc.css("div.p-wysiwyg").each do |team|
      team_urls << team.css("a")[0]["href"]
    end
    team_urls
  end

  def roster_url(team_url)
    html = open(team_url)
    doc = Nokogiri::HTML(html)
    if team_url == "https://www.mlb.com/reds" || team_url == "https://www.mlb.com/dodgers" || team_url == "https://www.mlb.com/giants"
      roster_url = doc.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--roster").attribute("href").value
    else
      roster_url = doc.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--team").attribute("href").value
    end
    roster_url
  end

  def roster_doc(team)
    html = open(team[:team_url])
    Nokogiri::HTML(html)
  end

  def player_numbers(team)
    player_numbers = []
    roster_doc(team).css("table.data.roster_table").css("td.dg-jersey_number").each do |player|
      player_numbers << player.text
    end
    player_numbers
  end

  def player_names(team)
    player_names = []
    roster_doc(team).css("td.dg-name_display_first_last").css("a").each do |player|
      player_names << player.text
    end
    player_names
  end

  def player_urls(team)
    player_urls = []
    team_url = team[:team_url]
    roster_doc(team).css("td.dg-name_display_first_last").css("a").each do |player|
      player_urls << team_url + player["href"]
    end
    player_urls
  end

  def player_doc(player)
    html = open(player[:player_url])
    Nokogiri::HTML(html)
  end

  def name(player)
    player_doc(player).css("span.player-header--vitals-name").text
  end

  def number(player)
    player_doc(player).css("span.player-header--vitals-number").text
  end

  def position(player)
    player_doc(player).css("div.player-header--vitals").css("ul").css("li")[0].text
  end

  def bats_and_throws(player)
    player_doc(player).css("div.player-header--vitals").css("ul").css("li")[1].text
  end

  def height_weight(player)
    player_doc(player).css("div.player-header--vitals").css("ul").css("li.player-header--vitals-height").text
  end

  def age(player)
    player_doc(player).css("div.player-header--vitals").css("ul").css("li.player-header--vitals-age").text
  end

end
