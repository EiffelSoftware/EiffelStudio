note
	description: "Summary description for {TEST_METADATA_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_METADATA_TABLES_TK

inherit
	TEST_I

feature -- Test

	test_cli_directory_size
		local
			l_dir: CLI_DIRECTORY
		do
				-- rva: 4 bytes
				-- data_size: 4 bytes
			check {CLI_DIRECTORY}.size_of = 8 end
		end

	test_cli_header_size
		local
			l_header: CLI_HEADER
		do
				--cb: 4 bytes
				--MajorRuntimeVersion: 2 bytes
				--MinorRuntimeVersion: 2 bytes
				--MetaData: 8 bytes (2 x 4 bytes)
				--Flags: 4 bytes
				--EntryPointToken: 4 bytes
				--Resources: 8 bytes (2 x 4 bytes)
				--StrongNameSignature: 8 bytes (2 x 4 bytes)
				--CodeManagerTable: 8 bytes (2 x 4 bytes)
				--VTableFixups: 8 bytes (2 x 4 bytes)
				--ExportAddressTableJumps: 8 bytes (2 x 4 bytes)
				--ManagedNativeHeader: 8 bytes (2 x 4 bytes)
			check {CLI_HEADER}.size_of = 72 end
		end

	test_empty_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
		do
			md_emit := new_emitter
			create l_pe_file.make ("test_empty_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			my_assembly: INTEGER
		do

			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("manus_assembly"),
					0, md_assembly_info, Void)

			create l_pe_file.make ({STRING_32} "test_define_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_user_string_heap
			-- Test the UserString heap , related to MD_EMIT.define_string
			--| Goals:
			--|	- test with small strings, big and really big strings
			--|	- also empty strings.
			--| - ensure no duplicated entries exists,
			--| - ensure the retrieve_user_string is valid and same as the original source.
		local
			lst: ARRAY [STRING_32]
			tb: STRING_TABLE [INTEGER_32]
			l_token1, l_token2, l_token3, l_token4, tok, rtok: INTEGER_32
			l_str: STRING_32
			md_emit: MD_EMIT
			l_result: NATURAL_64
			l_table_type_index: NATURAL_64
			l_index: NATURAL_64
		do
			md_emit := new_emitter
			lst := <<
						{STRING_32} "(attached pure_implementation_type (type_id) as l_current_rt_type and then attached {ISE_RUNTIME}.create_type (l_current_rt_type) as l_object and then attached {SYSTEM_TYPE}.get_type_from_handle (l_current_rt_type.type) as l_current_type)(attached pure_implementation_type (type_id) as l_current_rt_type and then attached {ISE_RUNTIME}.create_type (l_current_rt_type) as l_object and then attached {SYSTEM_TYPE}.get_type_from_handle (l_current_rt_type.type) as l_current_type)",
						{STRING_32} "abc",
						{STRING_32} "", -- Manifest empty string...
						{STRING_32} "DEF",
						{STRING_32} "",
						{STRING_32} "abc",
						{STRING_32} "Next",
						{STRING_32} "TEST_METADATA_TABLES_TK",
						{STRING_32} "1234567890123456789012345678901234567890123456789012345678901234"
			 		>>
			create tb.make (lst.count)
			across
				lst as s
			loop
				print ({STRING_32} "Define string %"" + s + "%"")
				tok := md_emit.define_string (create {CLI_STRING}.make (s))
				print (" -> tok=" + tok.out + "%N")
				rtok := md_emit.define_string (create {CLI_STRING}.make (s))
				if tok /= rtok then
					check same_token: False end
					print ("ERROR: different token for same string: %"")
					print (s)
					print ("%"%N")
				end
				tb [s] := tok
			end
			across
				tb as t
			loop
				l_str := retrieve_user_string (md_emit, t)
				if l_str.ends_with_general ("%U") then
					l_str.remove_tail (1)
				end
				if l_str.same_string (@t.key) then
					print ("VALID: same string fetch using token%"")
					print (t.out)
					print ("%" -> %"")
					print (@t.key)
					print ("%"%N")
				else
					check same_string: False end
					print ("ERROR: string fetch using token is different from original string: %"")
					print (@t.key)
					print ("%"%N")
				end
			end
		end

	test_user_string_heap_duplicates
		local
			l_token1, l_token2, l_token3, l_token4: NATURAL_32
			md_emit: MD_EMIT
		do
			md_emit := new_emitter

			l_token1 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel")).to_natural_32
			l_token2 := md_emit.define_string (create {CLI_STRING}.make ("Java")).to_natural_32
			l_token3 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel")).to_natural_32
			l_token4 := md_emit.define_string (create {CLI_STRING}.make ("Java")).to_natural_32

			check l_token1 = l_token3 end
			check l_token2 = l_token4 end

			l_token1 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel?")).to_natural_32
			l_token2 := md_emit.define_string (create {CLI_STRING}.make ("Java!")).to_natural_32
			l_token3 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel?")).to_natural_32
			l_token4 := md_emit.define_string (create {CLI_STRING}.make ("Java!")).to_natural_32

			check l_token1 = l_token3 end
			check l_token2 = l_token4 end

			l_token1 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_1")).to_natural_32
			l_token2 := md_emit.define_string (create {CLI_STRING}.make ("Java_2")).to_natural_32
			l_token3 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_1")).to_natural_32
			l_token4 := md_emit.define_string (create {CLI_STRING}.make ("Java_2")).to_natural_32

			check l_token1 = l_token3 end
			check l_token2 = l_token4 end

			l_token1 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_1!")).to_natural_32
			l_token2 := md_emit.define_string (create {CLI_STRING}.make ("Java_2!")).to_natural_32
			l_token3 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_1!")).to_natural_32
			l_token4 := md_emit.define_string (create {CLI_STRING}.make ("Java_2!")).to_natural_32

			check l_token1 = l_token3 end
			check l_token2 = l_token4 end

			l_token1 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_*")).to_natural_32
			l_token2 := md_emit.define_string (create {CLI_STRING}.make ("Java_*")).to_natural_32
			l_token3 := md_emit.define_string (create {CLI_STRING}.make ("Eiffel_*")).to_natural_32
			l_token4 := md_emit.define_string (create {CLI_STRING}.make ("Java_*")).to_natural_32

			check l_token1 = l_token3 end
			check l_token2 = l_token4 end
		end

	test_blob_heap_duplicates
		local
			md_emit: MD_EMIT
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			l_pub_key1, l_pub_key2: NATURAL_64
			l_pub_key3, l_pub_key4: NATURAL_64
			sig: MD_METHOD_SIGNATURE
			sig_token1, sig_token2: NATURAL_64
		do
			md_emit := new_emitter

			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			l_pub_key1 := hash_blob (md_emit, l_pub_key_token.item.read_array (0, l_pub_key_token.item.count), l_pub_key_token.item.count.to_natural_32)

			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
			l_pub_key2 := hash_blob (md_emit, l_pub_key_token.item.read_array (0, l_pub_key_token.item.count), l_pub_key_token.item.count.to_natural_32)

			check l_pub_key1 /= l_pub_key2 end

			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			l_pub_key3 := hash_blob (md_emit, l_pub_key_token.item.read_array (0, l_pub_key_token.item.count), l_pub_key_token.item.count.to_natural_32)

			check l_pub_key1 = l_pub_key3 end

			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
			l_pub_key4 := hash_blob (md_emit, l_pub_key_token.item.read_array (0, l_pub_key_token.item.count), l_pub_key_token.item.count.to_natural_32)
			check l_pub_key2 = l_pub_key4 end

				-- signature like void f()
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig_token1 := hash_blob (md_emit, sig.as_array, sig.count.to_natural_32)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig_token2 := hash_blob (md_emit, sig.as_array, sig.count.to_natural_32)

			check sig_token1 = sig_token2 end

		end

	test_define_module
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, mscorlib_token: INTEGER

		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("module_assembly"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"), md_assembly_info, l_pub_key_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("module_assembly.dll"))

			create l_pe_file.make ("module_assembly.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_module_net6
			-- Build a basic assembly defining the module name.
			-- Targeting .Net6.
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (3) -- set_minor_version
			md_assembly_info.set_minor_version (1)
			md_assembly_info.set_build_number (28)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_module_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("define_module_net6.dll"))

			create l_pe_file.make ("define_module_net6.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_type_ref
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			tasks_type_token: INTEGER
			system_type_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("typeref_assembly_tk"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			system_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System"), mscorlib_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			tasks_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Threading.Tasks"), mscorlib_token)

			create l_pe_file.make ("test_typeref_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_type
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor, tasks_type_token, system_type_token: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("typedef_assembly_tk"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			system_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System"), mscorlib_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			tasks_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Threading.Tasks"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("typedef_assembly_tk.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create l_pe_file.make ("test_typedef_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_member_ref
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("member_ref_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("member_ref_assembly.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			create l_pe_file.make ("test_member_ref_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save

		end

	test_define_method
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("method_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("method_assembly.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create l_pe_file.make ("test_method_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_field
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("field_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("field_assembly.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("item"), my_type,
					{MD_FIELD_ATTRIBUTES}.public, field_sig)

			create l_pe_file.make ("test_field_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_signature_local
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("signature_local_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("signature_local_assembly.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("item"), my_type,
					{MD_FIELD_ATTRIBUTES}.public, field_sig)

			create local_sig.make
			local_sig.set_local_count (2)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, my_type)
			local_token := md_emit.define_signature (local_sig)

			create l_pe_file.make ("test_signature_local_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_method_net2
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("method_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("method_assembly.dll"))

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("item"), my_type,
					{MD_FIELD_ATTRIBUTES}.public, field_sig)

			create local_sig.make
			local_sig.set_local_count (2)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, my_type)
			local_token := md_emit.define_signature (local_sig)

			create method_writer.make

			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_call ({MD_OPCODES}.Call, object_ctor, 0, True)
			label_id := body.define_label
			l_id2 := body.define_label
			body.mark_label (l_id2)
			body.put_opcode_label ({MD_OPCODES}.Br, label_id)
			body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Br, l_id2)
			body.mark_label (label_id)
			body.put_opcode ({MD_OPCODES}.Ret)
			body.set_local_token (local_token)
			method_writer.write_current_body

			my_meth := md_emit.define_method (create {CLI_STRING}.make ("test"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_meth)
			label_id := body.define_label
			l_id2 := body.define_label
			body.mark_label (l_id2)
			body.put_opcode_label ({MD_OPCODES}.Br, label_id)
			body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Br, l_id2)
			body.mark_label (label_id)
			body.put_opcode ({MD_OPCODES}.Ret)
			body.set_local_token (local_token)
			method_writer.write_current_body

			create l_pe_file.make ("method_assembly.dll", True, True, False, md_emit)
			l_pe_file.set_entry_point_token (my_meth)
			l_pe_file.save
		end

	test_define_entry_point
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			my_field, local_token, string_token: INTEGER
			my_ctor, object_type_token, mscorlib_token, my_assembly, my_type: INTEGER
			md_assembly_info: MD_ASSEMBLY_INFO
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, l_entry_type_token, console_type_token, write_line_token, console_token, string_type_token, system_type_token: INTEGER
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_tk"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)

			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			system_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System"), mscorlib_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Exception"), mscorlib_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), mscorlib_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), mscorlib_token)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("MAIN"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public,
					object_type_token, Void)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("item"), l_entry_type_token,
					{MD_FIELD_ATTRIBUTES}.public, field_sig)

			create local_sig.make
			local_sig.set_local_count (2)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)

			create method_writer.make

			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_call ({MD_OPCODES}.Call, object_ctor, 0, True)
			label_id := body.define_label
			l_id2 := body.define_label
			body.mark_label (l_id2)
			body.put_opcode_label ({MD_OPCODES}.Br, label_id)
			body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Br, l_id2)
			body.mark_label (label_id)
			body.put_opcode ({MD_OPCODES}.Ret)
			body.set_local_token (local_token)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.Call, write_line_token, 0, False)

				-- TODO nop is not supported!!!
			body.put_opcode ({MD_OPCODES}.pop)

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_main_net6.dll", True, False, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save
		end

	test_define_entry_point_net4
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			mscorlib_token, attribute_ctor, target_framework_attr_type_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_main_net4"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
				-- mscorlib.dll

			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), mscorlib_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), mscorlib_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_main_net4.dll"))

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, string_type_token)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			create method_writer.make

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.Call, write_line_token, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_call ({MD_OPCODES}.Call, object_ctor, 0, True)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			body.set_local_token (local_token)
			method_writer.write_current_body

			create l_pe_file.make ("test_main_net4.dll", True, False, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save
		end

	test_define_entry_point_net6
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			int32_type_token, compilation_relaxations_token, attribute_ctor, target_framework_attr_type_token: INTEGER
			assembly_configuration_token, assembly_company_token, runtime_compatibility_token: INTEGER
			assembly_file_version_token: INTEGER
			assembly_info_version_token: INTEGER
			assembly_product_token: INTEGER
			assembly_title_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_main_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

				-- mscorlib.dll

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), system_runtime_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), system_runtime_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), system_console_token)

			int32_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Int32"), system_runtime_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			compilation_relaxations_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.CompilationRelaxationsAttribute"), system_runtime_token)

			runtime_compatibility_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"), system_runtime_token)

			assembly_company_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyCompanyAttribute"), system_runtime_token)

			assembly_configuration_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyConfigurationAttribute"), system_runtime_token)

			assembly_file_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyFileVersionAttribute"), system_runtime_token)

			assembly_info_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyInformationalVersionAttribute"), system_runtime_token)

			assembly_product_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyProductAttribute"), system_runtime_token)

			assembly_title_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyTitleAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_main_net6.dll"))

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					compilation_relaxations_token, sig)

			create ca.make
			ca.put_integer_32 (8)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly:RuntimeCompatibilityAttribute(WrapNonExceptionThrows = true)];
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					runtime_compatibility_token, sig)

			create ca.make
				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boolean)
				-- Put the name of the property
			ca.put_string ("WrapNonExceptionThrows")
				-- Put the value
			ca.put_boolean (True)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyCompany("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("test_main_net6")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_configuration_token, sig)

			create ca.make
			ca.put_string ("Debug")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyFileVersion("1.0.0.0")]

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_file_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyInformationalVersion("1.0.0")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_info_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyProduct("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_product_token, sig)

			create ca.make
			ca.put_string ("test_main_net6")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyTitle("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_main_net6")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			create method_writer.make

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello world from Eiffel!!!"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_main_net6.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_property
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			property_sig: MD_PROPERTY_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			int32_type_token, compilation_relaxations_token, attribute_ctor, target_framework_attr_type_token: INTEGER
			assembly_configuration_token, assembly_company_token, runtime_compatibility_token: INTEGER
			assembly_file_version_token: INTEGER
			assembly_info_version_token: INTEGER
			assembly_product_token: INTEGER
			my_set_name, my_get_name, assembly_title_token: INTEGER
			string_value_token: INTEGER
			property_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_property"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

				-- mscorlib.dll

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), system_runtime_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), system_runtime_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), system_console_token)

			int32_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Int32"), system_runtime_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			compilation_relaxations_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.CompilationRelaxationsAttribute"), system_runtime_token)

			runtime_compatibility_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"), system_runtime_token)

			assembly_company_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyCompanyAttribute"), system_runtime_token)

			assembly_configuration_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyConfigurationAttribute"), system_runtime_token)

			assembly_file_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyFileVersionAttribute"), system_runtime_token)

			assembly_info_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyInformationalVersionAttribute"), system_runtime_token)

			assembly_product_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyProductAttribute"), system_runtime_token)

			assembly_title_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyTitleAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_property.dll"))

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					compilation_relaxations_token, sig)

			create ca.make
			ca.put_integer_32 (8)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly:RuntimeCompatibilityAttribute(WrapNonExceptionThrows = true)];
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					runtime_compatibility_token, sig)

			create ca.make
				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boolean)
				-- Put the name of the property
			ca.put_string ("WrapNonExceptionThrows")
				-- Put the value
			ca.put_boolean (True)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyCompany("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("test_property")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_configuration_token, sig)

			create ca.make
			ca.put_string ("Debug")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyFileVersion("1.0.0.0")]

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_file_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyInformationalVersion("1.0.0")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_info_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyProduct("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_product_token, sig)

			create ca.make
			ca.put_string ("test_property")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyTitle("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_property")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			create method_writer.make

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("name"), l_entry_type_token,
					{MD_FIELD_ATTRIBUTES}.private, field_sig)

				-- get_Name
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_get_name := md_emit.define_method (create {CLI_STRING}.make ("get_Name"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_get_name)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode_integer ({MD_OPCODES}.ldfld, my_field)
			body.put_opcode ({MD_OPCODES}.Stloc_0)
			l_id2 := body.define_label
			body.put_opcode_label ({MD_OPCODES}.br, l_id2)
			body.mark_label (l_id2)
			body.put_opcode ({MD_OPCODES}.Ldloc_0)
			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

				-- set_Name()

			string_value_token := md_emit.define_string (create {CLI_STRING}.make ("value"))
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_value_token)

			my_set_name := md_emit.define_method (create {CLI_STRING}.make ("set_Name"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_set_name)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_opcode_integer ({MD_OPCODES}.Stfld, my_field)

			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

			md_emit.define_parameter (my_set_name, create {CLI_STRING}.make ("value"), 1, {MD_PARAM_ATTRIBUTES}.In).do_nothing

			create property_sig.make
			property_sig.set_property_type ({MD_SIGNATURE_CONSTANTS}.property_sig | {MD_SIGNATURE_CONSTANTS}.has_current)
			property_sig.set_parameter_count (0)
			property_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

				-- Set Properties
			property_token := md_emit.define_property (l_entry_type_token, create {CLI_STRING}.make ("name"), 0, property_sig, my_set_name, my_get_name)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello world from Eiffel!!!"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_property.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_property_access
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			property_sig: MD_PROPERTY_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			int32_type_token, compilation_relaxations_token, attribute_ctor, target_framework_attr_type_token: INTEGER
			assembly_configuration_token, assembly_company_token, runtime_compatibility_token: INTEGER
			assembly_file_version_token: INTEGER
			assembly_info_version_token: INTEGER
			assembly_product_token: INTEGER
			my_set_name, my_get_name, assembly_title_token: INTEGER
			string_value_token: INTEGER
			property_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_property_access"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

				-- mscorlib.dll

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), system_runtime_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), system_runtime_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), system_console_token)

			int32_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Int32"), system_runtime_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			compilation_relaxations_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.CompilationRelaxationsAttribute"), system_runtime_token)

			runtime_compatibility_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"), system_runtime_token)

			assembly_company_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyCompanyAttribute"), system_runtime_token)

			assembly_configuration_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyConfigurationAttribute"), system_runtime_token)

			assembly_file_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyFileVersionAttribute"), system_runtime_token)

			assembly_info_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyInformationalVersionAttribute"), system_runtime_token)

			assembly_product_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyProductAttribute"), system_runtime_token)

			assembly_title_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyTitleAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_property_access.dll"))

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					compilation_relaxations_token, sig)

			create ca.make
			ca.put_integer_32 (8)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly:RuntimeCompatibilityAttribute(WrapNonExceptionThrows = true)];
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					runtime_compatibility_token, sig)

			create ca.make
				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boolean)
				-- Put the name of the property
			ca.put_string ("WrapNonExceptionThrows")
				-- Put the value
			ca.put_boolean (True)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyCompany("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("test_property_access")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_configuration_token, sig)

			create ca.make
			ca.put_string ("Debug")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyFileVersion("1.0.0.0")]

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_file_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyInformationalVersion("1.0.0")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_info_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyProduct("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_product_token, sig)

			create ca.make
			ca.put_string ("test_property_access")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyTitle("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_property_access")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			create method_writer.make

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("name"), l_entry_type_token,
					{MD_FIELD_ATTRIBUTES}.private, field_sig)

				-- get_Name
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_get_name := md_emit.define_method (create {CLI_STRING}.make ("get_Name"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_get_name)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode_integer ({MD_OPCODES}.ldfld, my_field)
			body.put_opcode ({MD_OPCODES}.Stloc_0)
			l_id2 := body.define_label
			body.put_opcode_label ({MD_OPCODES}.br, l_id2)
			body.mark_label (l_id2)
			body.put_opcode ({MD_OPCODES}.Ldloc_0)
			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

				-- set_Name()

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			my_set_name := md_emit.define_method (create {CLI_STRING}.make ("set_Name"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_set_name)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_opcode_integer ({MD_OPCODES}.Stfld, my_field)

			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

			md_emit.define_parameter (my_set_name, create {CLI_STRING}.make ("value"), 1, 0).do_nothing

			create property_sig.make
			property_sig.set_property_type ({MD_SIGNATURE_CONSTANTS}.property_sig | {MD_SIGNATURE_CONSTANTS}.has_current)
			property_sig.set_parameter_count (0)
			property_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

				-- Set Properties
			property_token := md_emit.define_property (l_entry_type_token, create {CLI_STRING}.make ("Name"), 0, property_sig, my_set_name, my_get_name)

				-- Program.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Joe Doe"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.callvirt, my_set_name, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, my_get_name, 0, True)

			body.put_static_call (write_line_token, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

				-- Program.ctor()
			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_property_access.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_file (dir: PATH)
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			object_type_token, mscorlib_token, object_ctor, tasks_type_token, system_type_token: INTEGER
			my_type, my_assembly, my_ctor, my_field, my_meth, my_meth2: INTEGER
			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			sig: MD_METHOD_SIGNATURE
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			local_token: INTEGER
			label_id, l_id2: INTEGER
			system_exception_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			ca: MD_CUSTOM_ATTRIBUTE
			ca_token, system_runtime_token, system_console_token, string_type_token, attribute_ctor: INTEGER
			target_framework_attr_type_token: INTEGER
			l_hash_file: MANAGED_POINTER
			l_signing: MD_STRONG_NAME
			l_file: CLI_STRING
			l_token_file: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_file_tk"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, md_pub_key_token)
			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, md_pub_key_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("define_file_tk.dll"))

			create l_file.make (dir.extended ("struct_test.e").name)
			create l_signing.make_with_version ("Net6")
			l_hash_file := l_signing.hash_of_file (l_file)
			string_token := md_emit.define_string (l_file)
			l_token_file := md_emit.define_file (l_file, l_hash_file, {MD_FILE_FLAGS}.Has_meta_data)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create l_pe_file.make ("test_define_file_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_interface
			-- Build an interface example with properties
			-- Define interface IPrintable
			-- 	with a method Print()
			-- Define interface IMark
			-- 	no methods
			-- Class Program: IPrintable, IMark
			-- Follow the AST process
			-- Compare the output with the cs\interface example.
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			property_sig: MD_PROPERTY_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			int32_type_token, compilation_relaxations_token, attribute_ctor, target_framework_attr_type_token: INTEGER
			assembly_configuration_token, assembly_company_token, runtime_compatibility_token: INTEGER
			assembly_file_version_token: INTEGER
			assembly_info_version_token: INTEGER
			assembly_product_token: INTEGER
			my_set_name, my_get_name, assembly_title_token: INTEGER
			string_value_token: INTEGER
			property_token: INTEGER
			iprintable_token: INTEGER
			iprint_method_token: INTEGER
			imp_print_method_token: INTEGER
			imark_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_interface"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

				-- mscorlib.dll

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), system_runtime_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), system_runtime_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), system_console_token)

			int32_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Int32"), system_runtime_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			compilation_relaxations_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.CompilationRelaxationsAttribute"), system_runtime_token)

			runtime_compatibility_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"), system_runtime_token)

			assembly_company_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyCompanyAttribute"), system_runtime_token)

			assembly_configuration_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyConfigurationAttribute"), system_runtime_token)

			assembly_file_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyFileVersionAttribute"), system_runtime_token)

			assembly_info_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyInformationalVersionAttribute"), system_runtime_token)

			assembly_product_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyProductAttribute"), system_runtime_token)

			assembly_title_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyTitleAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_interface.dll"))



			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					compilation_relaxations_token, sig)

			create ca.make
			ca.put_integer_32 (8)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly:RuntimeCompatibilityAttribute(WrapNonExceptionThrows = true)];
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					runtime_compatibility_token, sig)

			create ca.make
				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boolean)
				-- Put the name of the property
			ca.put_string ("WrapNonExceptionThrows")
				-- Put the value
			ca.put_boolean (True)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyCompany("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("test_interface")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_configuration_token, sig)

			create ca.make
			ca.put_string ("Debug")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyFileVersion("1.0.0.0")]

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_file_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyInformationalVersion("1.0.0")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_info_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyProduct("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_product_token, sig)

			create ca.make
			ca.put_string ("test_interface")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyTitle("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_interface")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Types:
				--  {IPrintable, IMark, Program}		

				-- Define IPrintable interface
			iprintable_token := md_emit.define_type (
						create {CLI_STRING}.make ("IPrintable"),
						{MD_TYPE_ATTRIBUTES}.public |
						{MD_TYPE_ATTRIBUTES}.is_interface |
						{MD_TYPE_ATTRIBUTES}.Abstract |
						{MD_TYPE_ATTRIBUTES}.Auto_layout,
						0,
						Void)


				-- Define IMark interface
			imark_token := md_emit.define_type (
							create {CLI_STRING}.make ("IMark"),
							{MD_TYPE_ATTRIBUTES}.public |
							{MD_TYPE_ATTRIBUTES}.is_interface |
							{MD_TYPE_ATTRIBUTES}.Abstract |
							{MD_TYPE_ATTRIBUTES}.Auto_layout,
							0,
							Void)

				--Define class Program: IPrintable, IMark
			l_entry_type_token := md_emit.define_type (
							create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
							{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
							object_type_token, <<iprintable_token, imark_token>>)


					-- Methods per Types :
					-- Define method in IPrintable interface: Print
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			iprint_method_token := md_emit.define_method (create {CLI_STRING}.make ("Print"),
						iprintable_token,
						{MD_METHOD_ATTRIBUTES}.Abstract |
						{MD_METHOD_ATTRIBUTES}.Public |
						{MD_METHOD_ATTRIBUTES}.hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.virtual |
						{MD_METHOD_ATTRIBUTES}.new_slot,
						sig,
						{MD_METHOD_ATTRIBUTES}.Managed)

				-- Interface Mark is emtpy {} no methods.

			create method_writer.make

				-- Type Program
				-- Define  Program.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define Method Program.get_Name
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_get_name := md_emit.define_method (create {CLI_STRING}.make ("get_Name"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)


				-- Define Method Program.set_Name()

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			my_set_name := md_emit.define_method (create {CLI_STRING}.make ("set_Name"),
						l_entry_type_token,
						{MD_METHOD_ATTRIBUTES}.Public |
						{MD_METHOD_ATTRIBUTES}.hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.special_name,
						sig, {MD_METHOD_ATTRIBUTES}.Managed)


				-- Define method Program.Print implement from IPrintable interface.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			imp_print_method_token := md_emit.define_method (create {CLI_STRING}.make ("Print"),
						l_entry_type_token,
						{MD_METHOD_ATTRIBUTES}.Public |
						{MD_METHOD_ATTRIBUTES}.hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.virtual |
						{MD_METHOD_ATTRIBUTES}.new_slot,
						sig,
						{MD_METHOD_ATTRIBUTES}.Managed)



				-- Define Program.Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define Properties
			create property_sig.make
			property_sig.set_property_type ({MD_SIGNATURE_CONSTANTS}.property_sig | {MD_SIGNATURE_CONSTANTS}.has_current)
			property_sig.set_parameter_count (0)
			property_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

					-- Set Properties
			property_token := md_emit.define_property (l_entry_type_token, create {CLI_STRING}.make ("Name"), 0, property_sig, my_set_name, my_get_name)


				-- Define Field
			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			my_field := md_emit.define_field (create {CLI_STRING}.make ("name"), l_entry_type_token,
								{MD_FIELD_ATTRIBUTES}.private, field_sig)




				-- Method GetName Implementation	
			body := method_writer.new_method_body (my_get_name)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode_integer ({MD_OPCODES}.ldfld, my_field)
			body.put_opcode ({MD_OPCODES}.Stloc_0)
			l_id2 := body.define_label
			body.put_opcode_label ({MD_OPCODES}.br, l_id2)
			body.mark_label (l_id2)
			body.put_opcode ({MD_OPCODES}.Ldloc_0)
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Define Method SetName Implementation
			body := method_writer.new_method_body (my_set_name)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_opcode_integer ({MD_OPCODES}.Stfld, my_field)

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				--Define Parameters
			md_emit.define_parameter (my_set_name, create {CLI_STRING}.make ("value"), 1, 0).do_nothing


				-- Implement the Print method
			body := method_writer.new_method_body (imp_print_method_token)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_call ({MD_OPCODES}.call, my_get_name, 0, True)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body


			-- Implement Program.ctor	
			-- Program.ctor()
			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				-- Implement Main Method
			body := method_writer.new_method_body (my_main)
			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Testing Interfaces"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.callvirt, my_set_name, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, imp_print_method_token, 0, True)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



			create l_pe_file.make ("test_interface.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_implementation
		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token, console_type_token: INTEGER
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id, l_id2: INTEGER
			local_token, system_exception_token: INTEGER
			my_field, my_ctor, string_token: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			object_ctor, system_console_token, object_type_token, write_line_token,
			ca_token, system_type_token, string_type_token, l_entry_type_token, write_line_method: INTEGER

			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			property_sig: MD_PROPERTY_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			int32_type_token, compilation_relaxations_token, attribute_ctor, target_framework_attr_type_token: INTEGER
			assembly_configuration_token, assembly_company_token, runtime_compatibility_token: INTEGER
			assembly_file_version_token: INTEGER
			assembly_info_version_token: INTEGER
			assembly_product_token: INTEGER
			my_jm_method, my_im_method, assembly_title_token: INTEGER
			string_value_token: INTEGER
			property_token: INTEGER
			iprintable_token: INTEGER
			iprint_method_token: INTEGER
			imp_print_method_token: INTEGER
			interface_i_token, interface_j_token: INTEGER
			im_method_token, jm_method_token: INTEGER
			l_class_c_token: INTEGER
			class_c_ctor: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_implementation"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB0, 0x3F, 0x5F, 0x7F, 0x11, 0xD5, 0x0A, 0x3A>>)
				-- b0 3f 5f 7f 11 d5 0a 3a
				-- b7 7a 5c 56 19 34 e0 89

				-- mscorlib.dll

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Object"), system_runtime_token)

			string_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.String"), system_runtime_token)

			console_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Console"), system_console_token)

			int32_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Int32"), system_runtime_token)

			target_framework_attr_type_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.Versioning.TargetFrameworkAttribute"), system_runtime_token)

			compilation_relaxations_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.CompilationRelaxationsAttribute"), system_runtime_token)

			runtime_compatibility_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Runtime.CompilerServices.RuntimeCompatibilityAttribute"), system_runtime_token)

			assembly_company_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyCompanyAttribute"), system_runtime_token)

			assembly_configuration_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyConfigurationAttribute"), system_runtime_token)

			assembly_file_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyFileVersionAttribute"), system_runtime_token)

			assembly_info_version_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyInformationalVersionAttribute"), system_runtime_token)

			assembly_product_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyProductAttribute"), system_runtime_token)

			assembly_title_token := md_emit.define_type_ref (
					create {CLI_STRING}.make ("System.Reflection.AssemblyTitleAttribute"), system_runtime_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("test_implementation.dll"))

				-- Definition of WriteLine method.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Define interface I
			interface_i_token := md_emit.define_type (
					create {CLI_STRING}.make ("I"),
					{MD_TYPE_ATTRIBUTES}.abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define method M in I interface
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			im_method_token := md_emit.define_method (create {CLI_STRING}.make ("M"),
					interface_i_token,
					{MD_METHOD_ATTRIBUTES}.Abstract |
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

				-- Define interface J
			interface_j_token := md_emit.define_type (
					create {CLI_STRING}.make ("J"),
					{MD_TYPE_ATTRIBUTES}.Abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define method M in J interface
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			jm_method_token := md_emit.define_method (create {CLI_STRING}.make ("M"),
					interface_j_token,
					{MD_METHOD_ATTRIBUTES}.Abstract |
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

				-- Define Class C: I, J

			l_class_c_token := md_emit.define_type (
					create {CLI_STRING}.make ("C"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, <<interface_i_token, interface_j_token>>)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- C.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			class_c_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_class_c_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create method_writer.make

				-- I.M
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_im_method := md_emit.define_method (create {CLI_STRING}.make ("I.M"),
					l_class_c_token,
					{MD_METHOD_ATTRIBUTES}.private |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_im_method)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("I.M"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- J.M
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_jm_method := md_emit.define_method (create {CLI_STRING}.make ("J.M"),
					l_class_c_token,
					{MD_METHOD_ATTRIBUTES}.private |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_jm_method)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("J.M"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			md_emit.define_method_impl (l_class_c_token, my_jm_method, jm_method_token)
			md_emit.define_method_impl (l_class_c_token, my_im_method, im_method_token)

				-- Class C.ctor()
			body := method_writer.new_method_body (class_c_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					compilation_relaxations_token, sig)

			create ca.make
			ca.put_integer_32 (8)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly:RuntimeCompatibilityAttribute(WrapNonExceptionThrows = true)];
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					runtime_compatibility_token, sig)

			create ca.make
				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_boolean)
				-- Put the name of the property
			ca.put_string ("WrapNonExceptionThrows")
				-- Put the value
			ca.put_boolean (True)
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					target_framework_attr_type_token, sig)

			create ca.make
			ca.put_string (".NETCoreApp,Version=v6.0")

				-- Number of named arguments
			ca.put_integer_16 (1)
				-- We mark it's a property
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
				-- Fill `FieldOrPropType' in `ca'
			ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
				-- Put the name of the property
			ca.put_string ("FrameworkDisplayName")
				-- Put the value
			ca.put_string ("")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyCompany("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("test_implementation")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_configuration_token, sig)

			create ca.make
			ca.put_string ("Debug")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyFileVersion("1.0.0.0")]

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_file_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyInformationalVersion("1.0.0")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_info_version_token, sig)

			create ca.make
			ca.put_string ("1.0.0")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyProduct("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_product_token, sig)

			create ca.make
			ca.put_string ("test_implementation")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyTitle("test_main_net6")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_implementation")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

				-- Program.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			my_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_main)

			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_class_c_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, class_c_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_opcode_mdtoken ({MD_OPCODES}.castclass, interface_i_token)
			body.put_call ({MD_OPCODES}.callvirt, im_method_token, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_opcode_mdtoken ({MD_OPCODES}.castclass, interface_j_token)
			body.put_call ({MD_OPCODES}.callvirt, jm_method_token, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)

			method_writer.write_current_body

				-- Program.ctor()
			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_implementation.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

end
