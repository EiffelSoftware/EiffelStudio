class C_EXTENSION_AS_B

inherit
	C_EXTENSION_AS;
	EXTERNAL_EXTENSION_AS_B
		rename
			init_byte_node as ext_init_byte_node
		undefine
			parse_special_part
		redefine
			need_encapsulation
		end
	EXTERNAL_EXTENSION_AS_B
		undefine
			parse_special_part
		redefine
			init_byte_node, need_encapsulation
		select
			init_byte_node
		end

feature

	extension_i (external_as: EXTERNAL_AS): C_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

	need_encapsulation: BOOLEAN is
			-- Does this language extension need an encapsulation?
		do
			Result := has_signature or is_macro
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
			ext_init_byte_node (b)
			b.set_special_file_name (special_file_name)
		end

end -- class C_EXTENSION_AS_B
