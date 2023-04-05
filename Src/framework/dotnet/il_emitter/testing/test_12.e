note
	description: "Summary description for {TEST_TABLES}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_12

feature -- Test

	test
		local
			l_dispenser: CIL_MD_METADATA_DISPENSER
			l_emit: CIL_MD_METADATA_EMIT
			l_assembly_info: CIL_MD_ASSEMBLY_INFO
			l_pub_key_token: CIL_MD_PUBLIC_KEY_TOKEN

			my_assembly, mscorlib_token: INTEGER

			l_pe_file: CIL_PE_FILE

		do
			create l_dispenser.make
			l_emit := l_dispenser.emit

			create l_assembly_info.make
			l_assembly_info.set_major (5)
			l_assembly_info.set_minor (2)

			my_assembly := l_emit.define_assembly ({STRING_32} "manu_assembly", 0, l_assembly_info, Void)

			l_assembly_info.set_major (1)
			l_assembly_info.set_minor (0)
			l_assembly_info.set_build (3300)
			create l_pub_key_token.make_from_array (
				{ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			mscorlib_token := l_emit.define_assembly_ref ({STRING_32} "mscorlib", l_assembly_info, l_pub_key_token)

			l_emit.set_module_name ({STRING_32}"manu_assembly.dll")

			create l_pe_file.make ("test12_e.dll", True, True, False, l_emit)
			l_pe_file.save
		end

end
