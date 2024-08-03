-- next steps could be to take user flags as in arg
-- arg to specify default remote server.
-- maybe have the default dest value prefilled with the file name
-- take in password (securely?)
-- maybe take a look at `wait_with_output` to notify on completion
local selected_or_hovered = ya.sync(function()
	local tab = cx.active
	local paths = {}

	-- count up selected files
	for _, url in pairs(tab.selected) do
		paths[#paths + 1] = tostring(url)
	end

	-- if no files are selected use the hovered file
	-- a tab has folders which have files which have urls
	if #paths == 0 and tab.current.hovered then
		-- lua so we are 1 indexed
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

return {
	entry = function()
		-- escape out of visual mode - idk why?
		ya.manager_emit("escape", { visual = true })

		local files = selected_or_hovered()
		if #files == 0 then
			return ya.notify { title = "Rsync", content = "No files selected", level = "warn", timeout = 5 }
		end

		-- if #files == 1 and <arg for default server> then
		-- 	local default_dest = arg..":"..cx.active.current.hovered.url
		-- end

		local dest, ok = ya.input {
			title = "Rsync - [user]@[remote]:<destination>",
			position = { "top-center", y = 3, w = 45 },
		}
		if ok ~= 1 then
			return
		end

		-- local cmd, err = Command("rsync"):args(files):arg(dest):stderr(Command.PIPED):output()
		local cmd, err = Command("rsync")
			:args({ "-ahP", "--no-motd" })
			:args(files)
			:arg(dest)
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()
		local stderr = cmd.stderr
		local stdout = cmd.stdout
		local return_code = cmd.status.code
		ya.err {
			stderr = stderr,
			stdout = stdout,
			err = err,
			child_res = cmd.status.success,
			child_return_code = return_code,
		}

		if return_code ~= 0 then
			ya.notify {
				title = "Rsync plugin",
				content = string.format("stderr below, exit code %s\n\n%s", cmd.status.code, stderr),
				level = "error",
				timeout = 10,
			}
		end
	end,
}
