indexing
	description: ".NET arrays as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ARRAY_TYPE

inherit
	CONSUMED_REFERENCED_TYPE
		rename
			internal_name as element_type_name
		export
			{ANY} element_type_name
		redefine
			name
		end

create
	make

feature -- Access

	name: STRING is
			-- Type name of Current.
		do
			create Result.make (element_type_name.count + 2)
			Result.append (element_type_name)
			Result.append_character ('[')
			Result.append_character (']')
		end
		
end -- class CONSUMED_ARRAY_TYPE
