indexing
	description: "This class is used to load the rich edit control %
		%dll. See class WEL_RICH_EDIT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_DLL

inherit
	WEL_DLL
		rename
			make as dll_make
		end

create
	make

feature
	make is
			-- Load the rich edit DLL.
		do
			make_permanent (rich_edit_dll_name)
		end

feature {NONE} -- Implementation

--	rich_edit_dll_name: STRING is "riched20.dll"
	rich_edit_dll_name: STRING is "riched32.dll";
			-- Name of the rich edit DLL
	

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




end -- class WEL_RICH_EDIT_DLL

