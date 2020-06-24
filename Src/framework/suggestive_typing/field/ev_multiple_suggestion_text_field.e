note
	description: "Descendant of EV_TEXT_FIELD equipped with suggestive typing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTIPLE_SUGGESTION_TEXT_FIELD

inherit
	EV_SUGGESTION_TEXT_FIELD
		redefine
			searched_text,
			insert_suggestion
		end

create
	make,
	make_with_settings

feature -- Text limit

	is_searched_text_separator (c: CHARACTER_32): BOOLEAN
			-- Is `c' a search_text separator
			--| Could be space, punctuation
		do
			if attached is_searched_text_separator_agent as agt then
				Result := agt.item ([c])
			else
				Result := c.is_space or (c.is_character_8 and then c.to_character_8.is_punctuation)
			end
		end

	is_searched_text_separator_agent: detachable FUNCTION [TUPLE [CHARACTER_32], BOOLEAN]

	set_is_searched_text_separator_agent (agt: like is_searched_text_separator_agent)
		do
			is_searched_text_separator_agent := agt
		end

feature -- Text operation

	searched_text: STRING_32
			-- Text which is going to be used as basis for suggestion.
			--| For example, if you have the following partial phone number "(555) 253-4" in `displayed_text'
			--| then the searched text could be "5552534".
		local
			s: like searched_text_from
		do
			s := searched_text_from (text, caret_position)
			if attached settings.searched_text_agent as l_agent then
				Result := l_agent.item ([s])
			else
				Result := s
			end
			Result := text_without_activator (Result)
		end

	searched_text_range (a_text: like text; a_position: INTEGER): TUPLE [left,right: INTEGER]
			-- Position range to extract the raw searched_text.
		local
			l_text: like text
			p: like caret_position
			p1,p2: INTEGER
			len: INTEGER
		do
			l_text := a_text
			if l_text.is_empty then
				p1 := 1
				p2 := 0
			else
				p := a_position
				len := l_text.count
				p1 := p
				if p <= 1 then
					p1 := 1
				elseif is_searched_text_separator (l_text [p1 - 1]) then
				else
					from
						p1 := p1 - 1
					until
						p1 < 2 or else is_searched_text_separator (l_text [p1 - 1])
					loop
						p1 := p1 - 1
					end
				end

				p2 := p
				if p2 >= len then
					p2 := len
				elseif is_searched_text_separator (l_text [p2]) then
					p2 := (p2 - 1).max (p1)
				else
					from
						p2 := p2 + 1
					until
						p2 > len or else is_searched_text_separator (l_text[p2])
					loop
						p2 := p2 + 1
					end
					p2 := p2 - 1
				end
				if is_searched_text_separator (l_text[p2]) then
					p2 := p2 - 1
				end
			end

			Result := [p1, p2]
		end

	searched_text_from (a_text: like text; a_position: INTEGER): STRING_32
			-- raw searched_text at position `a_position'.
		local
			tu: like searched_text_range
		do
			tu := searched_text_range (a_text, a_position)
			Result := a_text.substring (tu.left, tu.right)
		end

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.		

	insert_suggestion (a_selected_item: attached like last_suggestion)
			 -- Insert associated text of `a_selected_item' in Current if valid,
			 -- move caret to the end or suggestion and update `last_suggestion' with `a_selected_item'.
		local
			l_text: READABLE_STRING_GENERAL
			tu: like searched_text_range
		do
			selected_suggestion := a_selected_item
			l_text := suggested_text (a_selected_item)
			if not l_text.is_empty and not l_text.has_code (('%R').natural_32_code) then
				tu := searched_text_range (text, caret_position)
				if tu.right >= tu.left then
					set_selection (tu.left, tu.right + 1)
					delete_selection
				end
				insert_text (l_text)
				set_caret_position (caret_position + l_text.count)
			end
			refresh
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
