Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', "/"..Config.command,  'Take a job.',  {{name = 'Job Name', help = 'The name of the job you want to take.'}})
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', "/"..Config.command)
	end
end)