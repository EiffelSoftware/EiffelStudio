indexing

	description: 
		"EiffelVision text component, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_IMP
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			set_composite_widget_pointer_style
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} change_actions_internal	
		redefine
			create_change_actions
		end


feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
			Result := C.gtk_editable_struct_editable (entry_widget) /= 0
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_editable_get_position (entry_widget) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := C.gtk_editable_struct_selection_start_pos (entry_widget) /= 
				C.gtk_editable_struct_selection_end_pos (entry_widget)
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			a_start: INTEGER
		do
			a_start := C.gtk_editable_struct_selection_start_pos (entry_widget)
			Result := a_start.min (C.gtk_editable_struct_selection_end_pos (entry_widget)) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			a_start: INTEGER
		do
			a_start := C.gtk_editable_struct_selection_start_pos (entry_widget)
			Result := a_start.max (C.gtk_editable_struct_selection_end_pos (entry_widget))
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
			--| FIXME IEK Needs implementing with clipboard from app_imp
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			C.gtk_editable_set_editable (entry_widget, flag)
		end

	set_position (pos: INTEGER) is
			-- Set current insertion position.
		do
			C.gtk_editable_set_position (entry_widget, pos - 1)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			C.gtk_editable_set_position (entry_widget, pos - 1)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			check not_implemented: False end
		end

feature -- Basic operation

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		local
			pos: INTEGER
			a_gs: GEL_STRING
		do
			pos := caret_position - 1
			create a_gs.make (txt)
			C.gtk_editable_insert_text (
				entry_widget,
				a_gs.item,
				txt.count,
				$pos
			)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between 
			-- 'start_pos' and 'end_pos'.
		do
			select_region_internal (start_pos, end_pos)
			internal_timeout_imp ?= (create {EV_TIMEOUT}).implementation
			internal_timeout_imp.interface.actions.extend 
				(agent select_region_internal (start_pos, end_pos))
			internal_timeout_imp.set_interval_kamikaze (0)
		end	

	select_region_internal (start_pos, end_pos: INTEGER) is
			-- Select region
		do
			C.gtk_editable_select_region (entry_widget, start_pos - 1, end_pos)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			C.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			C.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (index)
			insert_text (clipboard_content)
			set_position (pos)
		end
		
feature {NONE} -- Implementation
		
	set_composite_widget_pointer_style (a_cursor_ptr: POINTER) is
			-- 
		do
			{EV_PRIMITIVE_IMP} Precursor (a_cursor_ptr)
			--C.gtk_widget_realize (entry_widget)
			--C.gtk_widget_realize (C.gtk_entry_struct_text_area (entry_widget))
			C.gdk_window_set_cursor (C.gtk_widget_struct_window (C.gtk_entry_struct_text_area (entry_widget)), a_cursor_ptr)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	internal_timeout_imp: EV_TIMEOUT_IMP
			-- Timeout to call 'select_region'

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "changed", agent gtk_marshal.text_component_change_intermediary (c_object), Void)
		end

	entry_widget: POINTER is
			-- Pointer to the gtkeditable widget.
		deferred
		end

	interface: EV_TEXT_COMPONENT

	stored_text: STRING
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	in_change_action: BOOLEAN
			-- Is Current being changed?

	toggle_in_change_action (a_flag: BOOLEAN) is
			-- Set 'in_change_action' to 'a_flag'
		do
			in_change_action := a_flag
		end

	on_change_actions is
			-- A change action has occurred.
		do
			if stored_text /= Void then
				if not text.is_equal (stored_text) then
						-- The text has actually changed
					stored_text := text
					change_actions_internal.call ([])
				end
			else
				stored_text := text
				change_actions_internal.call ([])
			end
		end

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Inte9ractive Software Engineering Inc.
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

