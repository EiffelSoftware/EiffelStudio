note
	description: "Summary description for {WIKI_LIST_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_LIST_FACTORY

inherit
	WIKI_LIST_HELPER

feature -- Access

	new_list (s: detachable READABLE_STRING_8): WIKI_LIST
		local
			t: STRING
			c: CHARACTER
			n: INTEGER
			v: NATURAL_8
		do
			if s = Void or else s.is_empty then
				create Result.make ("")
			else
				from
					v := {NATURAL_8}1
					n := s.index_of ('%N', 1)
					if n = 0 then
						n := s.count
					end
					create t.make (5)
					c := s.item (v)
				until
					v > n or not valid_kind (c)
				loop
					t.append_character (c)
					v := v + 1
					if s.valid_index (v) then
						c := s.item (v)
					else
						c := '%U'
					end
				end
				check t.count = v - 1 end
				inspect t.item (t.count)
				when {WIKI_LIST}.definition_term_kind then
					create {WIKI_DEFINITION_TERM} Result.make_item (t.string, s.substring (v, s.count))
				when {WIKI_LIST}.definition_description_kind then
					create {WIKI_DEFINITION_DESCRIPTION} Result.make_item (t.string, s.substring (v, s.count))
				else
					create {WIKI_LIST_ITEM} Result.make_item (t.string, s.substring (v, s.count))
				end
				check Result.kind = t.item (v - 1) end
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
