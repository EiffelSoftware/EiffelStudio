indexing
	description: "List of attribute sorted by category or skeleton of a class"
	date: "$date: $"
	revision: "$revision: $"

class GENERIC_SKELETON 

inherit
	ARRAYED_LIST [ATTR_DESC]

create
	make

feature -- Creation of CLASS_TYPE skeleton

	instantiation_in (class_type: CLASS_TYPE): SKELETON is
			-- Instantiation of Current in `class_type'.
		require
			class_type_not_void: class_type /= Void
			class_type_valid: class_type.type.is_valid
		do
			from
				create Result.make (count)
				start
			until
				after
			loop
				Result.extend (item.instantiation_in (class_type))
				forth
			end
			Result.update
		end

end
