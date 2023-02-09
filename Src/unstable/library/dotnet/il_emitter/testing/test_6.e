note
	description: "[
			This program calls a function 'Start(string)' in namespace 'nmspc' and class 'cls'
			Start prints both the passed string and a locally defined string to the console using
			System.Console.WriteLine()
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_6

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

			tp: CIL_TYPE
			type_list: LIST [CIL_TYPE]
			param1: CIL_PARAM

			start, main, result_: CIL_METHOD
			op: CIL_OPERAND
			ins: CIL_INSTRUCTION
			method_name: CIL_METHOD_NAME

		do
			create lib_entry.make_with_name ("test6", {PE_LIB}.il_only | {PE_LIB}.bits32)

			working := lib_entry.working_assembly

			create nmspc.make ("nmspc")
			working.add (nmspc)


			create cls.make ("cls", create {CIL_QUALIFIERS}.make_with_flags (
							{CIL_QUALIFIERS_ENUM}.ansi |
							{CIL_QUALIFIERS_ENUM}.sealed)
							, -1, -1)
			nmspc.add (cls)

			create signature_es.make ("Start", {CIL_QUALIFIERS_ENUM}.managed, cls)
			signature_es.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_) )
			create param1.make ("strn", create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.string))
			signature_es.add_parameter (param1)

			-- add a reference to the assembly (not implemented)
			-- lib_entry.load_assembly("mscorlib", 0, 0, 0, 0)

			-- create the function refernce to WriteLine
			-- there is an argument matcher in the library, set up a vector of types describing
			-- the arguments and it will try to find a matching overload.

			create tp.make ({CIL_BASIC_TYPE}.string)
			create {ARRAYED_LIST [CIL_TYPE]} type_list.make (0)
			type_list.force (tp)

--			create start.make (signature_es,
--											create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.Public |
--													{CIL_QUALIFIERS_ENUM}.Static |
--													{CIL_QUALIFIERS_ENUM}.hidebysig |
--													{CIL_QUALIFIERS_ENUM}.Cil |
--													{CIL_QUALIFIERS_ENUM}.managed), False)


--			create ins.make ({CIL_OPCODES}.i_ldsflda,{OPERAND_FACTORY}.complex_operand (create {FIELD_NAME}.make (ps)))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ldarg,{OPERAND_FACTORY}.complex_operand (param1))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signature_ep)))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_pop, Void)
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ret, Void)
--			start.add_instruction (ins)

--			start.optimize (lib_entry)

--			cls.add (start)

--			create signature_m.make ("$Main", {CIL_QUALIFIERS_ENUM}.managed, working)
--			signature_m.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_, 0))

--			create main.make (signature_m,
--											create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.private |
--													{CIL_QUALIFIERS_ENUM}.Static |
--													{CIL_QUALIFIERS_ENUM}.hidebysig |
--													{CIL_QUALIFIERS_ENUM}.Cil |
--													{CIL_QUALIFIERS_ENUM}.managed), True)

--			working.add (main)

--			create ins.make ({CIL_OPCODES}.i_ldc_i4,{OPERAND_FACTORY}.integer64_operand (57, {OPERAND_SIZE}.i32))
--			main.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (signature_es)))
--			main.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ret, Void)
--			main.add_instruction (ins)

--			main.optimize (lib_entry)



			lib_entry.dump_output_file ("test6.il", {CIL_OUTPUT_MODE}.ilasm, False)
			--lib_entry.dump_output_file ("test1.exe", {CIL_OUTPUT_MODE}.peexe, False)

		end

end
