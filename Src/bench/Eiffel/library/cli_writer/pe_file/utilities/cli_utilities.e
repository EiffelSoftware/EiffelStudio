indexing
	description: "Utilities for CLI PE file handling"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_UTILITIES

feature -- Access

	padding (i, chunk_size: INTEGER): INTEGER is
			-- Compute needed padding from position `i' to reach a multiple of `chunk_size'.
		require
			valid_i: i >= 0
			valid_chunk_size: chunk_size >= 0
		do
			if i /= 0 then
				Result := (((i - 1) // chunk_size) + 1) * chunk_size - i
			end
		ensure
			valid_result: Result >= 0
		end

	pad_up (i, chunk_size: INTEGER): INTEGER is
			-- Padded position of `i' to reach a multiple of `chunk_size'.
		require
			valid_i: i >= 0
			valid_chunk_size: chunk_size >= 0
		do
			if i /= 0 then
				Result := (((i - 1) // chunk_size) + 1) * chunk_size
			end
		ensure
			valid_result: Result >= 0
		end

	file_alignment: INTEGER is
			-- Current chosen file alignment.
		do
			Result := file_alignment_cell.item
		ensure
			valid_result: Result > 0
		end

feature {NONE} -- Implementation

	file_alignment_cell: INTEGER_REF is
			-- 
		once
			create Result
			Result.set_item (Small_file_alignment)
		end
		
feature -- Constants

	section_alignment: INTEGER is 0x2000
			-- Default section alignment.
	
	small_file_alignment: INTEGER is 0x0200
			-- Small file alignment.
	
	large_file_alignment: INTEGER is 0x1000
			-- Large file alignment.
		
end -- class CLI_UTILITIES
