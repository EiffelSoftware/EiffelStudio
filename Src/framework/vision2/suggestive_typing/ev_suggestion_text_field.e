note
	description: "Descendant of EV_TEXT_FIELD equipped with suggestive typing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_TEXT_FIELD

inherit
	EV_TEXT_FIELD
		redefine
			create_interface_objects,
			initialize
		end

	EV_ABSTRACT_SUGGESTION_FIELD
		redefine
			create_interface_objects
		end

create
	make,
	make_with_settings

feature{NONE} -- Initialization

	make (a_provider: like suggestion_provider)
			-- Initialize current using suggestion provider `a_provider'.
			-- If `a_provider.is_concurrent', then Current might create a new thread
			-- of control to perform the query.
		do
			suggestion_provider := a_provider
			default_create
		ensure
			suggestion_provider_set: suggestion_provider = a_provider
		end

	make_with_settings (a_provider: like suggestion_provider; a_settings: like settings)
			-- Initialize current using suggestion provider `a_provider' and associated `a_settings' settings.
			-- If `a_provider.is_concurrent', then Current might create a new thread
			-- of control to perform the query.
		do
			suggestion_provider := a_provider
			internal_settings := a_settings
			default_create
		ensure
			suggestion_provider_set: suggestion_provider = a_provider
			settings_set: internal_settings = a_settings
		end

	create_interface_objects
			-- <Precursor>
		do
			Precursor {EV_ABSTRACT_SUGGESTION_FIELD}
			Precursor {EV_TEXT_FIELD}
		end

	initialize
			-- Initialize current.
		do
			Precursor
			initialize_suggestion_field
		end

feature{NONE} -- Implementation

	move_caret_to (a_pos: INTEGER)
			-- <Precursor>
		do
			set_caret_position (a_pos.max (0).min (text_length + 1))
		end

	move_caret_to_end
			-- <Precursor>
		do
			set_caret_position (text_length + 1)
		end

	delete_character_before
			-- <Precursor>
		do
			if text_length > 0 and caret_position > 1 then
				select_region (caret_position - 1, caret_position - 1)
				delete_selection
			end
		end

	delete_character_after
			-- <Precursor>
		do
			if text_length > 0 and caret_position <= text_length then
				select_region (caret_position, caret_position)
				delete_selection
			end
		end

	delete_word_before
			-- <Precursor>
		do
			-- TO BE IMPLEMENTED
			check False end
			delete_character_before
		end

	delete_word_after
			-- <Precursor>
		do
			-- TO BE IMPLEMENTED
			check False end
			delete_character_after
		end

	insert_string (a_str: STRING_32)
			-- Insert `a_str' at cursor position.
		do
			insert_text (a_str)
			set_caret_position (caret_position + a_str.count)
		end

	insert_character (a_char: CHARACTER_32)
			-- Insert `a_char' at cursor position.
		do
			insert_text (create {STRING_32}.make_filled (a_char, 1))
			set_caret_position (caret_position + 1)
		end

	block_focus_in_actions
			-- Block focus in actions.
		do
			focus_in_actions.block
		end

	resume_focus_in_actions
			-- Resume focus in actions.
		do
			focus_in_actions.resume
		end

	block_focus_out_actions
			-- Block focus out actions.
		do
			focus_out_actions.block
		end

	resume_focus_out_actions
			-- Resume focus out actions.
		do
			focus_out_actions.resume
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
