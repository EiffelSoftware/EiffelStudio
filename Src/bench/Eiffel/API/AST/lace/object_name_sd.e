indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	OBJECT_NAME_SD

inherit
	LANGUAGE_NAME_SD
		redefine
			is_object
		end

feature -- Properties

	is_object: BOOLEAN is True
			-- Is the language name "Object" ?

end -- class OBJECT_NAME_SD
