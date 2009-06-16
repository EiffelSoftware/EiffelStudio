note
	description: "Wrapper for NSMenuItem."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_ITEM

inherit
	NS_OBJECT

	TARGET_ACTION_SUPPORT

create
	make,
	separator_item

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_MENU_ITEM_API}.new)
		end

	separator_item
		do
			make_from_pointer ({NS_MENU_ITEM_API}.separator_item)
		end

feature -- Access

	set_submenu (a_menu: NS_MENU)
		do
			{NS_MENU_ITEM_API}.set_submenu (item, a_menu.item)
		end

	set_title (a_title: STRING_GENERAL)
		do
			{NS_MENU_ITEM_API}.set_title (item, (create {NS_STRING}.make_with_string (a_title)).item)
		end

	set_key_equivalent (a_string: STRING_GENERAL)
		do
			{NS_MENU_ITEM_API}.set_key_equivalent (item, (create {NS_STRING}.make_with_string (a_string)).item)
		end

	set_key_equivalent_modifier_mask (a_mask: INTEGER)
		do
			{NS_MENU_ITEM_API}.set_key_equivalent_modifier_mask (item, a_mask)
		end

feature -- Managing the Image

	set_image (a_image: NS_IMAGE)
		do
			{NS_MENU_ITEM_API}.set_image (item, a_image.item)
		end

feature -- Managing the State

	set_state (a_state: INTEGER)
			-- Sets the state of the receiver.
			-- The image associated with the new state is displayed to the left of the menu item.
		require
			valid_state:
		do
			{NS_MENU_ITEM_API}.set_state (item, a_state)
		ensure
			state_set:
		end

	state: INTEGER assign set_state
			-- Returns the state of the receiver.
		do
			Result := {NS_MENU_ITEM_API}.state (item)
		ensure
			valid_state:
		end

feature -- Key Mask Constants (should be in NS_EVENT)

	frozen shift_key_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSShiftKeyMask;"
		end

	frozen alternate_key_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSAlternateKeyMask;"
		end

	frozen command_key_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSCommandKeyMask;"
		end

	frozen control_key_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSControlKeyMask;"
		end
end
