indexing
	description: "Byte code description of melted routine id array."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_ROUTID_ARRAY

inherit
	CHARACTER_ARRAY

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	make

end -- class MELTED_ROUTID_ARRAY
