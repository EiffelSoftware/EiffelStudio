note
	description: "Summary description for {TEST_MODULES_NET_FRAMEWORK}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MODULES_NET_FRAMEWORK

feature -- Test

	test_modules

		do
			module_2
			app
		end

feature -- app_module

	app
			-- Define an APP
			--	With references to Module1 and Module2
			--	Class Program with Method Main.

		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
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

			l_hash_file: MANAGED_POINTER
			l_signing: MD_STRONG_NAME
			l_file: CLI_STRING
			l_token_file_m1, l_token_file_m2: INTEGER
			module_1_token, module_2_token: INTEGER
			c_token: INTEGER
			class_b_m2: INTEGER
			class_b_method_j_token: INTEGER
			class_b_object_ctor: INTEGER
			mscorlib_token: INTEGER
			l_type_token: INTEGER
		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("app.exe"),
					0, md_assembly_info, Void)

			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"), md_assembly_info, l_pub_key_token)

			object_type_token := define_type_ref (md_emit, "System.Object", mscorlib_token)
			string_type_token := define_type_ref (md_emit, "System.String", mscorlib_token)
			console_type_token := define_type_ref (md_emit, "System.Console", mscorlib_token)
			int32_type_token := define_type_ref (md_emit, "System.Int32", mscorlib_token)

			md_emit.set_module_name (create {CLI_STRING}.make ("app.exe"))

				-- Define code to access System.Console.WriteLine

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Define file module2

			create l_file.make ("module_2.dll")
			create l_signing.make_with_version ("v4.0.30319")
			l_hash_file := l_signing.hash_of_file (l_file)
			l_token_file_m2 := md_emit.define_file (l_file, l_hash_file, {MD_FILE_FLAGS}.Has_meta_data)

			module_2_token := md_emit.define_module_ref (create {CLI_STRING}.make ("module_2.dll"))

			class_b_m2 := md_emit.define_type_ref (
					create {CLI_STRING}.make ("B"), module_2_token)

			md_emit.define_exported_type (create {CLI_STRING}.make ("B"), l_token_file_m2, class_b_token, {MD_TYPE_ATTRIBUTES}.Public).do_nothing

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			class_b_method_j_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("J"),
					class_b_m2, sig)

			class_b_object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					class_b_m2, sig)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				--
				-- Class Program
				--

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			create method_writer.make

				-- Method Main
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
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, class_b_m2)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (8)
			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, class_b_object_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, class_b_method_j_token, 0, False)
			body.put_nop

				-- Load the string "Hello" onto the stack

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello world from Eiffel!!!"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Method .ctor class Program

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

			create l_pe_file.make ("app.exe", True, False, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save
		end

feature -- Modules

	module_2
			-- Define a Module2 with a Class B and method J
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			sig: MD_METHOD_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY

			system_console_token, system_runtime_token: INTEGER
			object_type_token, string_type_token, console_type_token: INTEGER
			int32_type_token: INTEGER
			attribute_ctor: INTEGER
			target_framework_attr_type_token, compilation_relaxations_token: INTEGER
			ca_token: INTEGER
			write_line_token: INTEGER
			object_ctor: INTEGER
			l_class_b_token: INTEGER
			class_b_ctor: INTEGER
			j_method: INTEGER
			string_token: INTEGER
			mscorlib_token: INTEGER
		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("mscorlib"), md_assembly_info, l_pub_key_token)

			object_type_token := define_type_ref (md_emit, "System.Object", mscorlib_token)
			string_type_token := define_type_ref (md_emit, "System.String", mscorlib_token)
			console_type_token := define_type_ref (md_emit, "System.Console", mscorlib_token)
			int32_type_token := define_type_ref (md_emit, "System.Int32", mscorlib_token)

				-- Definition of WriteLine method.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_token := define_member_ref (md_emit, "WriteLine", console_type_token, sig)

				--
				-- Object.ctor
				--
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"), object_type_token, sig)

				--
				-- Define Class B
				--

			l_class_b_token := md_emit.define_type (
					create {CLI_STRING}.make ("B"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

			class_b_token := l_class_b_token
			create method_writer.make

				--
				-- Method J in class B
				--
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			j_method := md_emit.define_method (create {CLI_STRING}.make ("J"),
					l_class_b_token,
					{MD_METHOD_ATTRIBUTES}.public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (j_method)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Message from Class B method J"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Method .ctor class B

				-- C.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			class_b_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_class_b_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (class_b_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Set module name
			md_emit.set_module_name (create {CLI_STRING}.make ("module_2.dll"))

				-- Save Module

			create l_pe_file.make ("module_2.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.save
		end

feature -- Helper

	define_assembly_ref (md_emit: MD_EMIT; name: STRING; assembly_info: MD_ASSEMBLY_INFO; pub_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER
		do
			Result := md_emit.define_assembly_ref (create {CLI_STRING}.make (name), assembly_info, pub_key_token)
		end

	define_type_ref (md_emit: MD_EMIT; type_name: STRING; assembly_token: INTEGER): INTEGER
		do
			Result := md_emit.define_type_ref (create {CLI_STRING}.make (type_name), assembly_token)
		end

	define_member_ref (md_emit: MD_EMIT; member_name: STRING; type_token: INTEGER; signature: MD_METHOD_SIGNATURE): INTEGER
		do
			Result := md_emit.define_member_ref (create {CLI_STRING}.make (member_name), type_token, signature)
		end

	define_custom_attribute (md_emit: MD_EMIT; assembly_token, ctor_token: INTEGER; a_attribute: MD_CUSTOM_ATTRIBUTE): INTEGER
		do
			Result := md_emit.define_custom_attribute (assembly_token, ctor_token, a_attribute)
		end

	define_custom_attribute_with_integer (md_emit: MD_EMIT; assembly_token, ctor_token, int_value: INTEGER): INTEGER
		local
			ca: MD_CUSTOM_ATTRIBUTE
		do
			create ca.make
			ca.put_integer_32 (int_value)
			Result := md_emit.define_custom_attribute (assembly_token, ctor_token, ca)
		end

	define_attribute_ctor (md_emit: MD_EMIT; a_type_token: INTEGER; sig: MD_METHOD_SIGNATURE): INTEGER
		do
			Result := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"), a_type_token, sig)
		end

	class_c_token: INTEGER
	class_b_token: INTEGER

end
