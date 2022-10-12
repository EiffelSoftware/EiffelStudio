note
	description: "Summary description for {TEST_7}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_7


feature -- Test

	test
		local
			lib_entry: PE_LIB
			working: CIL_DATA_CONTAINER
			nmspc: CIL_NAMESPACE
			cls: CIL_CLASS
			signatures: CIL_METHOD_SIGNATURE
			param1: CIL_PARAM

			start, main: CIL_METHOD
			counter: CIL_LOCAL
			counter_operand: CIL_OPERAND
			loop_label: CIL_OPERAND
			number_of_times: INTEGER

			signaturem: CIL_METHOD_SIGNATURE
		do
			create lib_entry.make ("test7", {PE_LIB}.il_only | {PE_LIB}.bits32)
			working := lib_entry.working_assembly
			create nmspc.make ("nmspc")
			working.add (nmspc)

			create cls.make ("cls", create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.ansi |
							{CIL_QUALIFIERS_ENUM}.sealed),
							-1, -1)

			nmspc.add (cls)

			create signatures.make ("Start", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, cls)
			signatures.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))
			create param1.make ("strn", create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.String))
			signatures.add_parameter (param1)



			create start.make (signatures,
								create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public |
																	 {CIL_QUALIFIERS_ENUM}.static |
																	 {CIL_QUALIFIERS_ENUM}.hidebysig |
																	 {CIL_QUALIFIERS_ENUM}.cil |
																	 {CIL_QUALIFIERS_ENUM}.Managed),
																	 False)


			create counter.make ("counter", create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			start.add_local (counter)
			counter_operand := {CIL_OPERAND_FACTORY}.complex_operand (counter)

			start.add_instruction (create {CIL_INSTRUCTION}.make_with_text ({CIL_OPCODES}.i_comment, "initialize"))
			number_of_times := 7
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ldc_i4, {CIL_OPERAND_FACTORY}.integer64_operand (number_of_times, {CIL_OPERAND_SIZE}.i32)))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_stloc, counter_operand))
			start.add_instruction (create {CIL_INSTRUCTION}.make_with_text ({CIL_OPCODES}.i_comment, "start of loop"))
			loop_label := {CIL_OPERAND_FACTORY}.label_operand ("loop")
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_label, loop_label))

			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ldarg, {CIL_OPERAND_FACTORY}.complex_operand (param1)))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ldloc, counter_operand))

			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ldc_i4, {CIL_OPERAND_FACTORY}.integer64_operand (1, {CIL_OPERAND_SIZE}.i32)))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_sub, Void))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_dup, Void))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_stloc, counter_operand))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_brtrue, loop_label))
			start.add_instruction (create {CIL_INSTRUCTION}.make_with_text ({CIL_OPCODES}.i_comment, "exit"))
			start.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ret, Void))

			start.optimize (lib_entry)


			cls.add (start)


			create signaturem.make ("$Main", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, working)
			signaturem.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))



			create main.make (signaturem,
								create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private |
																	 {CIL_QUALIFIERS_ENUM}.static |
																	 {CIL_QUALIFIERS_ENUM}.hidebysig |
																	 {CIL_QUALIFIERS_ENUM}.cil |
																	 {CIL_QUALIFIERS_ENUM}.Managed),
																	 True)

			working.add (main)


			-- note the reference to the generic form of ldc.i4 ... it will be optimized
    		-- into an ldc.i4.s by the library
			main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ldstr, {CIL_OPERAND_FACTORY}.string_operand ("this is a string")))
			main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_call, {CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signatures))))
			main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_OPCODES}.i_ret, Void))

			main.optimize (lib_entry)

			lib_entry.dump_output_file ("test7.il", {CIL_OUTPUT_MODE}.ilasm, False)

		end
end

