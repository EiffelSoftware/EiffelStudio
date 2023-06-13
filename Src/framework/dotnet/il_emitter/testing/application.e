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
				--Result := {ARRAY [READABLE_STRING_GENERAL]} <<"tk.empty_assembly", "tk.define_method_net2", "om.method_assembly">>
			Result := {ARRAY [READABLE_STRING_GENERAL]} <<"tk.basic_interface">> --,"tk.interface_inheritance","tk.modules","tk.define_entry_point_net6", "tk.define_implementation", "tk.define_interface", "tk.ast_process">>
		end

	process_test (tn: READABLE_STRING_GENERAL)
		local
			curr: PATH
		do
			curr := execution_environment.current_working_path

--			pre_test (tn)
			if tn.starts_with ("tk.") then
				test_metadata_tables_token_interface (tn.head (2), tn.substring (4, tn.count))
			elseif tn.starts_with ("om.") then
				test_metadata_tables_object_model (tn.head (2), tn.substring (4, tn.count))
			else
				old_tests ("old", tn) --"test_11")
			end
--			post_test (tn)

			execution_environment.change_working_path (curr)
		rescue
			if attached curr then
				execution_environment.change_working_path (curr)
			end
		end

feature -- Token tests

	test_metadata_tables_token_interface (cat, a_pattern: READABLE_STRING_GENERAL)
		do
			if is_test_included ("cli_directory_size", a_pattern) then
				launch_test (cat, "cli_directory_size", agent (create {TEST_METADATA_TABLES_TK}).test_cli_directory_size)
			end
			if is_test_included ("cli_header_size", a_pattern) then
				launch_test (cat, "cli_header_size", agent (create {TEST_METADATA_TABLES_TK}).test_cli_header_size)
			end
			if is_test_included ("user_string_heap", a_pattern) then
				launch_test (cat, "user_string_heap", agent (create {TEST_METADATA_TABLES_TK}).test_user_string_heap)
			end
			if is_test_included ("empty_assembly", a_pattern) then
				launch_test (cat, "empty_assembly", agent (create {TEST_METADATA_TABLES_TK}).test_empty_assembly)
			end
			if is_test_included ("define_assembly", a_pattern) then
				launch_test (cat, "define_assembly", agent (create {TEST_METADATA_TABLES_TK}).test_define_assembly)
			end
			if is_test_included ("define_module", a_pattern) then
				launch_test (cat, "define_module", agent (create {TEST_METADATA_TABLES_TK}).test_define_module)
			end
			if is_test_included ("define_module_net6", a_pattern) then
				launch_test (cat, "define_module_net6", agent (create {TEST_METADATA_TABLES_TK}).test_define_module_net6)
			end
			if is_test_included ("define_method_net2", a_pattern) then
				launch_test (cat, "define_method_net2", agent (create {TEST_METADATA_TABLES_TK}).test_define_method_net2)
			end
			if is_test_included ("define_type_ref", a_pattern) then
				launch_test (cat, "define_type_ref", agent (create {TEST_METADATA_TABLES_TK}).test_define_type_ref)
			end
			if is_test_included ("define_type", a_pattern) then
				launch_test (cat, "define_type", agent (create {TEST_METADATA_TABLES_TK}).test_define_type)
			end
			if is_test_included ("define_member_ref", a_pattern) then
				launch_test (cat, "define_member_ref", agent (create {TEST_METADATA_TABLES_TK}).test_define_member_ref)
			end
			if is_test_included ("define_method", a_pattern) then
				launch_test (cat, "define_method", agent (create {TEST_METADATA_TABLES_TK}).test_define_method)
			end
			if is_test_included ("define_field", a_pattern) then
				launch_test (cat, "define_field", agent (create {TEST_METADATA_TABLES_TK}).test_define_field)
			end
			if is_test_included ("define_signature_local", a_pattern) then
				launch_test (cat, "define_signature_local", agent (create {TEST_METADATA_TABLES_TK}).test_define_signature_local)
			end
			if is_test_included ("define_entry_point", a_pattern) then
				launch_test (cat, "define_entry_point", agent (create {TEST_METADATA_TABLES_TK}).test_define_entry_point)
			end
			if is_test_included ("define_entry_point_net4", a_pattern) then
				launch_test (cat, "define_entry_point_net4", agent (create {TEST_METADATA_TABLES_TK}).test_define_entry_point_net4)
			end
			if is_test_included ("define_entry_point_net6", a_pattern) then
				launch_test (cat, "define_entry_point_net6", agent (create {TEST_METADATA_TABLES_TK}).test_define_entry_point_net6)
			end
			if is_test_included ("define_property", a_pattern) then
				launch_test (cat, "define_property", agent (create {TEST_METADATA_TABLES_TK}).test_define_property)
			end
			if is_test_included ("define_property_access", a_pattern) then
				launch_test (cat, "define_property_access", agent (create {TEST_METADATA_TABLES_TK}).test_define_property_access)
			end
			if is_test_included ("define_file", a_pattern) then
				launch_test (cat, "define_file", agent (create {TEST_METADATA_TABLES_TK}).test_define_file)
			end
			if is_test_included ("define_interface", a_pattern) then
				launch_test (cat, "define_interface", agent (create {TEST_METADATA_TABLES_TK}).test_define_interface)
			end
			if is_test_included ("define_implementation", a_pattern) then
				launch_test (cat, "define_implementation", agent (create {TEST_METADATA_TABLES_TK}).test_define_implementation)
			end
			if is_test_included ("user_string_heap_duplicates", a_pattern) then
				launch_test (cat, "user_string_heap_duplicates", agent (create {TEST_METADATA_TABLES_TK}).test_user_string_heap_duplicates)
			end
			if is_test_included ("blob_heap_duplicates", a_pattern) then
				launch_test (cat, "blob_heap_duplicates", agent (create {TEST_METADATA_TABLES_TK}).test_blob_heap_duplicates)
			end
