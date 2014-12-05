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
		require
			starts_with_curly_bracket_and_pipe: s.starts_with ("{|")
			ends_with_pipe_and_curly_bracket: s.ends_with ("|}")
		do
			initialize
			set_text (s)
		end

feature -- Access

	text: WIKI_STRING

	caption: detachable WIKI_STRING
			-- |+

	style: detachable STRING
			-- Table style  {| style |-

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := text.is_empty
		end

feature -- Change

	set_text (t: STRING)
		local
			i,n,p: INTEGER
			r: detachable WIKI_TABLE_ROW
			cl: detachable WIKI_TABLE_CELL
			s: STRING
			l_is_header_cell: BOOLEAN
			l_was_sep: BOOLEAN
			l_style,l_caption: detachable STRING
			l_modifier: detachable STRING
			l_is_sep: BOOLEAN
			l_stack: ARRAYED_STACK [READABLE_STRING_8]
		do
			create text.make (t)
			from
				create l_stack.make (1)
				i := 1 + 2  -- 2="{|"
				n := t.count - 2 --| skip last "|}"
				create s.make_empty
			until
				i > n
			loop
				if not l_stack.is_empty then
					if safe_character (t, i) = '|' and then safe_character (t, i+1) = '}' then
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
						if not l_stack.is_empty and then l_stack.item.same_string ("table") then
							l_stack.remove
						else
								-- closing table without starting table
						end
					elseif safe_character (t, i) = '{' and then safe_character (t, i + 1) = '|' then
						l_stack.force ("table")
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
					elseif safe_character (t, i) = ']' and then safe_character (t, i+1) = ']' then
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
						if not l_stack.is_empty and then l_stack.item.same_string ("link") then
							l_stack.remove
						else
								-- closing link without starting table
						end
					elseif safe_character (t, i) = '[' and then safe_character (t, i + 1) = '[' then
						l_stack.force ("link")
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
					elseif safe_character (t, i) = '}' and then safe_character (t, i+1) = '}' then
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
						if not l_stack.is_empty and then l_stack.item.same_string ("tpl") then
							l_stack.remove
						else
								-- closing template without starting table
						end
					elseif safe_character (t, i) = '{' and then safe_character (t, i + 1) = '{' then
						l_stack.force ("tpl")
						s.extend (t[i])
						i := i + 1
						s.extend (t[i])
					else
						s.extend (t[i])
					end
				elseif safe_character (t, i) = '{' and then safe_character (t, i + 1) = '|' then
					l_stack.force ("table")
					s.extend (t[i])
					i := i + 1
					s.extend (t[i])
				elseif safe_character (t, i) = '[' and then safe_character (t, i + 1) = '[' then
					l_stack.force ("link")
					s.extend (t[i])
					i := i + 1
					s.extend (t[i])
				elseif safe_character (t, i) = '{' and then safe_character (t, i + 1) = '{' then
					l_stack.force ("tpl")
					s.extend (t[i])
					i := i + 1
					s.extend (t[i])
				elseif safe_character (t, i) = '|' and safe_character (t, i + 1) = '+' then
					p := t.index_of ('|', i + 1)
					if p > 0 then
						if l_caption = Void then
							l_caption := t.substring (i + 2, p - 1)
							l_caption.left_adjust
						else
							l_caption.append (t.substring (i + 2, p - 1))
						end
						l_caption.right_adjust
						create caption.make (l_caption)
						i := p - 1
					else
						s.extend (t[i])
					end
				elseif safe_character (t, i) = '|' or safe_character (t, i) = '!' then
					if l_style = Void then
						l_style := s
						create style.make_from_string (s)
						create s.make_empty
					end
					cl := Void
					if safe_character (t, i + 1) = '-' then
						check safe_character (t, i) = '|' end
						if r /= Void then
								-- Previous row handling
							if l_is_header_cell then
								create {WIKI_TABLE_HEADER_CELL} cl.make (s)
							else
								create cl.make (s)
							end
							r.add_element (cl)
						else
							check s.is_whitespace end
						end
							-- New row
						create s.make_empty
						create r.make
						add_element (r)
						l_is_header_cell := False
						l_was_sep := True
						i := i + 1
					else
						l_is_header_cell := safe_character (t, i) = '!'
						if
							safe_character (t, i - 1) = '%N'
							or safe_character (t, i - 1) = '|'
						then
							l_is_sep := True
						elseif
							safe_character (t, i + 1) = '|'
						then
							l_is_sep := True
							i := i + 1
						else
							l_is_sep := False
						end
						if l_is_sep then
								-- Real column separator
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
						else
							if l_modifier = Void then
								create l_modifier.make_from_string (s)
								create s.make_empty
							else
								s.extend ('|')
							end
						end
					end

					if cl /= Void and l_modifier /= Void then
						cl.add_modifier (l_modifier)
						l_modifier := Void
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
