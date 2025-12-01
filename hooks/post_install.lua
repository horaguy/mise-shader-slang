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

    local testResult = os.execute(path .. "/bin/slangc -v > /dev/null 2>&1")
    if testResult ~= 0 then
        error("shader-slang installation appears to be broken")
    end
end
