indexing
	description: "Object that stores a block of data into a STRING object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_IO_STRING_BLOCK

inherit
	EB_PROCESS_IO_DATA_BLOCK

create 
	make

feature{NONE} -- Initialization
	
	make (str: STRING; from_error: BOOLEAN; is_last_one: BOOLEAN) is
			-- Store `str' into `Current' object.
			-- `from_error' indicates whether `str' comes from error stream 
			-- from process.
		require
			str_not_void: str /= Void
		local
			s: STRING
		do
			is_error := from_error
			is_end := is_last_one
			str.replace_substring_all ("%R", "")
			create string_buffer.make_from_string (str)	
			count := string_buffer.count
		ensure		
			is_error_set: is_error = from_error
			is_end_set: is_end = is_last_one
		end

feature  -- Status reporting

	data: ANY is
			-- 
		do
			Result := string_buffer
		end
		
	string_representation: STRING is
			-- 
		do
			Result := string_buffer
		end		
		
feature{NONE} -- Implementation
	
	string_buffer: STRING
	
invariant
	invariant_clause: True -- Your invariant here

end
