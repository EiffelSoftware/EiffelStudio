indexing
	description:
		"Eiffel Vision directory dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

create
	default_create,
	make_with_title

feature -- Access

	directory: STRING_32 is
			-- Path of currently selected directory.
			-- `Result' is empty if "OK" was not pressed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.directory
		ensure
			directory_not_void: Result /= Void
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.directory)
		end

	start_directory: STRING_32 is
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_directory
		ensure
			bridge_ok: Result.is_equal (implementation.start_directory)
		end

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL) is
			-- Assign `a_path' to `start_directory'.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
			a_path_valid_string_8: a_path.is_valid_as_string_8
			a_path_exists: (create {DIRECTORY}.make (a_path.to_string_8)).exists
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DIRECTORY_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DIRECTORY_DIALOG_IMP} implementation.make (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DIRECTORY_DIALOG

