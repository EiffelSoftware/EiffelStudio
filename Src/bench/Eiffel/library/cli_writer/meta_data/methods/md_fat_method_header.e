indexing
	description: "Representation of a fat method header"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FAT_METHOD_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature -- Initialization

	make, remake (a_max_stack: INTEGER_16; a_code_size, a_locals_token: INTEGER) is
			-- Create fat method header.
		do
			max_stack := a_max_stack
			code_size := a_code_size
			locals_token := a_locals_token
			
				-- Set internal data with `size' of current structure
				-- and default flags.
			internal_data := Header_size | (
				feature {MD_METHOD_CONSTANTS}.Fat_format |
				feature {MD_METHOD_CONSTANTS}.Init_locals)
		ensure
			max_stack_set: max_stack = a_max_stack
			code_size_set: code_size = a_code_size
			locals_token_set: locals_token = a_locals_token
		end

feature -- Access

	max_stack: INTEGER_16
			-- Stack size.
			
	code_size: INTEGER
			-- Size of code.
			
	locals_token: INTEGER
			-- Token for local signature.

	flags: INTEGER_8 is
			-- Current flags.
		do
			Result := (internal_data & 0x00FF).to_integer_8
		end

feature -- Access

	size: INTEGER is 12
			-- Size of structure once emitted.
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		do
			m.put_integer_16 (internal_data, pos)
			m.put_integer_16 (max_stack, pos + 2)
			m.put_integer_32 (code_size, pos + 4)
			m.put_integer_32 (locals_token, pos + 8)
		end
		
feature -- Settings

	set_flags (f: INTEGER_8) is
			-- Set `flags' with `f'.
		do
			internal_data := Header_size | (f |
				feature {MD_METHOD_CONSTANTS}.Fat_format |
				feature {MD_METHOD_CONSTANTS}.Init_locals)
		end
		
feature {NONE} -- Implementation

	internal_data: INTEGER_16
			-- To hold `size' of current and `flags'.

	Header_size: INTEGER_16 is 0x3000
			-- Size of current structure.

invariant
	valid_flags: flags & feature {MD_METHOD_CONSTANTS}.Fat_format = 
			feature {MD_METHOD_CONSTANTS}.Fat_format

end -- class MD_FAT_METHOD_HEADER
