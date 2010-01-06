indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ALL_PROPERTIES

inherit
	$SYSTEM_OBJECT

	PROPERTIES

	PROPERTIES1
		redefine
			init_properties
		end

	PROPERTIES2
		redefine
			init_properties
		end
		
feature {NONE} -- Initialization

	init_properties
		do
			Precursor {PROPERTIES1}
			Precursor {PROPERTIES2}
		end

end
