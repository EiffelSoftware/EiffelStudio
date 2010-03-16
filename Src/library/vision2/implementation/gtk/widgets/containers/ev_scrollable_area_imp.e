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
			x_offset,
			y_offset,
			set_x_offset,
			set_y_offset,
			child_has_resized,
			needs_event_box,
			make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create scrollable area.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			scrolled_window := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)

				-- Remove shadow so that the scrollable area looks like any other container.
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_scrolled_window_set_shadow_type (scrolled_window, {EV_GTK_EXTERNALS}.gtk_shadow_none_enum)
			set_c_object (scrolled_window)
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM, {EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM)
			viewport := {EV_GTK_EXTERNALS}.gtk_viewport_new (NULL, NULL)
			{EV_GTK_EXTERNALS}.gtk_widget_show (viewport)
			{EV_GTK_EXTERNALS}.gtk_container_add (scrolled_window, viewport)
			set_horizontal_step (10)
			set_vertical_step (10)
			fixed_widget := {EV_GTK_EXTERNALS}.gtk_fixed_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (fixed_widget)
			container_widget := {EV_GTK_EXTERNALS}.gtk_hbox_new (True, 0)
			{EV_GTK_EXTERNALS}.gtk_container_add (viewport, fixed_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			{EV_GTK_EXTERNALS}.gtk_container_add (fixed_widget, container_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (scrolled_window, 1, 1)
			Precursor
		end

	needs_event_box: BOOLEAN = True

feature -- Access

	horizontal_step: INTEGER
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_step_increment (horizontal_adjustment).rounded
		end

	vertical_step: INTEGER
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_step_increment (vertical_adjustment).rounded
		end

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		do
			Result := horizontal_policy = {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		do
			Result := vertical_policy = {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM
		end

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (horizontal_adjustment).rounded
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (vertical_adjustment).rounded
		end

feature -- Element change

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			internal_set_value_from_adjustment (horizontal_adjustment, a_x)
				-- The code below could be optimized so that `expose_actions' are not
				-- called immediately on `item'.
			{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (horizontal_adjustment)
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			internal_set_value_from_adjustment (vertical_adjustment, a_y)
				-- The code below could be optimized so that `expose_actions' are not
				-- called immediately on `item'.
			{EV_GTK_EXTERNALS}.gtk_adjustment_value_changed (vertical_adjustment)
		end

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		do
			if horizontal_step /= a_step then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_step_increment (horizontal_adjustment, a_step)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (horizontal_adjustment)
			end
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		do
			if vertical_step /= a_step then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_step_increment (vertical_adjustment, a_step)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (vertical_adjustment)
			end
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		do
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM, vertical_policy)
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		do
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_NEVER_ENUM, vertical_policy)
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM)
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {EV_GTK_EXTERNALS}.gTK_POLICY_NEVER_ENUM)
		end

feature {NONE} -- Implementation

	fixed_widget: POINTER
		-- Pointer to the fixed widget used for central positioning when `item' cannot be scrolled.

	fixed_width: INTEGER
			-- Fixed Horizontal size measured in pixels.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (fixed_widget)
			).max (0)
		end

	fixed_height: INTEGER
			-- Fixed Vertical size measured in pixels.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (fixed_widget)
			).max (0)
		end

	scrolled_window: POINTER

	on_size_allocate (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Set item in center of `Current' if smaller.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			Precursor {EV_VIEWPORT_IMP} (a_x, a_y, a_width, a_height)
			if attached item as l_item then
				item_imp ?= l_item.implementation
				check item_imp /= Void end
				{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, ((fixed_width - item_imp.width) // 2).max (0), ((fixed_height - item_imp.height) // 2).max (0))
			end
		end

	child_has_resized (item_imp: EV_WIDGET_IMP)
			-- If child has resized and smaller than parent then set position in center of `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, ((fixed_width - item_imp.width) // 2).max (0), ((fixed_height - item_imp.height) // 2).max (0))
		end

	horizontal_adjustment: POINTER
			-- Pointer to the adjustment struct of the hscrollbar
		do
			Result := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_hadjustment (scrolled_window)
		end

	vertical_adjustment: POINTER
			-- Pointer to the adjustment struct of the vscrollbar
		do
			Result := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_vadjustment (scrolled_window)
		end

	horizontal_policy: INTEGER
		-- Policy type used for the horizontal scrollbar (ALWAYS, AUTOMATIC or NEVER)

	vertical_policy: INTEGER
		-- Policy type used for the vertical scrollbar (ALWAYS, AUTOMATIC or NEVER)

	set_scrolling_policy (hscrollpol, vscrollpol: INTEGER)
			-- Set the policy for both scrollbars.
		do
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				scrolled_window,
				hscrollpol,
				vscrollpol
			)
			horizontal_policy := hscrollpol
			vertical_policy := vscrollpol
		end

feature {EV_ANY, EV_ANY_I} -- Implementation		

	interface: detachable EV_SCROLLABLE_AREA note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

end -- class EV_SCROLLABLE_AREA_IMP
