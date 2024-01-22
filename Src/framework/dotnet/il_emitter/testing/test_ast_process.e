note
	description: "Summary description for {TEST_AST_PROCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_AST_PROCESS

inherit
	TEST_I

feature -- Tests

	test_ast_process
			-- Build the following example
			--
			-- Interface I
			--     method M, P, N
			-- Interface J
			--    method M
			-- Interface L
			-- 	  no methods.
			-- Class C: I, J, L
			--     implements I.M, P, N, I.M
			-- Class Programs that uses C
			-- following this process
			--
			--1. Generate Types
			--		1.1 define_type
			--			-- At this point field index and method index were not computed.
			--
			--		1.2 Generate Methods per Type
			--			1.2.1  define_method
			--				-- At this point param index was not computer.
			--
			--			1.2.2  define_params
			--				-- here we can update the param index.
			--
			--		1.3 Generate fields per type define_field
			--			-- Here we can compute the param index.
			--
			-- The current example doesn't support Params and Fields
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
			interface_i_token, interface_j_token, interface_l_token: INTEGER
			im_method_token, jm_method_token: INTEGER
			ip_method_token, in_method_token: INTEGER
			l_class_c_token: INTEGER
			class_c_ctor: INTEGER
			my_p_method: INTEGER
			my_n_method: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_ast_process"), 0, md_assembly_info, Void)

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

				-- Define All Types
				-- Interface I, J,
				-- Classes C and Program

				-- Define interface I
			interface_i_token := md_emit.define_type (
					create {CLI_STRING}.make ("I"),
					{MD_TYPE_ATTRIBUTES}.abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define interface J
			interface_j_token := md_emit.define_type (
					create {CLI_STRING}.make ("J"),
					{MD_TYPE_ATTRIBUTES}.Abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define interface L
			interface_l_token := md_emit.define_type (
					create {CLI_STRING}.make ("L"),
					{MD_TYPE_ATTRIBUTES}.Abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define Class C: I, J, L
			l_class_c_token := md_emit.define_type (
					create {CLI_STRING}.make ("C"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, <<interface_i_token, interface_j_token, interface_l_token>>)

				-- Define the Root Class Program

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

				-- Define method M and P  and N in I interface
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

			ip_method_token := md_emit.define_method (create {CLI_STRING}.make ("P"),
					interface_i_token,
					{MD_METHOD_ATTRIBUTES}.Abstract |
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			in_method_token := md_emit.define_method (create {CLI_STRING}.make ("N"),
					interface_i_token,
					{MD_METHOD_ATTRIBUTES}.Abstract |
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

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

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Class C
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

				-- Class C.ctor()
				-- Begin
			body := method_writer.new_method_body (class_c_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				-- End

				-- Implement Methods I.M, P, N, J.M
				-- Using the same signature as a First Test

				-- I.M
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				--Begin
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
				--End

				-- P
				-- Begin
			my_p_method := md_emit.define_method (create {CLI_STRING}.make ("P"),
					l_class_c_token,
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_p_method)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Method P"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				-- End

				-- N
				-- Begin
			my_n_method := md_emit.define_method (create {CLI_STRING}.make ("N"),
					l_class_c_token,
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_n_method)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Method N"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				-- End

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
				-- End

			md_emit.define_method_impl (l_class_c_token, my_jm_method, jm_method_token)
			md_emit.define_method_impl (l_class_c_token, my_im_method, im_method_token)
			md_emit.define_method_impl (l_class_c_token, my_p_method, ip_method_token)
			md_emit.define_method_impl (l_class_c_token, my_n_method, in_method_token)

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
			ca.put_string ("test_ast_process")
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
			ca.put_string ("test_implementation_2")
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
			ca.put_string ("test_ast_process")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

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

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, my_n_method, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, my_p_method, 0, False)
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

			create l_pe_file.make ("test_ast_process.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_basic_interface
			-- Build an interface example
			-- Define interface IPrintable
			-- 	with a method Print()
			-- Define interface IMark
			-- 	no methods
			-- Class Program: IPrintable, IMark
			-- Follow the AST process
			-- Compare the output with the cs\basic_interface example.
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
			local_sig: MD_LOCAL_SIGNATURE
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_basic_interface"), 0, md_assembly_info, Void)

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

			md_emit.set_module_name (create {CLI_STRING}.make ("test_basic_interface.dll"))

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
			ca.put_string ("test_basic_interface")
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
			ca.put_string ("test_basic_interface")
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
			ca.put_string ("test_basic_interface")
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

				-- md_emit.define_method_impl (l_entry_type_token, imp_print_method_token, iprint_method_token )

				-- Implement the Print method
			body := method_writer.new_method_body (imp_print_method_token)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Testing Basic Interfaces"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

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
			body.put_call ({MD_OPCODES}.call, imp_print_method_token, 0, True)

			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Define Method .ctor
			my_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Implement Program.ctor
				-- Program.ctor()
			body := method_writer.new_method_body (my_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test_basic_interface.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_class
			-- Build a basic class MyClass with multiple methods
			-- from A .. K and each one will print out their names
			-- to the Console. The example targets .Net6.
			-- Uses the AST process

		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
			system_console_token: INTEGER

			assembly_file_version_token, assembly_title_token,
			assembly_configuration_token, assembly_product_token,
			assembly_info_version_token, assembly_company_token: INTEGER

			compilation_relaxations_token, runtime_compatibility_token,
			int32_type_token, target_framework_attr_type_token,
			object_type_token, string_type_token,
			console_type_token: INTEGER

			local_token, method_main, string_token,
			method_a, method_b, method_c, method_d,
			method_e, method_f, method_g, method_h,
			method_i, method_j, method_k,
			my_class_ctor,
			object_ctor, l_entry_type_token,
			attribute_ctor, ca_token,
			write_line_token: INTEGER

			sig: MD_METHOD_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			local_sig: MD_LOCAL_SIGNATURE
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_class_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)
			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

				-- Utility tokens.
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

				-- Module Name
			md_emit.set_module_name (create {CLI_STRING}.make ("define_class_net6.dll"))

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

				-- Access to the Method Console.WriteLine

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Object constructor .ctor.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Method Writer to be used in the class MyClass

			create method_writer.make

				-- Define Type MyClass

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("MyClass"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

				-- Define the Signature common to all the methods of the Class MyClass

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- MyClass.A() implementation

			method_a := md_emit.define_method (create {CLI_STRING}.make ("A"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_a)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("A"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.B() implementation
			method_b := md_emit.define_method (create {CLI_STRING}.make ("B"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_b)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("B"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.C() implementation
			method_c := md_emit.define_method (create {CLI_STRING}.make ("C"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_c)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("C"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.D() implementation
			method_d := md_emit.define_method (create {CLI_STRING}.make ("D"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_d)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("D"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.E() implementation
			method_e := md_emit.define_method (create {CLI_STRING}.make ("E"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_e)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("E"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.F() implementation
			method_f := md_emit.define_method (create {CLI_STRING}.make ("F"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_f)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("F"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.G() implementation
			method_g := md_emit.define_method (create {CLI_STRING}.make ("G"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_g)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("G"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.H() implementation
			method_h := md_emit.define_method (create {CLI_STRING}.make ("H"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_h)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("H"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.I() implementation
			method_i := md_emit.define_method (create {CLI_STRING}.make ("I"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_i)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("I"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.J() implementation
			method_j := md_emit.define_method (create {CLI_STRING}.make ("J"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_j)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("J"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- MyClass.K() implementation
			method_k := md_emit.define_method (create {CLI_STRING}.make ("K"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_k)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("K"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- MyClass.ctor() implementation
			my_class_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define method Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			method_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_main)
			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_class_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, method_a, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, method_b, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, method_c, 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			body := method_writer.new_method_body (my_class_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("define_class_net6.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (method_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end

	test_define_params
			-- Build a basic class Program with multiple methods
			-- from F1 .. F3 and each one will print out their names
			-- to the Console. The example targets .Net6.
			-- Uses the AST process

		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
			system_console_token: INTEGER

			assembly_file_version_token, assembly_title_token,
			assembly_configuration_token, assembly_product_token,
			assembly_info_version_token, assembly_company_token: INTEGER

			compilation_relaxations_token, runtime_compatibility_token,
			int32_type_token, target_framework_attr_type_token,
			object_type_token, string_type_token,
			console_type_token: INTEGER

			local_token, method_main, string_token,
			method_F1, method_F2, method_F3, my_class_ctor,
			object_ctor, l_entry_type_token,
			attribute_ctor, ca_token,
			write_line_tokens, write_line_tokeni: INTEGER

			sig: MD_METHOD_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			local_sig: MD_LOCAL_SIGNATURE
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_params_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)
			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

				-- Utility tokens.
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

				-- Module Name
			md_emit.set_module_name (create {CLI_STRING}.make ("define_params_net6.dll"))

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

				-- Access to the Method Console.WriteLine(String)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_tokens := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Method Console.WriteLine(String)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

			write_line_tokeni := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Object constructor .ctor.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Method Writer to be used in the class MyClass

			create method_writer.make

				-- Define Type MyClass

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

				-- Define the Signature F1(int i)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

				-- Program.F1(int) implementation

			method_F1 := md_emit.define_method (create {CLI_STRING}.make ("F1"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F1)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				-- Define the Signature F2(string str, int i)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (2)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)

				-- Program.F2(string str, int i) implementation

			method_F2 := md_emit.define_method (create {CLI_STRING}.make ("F2"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F2)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_2)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				-- Define the Signature F3(string str, int i, string str2)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (3)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, int32_type_token)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

				-- Program.F3(string str, int i, string str2) implementation

			method_F3 := md_emit.define_method (create {CLI_STRING}.make ("F3"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F3)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_2)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_3)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Program.ctor() implementation
			my_class_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define method Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			method_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_main)
			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (3)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_class_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F1"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 10)
			body.put_call ({MD_OPCODES}.callvirt, method_F1, 1, False)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F2"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.ldloc_0)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 11)
			body.put_call ({MD_OPCODES}.callvirt, method_F2, 2, False)
			body.put_nop


			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F3"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.ldloc_0)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 12)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("World"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.callvirt, method_F3, 3, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Implementation of Program.ctor()
			body := method_writer.new_method_body (my_class_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("define_param_net6.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (method_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end


	test_define_params_default
			-- Build a basic class Program with multiple methods
			-- from F1 .. F3 and each one will print out their names
			-- to the Console. The example targets .Net6.
			-- Uses the AST process
			-- set types using 0 instead of the corresponding token type.

		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
			system_console_token: INTEGER

			assembly_file_version_token, assembly_title_token,
			assembly_configuration_token, assembly_product_token,
			assembly_info_version_token, assembly_company_token: INTEGER

			compilation_relaxations_token, runtime_compatibility_token,
			int32_type_token, target_framework_attr_type_token,
			object_type_token, string_type_token,
			console_type_token: INTEGER

			local_token, method_main, string_token,
			method_F1, method_F2, method_F3, my_class_ctor,
			object_ctor, l_entry_type_token,
			attribute_ctor, ca_token,
			write_line_tokens, write_line_tokeni: INTEGER

			sig: MD_METHOD_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			local_sig: MD_LOCAL_SIGNATURE
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_params_default_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)
			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)

				-- Utility tokens.
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

				-- Module Name
			md_emit.set_module_name (create {CLI_STRING}.make ("define_params_net6.dll"))

				--
				-- Begin Metadata
				-- TODO check why adding the metadata cause issues with the Base Relation Table
				--

				-- [assembly: CompilationRelaxations(8)]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_company_token, sig)

			create ca.make
			ca.put_string ("define_params_default_net6")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				-- [assembly: AssemblyConfiguration("Debug")]
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

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
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

			attribute_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					assembly_title_token, sig)

			create ca.make
			ca.put_string ("test_main_net6")
			ca_token := md_emit.define_custom_attribute (my_assembly, attribute_ctor, ca)

				--
				-- End  Metadata
				--

				-- Access to the Method Console.WriteLine(String)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

			write_line_tokens := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Method Console.WriteLine(String)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)

			write_line_tokeni := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Object constructor .ctor.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Method Writer to be used in the class MyClass

			create method_writer.make

				-- Define Type MyClass

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Program"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, Void)

				-- Define the Signature F1(int i)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)

				-- Program.F1(int) implementation

			method_F1 := md_emit.define_method (create {CLI_STRING}.make ("F1"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F1)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				-- Define the Signature F2(string str, int i)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (2)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)

				-- Program.F2(string str, int i) implementation

			method_F2 := md_emit.define_method (create {CLI_STRING}.make ("F2"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F2)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_2)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body



				-- Define the Signature F3(string str, int i, string str2)
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (3)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

				-- Program.F3(string str, int i, string str2) implementation

			method_F3 := md_emit.define_method (create {CLI_STRING}.make ("F3"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_F3)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_1)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_2)
			body.put_static_call (write_line_tokeni, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldarg_3)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Program.ctor() implementation
			my_class_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define method Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			method_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_main)
			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (3)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_class_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F1"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 10)
			body.put_call ({MD_OPCODES}.callvirt, method_F1, 1, False)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F2"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.ldloc_0)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 11)
			body.put_call ({MD_OPCODES}.callvirt, method_F2, 2, False)
			body.put_nop


			string_token := md_emit.define_string (create {CLI_STRING}.make ("Function F3"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_tokens, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.ldloc_0)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Hello"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode_mdtoken ({MD_OPCODES}.ldc_i4, 12)
			string_token := md_emit.define_string (create {CLI_STRING}.make ("World"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_call ({MD_OPCODES}.callvirt, method_F3, 3, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

				-- Implementation of Program.ctor()
			body := method_writer.new_method_body (my_class_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("define_params_default_net6.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (method_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end


	test_define_class_app
			-- Build a basic class MyClass inherit from ANY with a method
			-- from A to the Console. The example targets .Net6.
			-- Uses the AST process

		local
			l_pe_file: CLI_PE_FILE
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			my_assembly, system_runtime_token: INTEGER
			system_console_token: INTEGER

			assembly_file_version_token, assembly_title_token,
			assembly_configuration_token, assembly_product_token,
			assembly_info_version_token, assembly_company_token: INTEGER

			compilation_relaxations_token, runtime_compatibility_token,
			int32_type_token, target_framework_attr_type_token,
			object_type_token, string_type_token,
			console_type_token: INTEGER

			local_token, method_main, string_token,
			method_a,
			my_class_ctor,
			object_ctor, l_entry_type_token,
			attribute_ctor, ca_token,
			write_line_token: INTEGER

			sig: MD_METHOD_SIGNATURE
			ca: MD_CUSTOM_ATTRIBUTE
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			local_sig: MD_LOCAL_SIGNATURE


			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN

			ise_runtime_token,
			l_ise_runtime_token,
			ise_any_type_token: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("define_class_app_net6"), 0, md_assembly_info, Void)

			md_assembly_info.set_major_version (6)
			md_assembly_info.set_minor_version (0)
			md_assembly_info.set_build_number (0)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xE0, 0x0A, 0x5E, 0xC9, 0x26, 0x36, 0x2E, 0x35>>)

				-- PublicKeyToken=b03f5f7f11d50a3a	
			system_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Runtime"), md_assembly_info, l_pub_key_token)
			system_console_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("System.Console"), md_assembly_info, l_pub_key_token)


				-- Define `ise_runtime_token'.
			create l_ass_info.make
			l_ass_info.set_major_version (7)
			l_ass_info.set_minor_version (3)
			l_ass_info.set_build_number (9)
			l_ass_info.set_revision_number (2490)

			create l_pub_key.make_from_array (
				{ARRAY [NATURAL_8]} <<0xDE, 0xF2, 0x6F, 0x29, 0x6E, 0xFE, 0xF4, 0x69>>)

			ise_runtime_token := md_emit.define_assembly_ref (create {CLI_STRING}.make ("EiffelSoftware.Runtime"), l_ass_info, l_pub_key)
			ise_any_type_token := md_emit.define_type_ref (create {CLI_STRING}.make ("EiffelSoftware.Runtime.ANY"), ise_runtime_token)

				-- Utility tokens.
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

				-- Module Name
			md_emit.set_module_name (create {CLI_STRING}.make ("define_class_app_net6.dll"))

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

				-- Access to the Method Console.WriteLine

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (1)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

			write_line_token := md_emit.define_member_ref (
					create {CLI_STRING}.make ("WriteLine"),
					console_type_token, sig)

				-- Access to the Object constructor .ctor.
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := md_emit.define_member_ref (create {CLI_STRING}.make (".ctor"),
					object_type_token, sig)

				-- Method Writer to be used in the class MyClass

			create method_writer.make

				-- Define Type MyClass

			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("MyClass"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, <<ise_any_type_token>>)

				-- Define the Signature common to all the methods of the Class MyClass

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- MyClass.A() implementation

			method_a := md_emit.define_method (create {CLI_STRING}.make ("A"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_a)
			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("A"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- MyClass.ctor() implementation
			my_class_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

				-- Define method Main
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			method_main := md_emit.define_method (create {CLI_STRING}.make ("Main"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (method_main)
			create local_sig.make
			local_sig.set_local_count (1)
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, my_class_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, method_a, 0, False)
			body.put_nop


			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			body := method_writer.new_method_body (my_class_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("define_class_app_net6.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (method_main)
			l_pe_file.save

			{NETCORE_UTILITIES}.deploy (l_pe_file, "Microsoft.NETCore.App/6.0.0", md_assembly_info)
		end


end
