indexing
	description: "Byte code description of melted feature."
	date: "$Date$"
	revision: "$Revision$"

class
	MELT_FEATURE 

inherit
	CHARACTER_ARRAY

	IDABLE
		rename
			id as real_body_id,
			set_id as set_real_body_id
		end

creation
	make
	
end -- class MELT_FEATURE
