-- hooks/pre_install.lua
-- Returns download information for a specific version
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook

-- Helper function for platform detection (uncomment and modify as needed)
local function get_platform()
    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType
    local platform_map = {
        ["darwin"] = {
            ["amd64"] = "macos-x86_64",
            ["arm64"] = "macos-aarch64",
        },
        ["linux"] = {
            ["amd64"] = "linux-x86_64",
            ["arm64"] = "linux-aarch64",
            -- ["386"] = "linux-386",
        },
        ["windows"] = {
            ["amd64"] = "windows-x86_64",
            ["arm64"] = "windows-aarch64",
            -- ["386"] = "windows-386",
        }
    }

    local os_map = platform_map[os_name]
    if os_map then
        return os_map[arch] or "linux-x86_64"  -- fallback
    end

    -- Default fallback
    return "linux-x86_64"
end

function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    -- ctx.runtimeVersion contains the full version string if needed

    local platform = get_platform()
    local url = "https://github.com/shader-slang/slang/releases/download/v" .. version .. "/slang-" .. version .. "-" .. platform .. ".zip"

    return {
        version = version,
        url = url,
        -- sha256 = sha256, -- Optional but recommended for security
        note = "Downloading shader-slang " .. version,
        -- addition = { -- Optional: download additional components
        --     {
        --         name = "component",
        --         url = "https://example.com/component.tar.gz"
        --     }
        -- }
    }
end

