note
	description: "MYSQL_BIND C Struct Wrapper"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_INTERNAL_BIND_ARRAY

inherit
	MEMORY_STRUCTURE
	MYSQLI_EXTERNALS

create{MYSQLI_EXTERNALS}
	make_with_size

feature{NONE}

	make_with_size (a_size: like size)
		do
			size := a_size
			make
		end

feature

	structure_size: INTEGER
		do
			Result := size_of_mysql_bind_struct * size
		end

	size: INTEGER

end
