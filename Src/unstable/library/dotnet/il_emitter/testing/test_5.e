note
	description: "[
		This program calls a function 'Start(57)' in namespace 'nmspc' and class 'cls'
		start calls printf("%d", arg1) via pinvoke.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_5


feature -- Test

	test
		local
			lib_entry: PE_LIB
			working: CIL_DATA_CONTAINER
			nmspc, nspc0: CIL_NAMESPACE

			cls: CIL_CLASS
			i8_cls: CIL_CLASS

			ps: CIL_FIELD
			str: CIL_FIELD

			ps_init: ARRAY [NATURAL_8]
			str_init: ARRAY [NATURAL_8]

			signature_ex, signature_ep: CIL_METHOD_SIGNATURE
			signature_m, signature_es: CIL_METHOD_SIGNATURE

			tp1: CIL_TYPE
			param1: CIL_PARAM

			start, main: CIL_METHOD
			op: CIL_OPERAND
			ins: CIL_INSTRUCTION
			method_name: CIL_METHOD_NAME

		do
			create lib_entry.make ("test5", {PE_LIB}.il_only | {PE_LIB}.bits32)

			working := lib_entry.working_assembly

			create nmspc.make ("nmspc")
			working.add (nmspc)


			create cls.make ("cls", create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.ansi |
							{CIL_QUALIFIERS_ENUM}.sealed)
							, -1, -1)
			nmspc.add (cls)

			create i8_cls.make ("int8[]", create {CIL_QUALIFIERS}.make_with_flags (
					{CIL_QUALIFIERS_ENUM}.public |
					{CIL_QUALIFIERS_ENUM}.explicit |
					{CIL_QUALIFIERS_ENUM}.ansi |
					{CIL_QUALIFIERS_ENUM}.sealed |
					{CIL_QUALIFIERS_ENUM}.value)
					, 1, 1)


			create ps.make ("pS", create {CIL_TYPE}.make_with_container (i8_cls), create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public | {CIL_QUALIFIERS_ENUM}.static))

			cls.add (i8_cls)
			cls.add (ps)

			ps_init := <<0x25, 0x64, 0x0a, 0>> --%d
			ps.add_initializer (ps_init)

			create signature_ex.make ("printf", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ex.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			signature_ex.add_parameter (create {CIL_PARAM}.make ("format", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))
			lib_entry.add_pinvoke_reference (signature_ex, "msvcrt.dll", true)

			create signature_ep.make ("printf", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ep.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			signature_ep.add_parameter (create {CIL_PARAM}.make ("format", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))
			signature_ep.add_vararg_param (create {CIL_PARAM}.make ("A_1", create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.Void_, 1)))
			signature_ep.signature_parent (signature_ex)

			create signature_es.make ("Start", {CIL_QUALIFIERS_ENUM}.managed, cls)
			signature_es.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_) )
			create param1.make ("val", create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.i32))
			signature_es.add_parameter (param1)

			create start.make (signature_es,
											create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.Public |
													{CIL_QUALIFIERS_ENUM}.Static |
													{CIL_QUALIFIERS_ENUM}.hidebysig |
													{CIL_QUALIFIERS_ENUM}.Cil |
													{CIL_QUALIFIERS_ENUM}.managed), False)


			create ins.make ({CIL_OPCODES}.i_ldsflda,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_FIELD_NAME}.make (ps)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ldarg,{CIL_OPERAND_FACTORY}.complex_operand (param1))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_call,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signature_ep)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_pop, Void)
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ret, Void)
			start.add_instruction (ins)

			start.optimize (lib_entry)

			cls.add (start)

			create signature_m.make ("$Main", {CIL_QUALIFIERS_ENUM}.managed, working)
			signature_m.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			create main.make (signature_m,
											create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private |
													{CIL_QUALIFIERS_ENUM}.Static |
													{CIL_QUALIFIERS_ENUM}.hidebysig |
													{CIL_QUALIFIERS_ENUM}.Cil |
													{CIL_QUALIFIERS_ENUM}.managed), True)

			working.add (main)

			create ins.make ({CIL_OPCODES}.i_ldc_i4,{CIL_OPERAND_FACTORY}.integer64_operand (57, {CIL_OPERAND_SIZE}.i32))
			main.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_call,{CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signature_es)))
			main.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ret, Void)
			main.add_instruction (ins)

			main.optimize (lib_entry)



			lib_entry.dump_output_file ("test5.il", {CIL_OUTPUT_MODE}.ilasm, False)

		end
end
