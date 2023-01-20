note
	description: "[
			This code is the mapping of the existing CLI_WRITER.sample (COM interface using Emit API),
			using the new IL_EMITTER library.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_9

feature -- Test

	test
		local
			pe_file: PE_LIB
			assembly: CIL_ASSEMBLY_DEF
			sig_main: CIL_METHOD_SIGNATURE
			method_main: CIL_METHOD
			mscorlib: CIL_ASSEMBLY_DEF
			l_result: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			l_system: CIL_NAMESPACE
			l_console: CIL_CLASS
			l_exception: CIL_CLASS
			l_object: CIL_CLASS
			l_sig_write_line: CIL_METHOD_SIGNATURE

			l_method_sig: CIL_METHOD_SIGNATURE
			l_method: CIL_METHOD
			l_field: CIL_FIELD
			l_locals: CIL_LOCAL
			l_method_ctor: CIL_METHOD_SIGNATURE

			l_type: CIL_CLASS
			l_label, l_id2: CIL_OPERAND
			l_try_label, l_catch_label: CIL_OPERAND
		do
				-- Create the workgin assembly `manu_assembluy`
				-- md_emit.define_assembly
			create pe_file.make ("manus_assembly", {PE_LIB}.il_only)
			pe_file.set_assembly_name ("manus_assembly.dll")

			assembly := pe_file.working_assembly
			assembly.set_major (5)
			assembly.set_minor (2)

				-- CIL_WRITER
				-- md_emit.define_assembly_ref

				-- the feature mscorlib_assembly defines
				-- System.Object
				-- System.ValueType
				-- System.Enum

			mscorlib := pe_file.mscorlib_assembly

			mscorlib.set_major (1)
			mscorlib.set_minor (0)
			mscorlib.set_build (3300)
			mscorlib.public_key_token := {ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>

			l_result := pe_file.find ({STRING_32} "System", Void, Void)
			check
				l_result.type = {CIL_FIND_TYPE}.s_namespace and then
				attached {CIL_NAMESPACE} l_result.resource
			end
			if attached {CIL_NAMESPACE} l_result.resource as l_r then
				l_system := l_r
			end

				-- Adding System.Exception.
			l_result := pe_file.find ({STRING_32} "Exception", Void, Void)
			if l_result.type /= {CIL_FIND_TYPE}.s_class then
				create l_exception.make ("Exception", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				if attached l_system then
					l_system.add (l_exception)
				end
			else
				if attached {CIL_CLASS} l_result.resource as l_r then
					l_exception := l_r
				end
			end


			l_result := pe_file.find ({STRING_32} "Console", Void, Void)
			if l_result.type /= {CIL_FIND_TYPE}.s_class then
				create l_console.make ({STRING_32} "Console", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				if attached l_system then
					l_system.add (l_console)
				end
			else
				if attached {CIL_CLASS} l_result.resource as l_r then
					l_console := l_r
				end
			end

			l_result := pe_file.find ({STRING_32} "Object", Void, Void)
			if l_result.type /= {CIL_FIND_TYPE}.s_class then
				create l_object.make ({STRING_32} "Object", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				if attached l_system then
					l_system.add (l_object)
				end
			else
				if attached {CIL_CLASS} l_result.resource as l_r then
					l_object := l_r
				end
			end

				-- Method signature for System.object::.ctor()
			create l_method_ctor.make (".ctor", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed | {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag, l_object)
			l_method_ctor.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

				-- Create Class TEST
			create l_type.make ("TEST", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.auto | {CIL_QUALIFIERS_ENUM}.ansi | {CIL_QUALIFIERS_ENUM}.public), -1, -1)
			l_type.set_extend_from (l_object)
			assembly.add (l_type)

				-- Define the method signature
				-- define_member_ref
			create l_method_sig.make (".ctor", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

				-- Define method
			create l_method.make (l_method_sig,
				create {CIL_QUALIFIERS}.make_with_flags (
						{CIL_QUALIFIERS_ENUM}.public |
						{CIL_QUALIFIERS_ENUM}.specialname |
						{CIL_QUALIFIERS_ENUM}.rtspecialname |
						{CIL_QUALIFIERS_ENUM}.cil |
						{CIL_QUALIFIERS_ENUM}.Managed
					), False)
			l_method.optimize

			l_type.add (l_method)

				-- Fields
			create l_field.make ({STRING_32} "item", create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.object), create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public))
			l_type.add (l_field)

				-- Locals
			create l_locals.make ("l_obj", create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.object))
			l_method.add_local (l_locals)
			create l_locals.make ("l_type", create {CIL_TYPE}.make_with_container (l_type))
			l_method.add_local (l_locals)

				-- Method body
			l_label := {CIL_OPERAND_FACTORY}.label_operand ("label1")
			l_id2 := {CIL_OPERAND_FACTORY}.label_operand ("label2")

			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_label, l_id2))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldarg_0, Void))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_call, {CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (l_method_ctor))))

			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_label))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1, Void))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_label, l_label))
			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ret, Void))

