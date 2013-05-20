note
	description: "Summary description for {CSS_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CSS_TEXT

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make (3)
		end

feature -- Access

	items: ARRAYED_LIST [TUPLE [selectors: ITERABLE [CSS_SELECTOR]; style: CSS_STYLE]]

	add_selector_style (a_selector: CSS_SELECTOR; a_style: CSS_STYLE)
		do
			items.force ([<<a_selector>>, a_style])
		end

	add_selectors_style (a_selectors: ITERABLE [CSS_SELECTOR]; a_style: CSS_STYLE)
		do
			items.force ([a_selectors, a_style])
		end

feature -- Conversion

	string: STRING_8
		local
			s: STRING_8
		do
			create s.make (64)
			append_to (s)
			Result := s
		end

	append_to (a_target: STRING_8)
		local
			s: STRING_8
			s_selectors: STRING_8
		do
			create s.make (64)
			create s_selectors.make (10)
			across
				items as c
			loop
				s_selectors.wipe_out
				across
					c.item.selectors as cs
				loop
					if not s_selectors.is_empty then
						s_selectors.append_character (',')
					end
					s_selectors.append (cs.item.string)
				end
				if not s_selectors.is_empty then
					a_target.append (s_selectors)
					a_target.append_character (' ')
					a_target.append_character ('{')
					c.item.style.append_text_to (a_target)
					a_target.append_character ('}')
					a_target.append_character ('%N')
				end
			end
		end

end
