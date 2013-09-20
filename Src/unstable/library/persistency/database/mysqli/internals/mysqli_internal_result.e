note
	description: "MYSQL_RESULT C Struct Wrapper"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_INTERNAL_RESULT

inherit
	MEMORY_STRUCTURE
	MYSQLI_EXTERNALS

create{MYSQLI_EXTERNALS}
	make,
	make_by_pointer

feature

	structure_size: INTEGER
		do
			Result := size_of_mysql_res_struct
		end

end
