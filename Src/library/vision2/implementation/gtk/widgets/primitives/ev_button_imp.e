indexing
	description:
		"Eiffel Vision button. GTK implementation."
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"
        
class
	EV_BUTTON_IMP
        
inherit
	EV_BUTTON_I
		redefine
			interface
		end
        
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			make,
			set_foreground_color,
			foreground_color_pointer,
			on_focus_changed,
			needs_event_box,
			event_widget,
			enable_sensitive
		end
 
	EV_PIXMAPABLE_IMP
		redefine
			interface,
			initialize
		end
     
	EV_TEXTABLE_IMP
		redefine
			interface,
			initialize,
			align_text_left,
			align_text_center,
			align_text_right
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize,
			fontable_widget
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		undefine
			visual_widget
		redefine
			interface
		end

create
        make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True

	enable_sensitive is
			-- Enable sensitivity of button
		do
			Precursor {EV_PRIMITIVE_IMP}
			{EV_GTK_EXTERNALS}.gtk_button_set_relief (visual_widget, {EV_GTK_EXTERNALS}.gtk_relief_normal_enum)
		end

	event_widget: POINTER is
			-- Pointer to the GtkWidget that handles the widget events
		do
			Result := visual_widget
		end

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_button_new)
		end

	initialize is
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			Precursor {EV_PRIMITIVE_IMP}
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (visual_widget, 0)
			{EV_GTK_EXTERNALS}.gtk_button_set_relief (visual_widget, {EV_GTK_EXTERNALS}.gtk_relief_normal_enum)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			is_initialized := True
			align_text_center
		end

	initialize_button_box is
			-- Create and initialize button box.
		local
			box: POINTER
		do
			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_container_add (visual_widget, box)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)

				-- Set up alignment dummy labels.
			left_side_label := {EV_GTK_EXTERNALS}.gtk_label_new (NULL)
			right_side_label := {EV_GTK_EXTERNALS}.gtk_label_new (NULL)
			{EV_GTK_EXTERNALS}.gtk_widget_show (left_side_label)
			{EV_GTK_EXTERNALS}.gtk_widget_show (right_side_label)

			{EV_GTK_EXTERNALS}.gtk_container_add (box, left_side_label)
			{EV_GTK_EXTERNALS}.gtk_container_add (box, pixmap_box)
	
			{EV_GTK_EXTERNALS}.gtk_container_add (box, text_label)
			{EV_GTK_EXTERNALS}.gtk_container_add (box, right_side_label)
		ensure
			button_box /= NULL
		end
		
	set_child_expandable (a_box: POINTER; a_child: POINTER; flag: BOOLEAN) is
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
		do
			{EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				a_box,
				a_child,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			{EV_GTK_EXTERNALS}.gtk_box_set_child_packing (
				a_box,
				a_child,
				flag,
				fill.to_boolean,
				pad,
				pack_type
			)
		end
		
	fontable_widget: POINTER is
			-- Pointer to the widget that may have fonts set.
		do
			Result := text_label
		end
		
	left_side_label, right_side_label: POINTER
			-- Dummy labels used for text/pixmap alignment

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button 
			-- for a particular container?
		
feature -- Status Setting

	align_text_center is
			-- Display `text' centered.
		do
			Precursor {EV_TEXTABLE_IMP}
			set_child_expandable (button_box, left_side_label, True)
			set_child_expandable (button_box, right_side_label, True)
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			set_child_expandable (button_box, left_side_label, False)
			set_child_expandable (button_box, right_side_label, True)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			set_child_expandable (button_box, left_side_label, True)
			set_child_expandable (button_box, right_side_label, False)
		end

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			enable_can_default
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		do		
			is_default_push_button := False		
		end

	enable_can_default is
			-- Allow the style of the button to be the default push button.
		do
			is_default_push_button := True
			{EV_GTK_EXTERNALS}.gtk_widget_set_flags (visual_widget, {EV_GTK_ENUMS}.gtk_can_default_enum)
		end

	set_foreground_color (a_color: EV_COLOR) is
		do
			Precursor {EV_PRIMITIVE_IMP} (a_color)
			real_set_foreground_color (text_label, a_color)
		end
	
feature {NONE} -- implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		local
			top_level_dialog_imp: EV_DIALOG_IMP
			rad_but: EV_RADIO_BUTTON_IMP
		do
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
			top_level_dialog_imp ?= top_level_window_imp
			if
				top_level_dialog_imp /= Void
			then
				if a_has_focus then
					rad_but ?= Current
					if rad_but = Void then
						-- We do not want radio buttons to affect current push button behavior
						top_level_dialog_imp.set_current_push_button (interface)
					end
				elseif top_level_dialog_imp.internal_current_push_button = interface  then
					top_level_dialog_imp.set_current_push_button (Void)
				end
			end
		end

	foreground_color_pointer: POINTER is
		do
			Result := {EV_GTK_EXTERNALS}.gtk_style_struct_fg (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_style (text_label)
			)
		end

	padding: INTEGER is 1
			-- Number of pixels of extra space around text and pixmap.

	button_box: POINTER is
			-- GtkHBox in button.
			-- Holds label and pixmap.
		local
			a_child_list: POINTER
		do
			a_child_list := {EV_GTK_EXTERNALS}.gtk_container_children (visual_widget)
			Result := {EV_GTK_EXTERNALS}.g_list_nth_data (a_child_list, 0)
			{EV_GTK_EXTERNALS}.g_list_free (a_child_list)
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_null: is_usable implies button_box /= NULL

end -- class EV_BUTTON_IMP

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

