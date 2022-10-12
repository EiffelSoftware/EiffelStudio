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
		do
			create pe_file.make ("test8", {PE_LIB}.bits32)

			assembly := pe_file.working_assembly
			create sig_main.make ("$Main", {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, assembly)
			sig_main.set_return_type (create {CIL_TYPE}.make ({CIL_BASIC_TYPE}.Void_))

			create method_main.make (sig_main,
									 create {CIL_QUALIFIERS}.make_with_flags (
									 						{CIL_QUALIFIERS_ENUM}.static |
									 						{CIL_QUALIFIERS_ENUM}.HideBySig |
									 						{CIL_QUALIFIERS_ENUM}.CIL |
									 						{CIL_QUALIFIERS_ENUM}.Managed
									 						), True)

			assembly.add (method_main)

			mscorlib := pe_file.mscorlib_assembly

			l_result := pe_file.find ("system", Void, Void)
		end
end
