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

  def roster_doc(team)
    team_html = open(team[:team_url])
    team_doc = Nokogiri::HTML(team_html)
    if team[:team_url] == "https://www.mlb.com/reds" || team[:team_url] == "https://www.mlb.com/dodgers" || team[:team_url] == "https://www.mlb.com/giants"
      roster_url = team_doc.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--roster").attribute("href").value
    else
      roster_url = team_doc.css("div.megamenu-navbar").css("a.megamenu-static-navbar__menu-item.megamenu-static-navbar__menu-item--team").attribute("href").value
    end
    roster_html = open(roster_url)
    Nokogiri::HTML(roster_html)
  end

  def roster(team)
    roster = []
    roster_doc(team).css("td.dg-name_display_first_last").css("a").each do |player|
      roster << player.text
    end
    roster
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