--				-- Method test
--			create l_method_sig.make ("test", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
--			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

--				-- Define method
--			create l_method.make (l_method_sig,
--				create {CIL_QUALIFIERS}.make_with_flags (
--						{CIL_QUALIFIERS_ENUM}.public |
--						{CIL_QUALIFIERS_ENUM}.cil |
--						{CIL_QUALIFIERS_ENUM}.Managed
--					), False)
--			l_method.optimize

--			l_type.add (l_method)

--				-- Locals
--			create l_locals.make ("l_obj", create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.object))
--			l_method.add_local (l_locals)
--			create l_locals.make ("l_type", create {CIL_TYPE}.make_with_container (l_type))
--			l_method.add_local (l_locals)

--				-- Method body
--			l_label := {CIL_OPERAND_FACTORY}.label_operand ("label_1")
--			l_id2 := {CIL_OPERAND_FACTORY}.label_operand ("label_2")
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldarg_0, l_id2))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldarg_0, Void))

--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_label))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ret, Void))

--				-- Method test2
--			create l_method_sig.make ("test2", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
--			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

--				-- Define method
--			create l_method.make (l_method_sig,
--				create {CIL_QUALIFIERS}.make_with_flags (
--						{CIL_QUALIFIERS_ENUM}.public |
--						{CIL_QUALIFIERS_ENUM}.cil |
--						{CIL_QUALIFIERS_ENUM}.Managed
--					), False)
--			l_method.optimize

--			l_type.add (l_method)

--				 -- Locals
--			create l_locals.make ("l_obj", create {CIL_TYPE}.make (create {CIL_BASIC_TYPE}.object))
--			l_method.add_local (l_locals)
--			create l_locals.make ("l_type", create {CIL_TYPE}.make_with_container (l_type))
--			l_method.add_local (l_locals)

--				-- Method body
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldarg_0, Void))

--			l_label := {CIL_OPERAND_FACTORY}.label_operand ("label_1")
--			l_id2 := {CIL_OPERAND_FACTORY}.label_operand ("label_2")
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_label))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_br, l_id2))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ret, Void))

--				-- Method test_rescue
--			create l_method_sig.make ("test_rescue", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, Void)
--			l_method_sig.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

--				 -- Define method
--			create l_method.make (l_method_sig,
--				create {CIL_QUALIFIERS}.make_with_flags (
--						{CIL_QUALIFIERS_ENUM}.public |
--						{CIL_QUALIFIERS_ENUM}.cil |
--						{CIL_QUALIFIERS_ENUM}.Managed
--					), False)
--			l_method.optimize

--			l_type.add (l_method)

--			l_try_label := {CIL_OPERAND_FACTORY}.label_operand ("try_exit")
--			l_catch_label := {CIL_OPERAND_FACTORY}.label_operand ("catch_exit")

--				 -- Try block
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make_seh ({CIL_SEH}.seh_try, True, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_leave, l_try_label))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make_seh ({CIL_SEH}.seh_try, False, Void))

--				 -- Catch block
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make_seh ({CIL_SEH}.seh_catch, True, if attached l_exception then create {CIL_TYPE}.make_with_container (l_exception) else Void end))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldstr, {CIL_OPERAND_FACTORY}.string_operand ("Manu is nice")))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_leave, l_catch_label))
--			l_method.add_instruction (create {CIL_INSTRUCTION}.make_seh ({CIL_SEH}.seh_catch, False, Void))

			pe_file.dump_output_file ("test_9e.il", {CIL_OUTPUT_MODE}.ilasm, false)
			pe_file.dump_output_file ("test_9e.dll", {CIL_OUTPUT_MODE}.pedll, false)

		end

end
