class Sportify::CLI

  def initialize
    @mlb = Sportify::MLBteams.new
    main_menu
    team_selector
  end

  def main_menu
    puts "***** Welcome To Sportify *****"
    puts ""
    @mlb.teams.each_with_index do |team, index|
      puts "#{index + 1}) #{team[:team_name]}"
    end
    puts ""
    puts "Enter the number of the team you want information on or type 'exit' to leave Sportify"
    puts ""
  end

  def team_selector
    input = gets.strip
    puts ""
    if input.to_i.between?(1, @mlb.teams.length)
      team_menu(@mlb.teams[input.to_i - 1])
    elsif input.downcase == "exit"
      puts "Goodbye"
    else
      puts "Invalid input.  Please try again."
      team_selector
    end
  end

  def team_menu(team)
    puts ""
    puts "You've selected the #{team[:team_name]}"
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
      puts "***** Active Roster *****"
      puts ""
      active_roster_display(team)
    when 2
      Sportify::CLI.new
    when 3
      puts "Goodbye"
    else
      puts "Invalid input.  Please try again."
      team_menu_router(team)
    end
  end

  def active_roster_display(team)
    @mlb.roster(team).each_with_index do |player, index|
      puts "#{index + 1}) #{player[:name]}"
    end
    player_selector(team)
  end

  def player_selector(team)
    puts ""
    puts "Please input the number next to the player you would like information on or type menu to return to team menu"
    puts ""
    input = gets.strip
    puts ""
    if input.to_i.between?(1, @mlb.roster(team).length)
      player_display(@mlb.roster(team)[input.to_i - 1])
      team_menu(team)
    elsif input.downcase == "menu"
      team_menu(team)
    else
      puts "Invalid input.  Please try again."
      player_selector(team)
    end
  end

  def player_display(player)
    player = @mlb.player_builder(player)
    puts "You've selected #{player[:name]}"
    puts ""
    puts "Jersey Number: #{player[:number]}"
    puts ""
    puts "Position: #{player[:position]}"
    puts ""
    puts "#{player[:bats_and_throws]}"
    puts ""
    puts "Height/Weight: #{player[:height_weight]}"
    puts ""
    puts "#{player[:age]}"
  end

end
