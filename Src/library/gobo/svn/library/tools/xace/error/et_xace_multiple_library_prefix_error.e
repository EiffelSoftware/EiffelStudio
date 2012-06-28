indexing

	description:

		"Error: Library mounted several times with different prefixes"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_XACE_MULTIPLE_LIBRARY_PREFIX_ERROR

inherit

	ET_XACE_ERROR

create

	make

feature {NONE} -- Initialization

	make (a_mount1, a_mount2: ET_XACE_MOUNTED_LIBRARY) is
			-- Create a new error reporting that a library has been
			-- mounted several times with different prefixes.
		require
			a_mount1_not_void: a_mount1 /= Void
			a_mount2_not_void: a_mount2 /= Void
		local
			a_prefix: STRING
		do
			create parameters.make (1, 5)
			parameters.put (a_mount1.pathname, 1)
			a_prefix := a_mount1.library_prefix
			if a_prefix = Void then
				a_prefix := "no-prefix"
			end
			parameters.put (a_prefix, 2)
			a_prefix := a_mount2.library_prefix
			if a_prefix = Void then
				a_prefix := "no-prefix"
			end
			parameters.put (a_prefix, 3)
			parameters.put (a_mount1.position.out, 4)
			parameters.put (a_mount2.position.out, 5)
		end

feature -- Access

	default_template: STRING is "Library '$1' mounted with incompatible prefixes '$2' and '$3' in $4 and $5"
			-- Default template used to built the error message

	code: STRING is "XA0011"
			-- Error code

end
