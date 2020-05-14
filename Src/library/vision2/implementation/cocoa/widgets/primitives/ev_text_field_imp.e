note
	description: "EiffelVision text field. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			make,
			default_key_processing_blocked,
			set_default_minimum_size
		redefine
			interface,
			on_key_event
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			on_key_event,
			set_minimum_width_in_characters,
			set_default_minimum_size,
			make
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		local
			a_font: EV_FONT
		do
			create text_field.make
			cocoa_view := text_field
			text_field.cell.set_wraps (False)

			Precursor {EV_TEXT_COMPONENT_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			align_text_left
			create a_font.default_create
			a_font.set_height (12)
			set_font (a_font)

			text_field.text_did_change_actions.extend (agent do change_actions.call ([]) end)
		end

feature -- Access

	text: STRING_32
			-- Text displayed in field.
		do
			Result := text_field.string_value.to_string_32
		end

feature -- Status setting

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make `nb' characters visible on one line.
		do
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			text_field.set_string_value (a_text)
		end

	append_text (a_text: READABLE_STRING_GENERAL)
			-- Append `a_text' to the end of the text.
		local
			s: STRING_32
		do
			create s.make_from_string (text)
			s.append_string_general (a_text)
			text_field.set_string_value (s)
		end

	prepend_text (a_text: READABLE_STRING_GENERAL)
			-- Prepend `a_text' to the end of the text.
		local
			s: STRING_32
		do
			create s.make_from_string_general (a_text)
			s.append (text)
			text_field.set_string_value (s)
		end

	set_capacity (len: INTEGER)
			-- Set the maximum number of characters that `Current' can hold to `len'.
		do

		end

	capacity: INTEGER
			-- Return the maximum number of characters that the
			-- user may enter.
		do

		end

	align_text_left
			-- Make text left aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
		end

	align_text_right
			-- Make text right aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
		end

	align_text_center
			-- Make text center aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
		end

feature -- Status Report

	text_alignment: INTEGER
		-- Text alignment of `Current'.

	caret_position: INTEGER
			-- Current position of the caret.
		do
			Result := 1
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	set_default_minimum_size
			-- Called after creation. Set current size and notify parent.
		do
			internal_set_minimum_size (maximum_character_width * 4, text_field.cell.cell_size.height.rounded)
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable.
		do
			Result := text_field.is_editable
		end

	has_selection: BOOLEAN
			-- Is something selected?
		do
		end

	start_selection: INTEGER
			-- Index of the first character selected.
		do
		end

	end_selection: INTEGER
			-- Index of the last character selected.
		do
		end

feature -- status settings


	set_editable (a_editable: BOOLEAN)
			-- Set editable state to `a_editable'.
		do
			text_field.set_editable (a_editable)
		end

	set_caret_position (pos: INTEGER)
			-- Set the position of the caret to `pos'.
		do
		end

feature -- Basic operation

	insert_text (txt: READABLE_STRING_GENERAL)
			-- Insert `txt' at the current position.
		do
		end

	insert_text_at_position (txt: READABLE_STRING_GENERAL; a_pos: INTEGER)
			-- Insert `txt' at the current position at position `a_pos'
		do
		end

	select_region (start_pos, end_pos: INTEGER)
			-- Select (highlight) the text between
			-- 'start_pos' and 'end_pos'.
		do
		end

	set_selection (start_pos, end_pos: INTEGER)
			-- <Precursor>
		do
			check not_implemented: False end
		end

	select_from_start_pos (start_pos, end_pos: INTEGER)
			-- Hack to select region from change actions
		do
		end

	deselect_all
			-- Unselect the current selection.
		do

		end

	delete_selection
			-- Delete the current selection.
		do

		end

	cut_selection
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
		end

	copy_selection
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
		end

	paste (index: INTEGER)
			-- Insert the string which is in the
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing.
		do
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_change_actions
			-- A change action has occurred.
		local
--			new_text: STRING_32
		do
--			new_text := text
--			if not in_change_action and then (stored_text /= Void and then not new_text.is_equal (stored_text)) or else stored_text = Void then
--					-- The text has actually changed
--				in_change_action := True
--				if change_actions_internal /= Void then

--					change_actions_internal.call (Void)
--				end
--				in_change_action := False
--				stored_text := text
--			end

		end

	in_change_action: BOOLEAN
		-- Is `Current' in the process of calling `on_change_actions'

	last_key_backspace: BOOLEAN
		-- Was the last key pressed a backspace, used for select region hack for EiffelStudio.

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- A key event has occurred
		do
			if a_key_press then
				if a_key /= Void then
					last_key_backspace := a_key.code = {EV_KEY_CONSTANTS}.key_back_space
				end
			end
			Precursor {EV_TEXT_COMPONENT_IMP} (a_key, a_key_string, a_key_press)
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	text_field: NS_TEXT_FIELD

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT_FIELD note option: stable attribute end;
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_TEXT_FIELD_IMP
