indexing
	description: "Eiffel Vision menu. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_MENU_ITEM_IMP
		undefine
			parent,
			show
		redefine
			interface,
			initialize,
			set_text,
			on_activate,
			dispose,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal,
			destroy
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			list_widget,
			insert_menu_item,
			dispose,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			list_widget := {EV_GTK_EXTERNALS}.gtk_menu_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)
			{EV_GTK_EXTERNALS}.gtk_menu_item_set_submenu (
				c_object, list_widget
			)
			Precursor {EV_MENU_ITEM_LIST_IMP}
			Precursor {EV_MENU_ITEM_IMP}
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			real_text := a_text.twin
			a_cs := u_lined_filter (real_text)
			key := {EV_GTK_EXTERNALS}.gtk_label_parse_uline (text_label,
				a_cs.item).to_natural_32
			{EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		local
			pc: EV_COORDINATE
			bw: INTEGER
		do
			pc := (create {EV_SCREEN}).pointer_position
			bw := {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (list_widget)
			if not interface.is_empty then
				{EV_GTK_DEPENDENT_EXTERNALS}.c_gtk_menu_popup (list_widget, pc.x + bw, pc.y + bw)
			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
			if not interface.is_empty then
				{EV_GTK_DEPENDENT_EXTERNALS}.c_gtk_menu_popup (list_widget,
					a_widget.screen_x + a_x,
					a_widget.screen_y + a_y)
			end
		end

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		local
			accel_group: POINTER
			menu_imp: EV_MENU_IMP
			a_cs: EV_GTK_C_STRING
		do
			Precursor {EV_MENU_ITEM_LIST_IMP} (an_item_imp, pos)
			if an_item_imp.key /= 0 then
				if accel_group = NULL then
					accel_group := {EV_GTK_EXTERNALS}.gtk_menu_get_accel_group (list_widget)
				end
				menu_imp ?= an_item_imp
				if menu_imp = Void and then accel_group /= NULL then
					a_cs := "activate"
					{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (an_item_imp.c_object,
						a_cs.item,
						accel_group,
						an_item_imp.key,
						0,
						0)
				elseif accel_group /= NULL then
					
					a_cs := "activate_item"
					{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (menu_imp.c_object,
						a_cs.item,
						accel_group,
						menu_imp.key,
						0,
						0)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
			end
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	list_widget: POINTER

	interface: EV_MENU

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature {NONE} -- Implementation
	
	destroy is
			-- Destroy the menu
		do
			interface.wipe_out
			Precursor {EV_MENU_ITEM_IMP}
		end
		
	dispose is
			-- Disposal routine
		do
			Precursor {EV_MENU_ITEM_IMP}
			list_widget := NULL
		end

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




end -- class EV_MENU_IMP

