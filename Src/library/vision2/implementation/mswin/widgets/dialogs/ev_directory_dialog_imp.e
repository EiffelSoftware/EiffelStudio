indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_SELECTION_DIALOG_IMP

inherit
	EV_DIRECTORY_SELECTION_DIALOG_I

	EV_STANDARD_DIALOG_IMP

	WEL_OPEN_FILE_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		redefine
			wel_make
		end

creation
	make

feature {NONE} -- Initialization

	wel_make is
		do
			{WEL_OPEN_FILE_DIALOG} Precursor
--			add_flag (Ofn_explorer)
--			add_flag (Ofn_enablehook)
--			cwel_open_file_name_set_lpfnhook (item, $hook_procedure)
		end

feature -- Status report

	directory: STRING is
			-- Path of the current selected file
		do
		end

feature -- Element change

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		do
		end

feature {NONE} -- Implementation

	frozen hook_procedure (hwnd: POINTER; msg, wparam,
			lparam: INTEGER): INTEGER is
			-- Hook procedure that receive the events
			-- of the dialog
		local
		do
			io.put_string ("%NBouh : ")
			io.putint (msg)
		end

feature {NONE} -- Externals

	cwel_open_file_name_set_hinstance (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_lpstrcustomfilter (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_nmaxcustfilter (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_nfileoffset (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_lcustdata (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_lpfnhook (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_set_lptemplatename (ptr, value: POINTER) is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_hinstance (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_lpstrcustomfilter (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_nmaxcustfilter (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_lcustdata (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_lpfnhook (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

	cwel_open_file_name_get_lptemplatename (ptr: POINTER): POINTER is
		external
			"C [macro %"ofn.h%"]"
		end

end -- class EV_DIRECTORY_SELECTION_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
