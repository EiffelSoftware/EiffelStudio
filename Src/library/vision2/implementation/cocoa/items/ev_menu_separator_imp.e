indexing
	description: "Eiffel Vision menu separator. Cocoa implementation."

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			enable_sensitive,
			disable_sensitive,
			is_sensitive,
			interface,
			initialize,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a menu.
		do
			base_make (an_interface)
			pixmapable_imp_initialize
			create {NS_MENU_ITEM}cocoa_item.separator_item
		end

	initialize
		do
			pixmapable_imp_initialize
			is_sensitive := True
			set_is_initialized (True)
		end

	initialize_menu_sep_box
			-- Create and initialize menu item box.
			--| This is just to satisfy pixmapable and textable contracts.
		do

		end

feature {NONE} -- Implementation

	is_sensitive: BOOLEAN

	enable_sensitive
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
		end

	disable_sensitive
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature {NONE} -- Implementation

	interface: EV_MENU_SEPARATOR;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MENU_SEPARATOR_IMP

