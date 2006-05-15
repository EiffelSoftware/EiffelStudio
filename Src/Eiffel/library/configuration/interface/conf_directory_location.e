indexing
	description: "Objects that represent a directory location."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_DIRECTORY_LOCATION

inherit
	CONF_LOCATION

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING; a_target: CONF_TARGET) is
			-- Create with `a_path' (without a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
			a_target_not_void: a_target /= Void
		do
			set_path (a_path)
			target := a_target
		ensure
			target_set: target = a_target
		end

feature {CONF_ACCESS} -- Update stored in configuration file.

	set_path (a_path: like original_path) is
			-- Set `original_path' to `a_path'.
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
		do
			original_path := to_internal (a_path)
			if original_path.count = 0 then
				original_path.append_character ('.')
			end
			if original_path.item (original_path.count) /= '\' then
				original_path.append_character ('\')
			end
		end

end
