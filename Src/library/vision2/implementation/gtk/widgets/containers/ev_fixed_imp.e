indexing
	description: 
		"Eiffel Vision fixed. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FIXED_IMP
	
inherit
	EV_FIXED_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_WIDGET_LIST_IMP
		redefine
			interface,
			on_removed_item
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_fixed_new)
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			w_imp: EV_WIDGET_IMP
		do
			update_request_size
			w_imp ?= a_widget.implementation
			{EV_GTK_EXTERNALS}.gtk_fixed_move (visual_widget, w_imp.c_object, an_x, a_y)
			set_minimum_size (minimum_width.max (w_imp.width + an_x), minimum_height.max (w_imp.height + a_y))
		end
		
	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			w_imp.store_minimum_size
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (w_imp.c_object, a_width, a_height)
			update_request_size
		end

feature {EV_ANY_I} -- Implementation

	on_removed_item (a_widget_imp: EV_WIDGET_IMP) is
			-- Reset minimum size.
		do
			Precursor (a_widget_imp)
			a_widget_imp.reset_minimum_size
		end			

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		local
			glist, fixlist, fixitem: POINTER
			temp_index: INTEGER
		do
			glist := {EV_GTK_EXTERNALS}.gtk_container_children (a_container)
			temp_index := {EV_GTK_EXTERNALS}.g_list_index (glist, a_child)
			fixlist := {EV_GTK_EXTERNALS}.gtk_fixed_struct_children (a_container)
			fixitem := {EV_GTK_EXTERNALS}.g_list_nth_data (fixlist, temp_index)
			fixlist := {EV_GTK_EXTERNALS}.g_list_remove (fixlist, fixitem)
			fixlist := {EV_GTK_EXTERNALS}.g_list_insert (fixlist, fixitem, a_position)
			{EV_GTK_EXTERNALS}.set_gtk_fixed_struct_children (a_container, fixlist)
			{EV_GTK_EXTERNALS}.gtk_widget_queue_resize (c_object)
			{EV_GTK_EXTERNALS}.g_list_free (glist)
		end

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_FIXED

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

