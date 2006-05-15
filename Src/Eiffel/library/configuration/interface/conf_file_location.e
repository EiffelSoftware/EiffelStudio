indexing
	description: "Objects that represent a file location."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_LOCATION

inherit
	CONF_LOCATION

create
	make

feature {NONE} -- Initialization

	make (a_full_path: STRING; a_target: CONF_TARGET) is
			-- Create with `a_full_path' (with a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_full_path_not_void: a_full_path /= Void
			a_target_not_void: a_target /= Void
		do
			set_full_path (a_full_path)
			target := a_target
		ensure
			target_set: target = a_target
		end

feature {CONF_ACCESS} -- Update, stored in configuration file.

	set_full_path (a_path: STRING) is
			-- Set `original_path' to `a_path'.
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_path_not_void: a_path /= Void
		do
			original_path := to_internal (a_path)
		end

end
