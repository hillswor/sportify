class Sportify::CLI

  def initialize
    Sportify::MLBscraper.team_builder
    main_menu
  end

  def main_menu
    puts "***** Welcome To Sportify *****"
    puts ""
    Sportify::MLBteam.teams.each_with_index do |team, index|
      puts "#{index + 1}) #{team.name}"
    end
    puts ""
    puts "Enter the number of the team you want information on or type 'exit' to leave Sportify"
    puts ""
    team_selector
  end

  def team_selector
    input = gets.strip
    puts ""
    if input.to_i.between?(1, Sportify::MLBteam.teams.length)
      team_menu(Sportify::MLBteam.teams[input.to_i - 1])
    elsif input.downcase == "exit"
      puts "Goodbye"
    else
      puts "Invalid input.  Please try again."
      team_selector
    end
  end

  def team_menu(team)
    puts "You've selected the #{team.name}"
    puts""
    puts "Please choose an option"
    puts ""
    puts "1) View Active Roster"
    puts "2) Return to Main Menu"
    puts "3) Exit Sportify"
    team_menu_router(team)
  end

  def team_menu_router(team)
    puts ""
    input = gets.strip.to_i
    puts ""
    case input
    when 1
      if team.roster_url == nil
        Sportify::MLBscraper.roster_url(team)
        active_roster_display(team)
      else
        active_roster_display(team)
      end
    when 2
      main_menu
    when 3
      puts "Goodbye"
    else
      puts "Invalid input.  Please try again."
      team_menu_router(team)
    end
  end

  def active_roster_display(team)
    if team.players.length == 0
      Sportify::MLBscraper.player_builder(team)
    end
    team.players.each_with_index do |player, index|
      puts "#{index + 1}) #{player.name}"
    end
    player_selector(team)
  end

  def player_selector(team)
    puts ""
    puts "Please input the number next to the player you would like information on or type menu to return to team menu"
    puts ""
    input = gets.strip
    puts ""
    if input.to_i.between?(1, team.players.length)
      player_display(team.players[input.to_i - 1])
    elsif input.downcase == "menu"
      team_menu(team)
    else
      active_roster_display(team)
    end
  end

  def player_display(player)
    if player.number == nil
      Sportify::MLBscraper.add_player_data(player)
    end
    puts "You've selected #{player.name}"
    puts ""
    puts "Jersey Number: #{player.number}"
    puts ""
    puts "Position: #{player.position}"
    puts ""
    puts "#{player.bats_and_throws}"
    puts ""
    puts "Height/Weight: #{player.height_weight}"
    puts ""
    puts "#{player.age}"
    puts ""
    team_menu(player.team)
  end

end
