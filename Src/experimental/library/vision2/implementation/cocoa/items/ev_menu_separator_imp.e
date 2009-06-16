note
	description: "Eiffel Vision menu separator. Cocoa implementation."
	author:	"Daniel Furrer"

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
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			pixmapable_imp_initialize
			create {NS_MENU_ITEM}cocoa_item.separator_item
			pixmapable_imp_initialize
			is_sensitive := True
			set_is_initialized (True)
		end

	initialize_menu_sep_box
			-- Create and initialize menu item box.
			--| This is just to satisfy pixmapable and textable contracts.
		do

		end

feature {EV_MENU_ITEM_LIST_IMP} -- Access

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radio items following this separator.

	create_radio_group
			-- Create `radio_group'.
		require
			radio_group_void: radio_group = Void
		do
			create radio_group.make
		ensure
			radio_group_not_void: radio_group /= Void
		end

	set_radio_group (a_list: like radio_group)
			-- Assign `a_list' to `radio_group'.
		require
			a_list_not_void: a_list /= Void
		do
			radio_group := a_list
		ensure
			assigned: radio_group = a_list
		end

	remove_radio_group
			-- Set `radio_group' to `Void'.
		do
			radio_group := Void
		ensure
			radio_group_void: radio_group = Void
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

	pointer_motion_actions_internal: detachable EV_POINTER_MOTION_ACTION_SEQUENCE
		note
			option: stable
			attribute
		end

	pointer_button_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
		note
			option: stable
			attribute
		end
		
	pointer_double_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
		note
			option: stable
			attribute
		end

feature {NONE} -- Implementation

	interface: detachable EV_MENU_SEPARATOR note option: stable attribute end;

end -- class EV_MENU_SEPARATOR_IMP