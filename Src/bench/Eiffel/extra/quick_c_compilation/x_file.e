indexing
	description: "Objects that ..."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	X_FILE

inherit
	PLAIN_TEXT_FILE

creation
	make

feature

	read_all is
		require else
			is_readable: file_readable
		local
			l_status : INTEGER;
			str_area: ANY
		do
			last_string.resize (count);
			str_area := last_string.area;
			l_status := fread ($str_area, 1,count,file_pointer);
			last_string.set_count (l_status);
		end

	fread (l_string: POINTER; l_size: INTEGER; l_count: INTEGER; l_file: POINTER): INTEGER is
		external
			"C [macro %"stdio.h%"]"
		end

end -- class X_FILE
