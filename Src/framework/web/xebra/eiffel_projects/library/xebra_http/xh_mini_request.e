note
	description: "[
		Represents a special version of request with only few attributes.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_MINI_REQUEST

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			webapp := ""
			post_too_big := False
		end

feature -- Access

	webapp: STRING
		-- The name of the webapp (extracted from uri)

	post_too_big: BOOLEAN
		-- True if the module added the post_too_big flag to the request

feature -- Status setting

	set_webapp (a_webapp: like webapp)
			-- Sets webapp.
		require
			a_webapp_attached: a_webapp /= Void
		do
			webapp := a_webapp
		ensure
			webapp_set: equal (webapp, a_webapp)
		end

	set_post_too_big (a_post_too_big: like post_too_big)
			-- Sets post_too_big.
		do
			post_too_big := a_post_too_big
		ensure
			post_too_big_set: equal (post_too_big, a_post_too_big)
		end

end

