indexing
	description: "General notions of a loadable resource."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "`make_by_predefined_id' does now take a POINTER as argument.%
		   %Please change any external clauses of existing prefedefined%
		   %IDs to POINTER too. Predefined IDs are correctly casted on%
		   %the C-side already"

deferred class
	WEL_RESOURCE

inherit
	WEL_ANY

feature {NONE} -- Initialization

	make_by_id (id: INTEGER) is
			-- Load the resource by an `id'
		require
			valid_id: id > 0
		do
			load_item (main_args.current_instance.item,
				cwin_make_int_resource (id))
		ensure
			not_shared: not shared
		end

	make_by_name (name: STRING) is
			-- Load the resource by a `name'
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (name)
			load_item (main_args.current_instance.item, a_wel_string.item)
		ensure
			not_shared: not shared
		end

	make_by_predefined_id (id: POINTER) is
			-- Load the resource by an `id', predefined by Windows
		local
			a_default_pointer: POINTER
		do
			load_item (a_default_pointer, id)
			shared := True
		ensure
			shared: shared
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load `id' from `hinstance' by calling
			-- the corresponding Windows function
		require
			id_not_void: id /= default_pointer
		deferred
		end

	main_args: WEL_MAIN_ARGUMENTS is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_make_int_resource (id: INTEGER): POINTER is
			-- Convert `id' to a pointer
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

end -- class WEL_RESOURCE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

