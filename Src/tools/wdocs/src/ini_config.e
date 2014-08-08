note
	description: "[
			Object parsing a .ini file.
			
			Lines starting by '#', or ';', or "--" are comments
			Section are declared using brackets "[section_name]"
			Values are declared as "key = value"
			List values are declared as multiple lines "key[] = value"
			example:
			--------------------
			[first_section]
			one = abc
			
			[second_section]
			two = def			
			lst[] = a
			lst[] = b
			lst[] = c
			
			[third_section]
			three = ghi
			table[a] = foo
			table[b] = bar
			--------------------
			
			Values are accessible from `items' or by section from `sections'
			`item' has smart support for '.'
			
			item ("one") -> abc
			item ("two") -> def
			item ("second_section.two") -> def
			item ("table[b]") -> foo
			item ("table.b") -> foo
			item ("third_section.table[b]") -> foo
			item ("third_section.table.b") -> foo

			notes:
				it is considered that the .ini file is utf-8 encoded
				keys are unicode string
				values are stored UTF-8 string, but one can use unicode_string_item to convert to STRING_32
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	INI_CONFIG

inherit
	TABLE_ITERABLE [ANY, READABLE_STRING_GENERAL]

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (p: PATH)
		do
			parse (p)
		end

feature -- Access

	unicode_string_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		local
			utf: UTF_CONVERTER
			obj: like item
		do
			obj := item (k)
			if attached {READABLE_STRING_32} obj as s32 then
				Result := s32
			elseif attached {READABLE_STRING_8} obj as s then
				Result := utf.utf_8_string_8_to_escaped_string_32 (s)
			end
		end

	item (k: READABLE_STRING_GENERAL): detachable ANY
		local
			i: INTEGER
			s,sk: READABLE_STRING_GENERAL
		do
				-- Try first directly in values
			Result := items.item (k)
			if Result = Void then
					--| If there is a dot
					--| this could be
					--|		section.variable
					--|		variable.name or variable[name]
				i := k.index_of ('.', 1)
				if i > 0 then
					s := k.head (i - 1)
						-- then search first in section
					if attached sections.item (s) as l_section then
						sk := k.substring (i + 1, k.count)
						Result := l_section.item (sk)
						if Result = Void then
							Result := item_from_values (l_section, sk)
						end
					else
							-- otherwise in values object.
						Result := item_from_values (items, k)
					end
				else
						--| Could be
						--| variable[name]
					Result := item_from_values (items, k)
				end
			end
		end

	items: STRING_TABLE [ANY]

	sections: STRING_TABLE [like items]

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [ANY, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation

	item_from_values (a_values: STRING_TABLE [ANY]; k: READABLE_STRING_GENERAL): detachable ANY
		local
			i,j: INTEGER
			s: READABLE_STRING_GENERAL
		do
			Result := a_values.item (k)
			if Result = Void then
				i := k.index_of ('.', 1)
				if i > 0 then
					s := k.head (i - 1)
					if attached {STRING_TABLE [ANY]} a_values.item (s) as l_table then
						Result := l_table.item (k.substring (i + 1, k.count))
					end
				else
					i := k.index_of ('[', 1)
					if i > 0 then
						j := k.index_of (']', i + 1)
						if j = k.count then
							s := k.head (i - 1)
							if attached {STRING_TABLE [ANY]} a_values.item (s) as l_table then
								Result := l_table.item (k.substring (i + 1, j - 1))
							end
						end
					end
				end
			end
		end

	record_in_section (obj: ANY; k: READABLE_STRING_GENERAL; a_section: READABLE_STRING_GENERAL)
		local
			v: detachable like items
		do
			v := sections.item (a_section)
			if v = Void then
				create v.make (1)
				sections.force (v, a_section)
			end
			v.force (obj, k)
		end

	parse (p: PATH)
		local
			f: PLAIN_TEXT_FILE
			k,sk: STRING_32
			s,v: STRING_8
			obj: detachable ANY
			l_section: detachable STRING_32
			lst: LIST [STRING_8]
			tb: STRING_TABLE [STRING_8]
			i,j: INTEGER
			utf: UTF_CONVERTER
		do
			create items.make (0)
			create sections.make (0)
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					obj := Void
					f.read_line_thread_aware
					s := f.last_string
					s.left_adjust
					if s.is_empty or s.starts_with_general ("#") or s.starts_with_general (";") or s.starts_with_general ("--") then
							-- Ignore
					elseif s.starts_with_general ("[") then
						i := s.index_of (']', 1)
						l_section := utf.utf_8_string_8_to_string_32 (s.substring (2, i - 1))
					else
						i := s.index_of ('=', 1)
						if i > 1 then
							k := utf.utf_8_string_8_to_string_32 (s.head (i - 1))
							k.right_adjust

							v := s.substring (i + 1, s.count)
							v.left_adjust
							v.right_adjust

							i := k.index_of ('[', 1)
							if i > 0 then
								j := k.index_of (']', i + 1)
								if j = i + 1 then -- ends_with "[]"
									k.keep_head (i - 1)
									if attached {LIST [STRING_8]} items.item (k) as l_list then
										lst := l_list
									else
										create {ARRAYED_LIST [STRING_8]} lst.make (1)
										items.force (lst, k)
									end
									lst.force (v)
									obj := lst
								elseif j > i then
										-- table
									sk := k.substring (i + 1, j - 1)
									sk.left_adjust
									sk.right_adjust
									k.keep_head (i - 1)
									if attached {STRING_TABLE [STRING_8]} items.item (k) as l_table then
										tb := l_table
									else
										create tb.make (1)
										items.force (tb, k)
									end
									tb.force (v, sk)
									obj := tb
								else
									-- Error missing closing ']'
								end
							else
								items.force (v, k)
								obj := v
							end

							if l_section /= Void and then obj /= Void then
								record_in_section (obj, k, l_section)
							end
						else
								-- Error
						end
					end
				end
				f.close
			end
		end

end
