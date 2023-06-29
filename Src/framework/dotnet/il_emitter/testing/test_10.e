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

			cil_assembly_info: MD_ASSEMBLY_INFO
			working_assembly: CIL_ASSEMBLY_DEF
			cil_type: CIL_CLASS
			cil_method: CIL_METHOD
			l_field: CIL_FIELD
			l_locals: CIL_LOCAL
			l_sig_ctor: CIL_METHOD_SIGNATURE
			l_method_sig: CIL_METHOD_SIGNATURE
			l_exception: CIL_CLASS

			l_label, l_id2: CIL_OPERAND
		do
			create cil_dispenser.make
			cil_emit := cil_dispenser.emit

			create cil_assembly_info.make
			cil_assembly_info.set_major_version (5)
			cil_assembly_info.set_minor_version (2)

			working_assembly := cil_emit.define_assembly ({STRING_32}"manu_assembly", cil_assembly_info, "")

			cil_assembly_info.set_major_version (1)
			cil_assembly_info.set_minor_version (0)
			cil_assembly_info.set_build_number (3300)

			cil_emit.define_mscorlib_assembly_ref (cil_assembly_info, {ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			cil_type := cil_emit.define_type ({STRING_32}"TEST", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.auto | {CIL_QUALIFIERS_ENUM}.ansi | {CIL_QUALIFIERS_ENUM}.public), cil_emit.define_type_ref_mscorlib ({STRING_32}"Object"))

				-- Method signature for System.object::.ctor()
			create l_sig_ctor.make_default
			l_sig_ctor.set_flags ({CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed | {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag)
			l_sig_ctor.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))
			cil_emit.define_method_ref (".ctor", cil_emit.define_type_ref_mscorlib ("Object"), l_sig_ctor)

				-- Method signature for TEST::.ctor()
			create l_method_sig.make (".ctor", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			cil_method := cil_emit.define_method (l_method_sig, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public |
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
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldarg_0)
			cil_method.put_call (l_sig_ctor)

			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_label)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2)
			cil_method.mark_label (l_label)
			cil_method.put_return

				-- Define method test

				-- Method signature for TEST::.test()
			create l_method_sig.make (".test", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			cil_method := cil_emit.define_method (l_method_sig, create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.public |
							{CIL_QUALIFIERS_ENUM}.cil |
							{CIL_QUALIFIERS_ENUM}.Managed
						), cil_type, False)

				-- Define labels
			l_label := cil_emit.define_label ("label1")
			l_id2 := cil_emit.define_label ("label2")

				-- Write method body
			cil_method.mark_label (l_id2)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_label)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2)
			cil_method.mark_label (l_label)
			cil_method.put_return

				-- Define method test2

				-- Method signature for TEST::.test2()
			create l_method_sig.make (".test2", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			cil_method := cil_emit.define_method (l_method_sig, create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.public |
							{CIL_QUALIFIERS_ENUM}.cil |
							{CIL_QUALIFIERS_ENUM}.Managed
						), cil_type, False)

				-- Define labels
			l_label := cil_emit.define_label ("label1")
			l_id2 := cil_emit.define_label ("label2")

				-- Write method body
			cil_method.mark_label (l_id2)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_label)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2)
			cil_method.mark_label (l_label)
			cil_method.put_return

				-- Define method test_rescue

			l_exception := cil_emit.define_type_ref_mscorlib ("Exception")
			create l_method_sig.make (".test_rescue", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			cil_method := cil_emit.define_method (l_method_sig, create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.public |
							{CIL_QUALIFIERS_ENUM}.cil |
							{CIL_QUALIFIERS_ENUM}.Managed
						), cil_type, False)

				-- Define labels
			l_label := cil_emit.define_label ("label1")

				-- Write body

			cil_method.put_exception_block_start
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_leave, l_label)
			cil_method.put_exception_block_end

			cil_method.put_exception_catch_start (if attached l_exception then create {CIL_TYPE}.make_with_container (l_exception) else Void end)
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_mdtoken ({CIL_INSTRUCTION_OPCODES}.i_ldstr, "Manu is nice!!")
			cil_method.put_opcode ({CIL_INSTRUCTION_OPCODES}.i_pop)
			cil_method.put_opcode_label ({CIL_INSTRUCTION_OPCODES}.i_leave, l_label)
			cil_method.put_exception_catch_end
			cil_method.mark_label (l_label)
			cil_method.put_return

				-- Generate the output.
			cil_emit.dump_output_file ("emit_test_9e.il", {CIL_OUTPUT_MODE}.ilasm, false)
			cil_emit.dump_output_file ("emit_test_9e.dll", {CIL_OUTPUT_MODE}.pedll, false)

		end

end
