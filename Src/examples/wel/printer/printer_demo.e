note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	PRINTER_DEMO

inherit
	WEL_APPLICATION

create
	make

feature

	main_window: MAIN_WINDOW
			-- Create the application's main window
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PRINTER_DEMO

