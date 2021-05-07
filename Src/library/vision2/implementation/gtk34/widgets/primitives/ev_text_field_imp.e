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
		export
			{EV_INTERMEDIARY_ROUTINES} return_actions_internal
		redefine
			interface,
			return_actions,
			hide_border
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			visual_widget,
			needs_event_box,
			on_key_event,
			set_minimum_width_in_characters,
			make
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: attached like interface)
			-- Create a gtk entry.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		local
			a_vbox: POINTER
		do
			a_vbox := {GTK3}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_vertical, 0)
			set_c_object (a_vbox)
			entry_widget := new_entry_widget
			{GTK}.gtk_widget_show (entry_widget)
			{GTK}.gtk_box_pack_start (a_vbox, entry_widget, False, False, 0)
			align_text_left
			Precursor
		end

feature -- Access

	text: STRING_32
			-- Text displayed in field.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.share_from_pointer ({GTK}.gtk_entry_get_text (entry_widget))
			Result := a_cs.string
		end

feature -- Status setting

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make `nb' characters visible on one line.
		do
			{GTK2}.gtk_widget_set_minimum_size (entry_widget, (nb + 1) * maximum_character_width, -1)
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text

			-- TODO JV
			-- Double check if this is really needed.
			{GTK}.gtk_entry_set_width_chars (entry_widget, 1)

			{GTK}.gtk_entry_set_text (entry_widget, a_cs.item)
			on_change_actions
		end

	append_text (a_text: READABLE_STRING_GENERAL)
			-- Append `a_text' to the end of the text.
		local
			a_cs: EV_GTK_C_STRING
			l_buffer: POINTER
		do
			a_cs := a_text
			l_buffer := {GTK}.gtk_entry_get_buffer (entry_widget)
			{GTK}.gtk_entry_buffer_insert_text (l_buffer, 1, a_cs.item, a_cs.string_length)
			on_change_actions
		end

	prepend_text (a_text: READABLE_STRING_GENERAL)
			-- Prepend `a_text' to the end of the text.
		local
			a_cs: EV_GTK_C_STRING
			l_buffer: POINTER
			l_end_pos: NATURAL_32
		do
			a_cs := a_text
			l_buffer := {GTK}.gtk_entry_get_buffer (entry_widget)
			l_end_pos := text_length.as_natural_32
			{GTK}.gtk_entry_buffer_insert_text (l_buffer, l_end_pos, a_cs.item, a_cs.string_length)
			on_change_actions
		end

	set_capacity (len: INTEGER)
			-- Set the maximum number of characters that `Current' can hold to `len'.
		do
			{GTK2}.gtk_entry_set_max_length (entry_widget, len)
		end

	align_text_left
			-- Make text left aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
			{GTK2}.gtk_entry_set_alignment (entry_widget, {REAL_32} 0.0)
		end

	align_text_right
			-- Make text right aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
			{GTK2}.gtk_entry_set_alignment (entry_widget, {REAL_32} 1.0)
		end

	align_text_center
			-- Make text center aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
			{GTK2}.gtk_entry_set_alignment (entry_widget, {REAL_32} 0.5)
		end

