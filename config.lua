--------------------------
---- ESX Discord Jobs ----
-- Created by Clink123 ---
--------------------------

Config = {}

-- Players will be able to select this job without any roles (as long as it has a command defined)
-- To do so, be sure to set it in the jobRoles config without any required roles!
Config.defaultJob = 'unemployed'
Config.defaultGrade = 0

-- Enable the chat commands (otherwise only the exports can be used in other resources)
Config.enableCommands = true

-- Job Name with associated list of discord IDs
-- {'Command Name', 'ESX Job Name', {'discordID', 'discordID'}, requireAll, JobGrade}
-- requireAll means that the user must have all the roles in the list. Otherwise they only need one of the roles in the list.
-- Note: You must list all of your jobs here for players to select them.
Config.jobRoles = {
  {'Unemployed', 'unemployed', {}, false, 0},
  {'Police', 'police', {'743005894517850144', '743005811730808832'}, false, 0}
}

-- RGB Colors of the confirmation and error messages
Config.messageColor = {255, 171, 25}
Config.errorColor = {255, 51, 51}

-- The command a player uses to take a job
Config.command = 'takejob'

-- Check periodically to see if players have the appropriate permissions for their job
-- Checks every Config.checkTime milliseconds if the player has the correct roles for their job
-- Config.timeBetweenPlayers is the amount of time between each player being checked (prevents discord api rate limits)
-- If they no longer have the required roles, it sets their job to Config.defaultJob (esx job name) with Config.defaultGrade (int)
Config.enableRoleChecks = true
Config.checkTime = 60000
Config.timeBetweenPlayers = 50
