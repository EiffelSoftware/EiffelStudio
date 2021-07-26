note
	description: "Eiffel Vision menu separator. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
			make,
			dispose,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Do nothing because an empty GtkMenuItem is a separator.
		do
			set_c_object({GTK}.gtk_separator_menu_item_new)
			{GTK}.gtk_widget_show (c_object)
			{GTK}.gtk_widget_set_sensitive (c_object, False)
			{GTK}.gtk_widget_set_size_request (c_object, -1, 2)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_menu_sep_box
			create radio_group_ref
			is_sensitive := True
			set_is_initialized (True)
		end

	initialize_menu_sep_box
			-- Create and initialize menu item box.
			--| This is just to satisfy pixmapable and textable contracts.
		do
			box := {GTK}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_horizontal, 0)
			box := {GTK}.g_object_ref_sink (box)
			{GTK}.gtk_box_pack_start (box, text_label, True, True, 0)
			{GTK}.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end

feature {NONE} -- Implementation

	is_sensitive: BOOLEAN

	enable_sensitive
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
			is_sensitive := True
		end

	disable_sensitive
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
			is_sensitive := False
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	dispose
			-- Unreference unwanted gtk widgets.
		do
			if not box.is_default_pointer then
				{GTK2}.g_object_unref (box)
				box := default_pointer
			end
			if not c_object.is_default_pointer then
				{GTK2}.g_object_unref (c_object)
				c_object := default_pointer
			end
			Precursor
		end

	box: POINTER
		-- Dummy hbox used for holding *able widgets to satisfy invariants.

	radio_group_ref: POINTER_REF

	set_radio_group (p: POINTER)
			-- Assign `p' to `radio_group'.
		do
			radio_group_ref.set_item (p)
		end

	radio_group: POINTER
			-- GSList with all radio items of this container.
		do
			Result := radio_group_ref.item
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_MENU_SEPARATOR_IMP
