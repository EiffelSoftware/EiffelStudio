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
			assembly: ASSEMBLY_DEF
			sig_main: METHOD_SIGNATURE
			method_main: METHOD
			mscorlib: ASSEMBLY_DEF
		do
			create pe_file.make ("test8", {PE_LIB}.bits32)

			assembly := pe_file.working_assembly
			create sig_main.make ("$Main", {METHOD_SIGNATURE_ATTRIBUTES}.managed, assembly)
			sig_main.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_))

			create method_main.make (sig_main,
									 create {QUALIFIERS}.make_with_flags (
									 						{QUALIFIERS_ENUM}.static |
									 						{QUALIFIERS_ENUM}.HideBySig |
									 						{QUALIFIERS_ENUM}.CIL |
									 						{QUALIFIERS_ENUM}.Managed
									 						), True)

			assembly.add (method_main)

			mscorlib := pe_file.mscorlib_assembly
		end
end
