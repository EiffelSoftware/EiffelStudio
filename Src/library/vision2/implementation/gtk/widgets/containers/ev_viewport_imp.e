indexing
	description: "Eiffel Vision viewport. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			container_widget := viewport
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
			if a_x /= internal_x_offset then
				block_resize_actions
				internal_x_offset := a_x
				internal_set_value_from_adjustment (horizontal_adjustment, a_x)
					-- Code below is to ensure that if the widget is visible then
					-- we only move the window, and not call the `expose_actions' on `item'
					-- as it is the case when calling `gtk_adjustment_value_changed'.
				if {EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (visual_widget) /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_window_move (
						{EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (visual_widget), -a_x, -internal_y_offset)
				else
					{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (horizontal_adjustment)
				end
				unblock_resize_actions
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			if a_y /= internal_y_offset then
				block_resize_actions
				internal_y_offset := a_y
				internal_set_value_from_adjustment (vertical_adjustment, a_y)
					-- Code below is to ensure that if the widget is visible then
					-- we only move the window, and not call the `expose_actions' on `item'
					-- as it is the case when calling `gtk_adjustment_value_changed'.
				if {EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (visual_widget) /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_window_move (
						{EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (visual_widget), -internal_x_offset, -a_y)
				else
					{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (vertical_adjustment)
				end
				unblock_resize_actions
			end
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
			w_imp: EV_WIDGET_IMP
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

			w_imp ?= item.implementation
			w_imp.store_minimum_size
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (w_imp.c_object, item_width, item_height)
		end

	on_removed_item (a_widget_imp: EV_WIDGET_IMP) is
			-- Reset minimum size.
		do
			Precursor (a_widget_imp)
			a_widget_imp.reset_minimum_size
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
			{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_value (l_adj, a_value)
		ensure
			value_set: {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (l_adj) = a_value
  		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

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




end -- class EV_VIEWPORT_IMP

