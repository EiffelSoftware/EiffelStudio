indexing
	description: "General notions of a loadable resource."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
			name_not_empty: not name.empty
		local
			a_wel_string: WEL_STRING
		do
			!! a_wel_string.make (name)
			load_item (main_args.current_instance.item, a_wel_string.item)
		ensure
			not_shared: not shared
		end

	make_by_predefined_id (id: INTEGER) is
			-- Load the resource by an `id', predefined by Windows
		do
			load_item (default_pointer,
				cwin_make_int_resource (id))
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
			!! Result
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
