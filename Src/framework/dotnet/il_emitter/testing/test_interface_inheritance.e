note
	description: "Summary description for {TEST_INTERFACE_INHERITANCE}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTERFACE_INHERITANCE

inherit
	TEST_I

feature

	test_inheritance
			-- Build the following example
			--
			-- Interface IAnimal
			--     method MakeSound
			-- Interface IDog: IAnimal
			--    method Fetch
			-- Class Dog: IDog
			--     implements Fetch and MakeSound
			-- 	   Main method create an instance of Dog
			--     call MakeSound and Fetch			
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
			my_jm_method, m_make_sound_token, assembly_title_token: INTEGER
			string_value_token: INTEGER
			property_token: INTEGER
			iprintable_token: INTEGER
			iprint_method_token: INTEGER
			imp_print_method_token: INTEGER
			ianimal_token, idog_token: INTEGER
			i_make_sound_token, i_fetching_token: INTEGER
			ip_method_token, in_method_token: INTEGER
			class_c_ctor: INTEGER
			m_fetching_token: INTEGER
			my_n_method: INTEGER
		do
			md_emit := new_emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (1) -- set_minor_version
			md_assembly_info.set_minor_version (0)

			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("test_inheritance"), 0, md_assembly_info, Void)

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

			md_emit.set_module_name (create {CLI_STRING}.make ("test_inheritance"))

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

				-- Define interface IAnimal
			ianimal_token := md_emit.define_type (
					create {CLI_STRING}.make ("IAnimal"),
					{MD_TYPE_ATTRIBUTES}.abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					Void)

				-- Define interface IDog
			idog_token := md_emit.define_type (
					create {CLI_STRING}.make ("IDog"),
					{MD_TYPE_ATTRIBUTES}.Abstract |
					{MD_TYPE_ATTRIBUTES}.is_interface |
					{MD_TYPE_ATTRIBUTES}.Auto_layout,
					0,
					<<ianimal_token>>)

				-- Define Class Dog: IDog
			l_entry_type_token := md_emit.define_type (
					create {CLI_STRING}.make ("Dog"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public | {MD_TYPE_ATTRIBUTES}.before_field_init,
					object_type_token, <<idog_token>>)


				-- Define the Root Class Program


				-- Define method MakeSounf
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			i_make_sound_token := md_emit.define_method (create {CLI_STRING}.make ("MakeSound"),
					ianimal_token,
					{MD_METHOD_ATTRIBUTES}.Abstract |
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig,
					{MD_METHOD_ATTRIBUTES}.Managed)


				-- Define method Fetch in IDog interface
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			i_fetching_token := md_emit.define_method (create {CLI_STRING}.make ("Fetch"),
					idog_token,
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

				-- Class Dog
				-- Dog.ctor signature
			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			class_c_ctor := md_emit.define_method (create {CLI_STRING}.make (".ctor"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create method_writer.make

				-- Class Dog.ctor()
				-- Begin
			body := method_writer.new_method_body (class_c_ctor)
			body.put_opcode ({MD_OPCODES}.Ldarg_0)
			body.put_static_call (object_ctor, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				-- End


				-- Implement Methods MakeSound and Fetch

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				--Begin
			m_make_sound_token := md_emit.define_method (create {CLI_STRING}.make ("MakeSound"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual |
					{MD_METHOD_ATTRIBUTES}.new_slot,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (m_make_sound_token)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Woof!"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				--End

				-- P
				-- Begin
			m_fetching_token := md_emit.define_method (create {CLI_STRING}.make ("Fetch"),
							l_entry_type_token,
							{MD_METHOD_ATTRIBUTES}.public |
							{MD_METHOD_ATTRIBUTES}.hide_by_signature |
							{MD_METHOD_ATTRIBUTES}.virtual |
							{MD_METHOD_ATTRIBUTES}.new_slot,
							sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (m_fetching_token)

			body.put_nop

			string_token := md_emit.define_string (create {CLI_STRING}.make ("Fetching !"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_static_call (write_line_token, 1, False)
			body.put_nop
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body
				-- End


			md_emit.define_method_impl (l_entry_type_token, m_make_sound_token, i_make_sound_token )
			md_emit.define_method_impl (l_entry_type_token, m_fetching_token, i_fetching_token)

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
			ca.put_string ("test_inheritance")
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
			ca.put_string ("test_inheritance")
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
			local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, l_entry_type_token)
			local_token := md_emit.define_signature (local_sig)
			body.set_local_token (local_token)
			body.update_stack_depth (2)

			body.put_nop

			body.put_call ({MD_OPCODES}.newobj, class_c_ctor, 0, False)
			body.put_opcode ({MD_OPCODES}.stloc_0)


			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, m_make_sound_token , 0, False)
			body.put_nop

			body.put_opcode ({MD_OPCODES}.ldloc_0)
			body.put_call ({MD_OPCODES}.callvirt, m_fetching_token , 0, False)
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

			create l_pe_file.make ("test_inheritance.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.set_entry_point_token (my_main)
			l_pe_file.save

		end
end
