note
	description: "Summary description for {NS_MENU_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_API

feature -- Managing the Menu Bar

feature -- Creating an NSMenu Object

feature -- Setting Up Menu Commands

feature -- Finding Menu Items

	frozen item_with_tag (a_ns_menu: POINTER; a_tag: INTEGER): POINTER
			-- - (NSMenuItem *)itemWithTag: (NSInteger) tag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenu*)$a_ns_menu itemWithTag: $a_tag];"
		end

	frozen item_with_title (a_ns_menu: POINTER; a_title: POINTER): POINTER
			-- - (NSMenuItem *)itemWithTitle: (NSString *) aTitle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenu*)$a_ns_menu itemWithTitle: $a_title];"
		end

	frozen item_at_index (a_ns_menu: POINTER; a_index: INTEGER): POINTER
			-- - (NSMenuItem *)itemAtIndex: (NSInteger) index
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenu*)$a_ns_menu itemAtIndex: $a_index];"
		end

	frozen number_of_items (a_ns_menu: POINTER): INTEGER
			-- - (NSInteger)numberOfItems
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenu*)$a_ns_menu numberOfItems];"
		end

	frozen item_array (a_ns_menu: POINTER): POINTER
			-- - (NSArray *)itemArray
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSMenu*)$a_ns_menu itemArray];"
		end

feature -- Finding Indices of Menu Items

feature -- Managing Submenus

feature -- Enabling and Disabling Menu Items

feature -- Handling Keyboard Equivalents

feature -- Simulating Mouse Clicks

feature -- Managing the Title

feature -- Updating Menu Layout

feature -- Displaying Context-Sensitive Help

feature -- Managing Display of the State Column

feature -- Controlling Allocation Zones

feature -- Handling Highlighting

feature -- Managing the Delegate

feature -- Handling Open and Close Events

feature -- Handling Tracking

end
