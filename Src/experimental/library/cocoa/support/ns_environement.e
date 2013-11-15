note
	description: "A collection of singletons which are originally Cocoa class methods."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
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
		once
			create l_screens.share_from_pointer ({NS_SCREEN_API}.screens)
			check attached l_screens.item (0) as l_root_screen then
				create Result.share_from_pointer (l_root_screen.item)
			end
		end


feature -- Getting the Notification Center

	default_center: NS_NOTIFICATION_CENTER
			-- The task's default notification center.
		once
			create Result.share_from_pointer ({NS_NOTIFICATION_CENTER_API}.default_center)
		end

feature -- Getting the Shared Font Manager

	shared_font_manager: NS_FONT_MANAGER
			-- Returns the shared instance of the font manager for the application, creating it if necessary.
		once
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.shared_font_manager)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
