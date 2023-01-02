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
			time: TIME
		do
			test_pe_version_string({STRING_32}"FileVersion", "1.1.0.1")
			--test_pe_version_string({STRING_32}"FileDescription", " ")
			text_hexadecimal_value
			test_path_entries
			test_pe_strings_32
			test_pe_naturals
			test_pe_reader
			test_pe_import_dir
			test_pe_write_string
			test_byte_array_to_string
			file_test
			test_natural_64
			test_byte_array
			test_guid;
			(create {TEST_1}).test;
			(create {TEST_2}).test;
			(create {TEST_3}).test;
			(create {TEST_4}).test;
			(create {TEST_5}).test;
			(create {TEST_6}).test;
			(create {TEST_7}).test;
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
			print ({UTF_CONVERTER}.string_32_to_utf_8_string_8 ("In the last decade, the German word %"�ber%" has come to be used frequently in colloquial English."))
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

	compute_size: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_HEADER
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {INTEGER_16} l_field then
						Result := Result + {PLATFORM}.integer_16_bytes
					elseif attached {NATURAL_8} l_field then
						Result := Result + {PLATFORM}.natural_8_bytes
					end
				end
			end
		end

	compute_pe_object_size: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_OBJECT
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {STRING} l_field as l_str then
						Result := Result + l_str.capacity
					elseif attached {ARRAY [INTEGER]} l_field as l_arr then
						Result := Result + (l_arr.count * {PLATFORM}.integer_32_bytes)
					end
				end
			end
		end

	number_of_seconds_since_epoch: INTEGER_32
			-- calculate the number of seconds since epoch in eiffel
		local
			l_date_epoch: DATE_TIME
			l_date_now: DATE_TIME
			l_diff: INTEGER_32
		do
			create l_date_epoch.make_from_epoch (0)
			create l_date_now.make_now_utc
			Result := l_date_now.definite_duration (l_date_epoch).seconds_count.to_integer
		ensure
			is_class: class
		end

feature -- Test Path

	test_path_entries
		local
			l_file_name: STRING_32
			l_path: PATH
			n: INTEGER
		do
			--l_file_name := {STRING_32}"C:\\Documents\\Newsletters\\Summer2018.pdf"
			l_file_name := {STRING_32}"Summer2018.pdf"
			create l_path.make_from_string (l_file_name)
			n := l_path.components.count
			l_file_name := l_path.components[n].name
		end

feature -- C Byte Array

	test_byte_array
		local
			l_arr, l_arr2: ARRAY [NATURAL_8]
			l_mp: MANAGED_POINTER
			l_special: SPECIAL [NATURAL_8]

		do
			l_arr := <<0,0,0,0,0,0,0,0>>
			l_special := l_arr.to_special
			create l_mp.make_from_array (l_arr)
			l_mp.put_integer_32 (2147483646, 0)
			l_arr := l_mp.read_array (0, 8)
			{BYTE_ARRAY_HELPER}.put_array_integer_32 (l_special, 2147483646, 0)

			l_arr := <<0,0,0,0,0,0,0,0>>
			{BYTE_ARRAY_HELPER}.put_array_integer_32 (l_arr.to_special, 26, 0)
		end

	test_byte_array_to_string
		local
			l_arr: ARRAY [NATURAL_8]
			l_bc: BYTE_ARRAY_CONVERTER
			str: STRING_32

		do
			create l_bc.make_from_string ("This is an apple")
			l_arr := l_bc.to_natural_8_array

			create str.make (l_arr.count)
			across 1 |..| l_arr.count as i loop
				str.append_character (l_arr[i].to_character_8)
			end
			print (str)

		end


	test_natural_64
		local
			l_val: NATURAL_64
			l_sp: SPECIAL [NATURAL_8]
			l_mp: MANAGED_POINTER
		do
			create l_sp.make_filled (0, 8)
			fun_test (l_sp)
			create l_mp.make_from_array (l_sp.to_array)
			l_val := l_mp.read_natural_64 (0)
		end


	fun_test (a_arr: SPECIAL [NATURAL_8])
		do
			{BYTE_ARRAY_HELPER}.put_array_integer_32 (a_arr, 2 | (27 |<< 24) , 0)
		end


	file_test
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write ("test.txt")

			l_file.put_string ("This is an apple")
			l_file.go (l_file.count -7)
			l_file.put_string (" sam")
			l_file.close
		end


	text_hexadecimal_value
		local
			l_file: RAW_FILE
			l_fmt_int: FORMAT_INTEGER
			language: NATURAL_32
			l_buf: STRING_32
		do
			create l_file.make_create_read_write ("eiffel_test.bin")
			language := 0x4b0
			l_buf := language.to_hex_string.to_string_32
			l_buf.append_character ('%U')
			put_string_32 (l_buf, l_file)
			l_file.close
		end

	put_string_32 (a_str: READABLE_STRING_32; a_file: RAW_FILE)
		do
			across 1 |..| a_str.count as i loop a_file.put_natural_32 (a_str.code (i)) end
		end

feature -- PE Reader

	test_pe_reader
		local
			l_reader: PE_READER
		do
			create l_reader.make
		end

