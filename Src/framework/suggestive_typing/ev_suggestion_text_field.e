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
			initialize,
			set_default_key_processing_handler,
			remove_default_key_processing_handler
		end

	EV_ABSTRACT_SUGGESTION_FIELD
		rename
			displayed_text as text,
			set_displayed_text as set_text
		redefine
			create_interface_objects
		end

create
	make,
	make_with_settings

feature {NONE} -- Initialization

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

feature -- Status setting

	set_default_key_processing_handler (a_handler: like default_key_processing_handler)
			-- Set `default_key_processing_handler' with `new_default_key_processing_handler'.
			-- Set `old_default_key_processing_handler' with `a_handler' if different from
			-- `new_default_key_processing_handler'.
		do
			if a_handler /= new_default_key_processing_handler then
				old_default_key_processing_handler := a_handler
			end
			if default_key_processing_handler /= new_default_key_processing_handler then
				Precursor (new_default_key_processing_handler)
			end
		ensure then
			handler_set: default_key_processing_handler = new_default_key_processing_handler
			a_handler_preserved: a_handler /= new_default_key_processing_handler implies old_default_key_processing_handler = a_handler
		end

	remove_default_key_processing_handler
			-- Ensure `old_default_key_processing_handler' is Void while preserving our own handler.
		do
			old_default_key_processing_handler := Void
		ensure then
			default_handler_preserved: default_key_processing_handler = new_default_key_processing_handler
		end

feature {NONE} -- Implementation

	select_all_text
			-- <Precursor>
		do
			select_all
		end

	move_caret_to_end
			-- <Precursor>
		do
			set_caret_position (text_length + 1)
		end

	delete_word_before
			-- <Precursor>
		local
			l_text: STRING_32
			i: INTEGER
			l_has_trailing_space: BOOLEAN
		do
			l_text := text
				-- Translate the `caret_position' as an index in the string
				-- for deleting text at the left of `caret_position'.
			i := caret_position - 1
			if not l_text.is_empty and l_text.valid_index (i) then
					-- If the character at the right of the `caret_position' is a space, we
					-- remove all spaces after removing all non-space characters.
				l_has_trailing_space := l_text.valid_index (i + 1) and then l_text.item (i + 1).is_space

					-- First we remove all spaces at the left of the `caret_position'.
				from until i = 0 or else not l_text.item (i).is_space loop
					i := i - 1
				end

					-- Then we remove all the non-spaces characters until we hit a space.
				from until i = 0 or else l_text.item (i).is_space loop
					i := i - 1
				end

				if l_has_trailing_space then
						-- We need to remove all the leading spaces of the word we just removed
						-- because initially the character at the right of the `caret_position'
						-- was a space.
					from until i = 0 or else not l_text.item (i).is_space loop
						i := i - 1
					end
				end
					-- Remove the text that we will not keep.
				set_selection (i + 1, caret_position)
				delete_selection
			end
		end

	delete_word_after
			-- <Precursor>
		local
			l_text: STRING_32
			i, nb: INTEGER
			l_has_leading_space, l_remove_spaces_only: BOOLEAN
		do
			l_text := text
				-- Translate the `caret_position' as an index in the string
				-- for deleting text at the right of `caret_position'.
			i := caret_position
			nb := text_length
  			if not l_text.is_empty and l_text.valid_index (i) then
					-- If the character at the left of the `caret_position' is a space, we
					-- remove all spaces after removing all non-space characters.
				l_has_leading_space := not l_text.valid_index (i - 1) or else l_text.item (i - 1).is_space

					-- If the character at the right of the `caret_position'
					-- is a space and the character at the left (if any) if also a space
					-- then we only remove spaces, nothing else.
				l_remove_spaces_only := l_text.item (i).is_space and then l_has_leading_space

					-- First we remove all spaces at the right of the `caret_position'.
				from until i > nb or else not l_text.item (i).is_space loop
					i := i + 1
				end

				if not l_remove_spaces_only then
						-- Then we remove all the non-spaces characters until we hit a space.					
					from until i > nb or else l_text.item (i).is_space loop
						i := i + 1
					end

					if l_has_leading_space then
							-- We need to remove all the trailing spaces of the word we just removed
							-- because initially the character at the left of the `caret_position'
							-- was a space.
						from until i > nb or else not l_text.item (i).is_space loop
							i := i + 1
						end
					end
				end
					-- Remove the text that we will not keep.
				set_selection (caret_position, i)
				delete_selection
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
