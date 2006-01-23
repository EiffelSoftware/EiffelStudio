indexing
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	MAIN_WINDOW_MANAGER_WINDOWS

inherit
	WEL_APPLICATION

feature -- Implementation

	add_main_window (tw: TOP_IMP) is
			-- Add `tw' to the list of main windows.
		do
			if main_windows.is_empty then
				main_windows.extend (tw)
				set_main_window
			else
				main_windows.extend (tw)
			end
		end

	set_main_window is
			-- Set the main window for the application
		require
			main_window_exists: main_window /= Void
		do
			set_application_main_window (main_window)
		ensure
			main_window_set: main_window /= Void
		end

	main_window: TOP_IMP is
			-- The main window of the application
		require else
			no_precondition: true
		do
			if not main_windows.is_empty then
				Result := main_windows.first
			end
		end

	main_windows: LINKED_LIST [TOP_IMP] is
			-- Storage for the main window
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	remove_main_window (tw: TOP_IMP) is
			-- Remove `tw' from the main windows list
		do
			if main_windows.count /= 1 then
				main_windows.start
				if application_main_window = tw then
					main_windows.search (tw)
					main_windows.remove
					set_main_window
				else
					main_windows.search (tw)
					main_windows.remove
				end
			end
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




end -- class MAIN_WINDOW_MANAGER_WINDOWS

