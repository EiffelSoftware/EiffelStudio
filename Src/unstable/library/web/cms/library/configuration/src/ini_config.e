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
				
			Additional features:
			- Include other files:
				@include=file-to-include

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	INI_CONFIG

inherit
	CONFIG_READER

	TABLE_ITERABLE [ANY, READABLE_STRING_GENERAL]

	SHARED_EXECUTION_ENVIRONMENT

create
	make_from_file,
	make_from_string,
	make_from_items

feature {NONE} -- Initialization

	make_from_file (p: PATH)
		do
			initialize
			parse_file (p)
		end

	make_from_string (a_content: STRING_8)
		do
			initialize
			parse_content (a_content)
		end

	make_from_items (a_items: like items)
		do
			initialize
			across
				a_items as ic
			loop
				items.force (ic.item, ic.key)
			end
		end

	initialize
			-- Initialize data.
		do
			associated_path := Void
			create utf
			create items.make (0)
			create sections.make (0)
		end

	reset
			-- Reset internal data.
		do
			has_error := False
			items.wipe_out
			sections.wipe_out
		end

feature -- Status report

	has_item  (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item associated with key `k'?
		do
			Result := item (k) /= Void
		end

	has_error: BOOLEAN
			-- Has error?
			--| Syntax error, source not found, ...

feature -- Access: Config Reader

	utf_8_text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- String item associated with key `k'.	
		do
			if attached text_item (k) as s32 then
				Result := utf.utf_32_string_to_utf_8_string_8 (s32)
			end
		end

	text_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String item associated with key `k'.	
		do
			Result := value_to_string_32 (item (k))
		end

	text_list_item (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- List of String item associated with key `k'.
		do
			if attached {LIST [READABLE_STRING_8]} item (k) as l_list then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (l_list.count)
				Result.compare_objects
				across
					l_list as ic
				until
					Result = Void
				loop
					if attached value_to_string_32 (ic.item) as s32 then
						Result.force (s32)
					else
						Result := Void
					end
				end
			end
		end

	text_table_item (k: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
			-- Table of String item associated with key `k'.
		do
			if attached {STRING_TABLE [READABLE_STRING_8]} item (k) as l_list then
				create {STRING_TABLE [READABLE_STRING_32]} Result.make (l_list.count)
				Result.compare_objects
				across
					l_list as ic
				until
					Result = Void
				loop
					if attached value_to_string_32 (ic.item) as s32 then
						Result.force (s32, ic.key)
					else
						Result := Void
					end
				end
			end
		end

	table_keys (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- <Precursor>
		do
			if attached {STRING_TABLE [like item]} item (k) as l_list then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (l_list.count)
				Result.compare_objects
				across
					l_list as ic
				loop
					Result.force (ic.key.as_string_32)
				end
			end
		end

	integer_item (k: READABLE_STRING_GENERAL): INTEGER
			-- Integer item associated with key `k'.
		do
			if attached {READABLE_STRING_GENERAL} item (k) as s then
				Result := s.to_integer
			end
		end

	associated_path: detachable PATH
			-- If current was built from a filename, return this path.

feature -- Duplication

	sub_config (k: READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration representing a subset of Current for key `k'.
		do
			if attached sections.item (k) as l_items then
				create {INI_CONFIG} Result.make_from_items (l_items)
			end
		end

feature -- Access		

	item (k: READABLE_STRING_GENERAL): detachable ANY
			-- Value associated with key `k'.
		local
			i: INTEGER
			s,sk: detachable READABLE_STRING_GENERAL
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
					end
					if Result = Void then
						i := k.index_of ('.', i + 1)
						if i > 0 then
								-- There is another dot .. could be due to include
							across
								sections as ic
							until
								Result /= Void
							loop
								s := ic.key
									-- If has other dot, this may be in sub sections ...
								if s.has ('.') and then k.starts_with (s) and then k[s.count + 1] = '.' then
									if attached sections.item (s) as l_section then
										sk := k.substring (s.count + 2, k.count)
										Result := l_section.item (sk)
										if Result = Void then
											Result := item_from_values (l_section, sk)
										end
									end
								end
							end
						end
						if Result = Void then
								-- otherwise in values object.
							Result := item_from_values (items, k)
						end
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

	value_to_string_32 (obj: detachable ANY): detachable STRING_32
		do
			if attached {READABLE_STRING_32} obj as s32 then
				Result := s32
			elseif attached {READABLE_STRING_8} obj as s then
				Result := utf.utf_8_string_8_to_escaped_string_32 (s)
			end
		end

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

	parse_content (a_content: STRING_8)
		local
			i,j,n: INTEGER
			s: STRING_8
		do
			last_section_name := Void
			from
				i := 1
				n := a_content.count
			until
				i > n
			loop
				j := a_content.index_of ('%N', i)
				if j > 0 then
					s := a_content.substring (i, j - 1)
					i := j + 1
					if i <= n and then a_content[i] = '%R' then
						i := i + 1
					end
				else
					j := n
					s := a_content.substring (i, j)
					i := j + 1
				end
				analyze_line (s, Void)
			variant
				i
			end
			last_section_name := Void
		rescue
			last_section_name := Void
			has_error := True
		end

	parse_file (p: PATH)
		do
			associated_path := p
			last_section_name := Void
			import_path (p, Void)
			last_section_name := Void
		end

	import_path (p: PATH; a_section_prefix: detachable READABLE_STRING_32)
			-- Import config from path `p'.
		local
			f: PLAIN_TEXT_FILE
			l_last_section_name: like last_section_name
			retried: BOOLEAN
			l_old_associated_path: like associated_path
		do
			l_old_associated_path := associated_path
			if retried then
				has_error := True
			else
				associated_path := p
				l_last_section_name := last_section_name
				last_section_name := Void
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					f.open_read
					from
					until
						f.exhausted or f.end_of_file
					loop
						f.read_line_thread_aware
						analyze_line (f.last_string, a_section_prefix)
					end
					f.close
				else
						-- File not readable
					has_error := True
				end
			end
			last_section_name := l_last_section_name
			associated_path := l_old_associated_path
		rescue
			retried := True
			retry
		end

	analyze_line (a_line: STRING_8; a_section_prefix: detachable READABLE_STRING_32)
			-- Analyze line `a_line'.
		local
			k,sk: STRING_32
			v: STRING_8
			obj: detachable ANY
			lst: LIST [STRING_8]
			tb: STRING_TABLE [STRING_8]
			i,j: INTEGER
			p: PATH
			l_section_name: like last_section_name
		do
			obj := Void
			a_line.left_adjust
			if
				a_line.is_empty
				or a_line.is_whitespace
				or a_line.starts_with_general ("#")
				or a_line.starts_with_general (";")
				or a_line.starts_with_general ("--")
			then
					-- Ignore
			elseif a_line.starts_with_general ("[") then
				i := a_line.index_of (']', 1)
				l_section_name := utf.utf_8_string_8_to_string_32 (a_line.substring (2, i - 1))
				l_section_name.left_adjust
				l_section_name.right_adjust
				if a_section_prefix /= Void then
					l_section_name.prepend_character ('.')
					l_section_name.prepend (a_section_prefix)
				end
				last_section_name := l_section_name
			else
				i := a_line.index_of ('=', 1)
				if i > 1 then
					k := utf.utf_8_string_8_to_string_32 (a_line.head (i - 1))
					k.right_adjust
					v := a_line.substring (i + 1, a_line.count)
					v.left_adjust
					v.right_adjust


					if k.is_case_insensitive_equal_general ("@include") then
						create p.make_from_string (v)
						if not p.is_absolute and attached associated_path as l_path then
							p := l_path.parent.extended_path (p)
						end
						import_path (p, last_section_name)
					else
						i := k.index_of ('[', 1)
						if i > 0 then
							j := k.index_of (']', i + 1)
							if j = i + 1 then -- ends_with "[]"
								k.keep_head (i - 1)
								if
									a_section_prefix /= Void and then
									attached {LIST [STRING_8]} items.item (a_section_prefix + {STRING_32} "." + k) as l_list
								then
									lst := l_list
								elseif
									attached last_section_name as l_section_prefix and then
									attached {LIST [STRING_8]} items.item (l_section_prefix + {STRING_32} "." + k) as l_list
								then
									lst := l_list
								elseif attached {LIST [STRING_8]} items.item (k) as l_list then
									lst := l_list
								else
									create {ARRAYED_LIST [STRING_8]} lst.make (1)
									record_item (lst, k, a_section_prefix)
								end
								lst.force (v)
								obj := lst
							elseif j > i then
									-- table
								sk := k.substring (i + 1, j - 1)
								sk.left_adjust
								sk.right_adjust
								k.keep_head (i - 1)
								if
									a_section_prefix /= Void and then
									attached {STRING_TABLE [STRING_8]} items.item (a_section_prefix + {STRING_32} "." + k) as l_table
								then
									tb := l_table
								elseif
									attached last_section_name as l_section_prefix and then
									attached {STRING_TABLE [STRING_8]} items.item (l_section_prefix + {STRING_32} "." + k) as l_table
								then
									tb := l_table
								elseif attached {STRING_TABLE [STRING_8]} items.item (k) as l_table then
									tb := l_table
								else
									create tb.make (1)
									record_item (tb, k, a_section_prefix)
								end
								tb.force (v, sk)
								obj := tb
							else
									-- Error missing closing ']'
								has_error := True
							end
						else
							record_item (v, k, a_section_prefix)
							obj := v
						end

						if attached last_section_name as l_session and then obj /= Void then
							record_in_section (obj, k, l_session)
						end
					end
				else
						-- Error
					has_error := True
				end
			end
		end

	record_item (v: ANY; k: READABLE_STRING_32; a_section_prefix: detachable READABLE_STRING_32)
		do
			if a_section_prefix /= Void then
				items.force (v, a_section_prefix + {STRING_32} "." + k)
			else
				items.force (v, k)
			end
		end

feature {NONE} -- Implementation

	last_section_name: detachable STRING_32

	utf: UTF_CONVERTER

invariant

note
	copyright: "2011-2018, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
