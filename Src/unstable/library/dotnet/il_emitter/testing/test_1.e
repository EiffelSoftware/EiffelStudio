note
	description: "[
		The first program just calls putchar('A') via pinvoke.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_1

feature -- Access

	test
		local
			lib_entry: PE_LIB
			working: DATA_CONTAINER
			signature_rep: METHOD_SIGNATURE
			signature_m: METHOD_SIGNATURE
			start: METHOD
			op: OPERAND
			ins: INSTRUCTION
			method_name: METHOD_NAME
		do
			create lib_entry.make ("test1", {PE_LIB}.bits32)
			working := lib_entry.working_assembly

			create signature_rep.make("putchar", 0, Void)
			signature_rep.set_return_type(create {CLS_TYPE}.make ({BASIC_TYPE}.Void_))
			signature_rep.add_parameter (create {PARAM}.make ("ch", create {CLS_TYPE}.make ({BASIC_TYPE}.i32)))
			lib_entry.add_pinvoke_reference (signature_rep, "msvcrt.dll", true)

			create signature_m.make ("$Main", {QUALIFIERS_ENUM}.managed, working)
			signature_m.set_return_type(create {CLS_TYPE}.make ({BASIC_TYPE}.Void_))

			create start.make (signature_m, create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private | {QUALIFIERS_ENUM}.Static | {QUALIFIERS_ENUM}.hidebysig | {QUALIFIERS_ENUM}.Cil | {QUALIFIERS_ENUM}.managed), True)

			working.add_code_container (start)

			op := {OPERAND_FACTORY}.character_operand ('A', {OPERAND_SIZE}.i32)
			create ins.make ({CIL_OPCODES}.i_ldc_i4, op)
			start.add_instruction(ins)

			create method_name.make (signature_rep)

			op := {OPERAND_FACTORY}.complex_operand (method_name)
			create ins.make ({CIL_OPCODES}.i_call, op)
			start.add_instruction (ins)

			create ins.make ({CIL_OPCODES}.i_ret, Void)
			start.add_instruction (ins)


			start.optimize(lib_entry)

			lib_entry.dump_output_file ("test1.il",{OUTPUT_MODE}.ilasm, False)
			lib_entry.dump_output_file ("test1.exe",{OUTPUT_MODE}.peexe, False)

		end
end
