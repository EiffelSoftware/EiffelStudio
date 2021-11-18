note
	description: "Eiffel Vision scrollable area. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			set_item_width,
			set_item_height
		redefine
			interface
		end

	EV_VIEWPORT_IMP
		undefine
			set_offset
		redefine
			horizontal_adjustment,
			vertical_adjustment,
			interface,
			old_make,
			on_size_allocate,
			update_viewport_item_size,
			x_offset,
			y_offset,
			set_x_offset,
			set_y_offset,
			child_has_resized,
			needs_event_box,
			make,
			gtk_insert_i_th
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create scrollable area.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			scrolled_window := {GTK}.gtk_scrolled_window_new (default_pointer, default_pointer)

				-- Remove shadow so that the scrollable area looks like any other container.
			{GTK2}.gtk_scrolled_window_set_shadow_type (scrolled_window, {GTK}.gtk_shadow_none_enum)
			set_c_object (scrolled_window)
			set_scrolling_policy ({GTK}.GTK_POLICY_AUTOMATIC_ENUM, {GTK}.GTK_POLICY_AUTOMATIC_ENUM)
			viewport := {GTK}.gtk_viewport_new (default_pointer, default_pointer)
			{GTK}.gtk_widget_show (viewport)
			{GTK}.gtk_container_add (scrolled_window, viewport)
			set_horizontal_step (10)
			set_vertical_step (10)
			fixed_widget := {GTK2}.gtk_fixed_new
			{GTK}.gtk_widget_show (fixed_widget)
			{GTK}.gtk_container_add (viewport, fixed_widget)
			container_widget := {GTK}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_horizontal, 0)
			{GTK}.gtk_box_set_homogeneous(container_widget, True)
			{GTK}.gtk_widget_show (container_widget)
			{GTK}.gtk_container_add (fixed_widget, container_widget)
			{GTK2}.gtk_widget_set_minimum_size (scrolled_window, 1, 1)
			Precursor
		end

	needs_event_box: BOOLEAN = True

feature -- Access

	horizontal_step: INTEGER
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := {GTK}.gtk_adjustment_get_step_increment (horizontal_adjustment).rounded
		end

	vertical_step: INTEGER
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := {GTK}.gtk_adjustment_get_step_increment (vertical_adjustment).rounded
		end

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		do
			Result := horizontal_policy = {GTK}.GTK_POLICY_ALWAYS_ENUM
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		do
			Result := vertical_policy = {GTK}.GTK_POLICY_ALWAYS_ENUM
		end

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
			Result := {GTK}.gtk_adjustment_get_value (horizontal_adjustment).rounded
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
			Result := {GTK}.gtk_adjustment_get_value (vertical_adjustment).rounded
		end

feature -- Element change

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			internal_set_value_from_adjustment (horizontal_adjustment, a_x)
				-- The code below could be optimized so that `expose_actions' are not
				-- called immediately on `item'.
			--{GTK}.gtk_adjustment_value_changed (horizontal_adjustment)
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			internal_set_value_from_adjustment (vertical_adjustment, a_y)
				-- The code below could be optimized so that `expose_actions' are not
				-- called immediately on `item'.
			--{GTK}.gtk_adjustment_value_changed (vertical_adjustment)
			-- GTK+ emits `value-changed` itself whenever the value changes.
			-- ie GTK do something like this g_signal_emit_by_name(container_widget, "value-changed")
			--|TODO double check in other case implement it in Eiffel like this.
			--|real_signal_connect (container_widget, once "value-changed", agent (app_implementation.gtk_marshal).y_offset_changed (internal_id), Void)
		end

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		do
			if horizontal_step /= a_step then
				{GTK}.gtk_adjustment_set_step_increment (horizontal_adjustment, a_step)
				--{GTK}.gtk_adjustment_changed (horizontal_adjustment)
			end
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		do
			if vertical_step /= a_step then
				{GTK}.gtk_adjustment_set_step_increment (vertical_adjustment, a_step)
				--{GTK}.gtk_adjustment_changed (vertical_adjustment)
			end
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		do
			set_scrolling_policy ({GTK}.GTK_POLICY_ALWAYS_ENUM, vertical_policy)
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		do
			set_scrolling_policy ({GTK}.GTK_POLICY_NEVER_ENUM, vertical_policy)
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {GTK}.GTK_POLICY_ALWAYS_ENUM)
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {GTK}.GTK_POLICY_NEVER_ENUM)
		end

