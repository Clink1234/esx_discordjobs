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
              xPlayer.setJob(requestedESXJob, jobGrade)
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","Your job has been set to " .. requestedESXJob .. " with grade " .. jobGrade .. "."}, color = Config.messageColor })
            else
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","You do not have permission to take that job."}, color = Config.errorColor })
            end
          else
            local restrict = true
            for index, requiredRole in ipairs(requiredRoleList) do
              for index, userRole in ipairs(userRoles) do
                if userRole == requiredRole then
                  restrict = false
                end
              end
            end
            if not restrict then
              xPlayer.setJob(requestedESXJob, jobGrade)
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","Your job has been set to " .. requestedESXJob .. " with grade " .. jobGrade .. "."}, color = Config.messageColor })
            else
              TriggerClientEvent('chat:addMessage', source, {args = {"Server","You do not have permission to take that job."}, color = Config.errorColor })
            end
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