--			if is_test_included ("define_implementation_2", a_pattern) then
--				launch_test (cat, "define_implementation_2", agent (create {TEST_METADATA_TABLES_TK}).test_define_implementation_2)
--			end
			if is_test_included("ast_process", a_pattern) then
				launch_test (cat, "ast_process", agent (create {TEST_AST_PROCESS}).test_ast_process)
			end
			if is_test_included("modules", a_pattern) then
				launch_test (cat, "modules", agent (create {TEST_MODULES_TK}).test_modules)
			end
			if is_test_included("interface_inheritance", a_pattern) then
				launch_test (cat, "interface_inheritance", agent (create {TEST_INTERFACE_INHERITANCE}).test_inheritance)
			end
			if is_test_included("basic_interface", a_pattern) then
				launch_test (cat, "basic_interface", agent (create {TEST_AST_PROCESS}).test_define_basic_interface)
			end
		end

feature -- Object model tests

	test_metadata_tables_object_model (cat, a_pattern: READABLE_STRING_GENERAL)
		do
			if is_test_included ("empty_assembly", a_pattern) then
				launch_test (cat, "empty_assembly", agent (create {TEST_METADATA_TABLES_OM}).test_empty_assembly)
			end
--			if is_test_included ("define_assembly", a_pattern) then
--				launch_test (cat, "define_assembly", agent (create {TEST_METADATA_TABLES_OM}).test_define_assembly)
--			end
			if is_test_included ("method_assembly", a_pattern) then
				launch_test (cat, "method_assembly", agent (create {TEST_METADATA_TABLES_OM}).test_define_method)
			end
			if is_test_included ("define_type_ref", a_pattern) then
				launch_test (cat, "define_type_ref", agent (create {TEST_METADATA_TABLES_OM}).test_define_type_ref)
			end

			if is_test_included ("define_type", a_pattern) then
				launch_test (cat, "define_type", agent (create {TEST_METADATA_TABLES_OM}).test_define_type)
			end

		end

feature -- Initialization

	make
		local
			tn: READABLE_STRING_GENERAL
			i, n: INTEGER
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			tests: ITERABLE [READABLE_STRING_GENERAL]
			conv: BYTE_ARRAY_CONVERTER
			p: PATH
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
								create p.make_from_string (argument (i + 1))
								i := i + 1
							else
								create p.make_current
							end
							test_directory := p.absolute_path
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

	old_tests (cat, a_pattern: READABLE_STRING_GENERAL)
			-- Run application.
		local
			mp: MANAGED_POINTER
			l_val: INTEGER
			l_cell: CELL [INTEGER]
			time: TIME
		do
			if is_test_included ("big_digits", a_pattern) then
				launch_test (cat, "big_digits", agent (create {OLD_TESTS}).test_big_digits)
			end
			if is_test_included ("copy_arrays", a_pattern) then
				launch_test (cat, "copy_arrays", agent (create {OLD_TESTS}).test_copy_arrays)
			end
			if is_test_included ("array_wrapped_code", a_pattern) then
				launch_test (cat, "array_wrapped_code", agent (create {OLD_TESTS}).test_array_wrapped_code)
			end
			if is_test_included ("arrays", a_pattern) then
				launch_test (cat, "arrays", agent (create {OLD_TESTS}).test_arrays)
			end
			if is_test_included ("string_to_buf", a_pattern) then
				launch_test (cat, "string_to_buf", agent (create {OLD_TESTS}).test_string_to_buf)
			end
			if is_test_included ("pe_version_string", a_pattern) then
				launch_test (cat, "pe_version_string", agent (create {OLD_TESTS}).test_pe_version_string ({STRING_32} "FileVersion", "1.1.0.1"))
