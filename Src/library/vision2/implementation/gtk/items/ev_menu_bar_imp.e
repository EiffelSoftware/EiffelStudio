indexing
	description: "Eiffel Vision menu bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_BAR_IMP
	
inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		export
			{EV_WINDOW_IMP}
				list_widget
		redefine
			interface,
			insert_menu_item
		end
	
create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_bar_new)
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
		end
		
feature {EV_WINDOW_IMP} -- Implementation

	set_parent_window_imp (a_wind: EV_WINDOW_IMP) is
			-- Set `parent_window' to `a_wind'.
		require
			a_wind_not_void: a_wind /= Void
		do
			parent_imp := a_wind
		end
		
	parent: EV_WINDOW is
			-- Parent window of Current.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end
	
	remove_parent_window is
			-- Set `parent_window' to Void.
		do
			parent_imp := Void
		end
		
	parent_imp: EV_WINDOW_IMP

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		do
			an_item_imp.set_item_parent_imp (Current)
			{EV_GTK_EXTERNALS}.gtk_menu_shell_insert (list_widget, an_item_imp.c_object, pos - 1)
			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR;

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




end -- class EV_MENU_BAR_IMP

