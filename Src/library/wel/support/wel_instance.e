indexing
	description: "Instance of an application."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INSTANCE

inherit
	WEL_ANY

create
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
			create a_wel_string.make_empty (Max_name_length + 1)
			nb := cwin_get_module_file_name (item, a_wel_string.item,
				Max_name_length + 1)
			Result := a_wel_string.substring (1, nb)
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

