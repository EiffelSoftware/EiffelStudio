indexing
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
			make,
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

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_item_new)
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			{EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (c_object, False)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, 8)
		end

	initialize is
			-- Do nothing because an empty GtkMenuItem is a separator.
		do
			real_text := ""
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_menu_sep_box
			create radio_group_ref
			is_sensitive := True
			set_is_initialized (True)
		end

	initialize_menu_sep_box is
			-- Create and initialize menu item box.
			--| This is just to satisfy pixmapable and textable contracts.
		do
			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.object_ref (box)
			{EV_GTK_EXTERNALS}.gtk_object_sink (box)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, text_label, True, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end
		
feature {NONE} -- Implementation

	is_sensitive: BOOLEAN
	
	enable_sensitive is
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
			is_sensitive := True
		end

	disable_sensitive is
			-- Implemented to fulfill assertions but leave c_object unsensitive.
		do
			is_sensitive := False
		end	

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	dispose is
			-- Unreference unwanted gtk widgets.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.object_unref (box)
			Precursor
		end
		
	box: POINTER
		-- Dummy hbox used for holding *able widgets to satisfy invariants.

	radio_group_ref: POINTER_REF

	set_radio_group (p: POINTER) is
			-- Assign `p' to `radio_group'.
		do
			radio_group_ref.set_item (p)
		end

	radio_group: POINTER is
			-- GSList with all radio items of this container.
		do
			Result := radio_group_ref.item
		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature {NONE} -- Implementation

	interface: EV_MENU_SEPARATOR;

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




end -- class EV_MENU_SEPARATOR_IMP

