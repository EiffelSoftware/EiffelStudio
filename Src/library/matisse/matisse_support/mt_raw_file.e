indexing
	description: "MATISSE-Eiffel Binding: Extension of RAW_FILE with byte array capability";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_RAW_FILE

inherit
	RAW_FILE

creation
	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature
	last_bytes: ARRAY [CHARACTER]
	
	last_bytes_count: INTEGER
		-- Number of bytes read from the file
		
	read_bytes (nb_bytes: INTEGER) is
			-- Read bytes of at most 'nb_bytes' bound bytes
			-- or until end of file.
			-- Make result available in 'last_bytes'.
		require
			is_readable: file_readable
		local
			bytes_area: ANY
		do
			!! last_bytes.make (1, nb_bytes)
			bytes_area := last_bytes.area
			last_bytes_count := file_read_bytes (file_pointer, $bytes_area, nb_bytes)
		end

feature {NONE} -- Implementation

	file_read_bytes (file: POINTER; byte_array: POINTER; length: INTEGER) : INTEGER is
		external 
			"C"
		end
	
end -- class MT_RAW_FILE
