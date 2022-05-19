# ESX Discord Jobs - Created By Clink123
[![Discord](https://img.shields.io/discord/710320434872320010.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/gsMTu3q)

FiveM ESX script that allows players to take jobs, using Discord roles to whitelist these jobs. Also can take away jobs (and set the player back to a default job) if they lose the required Discord roles.

## Prerequisites

You must have [discordroles](https://github.com/sadboilogan/discordroles) configured and started for this resource to work.

This resource was built and designed for [ESX Legacy](https://github.com/esx-framework/esx-legacy)

## Use

- Place `esx_discordjobs` in your server resources.
- Edit `config.lua` with your desired jobs and roles.
- Add `start esx_discordjobs` to your server.cfg.

## Use In Other Resources

Includes two exports that can be used in other resources as shown below...

```lua
-- Check Job Permissions - returns true if they have permission to have the job, false otherwise
exports['esx_discordjobs']:checkJobPermissions(playerIdentifier, esxJobName, esxJobGrade, function(result)
  print(result)
end)
```

```lua
-- Set Job - sets the player job checking that they have permission to do so
-- Returns true if they had permission for and now have the job, false otherwise
exports['esx_discordjobs']:setJob(playerIdentifier, esxJobName, esxJobGrade, function(result)
  print(result)
end)
```

Note: Remember that the jobs and grades must be defined in `Config.jobRoles` for these to work.

## License

This resource/script/modification is provided free of charge. No warranty is provided in any form. Any responsibility for damages caused by this resource rest solely with the user. The author(s) of this script accept no liability. By using this resource, you agree to the following terms...

- The license must remain unmodified and in its original state, installed with the resource in your server.
- You may not redistribute, modify and redistribute, or claim this work as your own. Any modifications you make to this resource must be for personal use only.

## Contributing

If you want to contribute, simply send in a pull request!
