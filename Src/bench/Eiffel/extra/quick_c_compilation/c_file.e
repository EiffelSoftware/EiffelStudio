indexing
	description: "Objects that ..."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	C_FILE

inherit
	RAW_FILE

create
	make

feature

	read_all (input_string: STRING) is
		require else
			is_readable: file_readable
		local
			l_status : INTEGER;
			str_area: ANY
		do
			if count > input_string.capacity then
				input_string.resize (count);
			end
			str_area := input_string.area
			l_status := fread ($str_area, 1, count,file_pointer)
			input_string.set_count (l_status);
		end

	fread (l_string: POINTER; l_size: INTEGER; l_count: INTEGER; l_file: POINTER): INTEGER is
		external
			"C [macro %"stdio.h%"] (void *, size_t, size_t, FILE *): EIF_INTEGER"
		end

end -- class C_FILE
