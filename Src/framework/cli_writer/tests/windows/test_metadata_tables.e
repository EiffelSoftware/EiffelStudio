note
	description: "[
			Eiffel tests that can be executed by testing tool.
		]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_METADATA_TABLES

inherit
	EQA_TEST_SET

feature -- Test routines

	test_empty_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			size: INTEGER
		do
			(create {CLI_COM}).initialize_com

			create md_dispenser.make
			md_emit := md_dispenser.emitter
			create l_pe_file.make ("test_empty_com.dll", True, True, False, md_emit)
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
			(create {CLI_COM}).initialize_com

			create md_dispenser.make
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_assembly"),
					0, md_assembly_info, Void)

			create l_pe_file.make ("test_define_assembly_com.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_cli_directory_size
		local
			l_dir: CLI_DIRECTORY
		do
				-- rva: 4 bytes
				-- data_size: 4 bytes
			check {CLI_DIRECTORY}.structure_size = 8 end
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
			check {CLI_HEADER}.structure_size = 72 end
		end

	test_define_type_ref
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
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("typeref_assembly_com"),
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

			create l_pe_file.make ("test_typeref_assembly_com.dll", True, True, False, md_emit)
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
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("member_ref_assembly_com"),
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

			md_emit.set_module_name (create {CLI_STRING}.make ("member_ref_assembly_com.dll"))

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

			create l_pe_file.make ("test_member_ref_assembly_com.dll", True, True, False, md_emit)
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
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("method_assembly_com"),
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

			md_emit.set_module_name (create {CLI_STRING}.make ("method_assembly_com.dll"))

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

			create l_pe_file.make ("test_method_assembly_com.dll", True, True, False, md_emit)
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
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("field_assembly_com"),
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

			md_emit.set_module_name (create {CLI_STRING}.make ("field_assembly_com.dll"))

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

			create l_pe_file.make ("test_field_assembly_com.dll", True, True, False, md_emit)
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
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("signature_local_assembly_com"),
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

			md_emit.set_module_name (create {CLI_STRING}.make ("signature_local_assembly_com.dll"))

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

			create l_pe_file.make ("test_signature_local_assembly_com.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_method_net2
			-- Creation procedure.
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
			md_emit := md_dispenser.emitter

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
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.save
		end

	test_define_entry_point
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			sig: MD_METHOD_SIGNATURE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			my_main: INTEGER
			label_id: INTEGER
			system_exception_token: INTEGER
			string_token: INTEGER
			object_type_token, mscorlib_token, my_assembly, my_type: INTEGER
			md_assembly_info: MD_ASSEMBLY_INFO
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN
			l_entry_type_token, console_type_token, write_line_token, console_token, string_type_token, system_type_token: INTEGER
		do
			create md_dispenser.make
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test"),
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

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("MAIN"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public,
					object_type_token, Void)

			create method_writer.make
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

			body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			body.put_opcode ({MD_OPCODES}.pop)

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)

				-- TODO double check why it fails
				-- When we run including it we got
				-- Unhandled exception. System.MissingMethodException: Method not found: 'Void System.Console.WriteLine(System.String)'.
				-- at MAIN.main()
			body.put_call ({MD_OPCODES}.Call, write_line_token, 0, False)

			body.put_opcode ({MD_OPCODES}.pop)

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test.dll", True, False, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save
		end

	test_define_file
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
			ca: MD_CUSTOM_ATTRIBUTE
			ca_token, string_type_token, attribute_ctor: INTEGER
			console_type_token: INTEGER
			l_hash_file: MANAGED_POINTER
			l_signing: MD_STRONG_NAME
			l_file: CLI_STRING
			l_token_file: INTEGER
		do
			create md_dispenser.make
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_file_com"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
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

			md_emit.set_module_name (create {CLI_STRING}.make ("define_file_com.dll"))

			create l_file.make ("test.txt")
			create l_signing.make_with_version ("Net3")
			l_hash_file := l_signing.hash_of_file (l_file)
			string_token := md_emit.define_string (l_file)
			l_token_file := md_emit.define_file (l_file, l_hash_file, {MD_FILE_FLAGS}.Has_meta_data)

			my_type := md_emit.define_type (create {CLI_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create l_pe_file.make ("test_define_file_com.dll", True, True, False, md_emit)
			l_pe_file.save
		end

end

