note
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

	directory: STRING_32
			-- Path of currently selected directory.
			-- `Result' is empty if "OK" was not pressed.
		obsolete
			"Use `path' instead."
		require
			not_destroyed: not is_destroyed
		do
			Result := path.name
		ensure
			directory_not_void: Result /= Void
		end

	path: PATH
			-- Path of currently selected directory.
			-- `Result' is empty if "OK" was not pressed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.path
		ensure
			directory_path_not_void: Result /= Void
			bridge_ok: Result /= Void implies Result.is_equal (implementation.path)
		end

	start_directory: STRING_32
			-- Base directory where browsing will start.
		obsolete
			"Use `start_path' instead."
		require
			not_destroyed: not is_destroyed
		do
			Result := start_path.name
		end

	start_path: PATH
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_path
		ensure
			bridge_ok: Result.is_equal (implementation.start_path)
		end

feature -- Element change

	set_start_directory (a_path: READABLE_STRING_GENERAL)
			-- Assign `a_path' to `start_directory'.
		obsolete
			"Use `set_start_path' instead."
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
			a_path_exists: (create {DIRECTORY}.make (a_path)).exists
		do
			set_start_path (create {PATH}.make_from_string (a_path))
		ensure
			assigned: start_directory.same_string_general (a_path)
		end

	set_start_path (a_path: PATH)
			-- Assign `a_path' to `start_path'.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
			a_path_exists: (create {DIRECTORY}.make_with_path (a_path)).exists
		do
			implementation.set_start_path (a_path)
		ensure
			assigned: start_path ~ a_path
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DIRECTORY_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Initialization

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DIRECTORY_DIALOG_IMP} implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DIRECTORY_DIALOG





