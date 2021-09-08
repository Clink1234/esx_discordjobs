--------------------------
---- ESX Discord Jobs ----
-- Created by Clink123 ---
--------------------------

Config = {}

-- Job Name with associated list of discord IDs
-- {'Command Name', 'ESX Job Name', {'discordID', 'discordID'}, requireAll, JobGrade}
-- requireAll means that the user must have all the roles in the list. Otherwise they only need one of the roles in the list.
-- Note: You must list all of your jobs here for players to select them.
Config.jobRoles = {
  {'Unemployed', 'unemployed', {'736414176863453206'}, false, 0},
  {'Police', 'police', {'736824407598694432', '743005394187714671'}, false, 0}
}

-- RGB Colors of the confirmation and error messages
Config.messageColor = {255, 171, 25}
Config.errorColor = {255, 51, 51}

-- The command a player uses to take a job
Config.command = 'takejob'