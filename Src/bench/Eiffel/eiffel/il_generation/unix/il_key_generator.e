indexing
	description: "To generate private key for .NET systems."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_KEY_GENERATOR

create
	default_create
	
feature -- Initialization

	generate_key (a_filename, a_runtime_version: STRING) is
			-- Generate a new key pair with 'a_filename' as filename for the specified
			-- .NET version
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
			a_runtime_version_not_void: a_runtime_version /= Void
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
