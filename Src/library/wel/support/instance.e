indexing
	description: "Instance of an application."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INSTANCE

inherit
	WEL_ANY

creation
	make

feature {NONE} -- Initialization

	make (a_hinstance: POINTER) is
			-- Make an instance identified by `a_hinstance'.
		do
			item := a_hinstance
		ensure
			item_set: item = a_hinstance
		end

feature -- Access

	name: STRING is
			-- Module name
		local
			a: ANY
		do
			!! Result.make (Max_name_length + 1)
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_module_file_name (item, $a,
				Max_name_length + 1))
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.empty
		end

feature {NONE} -- Removal

	destroy_item is
		do
			-- We don't have to destroy an instance.
			item := default_pointer
		end

feature {NONE} -- Implementation

	Max_name_length: INTEGER is 255
			-- Maximum module name length

feature {NONE} -- Externals

	cwin_get_module_file_name (hinstance, buffer: POINTER;
			length: INTEGER): INTEGER is
			-- SDK GetModuleFileName
		external
			"C [macro <wel.h>] (HINSTANCE, LPSTR, %
				%int): EIF_INTEGER"
		alias
			"GetModuleFileName"
		end

end -- class WEL_INSTANCE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
