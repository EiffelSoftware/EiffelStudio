indexing
	status: "See notice at end of class"; 
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
			!! Result.make
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

end -- class MAIN_WINDOW_MANAGER_WINDOWS
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

