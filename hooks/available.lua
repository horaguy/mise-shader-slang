-- hooks/available.lua
-- Returns a list of available versions for the tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook

function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    local repo_url = "https://api.github.com/repos/shader-slang/slang/releases?per_page=100"

    local resp, err = http.get({
        url = repo_url,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end
    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local tags = json.decode(resp.body)
    local result = {}

    for _, tag_info in ipairs(tags) do
        -- Only accept versions matching vYYYY.MM.DD format (e.g., v2025.13.1)
        -- Exclude formats like vulkan-sdk-1.4.321.0 or v2024.10.1-draft
        if not tag_info.tag_name:match("^v%d+%.%d+%.%d+$") then
            goto continue
        end
        local version = tag_info.tag_name:gsub("^v", "")
        local is_prerelease = tag_info.prerelease or false
        local note = is_prerelease and "pre-release" or nil

        table.insert(result, {
            version = version,
            note = nil, -- Optional: "latest", "lts", "pre-release", etc.
            -- addition = {} -- Optional: additional tools/components
        })

        ::continue::
    end

    return result
end
