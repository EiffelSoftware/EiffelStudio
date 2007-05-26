indexing
	description: "Eiffel Vision menu item. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			needs_event_box
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			accelerators_enabled
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN = False
			-- Does `a_widget' need an event box?

	is_dockable: BOOLEAN = False

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_menu_item_new)
			pixmapable_imp_initialize
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_menu_item_set_image (menu_item, pixmap_box)
		end

	initialize is
			-- Initialize `Current'
		local
			box: POINTER
		do
			Precursor {EV_ITEM_IMP}
			real_signal_connect_after (menu_item, once "activate", agent (App_implementation.gtk_marshal).menu_item_activate_intermediary (c_object), Void)
			textable_imp_initialize

			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_container_add (menu_item, box)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)

			if pixmap_box = default_pointer then
				pixmapable_imp_initialize
				{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, False, True, 0)
			end
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, text_label, False, True, 0)

			accel_label := {EV_GTK_EXTERNALS}.gtk_label_new (default_pointer)
			{EV_GTK_EXTERNALS}.gtk_widget_show (accel_label)
				-- We right align accelerator text.
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (accel_label, 1.0, 0.5)
			{EV_GTK_EXTERNALS}.gtk_misc_set_padding (accel_label, 0, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, accel_label, True, True, 0)
			{EV_GTK_EXTERNALS}.gtk_label_set_justify (accel_label, {EV_GTK_EXTERNALS}.gtk_justify_right_enum)
		end

		accel_label: POINTER

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		local
			l_split_text: STRING_32
			l_split_list: LIST [STRING_32]
			a_cs: EV_GTK_C_STRING
		do
			l_split_text := a_text.to_string_32.twin
			l_split_list := l_split_text.split ('%T')
			if l_split_list.count = 2 then
				Precursor {EV_TEXTABLE_IMP} (l_split_list @ 1)
				real_text := a_text
				a_cs := l_split_list @ 2
			else
				Precursor {EV_TEXTABLE_IMP} (a_text)
				a_cs := ""
			end
			{EV_GTK_EXTERNALS}.gtk_label_set_text (accel_label, a_cs.item)
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	menu_item: POINTER
			-- Pointer to the GtkMenuItem widget.
		do
			Result := c_object
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	accelerators_enabled: BOOLEAN is True

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
				{EV_GTK_EXTERNALS}.gtk_menu_shell_deactivate (p_imp.list_widget)
			end
			{EV_GTK_EXTERNALS}.gtk_menu_item_deselect (menu_item)
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	interface: EV_MENU_ITEM;

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




end -- class EV_MENU_ITEM_IMP

