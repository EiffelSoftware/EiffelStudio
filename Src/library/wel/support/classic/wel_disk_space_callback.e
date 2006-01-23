indexing
	description: "Callback facilities for WEL_DISK_SPACE. Version for classic Eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DISK_SPACE_CALLBACK

feature -- Access

feature -- Access

	last_query_success: BOOLEAN
			-- Was the last call to `query_disk_space' successful?

feature -- Status report

	query_local_drive(drive_letter: CHARACTER) is
			-- Query the disk space available on the local drice 
			-- designated by the letter `drive_letter'.
		do
			last_query_success := cwin_query_disk_space ($Current,
				drive_letter, $eif_set_disk_space_attributes_callback)
		end

feature {NONE} -- Implementation

	cwin_query_disk_space(current_object: POINTER; drive_letter: CHARACTER; 
			callback_function: POINTER): BOOLEAN is
		external 
			"C signature (EIF_REFERENCE, EIF_CHARACTER, EIF_POINTER): EIF_BOOLEAN use %"wel_disk_space.h%""
		end

	eif_set_disk_space_attributes_callback(
		-- Callback function called from the C code.
			free_space: INTEGER;
			total_space: INTEGER;
			free_space_in_bytes: INTEGER;
			total_space_in_bytes: INTEGER
			) is
		deferred
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




end -- class WEL_DISK_SPACE_CALLBACK

