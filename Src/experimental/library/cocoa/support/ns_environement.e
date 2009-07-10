note
	description: "Summary description for {NS_ENVIRONEMENT}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ENVIRONEMENT

feature -- Getting NSScreen Objects

	main_screen: NS_SCREEN
			-- Returns the NS_SCREEN object containing the window with the keyboard focus.
			-- The main screen is not necessarily the same screen that contains the menu bar or has its origin at (0, 0).
			-- The main screen refers to the screen containing the window that is currently receiving keyboard events.
			-- It is the main screen because it is the one with which the user is most likely interacting.
			-- The screen containing the menu bar is always the first object (index 0) in the array returned by the screens method.
		once
			create Result.share_from_pointer ({NS_SCREEN_API}.main_screen)
		end

	zero_screen: NS_SCREEN
			-- This screen contains the menu bar, has its origin at (0,0) and is always the first object (index 0) in the array returned by the screens method.
		local
			l_screens: NS_ARRAY [NS_SCREEN]
			l_root_screen: detachable NS_SCREEN
		once
			create l_screens.share_from_pointer ({NS_SCREEN_API}.screens)
			l_root_screen := l_screens.item (0)
			check l_root_screen /= void end
			create Result.share_from_pointer (l_root_screen.item)
		end

end
