note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature -- Testing

	default_tests: ARRAY [READABLE_STRING_GENERAL]
		once
			Result := {ARRAY [READABLE_STRING_GENERAL]} <<"tk.empty_assembly">>
		end

	process_test (tn: READABLE_STRING_GENERAL)
		local
			curr: PATH
		do
			curr := execution_environment.current_working_path

			pre_test (tn)
			if tn.starts_with ("tk.") then
				test_metadata_tables_token_interface (tn.substring (4, tn.count))
			elseif tn.starts_with ("om.") then
				test_metadata_tables_object_model (tn.substring (4, tn.count))
			else
				old_tests (tn) --"test_11")
			end
			post_test (tn)

			execution_environment.change_working_path (curr)
		rescue
			if attached curr then
				execution_environment.change_working_path (curr)
			end
		end

feature -- Token tests		

	test_metadata_tables_token_interface (a_pattern: READABLE_STRING_GENERAL)
		do
			if is_test_included ("cli_directory_size", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_cli_directory_size;
			end
			if is_test_included ("cli_header_size", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_cli_header_size;
			end
			if is_test_included ("user_string_heap", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_user_string_heap;
			end
			if is_test_included ("empty_assembly", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_empty_assembly;
			end
			if is_test_included ("define_assembly", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_define_assembly;
			end
			if is_test_included ("define_module", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_define_module;
			end
			if is_test_included ("define_module_net6", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_define_module_net6;
			end
			if is_test_included ("define_method_net2", a_pattern) then
				(create {TEST_METADATA_TABLES_TK}).test_define_method_net2;
			end
		end

feature -- Object model tests		

	test_metadata_tables_object_model (a_pattern: READABLE_STRING_GENERAL)
		do
			if is_test_included ("empty_assembly", a_pattern) then
				(create {TEST_METADATA_TABLES_OM}).test_empty_assembly;
			end
--			if is_test_included ("define_assembly", a_pattern) then
--				(create {TEST_METADATA_TABLES_OM}).test_define_assembly;
--			end
		end

feature -- Initialization

	make
		local
			tn: READABLE_STRING_GENERAL
			i, n: INTEGER
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			tests: ITERABLE [READABLE_STRING_GENERAL]
		do
			n := argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					tn := argument (i)
					if tn.starts_with ("-") then
						if tn.starts_with ("--testdir") then
							is_using_sub_directory_per_test := True
							if i < n then
								create test_directory.make_from_string (argument (i + 1))
								i := i + 1
							else
								create test_directory.make_current
							end
						end
						-- Ignore for now
					else
						if lst = Void then
							create lst.make (n)
						end
						lst.extend (tn)
					end
					i := i + 1
				end
			end
			if lst = Void then
					-- Default
				tests := default_tests
			else
				tests := lst
			end
			across
				tests as ic
			loop
				tn := ic
				process_test (tn)
			end
		end

feature -- Old tests		

	old_tests (a_pattern: READABLE_STRING_GENERAL)
			-- Run application.
		local
			mp: MANAGED_POINTER
			l_val: INTEGER
			l_cell: CELL [INTEGER]
			time: TIME
		do
			if is_test_included ("big_digits", a_pattern) then
				test_big_digits
			end
			if is_test_included ("copy_arrays", a_pattern) then
				test_copy_arrays
			end
			if is_test_included ("array_wrapped_code", a_pattern) then
				test_array_wrapped_code
			end
			if is_test_included ("arrays", a_pattern) then
				test_arrays
			end
			if is_test_included ("string_to_buf", a_pattern) then
				test_string_to_buf
			end
			if is_test_included ("pe_version_string", a_pattern) then
				test_pe_version_string ({STRING_32} "FileVersion", "1.1.0.1")
--				test_pe_version_string ({STRING_32} "FileDescription", " ")
			end
			if is_test_included ("hexadecimal_value", a_pattern) then
				text_hexadecimal_value
			end
			if is_test_included ("path_entries", a_pattern) then
				test_path_entries
			end
			if is_test_included ("pe_strings_32", a_pattern) then
				test_pe_strings_32
			end
			if is_test_included ("pe_naturals", a_pattern) then
				test_pe_naturals
			end
			if is_test_included ("pe_reader", a_pattern) then
				test_pe_reader
			end
			if is_test_included ("pe_import_dir", a_pattern) then
				test_pe_import_dir
			end
			if is_test_included ("pe_write_string", a_pattern) then
				test_pe_write_string
			end
			if is_test_included ("byte_array_to_string", a_pattern) then
				test_byte_array_to_string
			end
			if is_test_included ("test", a_pattern) then
				file_test
			end
			if is_test_included ("natural_64", a_pattern) then
				test_natural_64
			end
			if is_test_included ("byte_array", a_pattern) then
				test_byte_array
			end
			if is_test_included ("guid", a_pattern) then
				test_guid;
			end
			if is_test_included ("test_1", a_pattern) then
				(create {TEST_1}).test;
			end
			if is_test_included ("test_2", a_pattern) then
				(create {TEST_2}).test;
			end
			if is_test_included ("test_3", a_pattern) then
				(create {TEST_3}).test;
			end
			if is_test_included ("test_4", a_pattern) then
				(create {TEST_4}).test;
			end
			if is_test_included ("test_5", a_pattern) then
				(create {TEST_5}).test;
			end
			if is_test_included ("test_6", a_pattern) then
				(create {TEST_6}).test;
			end
			if is_test_included ("test_7", a_pattern) then
				(create {TEST_7}).test;
			end
			if is_test_included ("test_8", a_pattern) then
				(create {TEST_8}).test;
			end
			if is_test_included ("test_9", a_pattern) then
				(create {TEST_9}).test;
			end
			if is_test_included ("test_10", a_pattern) then
				(create {TEST_10}).test;
			end
			if is_test_included ("test_11", a_pattern) then
--FIXME				(create {TEST_11}).test;
			end
			if is_test_included ("random", a_pattern) then
				test_random
			end
			if is_test_included ("test_12", a_pattern) then
--FIXME				(create {TEST_12}).test;
			end

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
			l_list := (create {PE_LIB}.make_with_name ("", 0)).split_path ("System::Console.WriteLine")
			l_list := (create {PE_LIB}.make_with_name ("", 0)).split_path ("System.IO.FileStream..ctor")
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
			l_file_name := {STRING_32} "Summer2018.pdf"
			create l_path.make_from_string (l_file_name)
			n := l_path.components.count
			l_file_name := l_path.components [n].name
		end

feature -- Test BigDigits

	test_big_digits
		local
			l_result: ARRAY [NATURAL_32]
				-- Array to hold the result of the operation
			l_base: ARRAY [NATURAL_32]
				-- Array holding the base number
			l_exponent: ARRAY [NATURAL_32]
				-- Array holding the exponent
			l_modulus: ARRAY [NATURAL_32]
				-- Array holding the modulus
			l_ndigits: NATURAL_64
				-- Number of digits in the base number.

			l_dis: INTEGER
		do
			create l_result.make_filled (0, 1, 50)
			create l_base.make_filled (0, 1, 50)
			l_base [1] := 9
			create l_exponent.make_filled (0, 1, 50)
			l_exponent [1] := 3
			create l_modulus.make_filled (0, 1, 50)
			l_modulus [1] := 10
			l_ndigits := 1
			l_dis := {CIL_RSA_ENCODER}.c_mp_mod_exp (l_result.area.base_address, l_base.area.base_address, l_exponent.area.base_address, l_modulus.area.base_address, l_ndigits)
			check expected_9: l_result [1] = 9 end
		end

feature -- C Byte Array

	test_byte_array
		local
			l_arr, l_arr2: ARRAY [NATURAL_8]
			l_mp: MANAGED_POINTER
			l_special: SPECIAL [NATURAL_8]

		do
			l_arr := {ARRAY [NATURAL_8]} <<0, 0, 0, 0, 0, 0, 0, 0>>
			l_special := l_arr.to_special
			create l_mp.make_from_array (l_arr)
			l_mp.put_integer_32 (2147483646, 0)
			l_arr := l_mp.read_array (0, 8)
			{BYTE_ARRAY_HELPER}.put_array_integer_32 (l_special, 2147483646, 0)

			l_arr := {ARRAY [NATURAL_8]} <<0, 0, 0, 0, 0, 0, 0, 0>>
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
				str.append_character (l_arr [i].to_character_8)
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
			{BYTE_ARRAY_HELPER}.put_array_integer_32 (a_arr, 2 | (27 |<< 24), 0)
		end

	file_test
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write ("test.txt")

			l_file.put_string ("This is an apple")
			l_file.go (l_file.count - 7)
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

feature -- Test Arrays

	test_copy_arrays
		local
			l_result: ARRAY [NATURAL_8]
			l_pos: INTEGER
			l_tmp: NATURAL_8
		do
			create l_result.make_filled (0, 1, 50)
			l_result.fill_with (0xff)
			l_result [1] := 0
			l_result [2] := 1
			l_pos := l_result.count - 20 - der_header.count
				-- C++ version uses sizeof.
				--|result.size() - 20 - sizeof(DerHeader) - 1;
			l_result [l_pos] := 0
			l_result.subcopy (der_header, 1, der_header.count, l_pos + 1)
			l_pos := l_result.count - 20

				-- reverse it before encryption..
			across 1 |..| (l_result.count // 2) as i loop
				l_tmp := l_result [i]
				l_result [i] := l_result [l_result.count - i]
				l_result [l_result.count - i] := l_tmp
			end
		end

feature -- Static

	der_header: ARRAY [NATURAL_8]
		do
			Result := {ARRAY [NATURAL_8]} <<0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e, 0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14>>
		ensure
			instance_free: class
		end

	test_arrays
		local
			l_arr: ARRAY [NATURAL_8]
			l_arr2: ARRAY [NATURAL_8]
			mp: MANAGED_POINTER
			l_file: RAW_FILE

		do
			create l_file.make_create_read_write ("eif_array.bin")
			create l_arr.make_filled (0, 1, 100)
			create mp.share_from_pointer (l_arr.area.base_address, 100)
			mp.put_natural_32_le (0x2400, 0)
			mp.put_natural_32_le (0x8004, 1 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le ((0x14 + 20 // 8).to_natural_32, 2 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (1, 3 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (2, 4 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (3, 5 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (4, 6 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (5, 7 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (6, 8 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (7, 9 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (8, 10 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (9, 11 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (10, 12 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (11, 13 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (12, 14 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (13, 15 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (14, 16 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (15, 17 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (16, 18 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (17, 19 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (18, 20 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (19, 21 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (20, 22 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (21, 23 * {PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (22, 24 * {PLATFORM}.natural_32_bytes)

				--
			mp.put_character ('1', 23 * {PLATFORM}.natural_32_bytes) --  change to RSA1 (pub key only)
			mp.put_natural_8_le (6, 12 * {PLATFORM}.natural_32_bytes) -- change to pub key only

			print ("%N((char*)dkey)[12 + 0x0b] :=" + mp.read_character (23 * {PLATFORM}.natural_32_bytes).out)
			print ("%N(dkey[12 + 0x0b] :=" + mp.read_natural_32_le (23 * {PLATFORM}.natural_32_bytes).out)
			print ("%N((char*)dkey)[12 + 0] :=" + mp.read_natural_8_le (12 * {PLATFORM}.natural_32_bytes).out)
			print ("%N(dkey[12 + 0] :=" + mp.read_natural_32_le (12 * {PLATFORM}.natural_32_bytes).out)

			l_file.put_managed_pointer (mp, l_file.count, mp.count)
			l_file.close

		end

	test_array_wrapped_code
		local
			l_arr: ARRAY [NATURAL_8]
			l_mp: MANAGED_POINTER
			l_size: NATURAL_64
			l_file: RAW_FILE
		do
			create l_arr.make_filled (0, 1, 100)
				--create l_mp.share_from_pointer (l_arr.area.base_address, 100)
			c_array_wrap_code (l_arr.area.base_address, $l_size, 20)

----			print ("%N((char*)dkey)[12 + 0x0b] :=" + l_mp.read_natural_8_le (23 * {PLATFORM}.natural_32_bytes).out)
----			print ("%N(dkey[12 + 0x0b] :=" + l_mp.read_natural_32_le (23 * {PLATFORM}.natural_32_bytes).out)
----			print ("%N((char*)dkey)[12 + 0] :=" + l_mp.read_natural_8_le (12 * {PLATFORM}.natural_32_bytes).out)
----			print ("%N(dkey[12 + 0] :=" + l_mp.read_natural_32_le (12 * {PLATFORM}.natural_32_bytes).out)

			create l_file.make_create_read_write ("eif_carray.bin")
			l_file.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_arr), l_file.count, l_arr.count)
			l_file.close
		end

	c_array_wrap_code (a_key: POINTER; a_key_size: TYPED_POINTER [NATURAL_64]; a_modulus_bits: NATURAL_64)
		external
			"C++ inline use <iostream>, <fstream>"
		alias
			"[
				{
					typedef uint32_t DIGIT_T;
					DIGIT_T* dkey = (DIGIT_T*)$a_key;
					dkey[0] = 0x2400;
					dkey[1] = 0x8004;
					dkey[2] = 0x14 + $a_modulus_bits / 8;
					//
					//memcpy(dkey + 3, keyPair, dkey[2]);
					//

					// Code for testing
					dkey[2] = 0x14 + $a_modulus_bits / 8;
					dkey[3] = 1;
					dkey[4] = 2;
					dkey[5] = 3;
					dkey[6] = 4;
					dkey[7] = 5;
					dkey[8] = 6;
					dkey[9] = 7;
					dkey[10] = 8;
					dkey[11] = 9;
					dkey[12] = 10;
					dkey[13] = 11;
					dkey[14] = 12;
					dkey[15] = 13;
					dkey[16] = 14;
					dkey[17] = 15;
					dkey[18] = 16;
					dkey[19] = 17;
					dkey[20] = 18;
					dkey[21] = 19;
					dkey[22] = 20;
					dkey[23] = 21;
					dkey[24] = 22;

					((char*)dkey)[12 + 0x0b] = '1';  // change to RSA1 (pub key only)
					((char*)dkey)[12 + 0] = 6;       // change to pub key only
					*($a_key_size) = dkey[2] + 12;

					 std::cout << "dkey[12 + 0x0b] = " << dkey[12 + 0x0b] << std::endl;
					 std::cout << "((char*)dkey)[12 + 0x0b] = " << ((char*)dkey)[12 + 0x0b] << std::endl;

					 std::cout << "dkey[12 + 0] = " << dkey[12 + 0] << std::endl;
					 std::cout << "((char*)dkey)[12 + 0] = " << ((char*)dkey)[12 + 0] << std::endl;

					std::ofstream outfile;
	    			outfile.open("carray_key.bin", std::ios::binary);

					outfile.write(((char*)($a_key)), 100);
    								outfile.close();
    								std::ofstream outfile2;
	    			outfile2.open("carray_dkey.bin", std::ios::binary);

					outfile2.write(((char*)(dkey)), 100);
    								outfile2.close();

				}
			]"
		end

feature -- PE Writer tests

	test_string_to_buf
		local
			l_str: STRING_32
			l_str2: STRING
			l_buf: STRING_32
			l_size: INTEGER
		do

			l_str := {STRING_32} "Hello"
			l_str.append_character ('%U')

		end

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
			across 1 |..| ((n1 * 2).to_integer_32 - 1) as i loop
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
			l_string := {STRING_32} "V"
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
			l_val := 0x25ff
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
			create l_dir.make_filled (create {PE_IMPORT_DIR}, 1, 2)
			l_dir [1] := (create {PE_IMPORT_DIR})
			l_dir [1].thunk_pos2 := 10 + 2 * {PE_IMPORT_DIR}.size_of
			l_item := (l_dir [1].thunk_pos2 + 8).to_natural_32
			if l_item \\ 16 /= 0 then
				l_item := l_item + 16 - (l_item \\ 16)
			end
			l_main_name := l_item
			l_item := l_item + 2
			l_item := l_item + 12 -- in C++ sizeof("_CorXXXMain");
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
			l_str.append_character ('%U')
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
--			create l_mp.make (16)
--			c_create_guid (l_mp.item)
--			a_guid.make_from_array (l_mp.read_array (0, 16))
		end

	test_random
		local
			l_random: RANDOM
			l_data1: NATURAL_32
			l_data2: NATURAL_16
			l_data3: NATURAL_16
			l_data4: ARRAY [NATURAL_8]
			l_seed: INTEGER
			l_time: TIME
			l_guid: CIL_GUID
			l_val: NATURAL_8
			cil_guid: ARRAY [NATURAL_8]
		do
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second

				-- make (data1: NATURAL_32; data2, data3: NATURAL_16; data4: ARRAY [NATURAL_8])

			create l_random.set_seed (l_seed)
			l_random.start

			l_data1 := l_random.item.to_natural_32
			l_random.forth

			l_data2 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data3 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data4 := {ARRAY [NATURAL_8]} <<0, 0, 0, 0, 0, 0, 0, 0>>

			across 1 |..| 8 as i loop
				l_val := ((l_random.item.to_natural_32 \\ {NATURAL_8}.max_value) + 1).to_natural_8
				l_data4 [i] := l_val
				l_random.forth
			end

			create l_guid.make (l_data1, l_data2, l_data3, l_data4)
			print (l_guid.to_array_natural_8)
		end


feature -- Settings

	is_using_sub_directory_per_test: BOOLEAN

	test_directory: detachable PATH

feature {NONE} -- Implementation				

	pre_test (tn: READABLE_STRING_GENERAL)
		local
			p: PATH
			fut: FILE_UTILITIES
		do
			if is_using_sub_directory_per_test and then attached test_directory as loc then
				p := loc.extended (tn)
				if not fut.directory_path_exists (p) then
					fut.create_directory_path (p)
				end
				execution_environment.change_working_path (p)
			end
		end

	post_test (tn: READABLE_STRING_GENERAL)
		do

		end

feature -- Helper

	is_test_included (a_name: READABLE_STRING_GENERAL; a_pattern: READABLE_STRING_GENERAL): BOOLEAN
			-- Is test `a_name` matching pattern `a_pattern`?
		local
			s: READABLE_STRING_GENERAL
		do
			s := a_pattern.as_lower
			if
				s.starts_with ("test_") and
				not a_name.as_lower.starts_with ("test_")
			then
				s := s.substring (6, s.count) -- remove "test_" prefix
			end
			if
				s.is_empty
				or else s.is_case_insensitive_equal ("*")
				or else s.is_case_insensitive_equal ("all")
			then
				Result := True
			else
				Result := a_name.is_case_insensitive_equal (s)
				-- Todo: maybe add wildcart test such as ("*_assembly")
			end
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
