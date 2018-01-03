--[[
                     _   _        _
     _ __ ___   __ _| |_| |_ __ _| |_ __ _
    | '_ ` _ \ / _` | __| __/ _` | __/ _` |
    | | | | | | (_| | |_| || (_| | || (_| |
    |_| |_| |_|\__,_|\__|\__\__,_|\__\__,_|

    Configuration file for mattata v1.2.0

    Copyright 2017 Matthew Hesketh <wrxck0@gmail.com>
    This code is licensed under the MIT. See LICENSE for details.

    Each value in an array should be comma separated, with the exception of the last value!
    Make sure you always update your configuration file after pulling changes from GitHub!

]]

local get_plugins = function(extension, directory)
    extension = extension and tostring(extension) or 'royale'
    if extension:match('^%.') then
        extension = extension:match('^%.(.-)$')
    end
    directory = directory and tostring(directory) or 'plugins'
    if directory:match('/$') then
        directory = directory:match('^(.-)/$')
    end
    local plugins = {}
    local all = io.popen('mkdir -p ' .. directory .. '; ls ' .. directory .. '/'):read('*all')
    for plugin in all:gmatch('[%w_-]+%.' .. extension .. ' ?') do
        plugin = plugin:match('^([%w_-]+)%.' .. extension .. ' ?$')
        table.insert(plugins, plugin)
    end
    return plugins
end

return { -- Rename this file to configuration.lua for the bot to work!
    ['bot_token'] = '', -- In order for the bot to actually work, you MUST insert the Telegram
    -- bot API token you received from @BotFather.
    -- The following two tokens will require you to have setup payments with @BotFather, and
    -- a Stripe account with @stripe!
    ['admins'] = {  -- Here you need to specify the numerical ID of the users who shall have
    -- FULL control over the bot, this includes access to server files via the lua and shell plugins.
        nil
    },
    ['language'] = 'en', -- The two character locale to set your default language to.
    ['log_chat'] = nil, -- This needs to be the numerical identifier of the chat you wish to log
    -- errors into. If it's not a private chat it should begin with a '-' symbol.
    ['debug'] = false, -- Turn this on to print EVEN MORE information to the terminal.
    ['plugins'] = get_plugins(),
    ['redis'] = { -- Configurable options for connecting the bot to redis. Do NOT modify
    -- these settings if you don't know what you're doing!
        ['host'] = '127.0.0.1',
        ['port'] = 6379,
        ['password'] = nil,
        ['db'] = 2
    },
    ['keys'] = { -- API keys needed for the full functionality of several plugins.
        ['clashroyale'] = '', -- https://docs.cr-api.com
    },
    ['errors'] = { -- Messages to provide a more user-friendly approach to errors.
        ['connection'] = 'Connection error.',
        ['results'] = 'I couldn\'t find any results for that.',
        ['supergroup'] = 'This command can only be used in supergroups.',
        ['admin'] = 'You need to be a moderator or an administrator in this chat in order to use this command.',
        ['unknown'] = 'I don\'t recognise that user. If you would like to teach me who they are, forward a message from them to any chat that I\'m in.',
        ['generic'] = 'An unexpected error occured. Please report this error using /bugreport.'
    }
}

--[[

    End of configuration, you're good to go.
    Use `./launch.sh` to start the bot.
    If you can't execute the script, try running `chmod +x launch.sh`

]]
