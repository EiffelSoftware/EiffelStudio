indexing
	description: "Eiffel Vision viewport. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_width,
			set_item_height
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make,
			container_widget,
			visual_widget,
			on_removed_item,
			minimum_width,
			minimum_height,
			needs_event_box
		end
	
create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			viewport := {EV_GTK_EXTERNALS}.gtk_viewport_new (NULL, NULL)
			set_c_object (viewport)
			{EV_GTK_EXTERNALS}.gtk_viewport_set_shadow_type (viewport, {EV_GTK_EXTERNALS}.Gtk_shadow_none_enum)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (viewport, 1, 1) -- Hack needed to prevent viewport resize on item resize.
			container_widget := {EV_GTK_EXTERNALS}.gtk_hbox_new (True, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			{EV_GTK_EXTERNALS}.gtk_container_add (viewport, container_widget)
		end

feature -- Access

	minimum_width: INTEGER is
			-- Minimum width of widget.
		do
			-- Redefined due to bug in Viewport
			-- Result is as expected though as item has no effect on minimum_width
			Result := internal_minimum_width.max (0)
		end
		
	minimum_height: INTEGER is
			-- Minimum_height of widget.
		do
			-- Redefined due to bug in Viewport
			-- Result is as expected though as item has no effect on minimum_height
			Result := internal_minimum_height.max (0)
		end

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := internal_x_offset
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := internal_y_offset
		end

feature -- Element change

	block_resize_actions is
			-- Block any resize actions that may occur.
		local
			item_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				item_imp ?= item.implementation
				-- The blocking of resize actions is due to set uposition causing temporary resizing.
				if item_imp.resize_actions_internal /= Void then
					item_imp.resize_actions_internal.block	
				end				
			end
		end
			
	unblock_resize_actions is
			-- Unblock all resize actions.
		local
			item_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				item_imp ?= item.implementation
				if item_imp.resize_actions_internal /= Void then
					item_imp.resize_actions_internal.resume
				end	
			end
		end

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			block_resize_actions
			internal_x_offset := a_x
			internal_set_value_from_adjustment (horizontal_adjustment, a_x)
			unblock_resize_actions
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			block_resize_actions
			internal_y_offset := a_y
			internal_set_value_from_adjustment (vertical_adjustment, a_y)
			unblock_resize_actions
		end
		
	set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (a_width, a_height)
		end
		
	set_item_width (a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		do
			internal_set_item_size (a_width, -1)
		end
		
	set_item_height (a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (-1, a_height)
		end

feature {NONE} -- Implementation

	container_widget: POINTER
			-- Pointer to the event box

	visual_widget: POINTER is
			--
		do
			Result := c_object
		end

	internal_set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			item_width, item_height: INTEGER
		do
			if a_width > 0 then
				item_width := a_width
			else
				item_width := -1
			end

			if a_height > 0 then
				item_height := a_height
			else
				item_height := -1
			end
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (container_widget, item_width, item_height)
		end

	on_removed_item (a_widget_imp: EV_WIDGET_IMP) is
			-- Reset minimum size.
		do
			Precursor (a_widget_imp)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (container_widget, -1, -1)
			set_x_offset (0)
			set_y_offset (0)
		end

	internal_x_offset, internal_y_offset: INTEGER

	horizontal_adjustment: POINTER is
		do
			Result := {EV_GTK_EXTERNALS}.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER is
		do
			Result := {EV_GTK_EXTERNALS}.gtk_viewport_get_vadjustment (viewport)
		end

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER) is
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do
			if {EV_GTK_EXTERNALS}.gtk_adjustment_struct_lower (l_adj) > a_value then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_lower (l_adj, a_value)
			elseif {EV_GTK_EXTERNALS}.gtk_adjustment_struct_upper (l_adj) < a_value then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (l_adj, a_value)			
			end
			{EV_GTK_EXTERNALS}.gtk_adjustment_set_value (l_adj, a_value)
		ensure
			value_set: {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (l_adj) = a_value
		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

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

