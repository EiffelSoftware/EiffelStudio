note
	description: "Summary description for {EV_ABSTRACT_SUGGESTION_TEXT_COMPONENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ABSTRACT_SUGGESTION_TEXT_COMPONENT

inherit
	EV_ABSTRACT_SUGGESTION_FIELD

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

feature -- Access

	text: STRING_32
		deferred
		end

	text_length: INTEGER
		deferred
		end

feature -- Basic operation

	select_all
		deferred
		end

	set_selection (a_start_pos, a_end_pos: INTEGER)
			-- Select (highlight) the characters between valid caret positions `a_start_pos' and `a_end_pos'.	
		deferred
		end

	delete_selection
		deferred
		end

feature -- Status setting		

	set_caret_position (a_caret_position: INTEGER)
		deferred
		end

end
