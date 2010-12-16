note
	description: "Shared Configuration."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONFIGURATION

feature -- Shared Instance

	configuration: CONFIGURATION
			-- The shared configuation object.
		local
			retain_policies: HASH_TABLE [BOOLEAN, STRING]
		once
			create Result.make ("/Users/matteo/Desktop/Frameworks/", "Cocoa")
			Result.generate_structs := False
			retain_policies := Result.retain_policies
			retain_policies.put (True , "+newlineCharacterSet")
			retain_policies.put (True , "+dataWithBytesNoCopy:length:")
			retain_policies.put (True , "+dataWithBytesNoCopy:length:freeWhenDone:")
			retain_policies.put (True , "+dragCopyCursor")
		end

end
