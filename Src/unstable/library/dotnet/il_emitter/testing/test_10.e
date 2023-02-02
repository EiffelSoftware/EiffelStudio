note
	description: "[
			This code is the mapping of the existing CLI_WRITER.sample (COM interface using Emit API),
			using the new IL_EMITTER library.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_10

feature -- Test

	test
		local
			pe_file: PE_LIB

			cil_dispenser: CIL_DISPENSER
			cil_emit: CIL_EMIT

			cil_assembly_info: CIL_ASSEMBLY_INFO
			working_assembly: CIL_ASSEMBLY_DEF
			cil_type: CIL_CLASS
			cil_method: CIL_METHOD
			l_field: CIL_FIELD
			l_locals: CIL_LOCAL
			l_sig_ctor: CIL_METHOD_SIGNATURE

			l_label, l_id2: CIL_OPERAND
		do
			create cil_dispenser.make
			cil_emit := cil_dispenser.emit

			create cil_assembly_info.make
			cil_assembly_info.set_major (5)
			cil_assembly_info.set_minor (2)

			working_assembly := cil_emit.define_assembly ("manus_assembly", cil_assembly_info, "")

			cil_assembly_info.set_major (1)
			cil_assembly_info.set_minor (0)
			cil_assembly_info.set_build (3300)

			cil_emit.define_mscorlib_assembly_ref (cil_assembly_info, {ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			cil_type := cil_emit.define_type ("TEST", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.auto | {CIL_QUALIFIERS_ENUM}.ansi | {CIL_QUALIFIERS_ENUM}.public), cil_emit.define_type_ref_mscorlib ("Object"))

				-- Method signature for System.object::.ctor()
			create l_sig_ctor.make_default
			l_sig_ctor.set_flags ({CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed | {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag)
			l_sig_ctor.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))
			cil_emit.define_method_ref (".ctor", cil_emit.define_type_ref_mscorlib ("Object"), l_sig_ctor)

				-- Method .ctor
			cil_method := cil_emit.define_method (".ctor", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public |
							{CIL_QUALIFIERS_ENUM}.specialname |
							{CIL_QUALIFIERS_ENUM}.rtspecialname |
							{CIL_QUALIFIERS_ENUM}.cil |
							{CIL_QUALIFIERS_ENUM}.Managed
						), cil_type, False)

			l_field := cil_emit.define_field ("item", create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.object), create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), cil_type)

				-- Locals
			l_locals := cil_emit.define_local_from_basic_type ("l_obj", create {CIL_BASIC_TYPE}.object)
			cil_method.add_local (l_locals)
			l_locals := cil_emit.define_local_from_container ("l_type", cil_type)
			cil_method.add_local (l_locals)

				--Write  Method body

				-- Define labels
			l_label := cil_emit.define_label ("label1")
			l_id2 := cil_emit.define_label ("label2")

			cil_method.mark_label (l_id2)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldarg)
			cil_method.put_call (l_sig_ctor)

			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_label)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2)
			cil_method.mark_label (l_label)
			cil_method.put_return

			cil_emit.dump_output_file ("emit_test_9e.il", {CIL_OUTPUT_MODE}.ilasm, false)


		end

end
