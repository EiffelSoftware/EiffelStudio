class CPP_EXTENSION_AS_B

inherit
	CPP_EXTENSION_AS;
	EXTERNAL_EXTENSION_AS_B
		undefine
			parse_special_part
		redefine
			byte_node
		end

feature

	extension_i (external_as: EXTERNAL_AS): CPP_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_class_name (class_name)
			Result.set_class_header_file (class_header_file)
		end

feature -- Byte code

	byte_node: CPP_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			Result.set_type (type)
			Result.set_class_name (class_name)
			Result.set_class_header_file (class_header_file)
		end

end -- class CPP_EXTENSION_AS_B
