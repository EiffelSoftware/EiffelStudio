note
	description: "Array of MYSQL_BIND C Struct item."
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_INTERNAL_BIND_ARRAY

inherit
	MANAGED_POINTER
	MYSQLI_EXTERNALS
		undefine
			is_equal, copy
		end

create {MYSQLI_EXTERNALS}
	make_with_size

feature{NONE}

	make_with_size (a_size: like size)
		do
			size := a_size
			make (a_size * size_of_mysql_bind_struct)
		end

feature -- Access

	size: INTEGER

end
