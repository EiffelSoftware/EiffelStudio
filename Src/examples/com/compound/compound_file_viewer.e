indexing
	description: "Root class for compound file viewer"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOUND_FILE_VIEWER
	
inherit
	WEL_APPLICATION
		redefine
			init_application
		end

create
	make

feature -- Access
		
	main_window: MAIN_WINDOW is
			-- Application's main window
		once
			create Result.make
		end

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Rich edit dll
			
feature {NONE} -- Implementation

	init_application is
			-- Load Rich Edit dll
		do
			create rich_edit_dll.make
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


end -- class APPLICATION

