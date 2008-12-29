note
	description: "Shared list of open configuration windows"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONFIG_WINDOWS

feature {NONE} -- Access

	config_windows: HASH_TABLE [CONFIGURATION_WINDOW, STRING]
			-- Open configuration windows, indexed by the configuration file the represent.
		once
			create Result.make (5)
		end

end
