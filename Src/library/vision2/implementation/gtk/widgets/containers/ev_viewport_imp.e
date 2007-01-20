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
			set_item_height,
			set_offset
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
			needs_event_box,
			gtk_insert_i_th,
			gtk_container_remove
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

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
		do
			if item /= Void then
				-- The blocking of resize actions is due to set uposition causing temporary resizing.
				if item.implementation.resize_actions_internal /= Void then
					item.implementation.resize_actions_internal.block
				end
			end
		end

	unblock_resize_actions is
			-- Unblock all resize actions.
		do
			if item /= Void then
				if item.implementation.resize_actions_internal /= Void then
					item.implementation.resize_actions_internal.resume
				end
			end
		end

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			set_offset (a_x, internal_y_offset)
		end

	set_offset (a_x, a_y: INTEGER)
			-- Set viewport offset to `a_x', `a_y'.
		local
			l_null: POINTER
			l_x_offset_changed, l_y_offset_changed: BOOLEAN
		do
			l_x_offset_changed := a_x /= internal_x_offset
			l_y_offset_changed := a_y /= internal_y_offset
			if l_x_offset_changed or else l_y_offset_changed then
				block_resize_actions
				if l_x_offset_changed then
					internal_x_offset := a_x
					internal_set_value_from_adjustment (horizontal_adjustment, a_x)
				end
				if l_y_offset_changed then
					internal_y_offset := a_y
					internal_set_value_from_adjustment (vertical_adjustment, a_y)
				end

					-- Code below is to ensure that if the widget is visible then
					-- we only move the window, and not call the `expose_actions' on `item'
					-- as it is the case when calling `gtk_adjustment_value_changed'.
				if {EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (viewport) /= l_null then
					{EV_GTK_EXTERNALS}.gdk_window_move (
						{EV_GTK_EXTERNALS}.gtk_viewport_struct_bin_window (viewport), -a_x, -a_y)
				else
					if l_x_offset_changed then
						{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (horizontal_adjustment)
					end
					if l_y_offset_changed then
						{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (vertical_adjustment)
					end
				end
				unblock_resize_actions
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			set_offset (internal_x_offset, a_y)
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

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		local
			l_requisition: POINTER
			l_parent_box: POINTER
		do
				-- We add a parent box to `a_child' and control its size via this as
				-- GtkViewport updates the childs requisition upon allocation which
				-- affects the minimum size of the `a_child'.
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_event_box_new
			{EV_GTK_EXTERNALS}.gtk_event_box_set_visible_window (l_parent_box, False)
			{EV_GTK_EXTERNALS}.gtk_widget_show (l_parent_box)
			{EV_GTK_EXTERNALS}.gtk_container_add (l_parent_box, a_child)
			{EV_GTK_EXTERNALS}.gtk_container_add (a_container, l_parent_box)
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		local
			l_parent_box: POINTER
		do
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (a_child)
			{EV_GTK_EXTERNALS}.gtk_container_remove (l_parent_box, a_child)
			{EV_GTK_EXTERNALS}.gtk_container_remove (a_container, l_parent_box)
		end

	container_widget: POINTER
			-- Pointer to the event box

	visual_widget: POINTER is
			-- Pointer to the GtkViewport widget.
		do
			Result := viewport
		end

	internal_set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			item_width, item_height: INTEGER
			w_imp: EV_WIDGET_IMP
			l_parent_box: POINTER
			l_allocation: POINTER
		do
			w_imp ?= item.implementation
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (w_imp.c_object)
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (l_parent_box, a_width, a_height)
			l_allocation := {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (w_imp.c_object)
			if a_width > -1 then
				item_width := a_width
			else
				item_width := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width (l_allocation).max (w_imp.minimum_width)
			end

			if a_height > -1 then
				item_height := a_height
			else
				item_height := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height (l_allocation).max (w_imp.minimum_height)
			end
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (l_parent_box, item_width, item_height)
			{EV_GTK_EXTERNALS}.set_gtk_allocation_struct_width (l_allocation, item_width)
			{EV_GTK_EXTERNALS}.set_gtk_allocation_struct_height (l_allocation, item_height)
			{EV_GTK_EXTERNALS}.gtk_widget_size_allocate (w_imp.c_object, l_allocation)
		end

	on_removed_item (a_widget_imp: EV_WIDGET_IMP) is
			-- Reset minimum size.
		do
			Precursor (a_widget_imp)
			set_offset (0, 0)
		end

	internal_x_offset, internal_y_offset: INTEGER
		-- X and Y offset values for viewport.

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

