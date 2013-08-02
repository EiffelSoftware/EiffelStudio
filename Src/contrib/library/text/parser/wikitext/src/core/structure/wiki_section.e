note
	description: "Summary description for {WIKI_SECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_SECTION

inherit
	WIKI_BOX [WIKI_BOX [WIKI_ITEM]]
		redefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
		require
			s_attached: s /= Void
			s_starts_with_equal: s.count > 0 and then s.item (1) = '='
			s_without_eol: s.index_of ('%N', 1) = 0
		local
			t: STRING
			n,p: INTEGER
			v: like level
		do
			initialize
			from
				v := {NATURAL_8}1
				n := s.index_of ('%N', 1)
				if n = 0 then
					n := s.count
				end
				create t.make (5)
			until
				v >= n or s.item (v) /= '='
			loop
				t.extend ('=')
				v := v + 1
			end
			p := s.substring_index (t, v)
			level := v - 1
			if p > 0 and is_blank (s.substring (p + v, n)) then
				is_valid := True
				t := s.substring (v, p - 1)
				t.left_adjust
				t.right_adjust
				text := t
			else
				is_valid := False
			end
		end

feature -- Access

	level: NATURAL_8

	text: detachable WIKI_STRING

	adapted_parent_section (a_section: WIKI_SECTION): detachable WIKI_SECTION
		local
			p: like adapted_parent_section
			l_level: like level
		do
			from
				l_level := a_section.level
				p := Current
			until
				p = Void or else p.level < l_level - 1
			loop
				if attached {WIKI_SECTION} p.parent as l_parent_section then
					p := l_parent_section
				else
					p := Void
				end
			end
			Result := p
		ensure
			result_upper: Result /= Void implies Result.level < level
		end

feature -- Status report

	is_valid: BOOLEAN

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_section (Current)
		end

feature -- Status report

	debug_output: STRING
		do
			if attached text as t then
				Result := t.debug_output
				Result.prepend_character (' ')
				Result.prepend_character ('#')
				Result.prepend_integer (level)
				Result.prepend_string (create {STRING}.make_filled (' ', level))
			else
				Result := ""
			end
		end

invariant
	parent_upper: attached {WIKI_SECTION} parent as p implies p.level < level

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
