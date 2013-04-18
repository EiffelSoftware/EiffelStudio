note
	description: "Summary description for {IRON_INSTALL_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_INSTALL_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	resources: LIST [IMMUTABLE_STRING_32]
		deferred
		end

end
