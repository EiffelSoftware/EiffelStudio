indexing
	description: "[
		Represent a method signature both for reference
		and definition as we do not consume varargs.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_SIGNATURE

inherit
	MD_SIGNATURE

feature -- Access

	type: INTEGER_8
			-- Type of signature.
			-- See MD_SIGNATURE_CONSTANTS for possible values.
		
	parameter_count: INTEGER
			-- Number of parameter.
			-- To be compressed.
	
end -- class MD_METHOD_SIGNATURE
