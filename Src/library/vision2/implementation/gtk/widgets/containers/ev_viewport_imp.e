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
			interface
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make,
			initialize,
			container_widget,
			visual_widget,
			on_removed_item,
			minimum_width,
			minimum_height
		end
	
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_viewport_new (NULL, NULL))
			viewport := c_object
			feature {EV_GTK_EXTERNALS}.gtk_viewport_set_shadow_type (c_object, (App_implementation.gtk_marshal).Gtk_shadow_none_enum)
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, 1, 1) -- Hack needed to prevent viewport resize on item resize.
		end
		
	initialize is
			-- Add a fixed to the viewport to get rid of default blackness.
		do
			fixed_widget := feature {EV_GTK_EXTERNALS}.gtk_fixed_new
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (fixed_widget)
			container_widget := feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (viewport, fixed_widget)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (fixed_widget, container_widget)
			Precursor {EV_CELL_IMP}
		end

	container_widget: POINTER
			-- Pointer to the event box
			
	fixed_widget: POINTER
	
	visual_widget: POINTER is
			-- 
		do
			Result := fixed_widget
		end
		
	fixed_width: INTEGER is
			-- Fixed Horizontal size measured in pixels.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_width (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (fixed_widget)
			).max (0)
		end

	fixed_height: INTEGER is
			-- Fixed Vertical size measured in pixels.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_height (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (fixed_widget)
			).max (0)
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
			if a_x < 0 then
				feature {EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, -a_x, -1)
				internal_set_value_from_adjustment (horizontal_adjustment, 0)
			else
				feature {EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, 0, -1)
				internal_set_value_from_adjustment (horizontal_adjustment, a_x)
			end
			internal_x_offset := a_x
			unblock_resize_actions
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			block_resize_actions
			if a_y < 0 then
				feature {EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, -1, -a_y)
				internal_set_value_from_adjustment (vertical_adjustment, 0)
			else	
				feature {EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, -1, 0)
				internal_set_value_from_adjustment (vertical_adjustment, a_y)
			end
			internal_y_offset := a_y
			unblock_resize_actions
		end
		
	set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (a_width, a_height)
		end

feature {NONE} -- Implementation

	internal_set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
			temp_width, temp_height: INTEGER
		do
			if a_width > 0 then
				temp_width := a_width
			else
				temp_width := -1
			end
			
			if a_height > 0 then
				temp_height := a_height
			else
				temp_height := -1
			end
			w_imp ?= item.implementation
			w_imp.store_minimum_size
			--| FIXME IEK This needs to be thought out some more.
			--feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (container_widget, temp_width, temp_height)
		end

	on_removed_item (an_item: EV_WIDGET) is
			-- Reset minimum size.
		local
			item_imp: EV_WIDGET_IMP
		do
			Precursor (an_item)
			item_imp ?= an_item.implementation
			item_imp.reset_minimum_size
			set_x_offset (0)
			set_y_offset (0)
		end

	internal_x_offset, internal_y_offset: INTEGER

	horizontal_adjustment: POINTER is
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER is
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_viewport_get_vadjustment (viewport)
		end

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER) is
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do
			if feature {EV_GTK_EXTERNALS}.gtk_adjustment_struct_lower (l_adj) > a_value then
				feature {EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_lower (l_adj, a_value)
				feature {EV_GTK_EXTERNALS}.gtk_adjustment_changed (l_adj)
			elseif feature {EV_GTK_EXTERNALS}.gtk_adjustment_struct_upper (l_adj) < a_value then
				feature {EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (l_adj, a_value)
				feature {EV_GTK_EXTERNALS}.gtk_adjustment_changed (l_adj)				
			end
			feature {EV_GTK_EXTERNALS}.gtk_adjustment_set_value (l_adj, a_value)
		ensure
			value_set: feature {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (l_adj) = a_value
		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

