note
	description: "Summary description for {TEST_8}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_8

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
			l_sig_write_line: CIL_METHOD_SIGNATURE
		do
			create pe_file.make ("test8", {PE_LIB}.il_only | {PE_LIB}.bits32)

			assembly := pe_file.working_assembly
			create sig_main.make ("$Main", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, assembly)
			sig_main.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			create method_main.make (sig_main,
				create {CIL_QUALIFIERS}.make_with_flags (
						{CIL_QUALIFIERS_ENUM}.private |
						{CIL_QUALIFIERS_ENUM}.static |
						{CIL_QUALIFIERS_ENUM}.HideBySig |
						{CIL_QUALIFIERS_ENUM}.CIL |
						{CIL_QUALIFIERS_ENUM}.Managed
					), True)

			assembly.add (method_main)

			mscorlib := pe_file.mscorlib_assembly

			l_result := pe_file.find ("System", Void, Void)
			check
				l_result.type = {CIL_FIND_TYPE}.s_namespace and then
				attached {CIL_NAMESPACE} l_result.resource
			end
			if attached {CIL_NAMESPACE} l_result.resource as l_r then
				l_system := l_r
			end

			l_result := pe_file.find ("Console", Void, Void)
			if l_result.type /= {CIL_FIND_TYPE}.s_class then
				create l_console.make ("Console", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				if attached l_system then
					l_system.add (l_console)
				end
			else
				if attached {CIL_CLASS} l_result.resource as l_r then
					l_console := l_r
				end
			end

			create l_sig_write_line.make ("WriteLine", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, l_console)
			l_sig_write_line.set_return_type (create {CIL_TYPE}.make({CIL_BASIC_TYPE}.Void_))
			l_sig_write_line.add_parameter (create {CIL_PARAM}.make ("", create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.string)))

			method_main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ldstr, {CIL_OPERAND_FACTORY}.string_operand ("Hi There!")))
			method_main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_call, {CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (l_sig_write_line))))
			method_main.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_ret, Void))

			method_main.optimize

			pe_file.dump_output_file ("test_8.il", {CIL_OUTPUT_MODE}.ilasm, false)
			pe_file.dump_output_file ("test_8.il", {CIL_OUTPUT_MODE}.peexe, false)

		end

end
