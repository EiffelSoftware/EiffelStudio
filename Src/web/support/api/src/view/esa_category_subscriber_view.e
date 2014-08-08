note
	description: "Summary description for {ESA_CATEGORY_SUBSCRIBER_VIEW}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CATEGORY_SUBSCRIBER_VIEW

feature -- Access

	id: INTEGER
		-- Category Id.

	synopsis: detachable READABLE_STRING_32
		-- Category synopsis

	subscribed: BOOLEAN
		-- Is subscribed to category?

feature -- Element change

	set_id (a_id: like id)
			-- Set `id' to `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_synopsis (a_synopsis: like synopsis)
			-- Set `synopsis' to `a_synopsis'.
		do
			synopsis := a_synopsis
		ensure
			synopsis_set: synopsis = a_synopsis
		end

	set_subscribed (a_subscribed: INTEGER)
			-- Set `subscribed' to `a_subscribed'
			-- 0 : False, 1 : True
		do
			if a_subscribed = 0 then
				subscribed := False
			else
				subscribed := True
			end
		end

end
