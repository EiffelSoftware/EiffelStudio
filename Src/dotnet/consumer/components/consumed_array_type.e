indexing
	description: ".NET arrays as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ARRAY_TYPE

inherit
	CONSUMED_REFERENCED_TYPE
		rename
			make as referenced_type_make
		end

create
	make

feature {NONE} -- Initialization

	make (n: STRING; id: INTEGER; e: like element_type) is
			-- Initialize Current with type name `n' defined in assembly `id'
			-- where elements are of type `e'.
		require
			name_not_void: n /= void
			name_not_empty: not n.is_empty
			id_positive: id > 0
			e_not_void: e /= Void
		do
			referenced_type_make (n, id)
			element_type := e
		ensure
			name_set: name = n
			id_set: assembly_id = id
			element_type_set: element_type = e
		end
		
feature -- Access

	element_type: CONSUMED_REFERENCED_TYPE
			-- Type of array element.

end -- class CONSUMED_ARRAY_TYPE
