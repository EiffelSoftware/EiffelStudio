indexing
	description: "Available properties for method parameters"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PARAM_ATTRIBUTES

inherit
	ANY
		rename
			out as any_out
		end
		
feature -- Access

	in: INTEGER_16 is 0x0001
			-- Parameter is `in'.
			
	out: INTEGER_16 is 0x0002
			-- Parameter is `out'
			
	optional: INTEGER_16 is 0x0004
			-- Optional parameter.
			
	has_default: INTEGER_16 is 0x1000
			-- Parameter has default value.
			
	has_field_marshal: INTEGER_16 is 0x2000
			-- Parameter has field marshal.
			
	unused: INTEGER_16 is 0xCFE0
			-- Unused.

end -- class MD_PARAM_ATTRIBUTES