feature {NONE} -- Implementation

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER)
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do
			if {GTK}.gtk_adjustment_get_lower (l_adj) > a_value then
				{GTK}.gtk_adjustment_set_lower (l_adj, a_value)
			elseif {GTK}.gtk_adjustment_get_upper (l_adj) < a_value then
				{GTK}.gtk_adjustment_set_upper (l_adj, a_value)
			end
			{GTK}.gtk_adjustment_set_value (l_adj, a_value)
  		end

	fixed_widget: POINTER
		-- Pointer to the fixed widget used for central positioning when `item' cannot be scrolled.

	fixed_width: INTEGER
			-- Fixed Horizontal size measured in pixels.
		local
			l_alloc: POINTER
		do
			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (fixed_widget, l_alloc)
			Result := {GTK}.gtk_allocation_struct_width (l_alloc).max (0)
			l_alloc.memory_free
		end

	fixed_height: INTEGER
			-- Fixed Vertical size measured in pixels.
		local
			l_alloc: POINTER
		do
			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (fixed_widget, l_alloc)
			Result := {GTK}.gtk_allocation_struct_height (l_alloc).max (0)
			l_alloc.memory_free
		end

	scrolled_window: POINTER

	on_size_allocate (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Set item in center of `Current' if smaller.
		do
			Precursor {EV_VIEWPORT_IMP} (a_x, a_y, a_width, a_height)
			if attached item as l_item then
				if attached {EV_WIDGET_IMP} l_item.implementation as item_imp then
					check container_widget /= default_pointer end
						-- Move if and only if container widget is a Window.
					if {GTK}.gtk_is_window (container_widget) then
						{GTK}.gtk_window_move (
								container_widget,
								((fixed_width - item_imp.width) // 2).max (0),
								((fixed_height - item_imp.height) // 2).max (0)
							)
					end
				else
					check is_widget_imp: False end
				end
			end
		end

	update_viewport_item_size (a_viewport_width, a_viewport_height: INTEGER)
		do
			-- Do not resize the item for scrollable area, only for pure instance of EV_VIEWPORT_IMP.
		end

	child_has_resized (item_imp: EV_WIDGET_IMP)
			-- If child has resized and smaller than parent then set position in center of `Current'.
		do
			if {GTK}.gtk_is_window (container_widget)  then
				{GTK}.gtk_window_move (
						container_widget,
						((fixed_width - item_imp.width) // 2).max (0),
						((fixed_height - item_imp.height) // 2).max (0)
					)
			end
		end

	horizontal_adjustment: POINTER
			-- Pointer to the adjustment struct of the hscrollbar
		do
			Result := {GTK}.gtk_scrolled_window_get_hadjustment (scrolled_window)
		end

	vertical_adjustment: POINTER
			-- Pointer to the adjustment struct of the vscrollbar
		do
			Result := {GTK}.gtk_scrolled_window_get_vadjustment (scrolled_window)
		end

	horizontal_policy: INTEGER
		-- Policy type used for the horizontal scrollbar (ALWAYS, AUTOMATIC or NEVER)

	vertical_policy: INTEGER
		-- Policy type used for the vertical scrollbar (ALWAYS, AUTOMATIC or NEVER)

	set_scrolling_policy (hscrollpol, vscrollpol: INTEGER)
			-- Set the policy for both scrollbars.
		do
			{GTK}.gtk_scrolled_window_set_policy (
				scrolled_window,
				hscrollpol,
				vscrollpol
			)
			horizontal_policy := hscrollpol
			vertical_policy := vscrollpol
		end

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER_32)
		local
			l_parent_box: POINTER
		do
			l_parent_box := {GTK}.gtk_event_box_new
			{GTK2}.gtk_event_box_set_visible_window (l_parent_box, False)
			{GTK}.gtk_widget_show (l_parent_box)
			{GTK}.gtk_container_add (l_parent_box, a_child)
			{GTK}.gtk_container_add (container_widget, l_parent_box)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation		

	interface: detachable EV_SCROLLABLE_AREA note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_SCROLLABLE_AREA_IMP
