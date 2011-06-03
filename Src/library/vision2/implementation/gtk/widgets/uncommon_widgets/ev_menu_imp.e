note
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
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			make,
			on_activate,
			destroy,
			show,
			old_make
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			make,
			list_widget,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create a menu.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			Precursor {EV_MENU_ITEM_IMP}
			list_widget := {EV_GTK_EXTERNALS}.gtk_menu_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_show (menu_item)
			{EV_GTK_EXTERNALS}.gtk_menu_item_set_submenu (
				menu_item, list_widget
			)
			Precursor {EV_MENU_ITEM_LIST_IMP}
				-- We set the image here for the image menu item instead of packing it in a box.
			pixmapable_imp_initialize
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_menu_item_set_image (menu_item, pixmap_box)
		end

feature -- Basic operations

	show
			-- Pop up on the current pointer position.
		local
			pc: EV_COORDINATE
			bw: INTEGER
		do
			pc := (create {EV_SCREEN}).pointer_position
			bw := {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (list_widget)
			show_at (Void, pc.x + bw, pc.y + bw)
		end

	show_at (a_widget: detachable EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		local
			l_x, l_y: INTEGER
		do

			if count > 0 then
				if a_widget /= Void then
					l_x := a_widget.screen_x + a_x
					l_y := a_widget.screen_y + a_y
				else
					l_x := a_x
					l_y := a_y
				end
					-- Change from logical to physical screen coordinates.
				l_x := l_x - app_implementation.screen_virtual_x
				l_y := l_y - app_implementation.screen_virtual_y
					-- This is needed so that we can retrieve `Current' from the
					-- GdkEvent when it is unmapped to remove the reference
					-- of {EV_APPLICATION_IMP}.currently_shown_control
				couple_object_id_with_gtk_object (list_widget, object_id)
				app_implementation.set_currently_shown_control (interface)
				app_implementation.do_once_on_idle (agent
					c_gtk_menu_popup (list_widget,
							l_x, l_y, 0, {EV_GTK_EXTERNALS}.gtk_get_current_event_time)
				)
			end
		end

feature {NONE} -- Externals

	frozen couple_object_id_with_gtk_object (a_gtk_object: POINTER; a_object_id: INTEGER)
			-- Associate GtkObject `a_gtk_object' with object id `a_object_id'
		external
			"C inline use %"ev_any_imp.h%""
		alias
			"[
	            g_object_set_data (
	                G_OBJECT ($a_gtk_object),
	                "eif_oid",
	                (gpointer) (rt_int_ptr) $a_object_id
	            );
			]"
		end

	frozen c_gtk_menu_popup (a_menu: POINTER; a_x, a_y, a_button: INTEGER; a_event_time: NATURAL_32)
		external
			"C inline use %"ev_c_util.h%""
		alias
			"[
			{
				menu_position *pos = malloc (sizeof (menu_position));
				pos->x_position = (gint) $a_x;
				pos->y_position = (gint) $a_y;
				gtk_menu_popup ((GtkMenu*) $a_menu, NULL, NULL, (GtkMenuPositionFunc) c_gtk_menu_position_func, (gpointer) pos, (guint) $a_button, (guint32) $a_event_time);
			}
			]"
		end

feature {EV_ANY_I} -- Implementation

	on_activate
			-- `Current' has been activated.
		local
			p_imp: detachable EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions.call ([attached_interface])
				end
			end
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU note option: stable attribute end;
		-- Interface object for `Current'.

feature {NONE} -- Implementation

	list_widget: POINTER
		-- Pointer to the GtkMenuShell used for holding the items of `Current'.

	destroy
			-- Destroy the menu
		do
			wipe_out
			Precursor {EV_MENU_ITEM_IMP}
		end

note
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
