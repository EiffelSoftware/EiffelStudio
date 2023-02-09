note
	description: "Summary description for {TEST_11}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_11

feature -- Test

	test
		local
			l_dispenser: CIL_METADATA_DISPENSER
			l_emit: CIL_METADATA_EMIT
			l_assembly_info: CIL_ASSEMBLY_INFO

			my_assembly, mscorlib_token, object_type_token, system_exception_token,
			my_type: INTEGER

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
			mscorlib_token := l_emit.define_assembly_ref ({STRING_32}"mscorlib",
				l_assembly_info, {ARRAY [NATURAL_8]} <<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)

			object_type_token := l_emit.define_type_ref ({STRING_32}"System.Object", mscorlib_token)

			system_exception_token := l_emit.define_type_ref ({STRING_32}"System.Exception", mscorlib_token)

			my_type :=l_emit.define_type ({STRING_32}"TEST",
						{CIL_TYPE_ATTRIBUTES}.Ansi_class | {CIL_TYPE_ATTRIBUTES}.Auto_layout |
						{CIL_TYPE_ATTRIBUTES}.Public,
						object_type_token, Void)
		end

end
