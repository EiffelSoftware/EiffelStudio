note
	description	: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make
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
			(create {CLI_COM}).initialize_com

			create md_dispenser.make
			md_emit := md_dispenser.emitter (create {MD_UI})

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {CLI_STRING}.make ("manu_assembly"),
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

			md_emit.set_module_name (create {CLI_STRING}.make ("manu_assembly.dll"))

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

			my_meth2 := md_emit.define_method (create {CLI_STRING}.make ("test2"),
				my_type,
				{MD_METHOD_ATTRIBUTES}.Public,
				sig, {MD_METHOD_ATTRIBUTES}.Managed)

			method_writer.write_duplicate_body (my_meth, my_meth2)

			my_meth2 := md_emit.define_method (create {CLI_STRING}.make ("test_rescue"),
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
			string_token := md_emit.define_string (create {CLI_STRING}.make ("Manu is nice"))
			body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, string_token)
			body.put_opcode ({MD_OPCODES}.pop)
			body.put_opcode_label ({MD_OPCODES}.Leave, label_id)

			body.exception_block.set_end_position (body.count)

			body.mark_label (label_id)
			body.put_opcode ({MD_OPCODES}.Ret)
			method_writer.write_current_body

			create l_pe_file.make ("test.dll", True, True, False, md_emit)
			l_pe_file.set_method_writer (method_writer)
			l_pe_file.save
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ROOT_CLASS
