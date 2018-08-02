note
	description: "Summary description for {WIKI_SECTION_NODE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_SECTION_NODE

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Creation

	make (a_section: detachable WIKI_SECTION)
		do
			section := a_section
			if a_section /= Void then
				level := a_section.level
			end
		end

feature -- Access

	level: NATURAL_8

	section: detachable WIKI_SECTION

	parent: detachable WIKI_SECTION_NODE

	items: detachable ARRAYED_LIST [WIKI_SECTION_NODE]

	is_empty: BOOLEAN
		do
			Result := not attached items as l_items or else l_items.is_empty
		end

feature {WIKI_SECTION_NODE} -- Access

	last_item_at_level (lev: NATURAL_8): detachable WIKI_SECTION_NODE
		do
			if attached items as l_items and then not l_items.is_empty then
				Result := l_items.last
				if Result.level >= lev then
					Result := Void
				end
			end
		end

feature -- Query	

	item_for_section (a_section: WIKI_SECTION): detachable WIKI_SECTION_NODE
		local
			lev: NATURAL_8
			t: detachable WIKI_SECTION_NODE
		do
			lev := level
			if a_section.level <= lev then
				from
					Result := Current
				until
					Result = Void or else Result.level <= a_section.level - 1
				loop
					Result := Result.parent
				end
			else
				Result := Current
			end
			if Result /= Void then
				from
				until
					Result.level = a_section.level - 1
				loop
					t := Result.last_item_at_level (a_section.level)
					if t = Void then
						create t.make (Void)
						Result.extend (t)
					end
					Result := t
				end
				if Result.level = a_section.level - 1 then
				else
					check False end
					Result := Void
				end
			end
		end

feature -- Element change

	set_parent (p: like parent)
		do
			parent := p
			if p /= Void then
				level := p.level + 1
			end
		end

	extend (t: WIKI_SECTION_NODE)
		local
			l_items: like items
		do
			t.set_parent (Current)
			l_items := items
			if l_items = Void then
				create l_items.make (1)
				items := l_items
			end
			l_items.force (t)
		end

	extend_section (a_new_section: WIKI_SECTION)
		require
			attached section as l_section implies l_section.level + 1 = a_new_section.level
		do
			extend (create {WIKI_SECTION_NODE}.make (a_new_section))
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (0)
			Result.append ("<")
			Result.append (level.out)
			Result.append ("> ")
			if attached section as s then
				Result.append (s.debug_output)
			end
		end

invariant

note
	copyright: "2011-2018, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