feature -- PE Writer tests

	test_pe_version_string (a_name: STRING_32; a_value: STRING)
		local
			l_file: RAW_FILE
			n1: NATURAL_16
			n: NATURAL_32
			l_buf: STRING_32
			l_name: STRING_32
			l_index: INTEGER
		do
			print (a_name.substring (1, a_name.count))
			create l_file.make_create_read_write ("eiffel_test.bin")

			n1 := (a_name.count * 2 + a_value.count * 2 + 6 + 2 + 2).to_natural_16
			n := (a_name.count + 2).to_natural_32
			if n \\ 4 /= 0 then
				n1 := n1 + (n - n \\ 4).to_natural_16
			end
			n := ((a_value.count + 1) * 2).to_natural_32
			if n \\ 4 /= 0 then
				n1 := n1 + (n - n \\ 4).to_natural_16
			end
			l_file.put_natural_16 (n1)

			n1 := ((a_value.count + 1) * 2).to_natural_16
			l_file.put_natural_16 (n1)
			create l_buf.make_from_string_general (a_value)
			l_buf.append_character ('%U')
			n1 := 1
			l_file.put_natural_16 (n1)


				-- put_wide_character.
			create l_name.make_from_string_general (a_name)
			l_name.append_character ('%U')
			l_index := l_name.count // 2
			across 1 |..| l_index as i loop
				l_file.put_natural_16 (l_name.code (i).to_natural_16)
			end
			l_file.put_character (l_name.at (l_index + 1).to_character_8)

			n1 := 1
			across 1 |..| ((n1*2).to_integer_32 - 1) as  i loop
				l_file.put_natural_16 (l_buf.code (i).to_natural_16)
			end

			l_file.close
		end


	test_pe_strings_32
		local
			l_file: RAW_FILE
			l_converter: UTF_CONVERTER
			l_string: STRING_32
			l_arr: SPECIAL [NATURAL_8]
		do
			l_string := {STRING_32}"V"
			create l_file.make_create_read_write ("eiffel_test.bin")
			across 1 |..| l_string.count as i loop
				l_file.put_natural_32 (l_string.code (i))
			end
			l_file.close
		end


	test_pe_naturals
		local
			l_file: RAW_FILE
			l_val: NATURAL_32
		do
			l_val := 0
			create l_file.make_create_read_write ("eiffel_test.bin")
			l_file.put_natural_16 (l_val.to_natural_16)
			l_val :=0x25ff
			l_file.put_natural_16 (l_val.to_natural_16)
			l_file.close
		end

	test_pe_import_dir
		local
			l_file: RAW_FILE
			l_dir: ARRAY [PE_IMPORT_DIR]
			l_item: NATURAL_32
			l_main_name: NATURAL_32
			l_mp: MANAGED_POINTER
		do
			create l_dir.make_filled (create{PE_IMPORT_DIR}, 1,2)
			l_dir [1] := (create {PE_IMPORT_DIR})
			l_dir [1].thunk_pos2 := 10 + 2 * {PE_IMPORT_DIR}.size_of
			l_item := (l_dir [1].thunk_pos2 + 8).to_natural_32
			if l_item \\ 16 /= 0 then
				l_item := l_item + 16 - (l_item \\ 16)
			end
			l_main_name := l_item
			l_item := l_item + 2
			l_item := l_item + 12  -- in C++ sizeof("_CorXXXMain");
			l_dir [1].dll_name := l_item.to_integer_32
			l_dir [1].thunk_pos := 10

			create l_file.make_create_read_write ("eiffel_test.bin")

			create l_mp.make (0)
			across l_dir as dir loop
				l_mp.append (dir.managed_pointer)
			end

			l_file.put_managed_pointer (l_mp, l_file.count, l_mp.count)
			l_file.close
		end


	test_pe_write_string
		local
			l_file: RAW_FILE
			l_str: STRING
		do
			l_str := "#Strings"
			l_str.append_character('%U')
			create l_file.make_create_read_write ("eiffel_test.bin")

			l_file.put_string (l_str)
			l_file.close
		end



feature -- GUID

	test_guid
		local
			l_guid: ARRAY [NATURAL_8]
		do
			create l_guid.make_filled (0, 1, 16)
			create_guid (l_guid)
		end

	create_guid (a_guid: ARRAY [NATURAL_8])
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make (16)
			c_create_guid (l_mp.item)
			a_guid.make_from_array (l_mp.read_array (0, 16))
		end

	c_create_guid (a_guid: POINTER)
		external "C++ inline use <random>, <random>, <array>, <algorithm>, <functional>"
		alias
			"{
			std::array<unsigned char, 128 / 8> rnd;

		    std::uniform_int_distribution<int> distribution(0, 0xff);
		    // note that this whole thing will fall apart if the C++ lib uses
		    // a prng with constant seed for the random_device implementation.
		    // that shouldn't be a problem on OS we are interested in.
		    std::random_device dev;
		    std::mt19937 engine(dev());
		    auto generator = std::bind(distribution, engine);

		    std::generate(rnd.begin(), rnd.end(), generator);

		    // make it a valid version 4 (random) GUID
		    // remember that on windows GUIDs are native endianness so this may need
		    // work if you port it
		    rnd[7 /*6*/] &= 0xf;
		    rnd[7 /*6*/] |= 0x40;
		    rnd[9 /*8*/] &= 0x3f;
		    rnd[9 /*8*/] |= 0x80;

		    memcpy($a_guid, rnd.data(), rnd.size());
			}"
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
