indexing
	description: "Byte code description of melted feature table."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_FEATURE_TABLE 

inherit
	CHARACTER_ARRAY

	IDABLE
		rename
			id as type_id,
			set_id as set_type_id
		end

creation
	make
	
end -- class MELTED_FEATURE_TABLE
