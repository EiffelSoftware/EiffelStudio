note
	description: "[
			Summary description for {WIKI_TABLE}.
			
			{| border="1" cellspacing="0" cellpadding="5" align="center"
			! This
			! is
			|- 
			| a
			| table
			|}
			
			renders
			
			This    |   is               (first row in bold)
			-----------------
			a       | table

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TABLE

inherit
	WIKI_BOX [WIKI_TABLE_ROW]
		redefine
			process
		end

	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
		do
			initialize
			set_text (s)
		end

feature -- Access

	text: WIKI_STRING

	style: detachable STRING
			-- Table style  {| style |-

feature -- Change

	set_text (t: STRING)
		local
			i,n: INTEGER
			tbls_level: INTEGER
			r: detachable WIKI_TABLE_ROW
			cl: WIKI_TABLE_CELL
			s: STRING
			l_is_header_cell: BOOLEAN
			l_was_sep: BOOLEAN
			l_style: detachable STRING
		do
			create text.make (t)
			from
				i := 1
				n := t.count
				create s.make_empty
			until
				i > n
			loop
				if tbls_level > 0 then
					if safe_character (t, i) = '|' and then safe_character (t, i+1) = '}' then
						tbls_level := tbls_level - 1
					else
						s.extend (t[i])
					end
				elseif safe_character (t, i) = '{' and then safe_character (t, i + 1) = '|' then
					tbls_level := tbls_level + 1
				elseif safe_character (t, i) = '|' or safe_character (t, i) = '!' then
					if l_style = Void then
						l_style := s
						create style.make_from_string (s)
						create s.make_empty
					end
					if safe_character (t, i + 1) = '-' then
						check safe_character (t, i) = '|' end
						if r /= Void then
							if l_is_header_cell then
								create {WIKI_TABLE_HEADER_CELL} cl.make (s)
							else
								create cl.make (s)
							end
							r.add_element (cl)
						else
							check s.is_whitespace end
						end
						create s.make_empty
						create r.make
						add_element (r)
						l_is_header_cell := False
						l_was_sep := True
						i := i + 1
					else
						l_is_header_cell := safe_character (t, i) = '!'
						if r = Void then
							check has_row: False end
							create r.make
							add_element (r)
						elseif not s.is_empty then
							if not l_was_sep then
								if l_is_header_cell then
									create {WIKI_TABLE_HEADER_CELL} cl.make (s)
								else
									create cl.make (s)
								end
								r.add_element (cl)
							end
						end
						create s.make_empty
						l_was_sep := False
					end
				else
					s.extend (t[i])
				end
				i := i + 1
			end
			if not s.is_empty then
				if r = Void then
					create r.make
					add_element (r)
				end
				create cl.make (s)
				r.add_element (cl)
				create s.make_empty
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_table (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
