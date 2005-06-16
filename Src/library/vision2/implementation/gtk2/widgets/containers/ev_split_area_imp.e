indexing
	description: 
		"EiffelVision Split Area. GTK+ implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface,
			initialize,
			container_widget,
			on_widget_mapped,
			needs_event_box
		end

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is do Result := False end

	initialize is
		do
			Precursor {EV_CONTAINER_IMP}
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			second_expandable := True
			user_split_position := -1
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (container_widget, 0)
			real_signal_connect_after (container_widget, "map-event", agent (App_implementation.gtk_marshal).on_widget_show (c_object), App_implementation.default_translate)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (container_widget, False)
		end

feature -- Access

	split_position: INTEGER is
			-- Position from the left/top of the splitter from `Current'.
		do
			if not is_displayed and then user_split_position /= -1 then
				Result := user_split_position
			else
				Result := gtk_paned_struct_child1_size (container_widget)
				Result := Result.max (minimum_split_position)
			end
		end

	set_first (an_item: like item) is
			-- Make `an_item' `first'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			item_imp.set_parent_imp (Current)
			check item_imp_not_void: item_imp /= Void end
			{EV_GTK_EXTERNALS}.gtk_paned_pack1 (container_widget, item_imp.c_object, False, False)
			first := an_item
			set_item_resize (first, False)
		end

	set_second (an_item: like item) is
			-- Make `an_item' `second'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			item_imp.set_parent_imp (Current)
			check item_imp_not_void: item_imp /= Void end
			{EV_GTK_EXTERNALS}.gtk_paned_pack2 (container_widget, item_imp.c_object, True, False)
			second := an_item
			set_item_resize (second, True)
		end

	prune (an_item: like item) is
			-- Remove `an_item' if present from `Current'.
		local
			item_imp: EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				item_imp ?= an_item.implementation
				item_imp.set_parent_imp (Void)
				check item_imp_not_void: item_imp /= Void end
				{EV_GTK_DEPENDENT_EXTERNALS}.object_ref (item_imp.c_object)
				{EV_GTK_EXTERNALS}.gtk_container_remove ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (item_imp.c_object), item_imp.c_object)
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
			end
		end

	enable_item_expand (an_item: like item) is
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: like item) is
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Set the position of the splitter.
		do
			internal_set_split_position (a_split_position)
		end

feature {NONE} -- Implementation

	internal_set_split_position (a_split_position: INTEGER) is
			-- Set the position of the splitter.
		do
			if is_displayed then
				user_split_position := -1
			else
				user_split_position := a_split_position
			end
			{EV_GTK_EXTERNALS}.gtk_paned_set_position (container_widget, a_split_position)
		end

	user_split_position: INTEGER
			-- Split position as set by user, -1 if unset.

	on_widget_mapped is
			-- `Current' has been mapped to screen.
		do
			if user_split_position /= -1 then
				internal_set_split_position (user_split_position)
			end
		end

	container_widget: POINTER
		-- Pointer to the GtkPaned widget.

	splitter_width: INTEGER is 8

	set_item_resize (an_item: like item; a_resizable: BOOLEAN) is
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		do
			if an_item = first then
				first_expandable := a_resizable
			else
				second_expandable := a_resizable
			end
			set_gtk_paned_struct_child1_resize (container_widget, first_expandable)
			set_gtk_paned_struct_child2_resize (container_widget, second_expandable)
		end

feature {NONE} -- Externals.

	gtk_paned_struct_child1_size (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned): EIF_INTEGER"
		alias
			"child1_size"
		end

	set_gtk_paned_struct_child1_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child1_resize"
		end

	set_gtk_paned_struct_child2_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child2_resize"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPLIT_AREA


end -- class EV_SPLIT_AREA_IMP

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

