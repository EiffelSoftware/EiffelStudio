note
	description: "[
			This code is the mapping of the existing CLI_WRITER.sample (COM interface using Emit API),
			using the new IL_EMITTER library token API .
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_11

feature -- Test

	test
		local
			l_dispenser: MD_DISPENSER
			l_emit: MD_EMIT
			l_assembly_info: MD_ASSEMBLY_INFO
			l_pub_key_token: MD_PUBLIC_KEY_TOKEN
			l_field_sig: MD_FIELD_SIGNATURE
			sig: MD_METHOD_SIGNATURE
			l_local_sig: MD_LOCAL_SIGNATURE

			my_assembly, mscorlib_token, object_type_token, system_exception_token,
			my_type, my_ctor, object_ctor, my_field, local_token, my_meth, my_meth2: INTEGER

			string_token: INTEGER
			method_writer: MD_METHOD_WRITER
			body: MD_METHOD_BODY
			field_sig: MD_FIELD_SIGNATURE
			local_sig: MD_LOCAL_SIGNATURE
			label_id, l_id2: INTEGER
			md_pub_key_token: MD_PUBLIC_KEY_TOKEN

			l_pe_file: CIL_PE_FILE

		do
			create l_dispenser.make
			l_emit := l_dispenser.emit

			create l_assembly_info.make
			l_assembly_info.set_major (5)
			l_assembly_info.set_minor (2)

			my_assembly := l_emit.define_assembly (create {NATIVE_STRING}.make ("manu_assembly"), 0, l_assembly_info, Void)

			l_assembly_info.set_major (1)
			l_assembly_info.set_minor (0)
			l_assembly_info.set_build (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := l_emit.define_assembly_ref (create {NATIVE_STRING}.make ("mscorlib"), l_assembly_info, l_pub_key_token)

			object_type_token := l_emit.define_type_ref (create {NATIVE_STRING}.make ("System.Object"), mscorlib_token)

			system_exception_token := l_emit.define_type_ref (create {NATIVE_STRING}.make ("System.Exception"), mscorlib_token)

			my_type := l_emit.define_type (create {NATIVE_STRING}.make ("TEST"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class | {MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := l_emit.define_member_ref (create {NATIVE_STRING}.make (".ctor"), object_type_token, sig)

			my_ctor := l_emit.define_method (create {NATIVE_STRING}.make (".ctor"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			create l_field_sig.make
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

			my_field := l_emit.define_field (create {NATIVE_STRING}.make ("item"), my_type, {MD_FIELD_ATTRIBUTES}.public, l_field_sig)

			create l_local_sig.make
			l_local_sig.set_local_count (2)
			l_local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			l_local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, my_type)
			local_token := l_emit.define_signature (l_local_sig)

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

			my_meth := L_emit.define_method (create {NATIVE_STRING}.make ("test"),
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

			my_meth2 := l_emit.define_method (create {NATIVE_STRING}.make ("test2"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			method_writer.write_duplicate_body (my_meth, my_meth2)

			my_meth2 := l_emit.define_method (create {NATIVE_STRING}.make ("test_rescue"),
					my_type,
					{MD_METHOD_ATTRIBUTES}.Public,
					sig, {MD_METHOD_ATTRIBUTES}.Managed)

			body := method_writer.new_method_body (my_meth2)
			body.exception_block.set_start_position (body.count)

			label_id := body.define_label

			body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Leave, label_id)

			body.exception_block.set_catch_position (body.count)
			body.exception_block.set_type_token (system_exception_token)

			body.put_opcode ({MD_OPCODES}.pop)
			string_token := l_emit.define_string (create {NATIVE_STRING}.make ("Manu is nice"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Leave, label_id)

			body.exception_block.set_end_position (body.count)

			body.mark_label (label_id)
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ({STRING_32} "test.dll", True, True, False, L_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.save

		end

end
