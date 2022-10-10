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
			working: DATA_CONTAINER
			i8_cls: CLS_CLASS
			ps: FIELD
			str: FIELD

			ps_init: ARRAY [NATURAL_8]
			str_init: ARRAY [NATURAL_8]

			signature_ex, signature_ep: METHOD_SIGNATURE
			signature_m: METHOD_SIGNATURE
			start: METHOD
			op: OPERAND
			ins: INSTRUCTION
			method_name: METHOD_NAME
		do
			create lib_entry.make ("test2", {PE_LIB}.il_only | {PE_LIB}.bits32)
			working := lib_entry.working_assembly

			create i8_cls.make ("int8[]", create {QUALIFIERS}.make_with_flags (
					{QUALIFIERS_ENUM}.private |
					{QUALIFIERS_ENUM}.explicit |
					{QUALIFIERS_ENUM}.ansi |
					{QUALIFIERS_ENUM}.sealed |
					{QUALIFIERS_ENUM}.value)
				, 1, 1)

			create ps.make ("pS", create {CLS_TYPE}.make_with_container (i8_cls), create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private | {QUALIFIERS_ENUM}.static))
			create str.make ("Str", create {CLS_TYPE}.make_with_container (i8_cls), create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private | {QUALIFIERS_ENUM}.static))

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

			create signature_ex.make ("printf", {METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ex.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.i32))
			signature_ex.add_parameter (create {PARAM}.make ("format", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))
			lib_entry.add_pinvoke_reference (signature_ex, "msvcrt.dll", true)


			--  then we make a call site signature that enumerates all the args
			--  including the ones we are adding as variable length
			--  this is the one we use in the call
			create signature_ep.make ("printf", {METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ep.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.i32))
			signature_ep.add_parameter (create {PARAM}.make ("format", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))
			signature_ep.add_vararg_param (create {PARAM}.make ("A_1", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))

			--  note the reference to the pinvoke signature
			signature_ep.signature_parent (signature_ex)



			create signature_m.make ("$Main", {QUALIFIERS_ENUM}.managed, working)
			signature_m.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_))

			create start.make (signature_m,
											create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private |
													{QUALIFIERS_ENUM}.Static |
													{QUALIFIERS_ENUM}.hidebysig |
													{QUALIFIERS_ENUM}.Cil |
													{QUALIFIERS_ENUM}.managed), True)

			working.add_code_container (start)


			create ins.make ({CIL_OPCODES}.i_ldsflda,{OPERAND_FACTORY}.complex_operand (create {FIELD_NAME}.make (ps)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ldsflda,{OPERAND_FACTORY}.complex_operand (create {FIELD_NAME}.make (str)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {METHOD_NAME}.make (signature_ep)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_pop, Void)
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ret, Void)
			start.add_instruction (ins)


			start.optimize (lib_entry)

			lib_entry.dump_output_file ("test2.il", {OUTPUT_MODE}.ilasm, False)
			--lib_entry.dump_output_file ("test1.exe", {OUTPUT_MODE}.peexe, False)

		end

end
