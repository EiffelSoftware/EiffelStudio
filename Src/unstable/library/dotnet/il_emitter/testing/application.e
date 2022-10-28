note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			mp: MANAGED_POINTER
			l_val: INTEGER
			l_cell: CELL [INTEGER]
			l_api: CIL_EMITTER_API
		do
--			l_val := 1
--			create l_cell.put (l_val)
--			fn (l_cell)
--			create mp.make (8)
--			mp.put_real_32 (3.5, 0)
--			across mp.read_array (0, 4) as ic loop
--				print (ic.to_hex_String)
--				io.put_new_line
--			end

--			print (escaped_string ("Do you wish to send anyway?"))
--			io.put_new_line
--			print (escaped_string ("In the last decade, the German word %"über%" has come to be used frequently in colloquial English."))

--			test4;
--			test;
--			test_2;
--			test_3;
--			(create {TEST_1}).test;
--			(create {TEST_2}).test;
--			(create {TEST_3}).test;
--			(create {TEST_4}).test;
--			(create {TEST_5}).test;
--			(create {TEST_6}).test;
--			(create {TEST_7}).test;
			(create {TEST_8}).test;
		end

	test
		local
			list: LIST [INTEGER]
			found: BOOLEAN
		do
			create {ARRAYED_LIST [INTEGER]} list.make_from_array (<<2, 5, 6, 7, 8, 9>>)
			across list as i until found loop
				if i = 6 then
					found := True
				end
				print (i.out)
			end

			across list as i until found loop
				if i = 6 then
					list.prune (i)
				end
			end

			list.do_all (agent (item: INTEGER) do print ("%N" + item.out) end)

			across list as i loop
				print ("%NCursor index" + (@ i.cursor_index).out)
				print (" - Value: " + i.out)
			end

		end

	test_2
		local
			l_list: LIST [STRING_32]
		do
			l_list := (create {PE_LIB}.make ("", 0)).split_path ("System::Console.WriteLine")
			l_list := (create {PE_LIB}.make ("", 0)).split_path ("System.IO.FileStream..ctor")
		end

	test_3
		local
			l_seh: CIL_SEH
			l_special: ARRAYED_LIST [CIL_SEH]
		do
			l_seh := {CIL_SEH}.seh_try
			create {ARRAYED_LIST [CIL_SEH]} l_special.make_from_iterable ({CIL_SEH}.instances)
			print ("Position" + l_special.area.index_of (l_seh, l_special.area.lower).out)
		end

	test4
		local
			str: STRING_32
			cursor: STRING_ITERATION_CURSOR
			l_exit: BOOLEAN
		do
			str := "Eiffel Programming Language"
			create cursor.make (str)

			across cursor as ic loop
				print (ic.code.out)
				io.put_new_line
			end
			print ("%N===============%N")
			across str as i until l_exit loop
				print (i.code.out)
				io.put_new_line
				if i = 'P' then
					l_exit := True
				end
			end
			print ({UTF_CONVERTER}.string_32_to_utf_8_string_8 ("Do you wish to send anyway?"))
			IO.put_new_line
			print ({UTF_CONVERTER}.string_32_to_utf_8_string_8 ("In the last decade, the German word %"über%" has come to be used frequently in colloquial English."))
		end

	escaped_string (string_value: STRING_32): STRING_32
		local
			l_doit: BOOLEAN
			l_ret_val: STRING_32
			l_item: INTEGER_32
			l_ch: CHARACTER_32
			l_a: CHARACTER_32
			l_b: CHARACTER_32
			l_f: CHARACTER_32
			l_n: CHARACTER_32
			l_r: CHARACTER_32
			l_v: CHARACTER_32
			l_t: CHARACTER_32
			l_0: CHARACTER_32
		do
			l_a := '%A'
			l_b := '%B'
			l_f := '%F'
			l_n := '%N'
			l_r := '%R'
			l_v := '%V'
			l_t := '%T'
			l_0 := '0'

			create l_ret_val.make_empty
			across string_value as i until l_doit loop
				if i.code < 32 or else i.code > 126 or else i = '\' or else i = '"' then
					l_doit := True
				end
			end
			if l_doit then
				across string_value as i loop
					l_item := i.code & 0xff
					if l_item < 32 then

						if l_a.code = l_item then
							l_ch := 'a'
							l_item := l_ch.code
						elseif l_b.code = l_item then
							l_ch := 'b'
							l_item := l_ch.code
						elseif l_f.code = l_item then
							l_ch := 'f'
							l_item := l_ch.code
						elseif l_n.code = l_item then
							l_ch := 'n'
							l_item := l_ch.code
						elseif l_r.code = l_item then
							l_ch := 'r'
							l_item := l_ch.code
						elseif l_v.code = l_item then
							l_ch := 'v'
							l_item := l_ch.code
						elseif l_t.code = l_item then
							l_ch := 't'
							l_item := l_ch.code
						end

						if l_item < 32 then
							l_ret_val.append ("\0")
							l_ret_val.append_character ((l_item // 8 + l_0.code).to_character_32)
							l_ret_val.append_character ((l_item & 7 + l_0.code).to_character_32)
						else
							l_ret_val.append ("\")
							l_ret_val.append_character (l_item.to_character_32)
						end
					elseif l_item.to_character_32 = '"' or else l_item.to_character_32 = '%H' then
						l_ret_val.append ("\")
						l_ret_val.append_character (l_item.to_character_32)
					elseif l_item > 126 then
						l_ret_val.append ("\")
						l_ret_val.append_character ((l_item // 64 + l_0.code).to_character_32)
						l_ret_val.append_character (((l_item // 8) & 7 + l_0.code).to_character_32)
						l_ret_val.append_character ((l_item & 7 + l_0.code).to_character_32)
					else
						l_ret_val.append_character (l_item.to_character_32)
					end
				end
				Result := l_ret_val
			else
				Result := string_value
			end
		end

	fn (val: CELL [INTEGER])
		local
			l_test: INTEGER

		do
			val.put (val.item + 5)
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
