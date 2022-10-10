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
			working: DATA_CONTAINER
			nmspc, nspc0: NAMESPACE

			cls: CLS_CLASS
			i8_cls: CLS_CLASS

			ps: FIELD
			str: FIELD

			ps_init: ARRAY [NATURAL_8]
			str_init: ARRAY [NATURAL_8]

			signature_ex, signature_ep: METHOD_SIGNATURE
			signature_m, signature_es: METHOD_SIGNATURE

			tp: CLS_TYPE
			type_list: LIST [CLS_TYPE]
			param1: PARAM

			start, main, result_: METHOD
			op: OPERAND
			ins: INSTRUCTION
			method_name: METHOD_NAME

		do
			create lib_entry.make ("test6", {PE_LIB}.il_only | {PE_LIB}.bits32)

			working := lib_entry.working_assembly

			create nmspc.make ("nmspc")
			working.add (nmspc)


			create cls.make ("cls", create {QUALIFIERS}.make_with_flags (
							{QUALIFIERS_ENUM}.ansi |
							{QUALIFIERS_ENUM}.sealed)
							, -1, -1)
			nmspc.add (cls)

			create signature_es.make ("Start", {QUALIFIERS_ENUM}.managed, cls)
			signature_es.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_) )
			create param1.make ("strn", create {CLS_TYPE}.make ({BASIC_TYPE}.string))
			signature_es.add_parameter (param1)

			-- add a reference to the assembly (not implemented)
			-- lib_entry.load_assembly("mscorlib", 0, 0, 0, 0)

			-- create the function refernce to WriteLine
			-- there is an argument matcher in the library, set up a vector of types describing
			-- the arguments and it will try to find a matching overload.

			create tp.make ({BASIC_TYPE}.string)
			create {ARRAYED_LIST [CLS_TYPE]} type_list.make (0)
			type_list.force (tp)

--			create start.make (signature_es,
--											create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.Public |
--													{QUALIFIERS_ENUM}.Static |
--													{QUALIFIERS_ENUM}.hidebysig |
--													{QUALIFIERS_ENUM}.Cil |
--													{QUALIFIERS_ENUM}.managed), False)


--			create ins.make ({CIL_OPCODES}.i_ldsflda,{OPERAND_FACTORY}.complex_operand (create {FIELD_NAME}.make (ps)))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ldarg,{OPERAND_FACTORY}.complex_operand (param1))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {METHOD_NAME}.make (signature_ep)))
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_pop, Void)
--			start.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ret, Void)
--			start.add_instruction (ins)

--			start.optimize (lib_entry)

--			cls.add (start)

--			create signature_m.make ("$Main", {QUALIFIERS_ENUM}.managed, working)
--			signature_m.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_, 0))

--			create main.make (signature_m,
--											create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private |
--													{QUALIFIERS_ENUM}.Static |
--													{QUALIFIERS_ENUM}.hidebysig |
--													{QUALIFIERS_ENUM}.Cil |
--													{QUALIFIERS_ENUM}.managed), True)

--			working.add (main)

--			create ins.make ({CIL_OPCODES}.i_ldc_i4,{OPERAND_FACTORY}.integer64_operand (57, {OPERAND_SIZE}.i32))
--			main.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {METHOD_NAME}.make (signature_es)))
--			main.add_instruction (ins)
--			create ins.make ({CIL_OPCODES}.i_ret, Void)
--			main.add_instruction (ins)

--			main.optimize (lib_entry)



			lib_entry.dump_output_file ("test6.il", {OUTPUT_MODE}.ilasm, False)
			--lib_entry.dump_output_file ("test1.exe", {OUTPUT_MODE}.peexe, False)

		end

end
