indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC_IMPL

creation

	make

feature -- Creation

	make (obj: DATABASE) is
			-- Set database in use to `obj'.
		do
			object := obj
		end

feature -- Access

	object : DATABASE
			-- Database in use. 

feature -- Basic operations

	change_object (obj: DATABASE) is
			-- Set database in use to `obj'.
		do
			object := obj
		end

end -- class HANDLE_SPEC_IMPL
