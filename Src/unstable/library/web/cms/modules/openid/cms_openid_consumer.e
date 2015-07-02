note
	description: "Summary description for {CMS_OPENID_CONSUMER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_CONSUMER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: like id)
		do
			id := a_id
			default_create
		end

	default_create
		do
			set_endpoint ("")
			set_name ("")
		end

feature -- Access

	endpoint: READABLE_STRING_8
			-- 	Url to authorize the user.

	name: READABLE_STRING_8
			-- consumer name.

	id: INTEGER_64
			-- unique identifier.

feature -- Element change


	set_endpoint (a_endpoint: like endpoint)
			-- Assign `endpoint' with `a_endpoint'.
		do
			endpoint := a_endpoint
		ensure
			endpoint_assigned: endpoint = a_endpoint
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

end
