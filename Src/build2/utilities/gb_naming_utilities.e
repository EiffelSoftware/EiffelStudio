indexing
	description: "Objects that provide useful functions for naming."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NAMING_UTILITIES

feature -- Basic operations

	valid_class_name (a_name: STRING): BOOLEAN is
			-- Check that name `class_name' is a valid class name.
		local
			cn: STRING
			cchar: CHARACTER
			i: INTEGER
		do
			Result := True
			cn := a_name
			if not cn.is_empty then
				if cn = void or else not (cn @ 1).is_alpha then
					Result := False
				else
					from
						i := 2
					until
						i > cn.count or not Result
					loop
						cchar := (cn @ i)
						Result := cchar.is_alpha or cchar.is_digit or cchar = '_'
						i := i + 1
					end
				end
			end
		end

end -- class GB_NAMING_UTILITIES