--				launch_test (cat, "pe_version_string", (create {OLD_TESTS}).test_pe_version_string ({STRING_32} "FileDescription", " "))
			end
			if is_test_included ("hexadecimal_value", a_pattern) then
				launch_test (cat, "hexadecimal_value", agent (create {OLD_TESTS}).text_hexadecimal_value)
			end
			if is_test_included ("path_entries", a_pattern) then
				launch_test (cat, "path_entries", agent (create {OLD_TESTS}).test_path_entries)
			end
			if is_test_included ("pe_strings_32", a_pattern) then
				launch_test (cat, "pe_strings_32", agent (create {OLD_TESTS}).test_pe_strings_32)
			end
			if is_test_included ("pe_naturals", a_pattern) then
				launch_test (cat, "pe_naturals", agent (create {OLD_TESTS}).test_pe_naturals)
			end
			if is_test_included ("pe_reader", a_pattern) then
				launch_test (cat, "pe_reader", agent (create {OLD_TESTS}).test_pe_reader)
			end
			if is_test_included ("pe_import_dir", a_pattern) then
				launch_test (cat, "pe_import_dir", agent (create {OLD_TESTS}).test_pe_import_dir)
			end
			if is_test_included ("pe_write_string", a_pattern) then
				launch_test (cat, "pe_write_string", agent (create {OLD_TESTS}).test_pe_write_string)
			end
			if is_test_included ("byte_array_to_string", a_pattern) then
				launch_test (cat, "byte_array_to_string", agent (create {OLD_TESTS}).test_byte_array_to_string)
			end
			if is_test_included ("test", a_pattern) then
				launch_test (cat, "test", agent (create {OLD_TESTS}).file_test)
			end
			if is_test_included ("natural_64", a_pattern) then
				launch_test (cat, "natural_64", agent (create {OLD_TESTS}).test_natural_64)
			end
			if is_test_included ("byte_array", a_pattern) then
				launch_test (cat, "byte_array", agent (create {OLD_TESTS}).test_byte_array)
			end
			if is_test_included ("guid", a_pattern) then
				launch_test (cat, "guid", agent (create {OLD_TESTS}).test_guid)
			end
			if is_test_included ("test_1", a_pattern) then
				launch_test (cat, "test_1", agent (create {TEST_1}).test)
			end
			if is_test_included ("test_2", a_pattern) then
				launch_test (cat, "test_2", agent (create {TEST_2}).test)
			end
			if is_test_included ("test_3", a_pattern) then
				launch_test (cat, "test_3", agent (create {TEST_3}).test)
			end
			if is_test_included ("test_4", a_pattern) then
				launch_test (cat, "test_4", agent (create {TEST_4}).test)
			end
			if is_test_included ("test_5", a_pattern) then
				launch_test (cat, "test_5", agent (create {TEST_5}).test)
			end
			if is_test_included ("test_6", a_pattern) then
				launch_test (cat, "test_6", agent (create {TEST_6}).test)
			end
			if is_test_included ("test_7", a_pattern) then
				launch_test (cat, "test_7", agent (create {TEST_7}).test)
			end
			if is_test_included ("test_8", a_pattern) then
				launch_test (cat, "test_8", agent (create {TEST_8}).test)
			end
			if is_test_included ("test_9", a_pattern) then
				launch_test (cat, "test_9", agent (create {TEST_9}).test)
			end
			if is_test_included ("test_10", a_pattern) then
				launch_test (cat, "test_10", agent (create {TEST_10}).test)
			end
			if is_test_included ("test_11", a_pattern) then
--FIXME			launch_test (cat, "test_11", (create {TEST_11}).test)
			end
			if is_test_included ("random", a_pattern) then
				launch_test (cat, "random", agent (create {OLD_TESTS}).test_random)
			end
			if is_test_included ("test_12", a_pattern) then
--FIXME			launch_test (cat, "test_12", (create {TEST_12}).test)
			end

		end

feature -- Settings

	is_using_sub_directory_per_test: BOOLEAN

	test_directory: detachable PATH

feature {NONE} -- Implementation

	launch_test (cat, a_name: READABLE_STRING_GENERAL; act: PROCEDURE)
		local
			retried: BOOLEAN
			n: READABLE_STRING_GENERAL
		do
			if cat.is_empty then
				n := a_name
			else
				n := cat + "." + a_name
			end
			if not retried then
				print ({STRING_32} "Test " + n + "%N")
				pre_test (n)
				act.call (Void)
				post_test (n)
			else
				print ({STRING_32} "Test " + n.to_string_32 + ": ERROR: exception%N")
			end
		rescue
			retried := True
			retry
		end


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
			if attached test_directory as p then
				execution_environment.change_working_path (p)
			end
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
