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
		local
			l_data: like internal_data
			l_max_stack: INTEGER_16
			l_code_size, l_token: INTEGER
			l_ptr: POINTER
		do
			l_data := internal_data
			l_ptr := m.item + pos
			l_ptr.memory_copy ($l_data, 2)
			l_ptr := l_ptr + 2

			l_max_stack := max_stack
			l_ptr.memory_copy ($l_max_stack, 2)
			l_ptr := l_ptr + 2
			
			l_code_size := code_size
			l_ptr.memory_copy ($l_code_size, 4)
			l_ptr := l_ptr + 4
			
			l_token := locals_token
			l_ptr.memory_copy ($l_token, 4)
			l_ptr := l_ptr + 4
		end
		
feature -- Settings

	set_flags (f: INTEGER_8) is
			-- Set `flags' with `f'.
		require
			f_has_fat: f & feature {MD_METHOD_CONSTANTS}.Fat_format = 
				feature {MD_METHOD_CONSTANTS}.Fat_format
		do
			internal_data := Header_size | (
				feature {MD_METHOD_CONSTANTS}.Fat_format |
				feature {MD_METHOD_CONSTANTS}.Init_locals)
		ensure
			flags_set: flags = f
		end
		
feature {NONE} -- Implementation

	internal_data: INTEGER_16
			-- To hold `size' of current and `flags'.

	Header_size: INTEGER_16 is 0x0B00
			-- Size of current structure.

invariant
	valid_flags: flags & feature {MD_METHOD_CONSTANTS}.Fat_format = 
			feature {MD_METHOD_CONSTANTS}.Fat_format

end -- class MD_FAT_METHOD_HEADER
