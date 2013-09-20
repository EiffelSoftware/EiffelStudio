note
	description: "MYSQL_STMT C Struct Wrapper"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_INTERNAL_STATEMENT

inherit
	MEMORY_STRUCTURE
	MYSQLI_EXTERNALS

create{MYSQLI_EXTERNALS}
	make_by_pointer

feature

	structure_size: INTEGER
		do
			Result := size_of_mysql_stmt_struct
		end

end

