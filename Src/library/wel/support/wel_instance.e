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
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create Result.make (Max_name_length + 1)
			Result.fill_blank
			create a_wel_string.make (Result)
			nb := cwin_get_module_file_name (item, a_wel_string.item,
				Max_name_length + 1)
			Result := a_wel_string.string
			Result.keep_head (nb)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
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


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

