note
	description: "Summary description for {WIKI_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_LIST

inherit
	WIKI_BOX [WIKI_LIST]
		redefine
--			parent,
			add_element,
			process
		end

	WIKI_LIST_HELPER

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_description: like description)
		do
			initialize
			if a_description.is_empty then
				level := 0
				kind := List_kind
			else
				level := a_description.count.as_natural_8
				kind := a_description.item (a_description.count)
			end
			description := a_description
		end

	make_from_string (s: detachable STRING)
		require
			s_starts_with_valid_kind: s /= Void implies (s.count > 0 and then valid_kind (s.item (1)))
			s_without_eol: s /= Void implies s.index_of ('%N', 1) = 0
		local
			t: STRING
			c: CHARACTER
--			p,
			n: INTEGER
			v: like level
		do
			initialize
			if s = Void or else s.is_empty then
				level := 0
				kind := List_kind
				description := ""
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
					c := s.item (v)
				end
				level := v - 1
				kind := t.item (level)
				description := t.string
			end
		end

feature -- Access

	level: NATURAL_8

	kind: CHARACTER
			-- '*' or '#' or ';' or ':' or '%U' (for root list)

	description: READABLE_STRING_8

	expected_parent_description: like description
		do
			if level > 0 then
				Result := description.substring (1, description.count - 1)
			else
				Result := ""
			end
		end

	expected_description_at_level (v: like level): like description
		require
			valid_level: v <= level
		do
			if v > 0 then
				Result := description.substring (1, v)
			else
				Result := ""
			end
		end

--	parent: detachable WIKI_LIST

	adapted_parent_list (a_list: WIKI_LIST): detachable WIKI_LIST
			--Try to find an adapted parent from Current, to be applied to `a_list'
		local
			p: like adapted_parent_list
			l_level: like level
		do
			-- FIXME
			l_level := a_list.level

			from
--				if l_level <= level then
--					p := parent
--				else
					p := Current
--				end
			until
				p = Void or else (
					p.level < l_level and
					(p.description.same_string (a_list.expected_description_at_level (p.level)))
					)
			loop
				if attached {WIKI_LIST} p.parent as l_parent_list then
					p := l_parent_list
				else
					p := Void
				end
			end
			Result := p
		ensure
			result_upper: Result /= Void implies Result.level < a_list.level
		end

feature -- Status report

	is_unordered_kind: BOOLEAN
		do
			Result := kind = unordered_kind
		end

	is_ordered_kind: BOOLEAN
		do
			Result := kind = ordered_kind
		end

	is_definition_term_kind: BOOLEAN
		do
			Result := kind = definition_term_kind
		end

	is_definition_description_kind: BOOLEAN
		do
			Result := kind = definition_description_kind
		end

feature -- Element change

	add_element (e: WIKI_LIST)
		local
			w, wp: WIKI_LIST
			ve,vp: NATURAL_8
		do
			ve := e.level
			vp := level
			if ve = vp + 1 then
				if kind = list_kind then
					kind := e.kind
				elseif kind /= e.kind then
					kind := list_kind
				end
				e.set_parent (Current)
				Precursor (e)
			else
					--| build intermediate list
				from
					w := e
				until
					w.level = vp + 1
				loop
					create wp.make (w.expected_parent_description)
					wp.add_element (w)
					w := wp
				end
				Precursor (w)
				w.set_parent (Current)
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_list (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := description.string
		end

invariant
	valid_parent: attached {WIKI_LIST} parent as p implies (p.level < level and p.description.same_string (description.substring (1, level - 1)))

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

