indexing
	description: "EiffelVision text field. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP
	
inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end
	
	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			visual_widget,
			on_key_event,
			create_change_actions
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			visual_widget
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES}
				return_actions_internal
		redefine
			create_return_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk entry.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0))
			entry_widget := {EV_GTK_EXTERNALS}.gtk_entry_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (entry_widget, 40, -1)
			--| Minimum sizes need to be similar on both platforms
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (c_object, entry_widget, False, False, 0)
			set_text ("")
		end

feature -- Access

	text: STRING is
			-- Text displayed in field.
		do
			create Result.make_from_c ({EV_GTK_EXTERNALS}.gtk_entry_get_text (entry_widget))
		end

feature -- Status setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			{EV_GTK_EXTERNALS}.gtk_entry_set_text (entry_widget, a_cs.item)
		end

	append_text (txt: STRING) is
			-- Append `txt' to the end of the text.
		local
			temp_caret_pos: INTEGER
			a_cs: EV_GTK_C_STRING
		do
			temp_caret_pos := caret_position
			a_cs := txt
			{EV_GTK_EXTERNALS}.gtk_entry_append_text (entry_widget, a_cs.item)
			internal_set_caret_position (temp_caret_pos)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend `txt' to the end of the text.
		local
			temp_caret_pos: INTEGER
			a_cs: EV_GTK_C_STRING
		do
			temp_caret_pos := caret_position
			a_cs := txt
			{EV_GTK_EXTERNALS}.gtk_entry_prepend_text (entry_widget, a_cs.item)
			internal_set_caret_position (temp_caret_pos)
		end
		
	set_capacity (len: INTEGER) is
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end
	
	capacity: INTEGER is
			-- Return the maximum number of characters that the
			-- user may enter.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_entry_struct_text_max_length (entry_widget)
		end

feature -- Status Report

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			if in_change_action and not last_key_backspace then
				Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 2
			else
				Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1	
			end
		end
	
	last_key_backspace: BOOLEAN
			-- Was the last key pressed the backspace/delete key?

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		do
			if a_key_press then
					-- The event is a key press event.
				if a_key /= Void then
					if a_key.code = {EV_KEY_CONSTANTS}.Key_back_space then
						last_key_backspace := True
					else
						last_key_backspace := False
					end	
				end
			end
			Precursor (a_key, a_key_string, a_key_press)
		end

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "activate", agent (App_implementation.gtk_marshal).text_field_return_intermediary (c_object), Void)
		end
		
feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
			--| FIXME This should be removed when gtk1 imp is made obsolete
			Result := (create {EV_GTK_DEPENDENT_EXTERNALS}).gtk_editable_get_editable (entry_widget)
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget) /= 
				{EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.min ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.max ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget))
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_editable (entry_widget, flag)
		end

	set_position (pos: INTEGER) is
			-- Set current insertion position.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			internal_set_caret_position (pos)
		end

feature -- Basic operation

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		local
			pos: INTEGER
			a_cs: EV_GTK_C_STRING
		do
			pos := caret_position - 1
			a_cs := txt
			{EV_GTK_EXTERNALS}.gtk_editable_insert_text (
				entry_widget,
				a_cs.item,
				txt.count,
				$pos
			)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between 
			-- 'start_pos' and 'end_pos'.
		do
			internal_set_caret_position (end_pos.max (start_pos) + 1)
			select_region_internal (start_pos, end_pos)
			internal_timeout_imp ?= (create {EV_TIMEOUT}).implementation
			internal_timeout_imp.interface.actions.extend 
				(agent select_region_internal (start_pos, end_pos))
			internal_timeout_imp.set_interval_kamikaze (0)
		end	

	select_region_internal (start_pos, end_pos: INTEGER) is
			-- Select region
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))
		end

	deselect_all is
			-- Unselect the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (entry_widget)
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

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	internal_set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "changed", agent (App_implementation.gtk_marshal).text_component_change_intermediary (c_object), Void)
		end

	internal_timeout_imp: EV_TIMEOUT_IMP
			-- Timeout to call 'select_region

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
			toggle_in_change_action (True)
			if stored_text /= Void then
				if not text.is_equal (stored_text) then
						-- The text has actually changed
					stored_text := text
					change_actions_internal.call (Void)
				end
			else
				stored_text := text
				change_actions_internal.call (Void)
			end
			toggle_in_change_action (False)
		end
		
feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field
		
	visual_widget: POINTER is
			-- Pointer to the widget shown on screen.
		do
			Result := entry_widget
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	entry_widget_set: entry_widget /= NULL
	
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




end -- class EV_TEXT_FIELD_IMP

