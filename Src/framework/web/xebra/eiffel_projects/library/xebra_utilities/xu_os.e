note
	description: "[
		Provides file extensions and slashes for the current operating system.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_OS

feature -- Access

	exe_extension: STRING
			-- Returns ".exe" for windows and "" otherwise
		do
			if is_windows then
				Result := ".exe"
			else
				Result := ""
			end
		end


	is_windows: BOOLEAN
			-- Checks if this is windows
		do
			Result := {PLATFORM}.is_windows
		end

end
