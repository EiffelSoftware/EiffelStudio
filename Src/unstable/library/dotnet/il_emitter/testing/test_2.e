note
	description: "[
			The program calls printf("%s", "hi")
			It only uses the unnamed namespace
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_2

feature -- Access

	test
		local
			lib_entry: PE_LIB
			working: CIL_DATA_CONTAINER
			i8_cls: CIL_CLASS
			ps: CIL_FIELD
			str: CIL_FIELD

			ps_init: ARRAY [NATURAL_8]
			str_init: ARRAY [NATURAL_8]

			signature_ex, signature_ep: CIL_METHOD_SIGNATURE
			signature_m: CIL_METHOD_SIGNATURE
			start: CIL_METHOD
			op: CIL_OPERAND
			ins: CIL_INSTRUCTION
			method_name: CIL_METHOD_NAME
		do
			create lib_entry.make ("test2", {PE_LIB}.il_only | {PE_LIB}.bits32)
			working := lib_entry.working_assembly

			create i8_cls.make ("int8[]", create {CIL_QUALIFIERS}.make_with_flags (
					{CIL_QUALIFIERS_ENUM}.private |
					{CIL_QUALIFIERS_ENUM}.explicit |
					{CIL_QUALIFIERS_ENUM}.ansi |
					{CIL_QUALIFIERS_ENUM}.sealed |
					{CIL_QUALIFIERS_ENUM}.value)
				, 1, 1)

			create ps.make ("pS", create {CIL_TYPE}.make_with_container (i8_cls), create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private | {CIL_QUALIFIERS_ENUM}.static))
			create str.make ("Str", create {CIL_TYPE}.make_with_container (i8_cls), create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private | {CIL_QUALIFIERS_ENUM}.static))

			working.add (i8_cls)
			working.add (ps)
			working.add (str)

			ps_init := <<0x25, 0x73, 0x0a, 0>> --%s
			str_init := <<0x48, 0x49, 0>> -- HI


			-- these calls put the strings in the SDATA.		
			-- reading from SDATA is ok, but writing can only be done by
			-- standalone programs that don't interact with other .net assemblies
			-- we are only reading...

			ps.add_initializer (ps_init)
			str.add_initializer (str_init)

			-- we have to first make a pinvoke reference WITHOUT extra args

			create signature_ex.make ("printf", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ex.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			signature_ex.add_parameter (create {CIL_PARAM}.make ("format", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))
			lib_entry.add_pinvoke_reference (signature_ex, "msvcrt.dll", true)


			--  then we make a call site signature that enumerates all the args
			--  including the ones we are adding as variable length
			--  this is the one we use in the call
			create signature_ep.make ("printf", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ep.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			signature_ep.add_parameter (create {CIL_PARAM}.make ("format", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))
			signature_ep.add_vararg_param (create {CIL_PARAM}.make ("A_1", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))

			--  note the reference to the pinvoke signature
			signature_ep.signature_parent (signature_ex)



			create signature_m.make ("$Main", {CIL_QUALIFIERS_ENUM}.managed, working)
			signature_m.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			create start.make (signature_m,
											create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private |
													{CIL_QUALIFIERS_ENUM}.Static |
													{CIL_QUALIFIERS_ENUM}.hidebysig |
													{CIL_QUALIFIERS_ENUM}.Cil |
													{CIL_QUALIFIERS_ENUM}.managed), True)

			working.add_code_container (start)


			create ins.make ({CIL_INSTRUCTION_OPCODES}.i_ldsflda,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_FIELD_NAME}.make (ps)))
			start.add_instruction (ins)
			create ins.make ({CIL_INSTRUCTION_OPCODES}.i_ldsflda,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_FIELD_NAME}.make (str)))
			start.add_instruction (ins)
			create ins.make ({CIL_INSTRUCTION_OPCODES}.i_call,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signature_ep)))
			start.add_instruction (ins)
			create ins.make ({CIL_INSTRUCTION_OPCODES}.i_pop, Void)
			start.add_instruction (ins)
			create ins.make ({CIL_INSTRUCTION_OPCODES}.i_ret, Void)
			start.add_instruction (ins)


			start.optimize

			lib_entry.dump_output_file ("test2.il", {CIL_OUTPUT_MODE}.ilasm, False)
			lib_entry.dump_output_file ("test2.exe", {CIL_OUTPUT_MODE}.peexe, False)

		end

end
