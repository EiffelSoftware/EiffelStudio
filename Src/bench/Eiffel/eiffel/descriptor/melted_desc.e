indexing
	description: "Melted class descriptors. A melted descriptor contains the byte code%
		%for all the class types associated with a given class."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_DESC 

inherit
	CHARACTER_ARRAY

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

creation
	make

end -- class MELTED_DESC
