indexing
	description: "Representation of a tiny method header."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TINY_METHOD_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature {NONE} -- Initialization

	make (a_size: INTEGER_8) is
			-- Create a tiny header representing a feature
			-- with no rescue clause, nor local variables
			-- and a maxstack less than 8.
		require
			valid_size: a_size >= 0 and a_size < 64
		do
			set_code_size (a_size)
		ensure
			code_size_set: code_size = a_size
		end
		
feature -- Access

	code_size: INTEGER is
			-- Size of current feature.
		do
			Result := (internal_data & 0x000000FC) |>> 2
		ensure
			valid_result: Result >= 0 and Result < 64
		end

feature -- Access

	count: INTEGER is 1
			-- Size of structure once emitted.
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		local
			l_data: INTEGER_8
			l_ptr: POINTER
		do
			l_data := (internal_data & 0x000000FF).to_integer_8
			l_ptr := m.item + pos
			l_ptr.memory_copy ($l_data, 1)
		end
		
feature -- Settings

	set_code_size (a_size: INTEGER) is
			-- Set `code_size' to `a_size' of current feature.
		require
			valid_size: a_size >= 0 and a_size < 64
		do
			internal_data := feature {MD_METHOD_CONSTANTS}.tiny_format.to_integer_32 | (a_size |<< 2)
		ensure
			code_size_set: code_size = a_size			
		end
		
feature {NONE} -- Implementation

	internal_data: INTEGER
			-- Hold value of code_size and header type.

end -- class MD_TINY_METHOD_HEADER
