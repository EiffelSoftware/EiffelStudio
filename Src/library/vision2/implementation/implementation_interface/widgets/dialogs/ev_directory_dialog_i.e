indexing
	description: "Eiffel Vision directory dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DIRECTORY_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	directory: STRING_32 is
			-- Path of the current selected file
		deferred
		end

	start_directory: STRING_32 is
			-- Base directory where browsing will start.
		deferred
		end

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL) is
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		deferred
		ensure
			assigned: start_directory.is_equal (a_path)
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




end -- class EV_DIRECTORY_DIALOG_I

