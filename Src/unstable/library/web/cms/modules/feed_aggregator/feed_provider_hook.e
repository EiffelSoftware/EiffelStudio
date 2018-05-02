note
	description: "Summary description for {FEED_HOOK}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEED_PROVIDER_HOOK

inherit
	CMS_HOOK

feature -- Invocation

	feed (a_location: READABLE_STRING_8): detachable FEED
			-- Feed associated with `a_location`.
		deferred
		end

end
