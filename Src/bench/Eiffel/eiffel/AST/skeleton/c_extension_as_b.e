class C_EXTENSION_AS_B

inherit
	EXTERNAL_EXTENSION_AS_B
		undefine
			parse_special_part
		redefine
			init_byte_node
		end

	C_EXTENSION_AS

feature -- Get the C extension

	extension_i (external_as: EXTERNAL_AS): C_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is
			-- Does a C external need an encapsulation?
			--| Only when it is a macro, otherwise we
			--| can use the new name of the redefinition
			--| in the routine tables.
		do
		end

feature -- Byte code

	byte_node: C_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
		end

	init_byte_node (b: C_EXT_BYTE_CODE) is
			-- Initialize byte node.
		do
			{EXTERNAL_EXTENSION_AS_B} precursor (b)
			b.set_special_file_name (special_file_name)
		end

end -- class C_EXTENSION_AS_B