feature -- Status Report

	text_alignment: INTEGER
		-- Text alignment of `Current'.

	caret_position: INTEGER
			-- Current position of the caret.
		do
			Result := {GTK}.gtk_editable_get_position (entry_widget) + 1
		end

	capacity: INTEGER
			-- Return the maximum number of characters that the
			-- user may enter.
		do
			Result := {GTK}.gtk_entry_get_max_length (entry_widget)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
		do
			Precursor (a_key, a_key_string, a_key_press)
			if a_key_press then
				on_change_actions
			end
		end

	return_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- <Precursor>
		do
			if attached return_actions_internal as l_result then
				Result := l_result
			else
				create Result
				real_signal_connect_after (entry_widget, once "activate", agent (App_implementation.gtk_marshal).text_field_return_intermediary (c_object), Void)
				return_actions_internal := Result
			end
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable.
		do
			Result := {GTK2}.gtk_editable_get_editable (entry_widget)
		end

	has_selection: BOOLEAN
			-- Is something selected?
		local
			a_start, a_end: INTEGER
		do
			Result := {GTK2}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
		end

	start_selection: INTEGER
			-- Index of the first character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
			has_sel := {GTK2}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_start + 1
		end

	end_selection: INTEGER
			-- Index of the last character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
			has_sel := {GTK2}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_end + 1
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- status settings

	hide_border
			-- Hide the border of `Current'.
		local
			l_context: POINTER
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
		do
			l_context := {GTK3}.gtk_widget_get_style_context (entry_widget)
			l_provider := {GTK_CSS}.gtk_css_provider_new
			create l_css_data.make ("entry { border:none }")
			if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
				-- Handle error
			end
			{GTK2}.gtk_style_context_add_provider (l_context, l_provider, 800)
			{GTK2}.gtk_entry_set_has_frame (entry_widget, False)
		end

	set_editable (a_editable: BOOLEAN)
			-- Set editable state to `a_editable'.
		do
			{GTK}.gtk_editable_set_editable (entry_widget, a_editable)
		end

	set_caret_position (pos: INTEGER)
			-- Set the position of the caret to `pos'.
		do
			{GTK}.gtk_editable_set_position (entry_widget, pos - 1)
		end

feature -- Basic operation

	insert_text (txt: READABLE_STRING_GENERAL)
			-- Insert `txt' at the current position.
		do
			insert_text_at_position (txt, caret_position)
			on_change_actions
		end

	insert_text_at_position (txt: READABLE_STRING_GENERAL; a_pos: INTEGER)
			-- Insert `txt' at the current position at position `a_pos'
		local
			a_cs: EV_GTK_C_STRING
			pos: INTEGER
		do
			pos := a_pos - 1
			a_cs := txt
			{GTK}.gtk_editable_insert_text (
				entry_widget,
				a_cs.item,
				txt.count,
				$pos
			)
		end

	select_region (start_pos, end_pos: INTEGER)
			-- <Precursor>
		do
			{GTK}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))
		end

	set_selection (start_pos, end_pos: INTEGER)
			-- <Precursor>
		do
			{GTK}.gtk_editable_select_region (entry_widget, start_pos - 1, end_pos - 1)
		end

	deselect_all
			-- Unselect the current selection.
		do
			{GTK}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection
			-- Delete the current selection.
		do
			{GTK}.gtk_editable_delete_selection (entry_widget)
			on_change_actions
		end

	cut_selection
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{GTK}.gtk_editable_cut_clipboard (entry_widget)
			on_change_actions
		end

	copy_selection
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{GTK}.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER)
			-- Insert the string which is in the
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing.
		do
			insert_text_at_position (clipboard_content, index)
			on_change_actions
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	stored_text: detachable STRING_32
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	on_change_actions
			-- A change action has occurred.
		local
			new_text: STRING_32
		do
			new_text := text
			if --not in_change_action and then
			(attached stored_text as l_stored_text and then not new_text.is_equal (l_stored_text)) or else stored_text = Void then
					-- The text has actually changed
				in_change_action := True
				if attached change_actions_internal as l_change_actions_internal then
					l_change_actions_internal.call (Void)
				end
				in_change_action := False
				stored_text := text
			end

		end

	in_change_action: BOOLEAN
		-- Is `Current' in the process of calling `on_change_actions'

feature {NONE} -- Implementation

	new_entry_widget: POINTER
			-- Create an uninitialized entry widget.
		do
			Result := {GTK}.gtk_entry_new
		end

	entry_widget: POINTER
		-- A pointer on the text field

	visual_widget: POINTER
			-- Pointer to the widget shown on screen.
		do
			Result := entry_widget
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT_FIELD note option: stable attribute end;
			--Provides a common user interface to platform dependent
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

end -- class EV_TEXT_FIELD_IMP
