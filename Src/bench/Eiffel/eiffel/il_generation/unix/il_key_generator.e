indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_KEY_GENERATOR

create
	default_create
	
feature -- Initialization

	generate_key (a_filename: STRING) is
			-- Generate a new key pair with 'a_filename' as filename
		do
			check
				False
			end
		end

end -- class IL_KEY_GENERATOR
