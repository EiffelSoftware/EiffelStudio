indexing
	description: "Eiffel Vision scrollable area. GTK+ implementation."
	status: "See notice at end of class"
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
		redefine
			horizontal_adjustment,
			vertical_adjustment,
			interface,
			make,
			on_size_allocate,
			x_offset,
			y_offset,
			set_x_offset,
			set_y_offset,
			child_has_resized,
			needs_event_box
		end
	
create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False--True

	make (an_interface: like interface) is
				-- Initialize.
		do
			base_make (an_interface)
			scrolled_window := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)
			set_c_object (scrolled_window)
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM, {EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM)
			viewport := {EV_GTK_EXTERNALS}.gtk_viewport_new (NULL, NULL)
			{EV_GTK_EXTERNALS}.gtk_widget_show (viewport)
			{EV_GTK_EXTERNALS}.gtk_container_add (scrolled_window, viewport)
			set_horizontal_step (10)
			set_vertical_step (10)
		end

feature -- Access

	horizontal_step: INTEGER is
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_step_increment (horizontal_adjustment).rounded
		end

	vertical_step: INTEGER is
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_step_increment (vertical_adjustment).rounded
		end

	is_horizontal_scroll_bar_visible: BOOLEAN is
			-- Should horizontal scroll bar be displayed?
		do
			Result := horizontal_policy = {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM
		end

	is_vertical_scroll_bar_visible: BOOLEAN is
			-- Should vertical scroll bar be displayed?
		do
			Result := vertical_policy = {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM
		end

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (horizontal_adjustment).rounded
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (vertical_adjustment).rounded
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			internal_set_value_from_adjustment (horizontal_adjustment, a_x)
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			internal_set_value_from_adjustment (vertical_adjustment, a_y)
		end

	set_horizontal_step (a_step: INTEGER) is
			-- Set `horizontal_step' to `a_step'.
		do
			if horizontal_step /= a_step then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_step_increment (horizontal_adjustment, a_step)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (horizontal_adjustment)
			end
		end

	set_vertical_step (a_step: INTEGER) is
			-- Set `vertical_step' to `a_step'.
		do
			if vertical_step /= a_step then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_step_increment (vertical_adjustment, a_step)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (vertical_adjustment)
			end
		end

	show_horizontal_scroll_bar is
			-- Display horizontal scroll bar.
		do
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM, vertical_policy)			
		end

	hide_horizontal_scroll_bar is
			-- Do not display horizontal scroll bar.
		do
			set_scrolling_policy ({EV_GTK_EXTERNALS}.gTK_POLICY_NEVER_ENUM, vertical_policy)
		end

	show_vertical_scroll_bar is
			-- Display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {EV_GTK_EXTERNALS}.gTK_POLICY_ALWAYS_ENUM)
		end

	hide_vertical_scroll_bar is
			-- Do not display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, {EV_GTK_EXTERNALS}.gTK_POLICY_NEVER_ENUM)
		end

feature {NONE} -- Implementation

	scrolled_window: POINTER

	on_size_allocate (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Set item in center of `Current' if smaller.
		local
			item_imp: EV_WIDGET_IMP
		do
			Precursor {EV_VIEWPORT_IMP} (a_x, a_y, a_width, a_height)
			if item /= Void then
				item_imp ?= item.implementation
				{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, ((fixed_width - item_imp.width) // 2).max (0), ((fixed_height - item_imp.height) // 2).max (0))
			end	
		end
		
	child_has_resized (item_imp: EV_WIDGET_IMP) is
			-- If child has resized and smaller than parent then set position in center of `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (container_widget, ((fixed_width - item_imp.width) // 2).max (0), ((fixed_height - item_imp.height) // 2).max (0))
		end

	horizontal_adjustment: POINTER is
			-- Pointer to the adjustment struct of the hscrollbar
		do
			Result := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_hadjustment (scrolled_window)
		end

	vertical_adjustment: POINTER is
			-- Pointer to the adjustment struct of the vscrollbar
		do
			Result := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_vadjustment (scrolled_window)
		end

	horizontal_policy: INTEGER
		-- Policy type used for the horizontal scrollbar (ALWAYS, AUTOMATIC or NEVER)

	vertical_policy: INTEGER
		-- Policy type used for the vertical scrollbar (ALWAYS, AUTOMATIC or NEVER)

	set_scrolling_policy (hscrollpol, vscrollpol: INTEGER) is
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

feature {EV_ANY_I} -- Implementation		

	interface: EV_SCROLLABLE_AREA
			-- Provides a common user interface to platform dependent 
			-- functionality implemented by `Current'

end -- class EV_SCROLLABLE_AREA_IMP

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

