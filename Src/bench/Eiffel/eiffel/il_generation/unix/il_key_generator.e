indexing
	description: "To generate private key for .NET systems."
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

feature -- Status report

	successful: BOOLEAN
			-- Was call to `generate_key' successful?

	error_message: STRING is "No supported on UNIX systems."
			-- Associated error message if not successful.

end -- class IL_KEY_GENERATOR
