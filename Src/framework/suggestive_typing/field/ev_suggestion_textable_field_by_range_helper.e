note
	description: "Summary description for {EV_SUGGESTION_TEXTABLE_FIELD_BY_RANGE_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SUGGESTION_TEXTABLE_FIELD_BY_RANGE_HELPER

feature -- Text limit

	is_searched_text_separator_agent: detachable FUNCTION [TUPLE [CHARACTER_32], BOOLEAN]

	set_is_searched_text_separator_agent (agt: like is_searched_text_separator_agent)
		do
			is_searched_text_separator_agent := agt
		end

	is_searched_text_separator (c: CHARACTER_32): BOOLEAN
		do
			if attached is_searched_text_separator_agent as agt then
				Result := agt.item ([c])
			else
				Result := c.is_space or (c.is_character_8 and then c.to_character_8.is_punctuation)
			end
		end

feature -- deferred

	settings: EV_SUGGESTION_SETTINGS
		deferred
		end

	displayed_text: STRING_32
			-- Text which is currently displayed.
		deferred
		end

	caret_position: INTEGER
			-- Current position of caret in `text'.
		deferred
		end

feature -- Text operation

	searched_text: STRING_32
			-- Text which is going to be used as basis for suggestion.
			--| For example, if you have the following partial phone number "(555) 253-4" in `displayed_text'
			--| then the searched text could be "5552534".
		local
			s: like searched_text_from
		do
			s := searched_text_from (displayed_text, caret_position)
			if attached settings.searched_text_agent as l_agent then
				Result := l_agent.item ([s])
			else
				Result := s
			end
		end

	searched_text_range (a_text: like displayed_text; a_position: INTEGER): TUPLE [left,right: INTEGER]
		local
			p: like caret_position
			p1,p2: INTEGER
			len: INTEGER
		do
			if a_text.is_empty then
				p1 := 1
				p2 := 0
			else
				p := a_position
				len := a_text.count
				p1 := p
				if p <= 1 then
					p1 := 1
				elseif is_searched_text_separator (a_text [p1 - 1]) then
				else
					from
						p1 := p1 - 1
					until
						p1 < 2 or else is_searched_text_separator (a_text [p1 - 1])
					loop
						p1 := p1 - 1
					end
				end

				p2 := p
				if p2 >= len then
					p2 := len
				elseif is_searched_text_separator (a_text [p2]) then
					p2 := (p2 - 1).max (p1)
				else
					from
						p2 := p2 + 1
					until
						p2 > len or else is_searched_text_separator (a_text [p2])
					loop
						p2 := p2 + 1
					end
					p2 := p2 - 1
				end
				if is_searched_text_separator (a_text [p2]) then
					p2 := p2 - 1
				end
			end

			Result := [p1, p2]
		end

	searched_text_from (a_text: like displayed_text; a_position: INTEGER): STRING_32
			-- Text which is currently displayed.
		local
			tu: like searched_text_range
		do
			tu := searched_text_range (a_text, a_position)
			last_searched_text_range := tu
			Result := a_text.substring (tu.left, tu.right)
			debug ("suggestive")
				io.put_string ("("+ tu.left.out +","+ tu.right.out +") @[")
				io.put_string_32 (Result)
				io.put_string ("]%N")
			end
		end

	last_searched_text_range: detachable like searched_text_range

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.		

	insert_suggestion_text (a_suggested_text: READABLE_STRING_GENERAL)
			-- Insert associated text of `a_selected_item' in Current if valid,
			-- move caret to the end and update `last_suggestion' with `a_selected_item'.
		local
			l_text: READABLE_STRING_GENERAL
			tu: like last_searched_text_range
		do
			l_text := a_suggested_text
			if not l_text.is_empty and not l_text.has_code (('%R').natural_32_code) then
				tu := last_searched_text_range
				--searched_text_range (displayed_text, caret_position)
				if tu /= Void and then tu.right >= tu.left then
					set_selection (tu.left, tu.right + 1)
					debug ("suggestive")
						io.put_string ("("+ tu.left.out +","+ tu.right.out +") [")
						io.put_string_32 (selected_text)
						io.put_string ("]%N")
					end
					delete_selection
				end
				insert_text (l_text)
				set_caret_position (caret_position + l_text.count)
			end
--			refresh
		end

feature -- Textable

	set_caret_position (p: INTEGER)
		deferred
		end

	set_selection (a_start_pos, a_end_pos: INTEGER)
			-- Select (highlight) the characters between valid caret positions `a_start_pos' and `a_end_pos'.
		deferred
		end

	delete_selection
		deferred
		end

	selected_text: STRING_32
		deferred
		end

	insert_text (a_text: READABLE_STRING_GENERAL)
		deferred
		end

end
