note
	description: "Summary description for {TEST_METADATA_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_METADATA_TABLES_TK

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
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT

		do
			create md_dispenser.make
			md_emit := md_dispenser.emit
			create l_pe_file.make ("test_empty_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			my_assembly: INTEGER
		do

			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("manus_assembly"),
					0, md_assembly_info, Void)

			create l_pe_file.make ({STRING_32} "test_define_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_user_string_heap
		local
			l_token1, l_token2, l_token3: NATURAL_64
			l_str: STRING_32
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			l_result: NATURAL_64
			l_table_type_index: NATURAL_64
			l_index: NATURAL_64
		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			l_token1 := md_emit.define_string (create {NATIVE_STRING}.make ("Eiffel")).to_natural_64
			l_token2 := md_emit.define_string (create {NATIVE_STRING}.make ("Java")).to_natural_64
			l_token3 := md_emit.define_string (create {NATIVE_STRING}.make ("TEST_METADATA_TABLES_TK")).to_natural_64
			l_str := md_emit.retrieve_user_string (l_token1.to_integer_32)
			check same_string: l_str.same_string_general ("Eiffel") end

			l_str := md_emit.retrieve_user_string (l_token2.to_integer_32)
			check same_string: l_str.same_string_general ("Java") end
			l_str := md_emit.retrieve_user_string (l_token3.to_integer_32)
			check same_string: l_str.same_string_general ("TEST_METADATA_TABLES_TK") end
		end

	test_define_module
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, mscorlib_token: INTEGER

		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)

			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("module_assembly"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"), md_assembly_info, l_pub_key_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("module_assembly.dll"))

			create l_pe_file.make ("module_assembly.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_module_net6
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (6) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("module_assembly_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

			system_runtime_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("module_assembly_net6.dll"))

			create l_pe_file.make ("module_assembly_net6.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_type_ref
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("typeref_assembly_tk"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			system_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System"), mscorlib_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			tasks_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Threading.Tasks"), mscorlib_token)

			create l_pe_file.make ("test_typeref_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_type
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("typedef_assembly_tk"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			system_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System"), mscorlib_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			tasks_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Threading.Tasks"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("typedef_assembly_tk.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create l_pe_file.make ("test_typedef_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_member_ref
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("member_ref_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("member_ref_assembly.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"),
					object_type_token, sig)

			create l_pe_file.make ("test_member_ref_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save

		end

	test_define_method
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("method_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("method_assembly.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {NATIVE_STRING}.make (".ctor"),
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
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("field_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("field_assembly.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {NATIVE_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {NATIVE_STRING}.make ("item"), my_type,
					{MD_FIELD_ATTRIBUTES}.public, field_sig)

			create l_pe_file.make ("test_field_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end


	test_define_signature_local
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("signature_local_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("signature_local_assembly.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {NATIVE_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {NATIVE_STRING}.make ("item"), my_type,
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
			md_dispenser: MD_DISPENSER
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
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("method_assembly"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create md_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
			mscorlib_token := md_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"),
					md_assembly_info, md_pub_key_token)

			object_type_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := md_emit.define_type_ref (
					create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			md_emit.set_module_name (create {NATIVE_STRING}.make ("method_assembly.dll"))

			my_type := md_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"),
					object_type_token, sig)

			my_ctor := md_emit.define_method (create {NATIVE_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create field_sig.make
			field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := md_emit.define_field (create {NATIVE_STRING}.make ("item"), my_type,
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

			my_meth := md_emit.define_method (create {NATIVE_STRING}.make ("test"),
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
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.save
		end

end
