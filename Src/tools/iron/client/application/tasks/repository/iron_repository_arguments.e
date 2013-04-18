note
	description: "Summary description for {IRON_REPOSITORY_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPOSITORY_ARGUMENTS

inherit
	IRON_ARGUMENTS

feature -- Access

	is_listing: BOOLEAN
		deferred
		end

	repository_url: detachable IMMUTABLE_STRING_32
		deferred
		end

	repository_to_add: detachable IMMUTABLE_STRING_8
		deferred
		end

	repository_to_remove: detachable IMMUTABLE_STRING_32
			-- Name or uri to unregister.
		deferred
		end


end
