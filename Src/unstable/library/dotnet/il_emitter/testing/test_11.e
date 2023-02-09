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
			l_dispenser: CIL_MD_METADATA_DISPENSER
			l_emit: CIL_MD_METADATA_EMIT
			l_assembly_info: CIL_MD_ASSEMBLY_INFO
			l_pub_key_token: CIL_MD_PUBLIC_KEY_TOKEN
			sig: CIL_MD_METHOD_SIGNATURE

			my_assembly, mscorlib_token, object_type_token, system_exception_token,
			my_type, my_ctor, object_ctor: INTEGER

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

			object_type_token := l_emit.define_type_ref ({STRING_32} "System.Object", mscorlib_token)

			system_exception_token := l_emit.define_type_ref ({STRING_32} "System.Exception", mscorlib_token)

			my_type := l_emit.define_type ({STRING_32} "TEST",
					{CIL_MD_TYPE_ATTRIBUTES}.Ansi_class | {CIL_MD_TYPE_ATTRIBUTES}.Auto_layout |
					{CIL_MD_TYPE_ATTRIBUTES}.Public,
					object_type_token, Void)

			create sig.make
			sig.set_method_type ({CIL_MD_SIGNATURE_CONSTANTS}.Has_current)
			sig.set_parameter_count (0)
			sig.set_return_type ({CIL_MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor := l_emit.define_member_ref ({STRING_32} ".ctor", object_type_token, sig)

		end

end
