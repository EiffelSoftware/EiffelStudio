indexing
	description: "Callback facilities for WEL_DISK_SPACE. Version for classic Eiffel."
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
			"C signature (EIF_OBJECT, EIF_CHARACTER, EIF_POINTER): EIF_BOOLEAN use %"wel_disk_space.h%""
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

end -- class WEL_DISK_SPACE_CALLBACK

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
