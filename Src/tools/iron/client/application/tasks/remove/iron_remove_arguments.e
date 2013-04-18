note
	description: "Summary description for {IRON_REMOVE_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REMOVE_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	resources: LIST [IMMUTABLE_STRING_32]
		deferred
		end

end
