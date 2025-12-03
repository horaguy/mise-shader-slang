-- hooks/post_install.lua
-- Performs additional setup after installation
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook

function PLUGIN:PostInstall(ctx)
    -- Available context:
    -- ctx.rootPath - Root installation path
    -- ctx.runtimeVersion - Full version string
    -- ctx.sdkInfo[PLUGIN.name] - SDK information

    local sdkInfo = ctx.sdkInfo[PLUGIN.name]
    local path = sdkInfo.path
    -- local version = sdkInfo.version

    -- Build executable path based on platform
    local pathSeparator = "/"
    local executableName = "slangc"
    if RUNTIME.osType == "Windows" then
        pathSeparator = "\\"
        executableName = "slangc.exe"
    end

    local executablePath = path .. pathSeparator .. "bin" .. pathSeparator .. executableName
    local success, exitType, exitCode = os.execute(executablePath .. " -v")

    print('success: ' .. success)
    print('exitType: ' .. exitType)
    print('exitCode: ' .. exitCode)

    -- Handle different return value formats across platforms
    -- On Windows, exitCode might be nil, so check success first
    if not success then
        error("shader-slang installation appears to be broken")
    end
    -- On Unix-like systems, check exitCode if available
    if exitCode ~= nil and exitCode ~= 0 then
        error("shader-slang installation appears to be broken")
    end
end
