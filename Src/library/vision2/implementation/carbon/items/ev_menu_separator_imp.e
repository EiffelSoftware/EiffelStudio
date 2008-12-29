note
	description: "Eiffel Vision menu separator. Carbon implementation."

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
			enable_sensitive,
			disable_sensitive,
			is_sensitive,
			interface,
			initialize,
			dispose,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Do nothing because an empty GtkMenuItem is a separator.
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

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	dispose
			-- Unreference unwanted gtk widgets.
		do
		end

	box: POINTER
		-- Dummy hbox used for holding *able widgets to satisfy invariants.

	radio_group_ref: POINTER_REF

	set_radio_group (p: POINTER)
			-- Assign `p' to `radio_group'.
		do
		end

	radio_group: POINTER
			-- GSList with all radio items of this container.
		do
		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature {NONE} -- Implementation

	interface: EV_MENU_SEPARATOR;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_MENU_SEPARATOR_IMP

