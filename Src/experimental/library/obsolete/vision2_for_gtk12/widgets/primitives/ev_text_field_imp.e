note
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
			create_change_actions,
			needs_event_box
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

	needs_event_box: BOOLEAN
		do
			Result := True
		end

	make (an_interface: like interface)
			-- Create a gtk entry.
		local
			l_vbox: POINTER
		do
			base_make (an_interface)
			l_vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (l_vbox)
			entry_widget := {EV_GTK_EXTERNALS}.gtk_entry_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (entry_widget, 40, -1)
			--| Minimum sizes need to be similar on both platforms
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (l_vbox, entry_widget, False, False, 0)
			set_text ("")
		end

feature -- Access

	text: STRING_32
			-- Text displayed in field.
		do
			create Result.make_from_c ({EV_GTK_EXTERNALS}.gtk_entry_get_text (entry_widget))
		end

feature -- Status setting

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			{EV_GTK_EXTERNALS}.gtk_entry_set_text (entry_widget, a_cs.item)
		end

	append_text (txt: STRING_GENERAL)
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

	prepend_text (txt: STRING_GENERAL)
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

	set_capacity (len: INTEGER)
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

	capacity: INTEGER
			-- Return the maximum number of characters that the
			-- user may enter.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_entry_struct_text_max_length (entry_widget)
		end

feature -- Status Report

	caret_position: INTEGER
			-- Current position of the caret.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1
			if in_change_action and then not last_key_backspace then
					-- Hack needed for autocompletion in EiffelStudio
				Result := Result + 1
			end
		end

	last_key_backspace: BOOLEAN
			-- Was the last key pressed the backspace/delete key?

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN; call_application_events: BOOLEAN)
			-- A key event has occurred
		do
			if a_key_press then
				if a_key /= Void then
					last_key_backspace := a_key.code = {EV_KEY_CONSTANTS}.key_back_space
				end
			end
			Precursor {EV_TEXT_COMPONENT_IMP} (a_key, a_key_string, a_key_press, call_application_events)
		end

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			create Result
			real_signal_connect (entry_widget, "activate", agent (App_implementation.gtk_marshal).text_field_return_intermediary (c_object), Void)
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable.
		do
			--| FIXME This should be removed when gtk1 imp is made obsolete
			Result := (create {EV_GTK_DEPENDENT_EXTERNALS}).gtk_editable_get_editable (entry_widget)
		end

	position: INTEGER
			-- Current position of the caret.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1
		end

	has_selection: BOOLEAN
			-- Is something selected?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget) /=
				{EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)
		end

	selection_start: INTEGER
			-- Index of the first character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.min ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)) + 1
		end

	selection_end: INTEGER
			-- Index of the last character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.max ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget))
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- status settings

	set_editable (flag: BOOLEAN)
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_editable (entry_widget, flag)
		end

	set_position (pos: INTEGER)
			-- Set current insertion position.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	set_caret_position (pos: INTEGER)
			-- Set the position of the caret to `pos'.
		do
			internal_set_caret_position (pos)
		end

feature -- Basic operation

	insert_text (txt: STRING)
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

	select_region (start_pos, end_pos: INTEGER)
			-- Select (highlight) the text between
			-- 'start_pos' and 'end_pos'.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))

				-- Hack to ensure text field is selected when called from change actions
			if not last_key_backspace and then change_actions_internal /= Void and then change_actions_internal.state = change_actions_internal.blocked_state and then end_pos = text.count then
				app_implementation.do_once_on_idle (agent select_from_start_pos (start_pos, end_pos))
			end
		end

	select_from_start_pos (start_pos, end_pos: INTEGER)
			-- Hack to select region from change actions
		local
			a_start, a_end, text_count: INTEGER
		do
			if not is_destroyed then
				a_start := start_pos.min (end_pos)
				a_end := end_pos.max (start_pos)
				text_count := text.count
				if a_end < text_count then
					a_start := a_start + (text_count - a_end)
				end
				{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, a_start - 1, -1)
			end
		end

	deselect_all
			-- Unselect the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection
			-- Delete the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER)
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

	internal_set_caret_position (pos: INTEGER)
			-- Set the position of the caret to `pos'.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			create Result
			real_signal_connect (entry_widget, "changed", agent (App_implementation.gtk_marshal).text_component_change_intermediary (c_object), Void)
		end

	stored_text: STRING
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	in_change_action: BOOLEAN
			-- Is Current being changed?

	on_change_actions
			-- A change action has occurred.
		local
			new_text: STRING_32
		do
			new_text := text
			if not in_change_action and then (stored_text /= Void and then not new_text.is_equal (stored_text)) or else stored_text = Void then
					-- The text has actually changed
				in_change_action := True
				if change_actions_internal /= Void then
					change_actions_internal.call (Void)
				end
				in_change_action := False
				stored_text := text
			end

		end

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field

	visual_widget: POINTER
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




end -- class EV_TEXT_FIELD_IMP

