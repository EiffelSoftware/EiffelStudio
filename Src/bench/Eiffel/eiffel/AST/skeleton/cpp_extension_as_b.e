class CPP_EXTENSION_AS_B

inherit
	CPP_EXTENSION_AS;
	EXTERNAL_EXTENSION_AS_B
		redefine
			byte_node
		end

feature

	extension_i (external_as: EXTERNAL_AS): CPP_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
		end

feature -- Byte code

	byte_node: CPP_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
		end

end -- class CPP_EXTENSION_AS_B
