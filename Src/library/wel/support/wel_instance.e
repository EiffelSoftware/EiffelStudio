indexing
	description: "Instance of an application."
	legal: "See notice at end of class."
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

	name: STRING_32 is
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
			"C [macro <wel.h>] (HINSTANCE, LPTSTR, %
				%int): EIF_INTEGER"
		alias
			"GetModuleFileName"
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




end -- class WEL_INSTANCE

