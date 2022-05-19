if Config.enableCommands then
  RegisterCommand(Config.command, function(source, args, rawCommand)
    if source and source ~= 0 then
      local requestedJob = args[1]
      local xPlayer = ESX.GetPlayerFromId(source)
      local requiredRoleList = false
      local requireAll = false
      local requestedESXJob = false
      local jobGrade = false
      
      for index, jobRoleEntry in ipairs(Config.jobRoles) do
        if jobRoleEntry[1] == requestedJob then
          requestedESXJob = jobRoleEntry[2]
          requiredRoleList = jobRoleEntry[3]
          requireAll = jobRoleEntry[4]
          jobGrade = jobRoleEntry[5]
        end
      end
      
      local jobExists = ESX.DoesJobExist(requestedESXJob, jobGrade)
      
      if jobExists then
        exports.discordroles:getUserRoles(source, function(userRoles)
          if xPlayer and userRoles then
            local hasPermissions = checkPermissions(requiredRoleList, requireAll, userRoles)
            if hasPermissions then
              xPlayer.setJob(requestedESXJob, jobGrade)
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","Your job has been set to " .. requestedESXJob .. " with grade " .. jobGrade .. "."}, color = Config.messageColor })
            else
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","You do not have permission to take that job."}, color = Config.errorColor })
            end
          else
            TriggerClientEvent('chat:addMessage', source, {args = {"Server","Could not get your Discord roles. Try restarting Fivem."}, color = Config.errorColor })
          end
        end)
      else
        TriggerClientEvent('chat:addMessage', source, {args = {"Server","The requested job does not exist."}, color = Config.errorColor })
      end
    end
  end, false)
end

Citizen.CreateThread(function()
  if Config.enableRoleChecks then
    local requiredRoleList = false
    local requireAll = false
    local checkESXJob = false
    local checkJobGrade = false
    local playerJob = false
    while true do
      Citizen.Wait(Config.checkTime)
      local xPlayers = ESX.GetExtendedPlayers()
      for _, xPlayer in pairs(xPlayers) do
        Citizen.Wait(Config.timeBetweenPlayers)
        exports.discordroles:getUserRoles(xPlayer.source, function(userRoles)
          for index, jobRoleEntry in ipairs(Config.jobRoles) do
            checkESXJob = jobRoleEntry[2]
            checkJobGrade = jobRoleEntry[5]
            requiredRoleList = jobRoleEntry[3]
            requireAll = jobRoleEntry[4]
            playerJob = xPlayer.getJob()
            if playerJob['grade'] == checkJobGrade and playerJob['name'] == checkESXJob then
              if xPlayer and userRoles then
                local hasPermissions = checkPermissions(requiredRoleList, requireAll, userRoles)
                if not hasPermissions then
                  xPlayer.setJob(Config.defaultJob, Config.defaultGrade)
                  print(xPlayer.getName().." did not have permissions for the job " .. checkESXJob .. " and was set to the default job of " .. Config.defaultJob .. " with grade " .. Config.defaultGrade)
                end
              else
                print("Count not check a player's discord permissions. Is discordroles running?")
              end
            end
          end
        end)
      end
    end
  end
end)

function checkPermissions(requiredRoleList, requireAll, userRoles)
  if requireAll then
    local restrict = false
    for index, requiredRole in ipairs(requiredRoleList) do
      local foundRole = false
      for index, userRole in ipairs(userRoles) do
        if userRole == requiredRole then
          foundRole = true
        end
      end
      restrict = not foundRole
    end
    if not restrict then
      return true
    else
      return false
    end
  else
    local restrict = true
    if next(requiredRoleList) == nil then
      restrict = false
    end
    for index, requiredRole in ipairs(requiredRoleList) do
      for index, userRole in ipairs(userRoles) do
        if userRole == requiredRole then
          restrict = false
        end
      end
    end
    if not restrict then
      return true
    else
      return false
    end
  end
end

exports('checkJobPermissions', function(identifier, jobName, grade, cb)
  local jobExists = ESX.DoesJobExist(jobName, grade)
  local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
  if xPlayer and jobExists then
    local requiredRoleList = false
    local requireAll = false
    
    for index, jobRoleEntry in ipairs(Config.jobRoles) do
      if jobRoleEntry[2] == jobName and jobRoleEntry[5] == grade then
        requiredRoleList = jobRoleEntry[3]
        requireAll = jobRoleEntry[4]
      end
    end

    exports.discordroles:getUserRoles(xPlayer.source, function(userRoles)
      if xPlayer and userRoles then
        cb(checkPermissions(requiredRoleList, requireAll, userRoles))
      end
    end)
  else
    cb(false)
  end
end)

exports('setJob', function(identifier, jobName, grade, cb)
	local jobExists = ESX.DoesJobExist(jobName, grade)
  local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
  if xPlayer and jobExists then
    local requiredRoleList = false
    local requireAll = false
    
    for index, jobRoleEntry in ipairs(Config.jobRoles) do
      if jobRoleEntry[2] == jobName and jobRoleEntry[5] == grade then
        requiredRoleList = jobRoleEntry[3]
        requireAll = jobRoleEntry[4]
      end
    end

    exports.discordroles:getUserRoles(xPlayer.source, function(userRoles)
      if xPlayer and userRoles then
        local hasPermissions = checkPermissions(requiredRoleList, requireAll, userRoles)
        if checkPermissions(requiredRoleList, requireAll, userRoles) then
          xPlayer.setJob(jobName, grade)
          cb(true)
        else
          cb(false)
        end
      end
    end)
  else
    cb(false)
  end
end)
