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

	make (a_name: STRING; id: INTEGER; t: like element_type) is
			-- Initialize Current with type name `a_name' defined in assembly `id'
			-- where elements are of type `t'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			id_positive: id > 0
			t_not_void: t /= Void
		do
			referenced_type_make (a_name, id)
			e := t
		ensure
			name_set: name = a_name
			id_set: assembly_id = id
			element_type_set: element_type = t
		end
		
feature -- Access

	element_type: CONSUMED_REFERENCED_TYPE is
			-- Type of array element.
		do
			Result := e
		end

feature {NONE} -- Access

	e: like element_type
			-- Internal data for `element_type'.

invariant
	element_type_not_void: element_type /= Void

end -- class CONSUMED_ARRAY_TYPE
