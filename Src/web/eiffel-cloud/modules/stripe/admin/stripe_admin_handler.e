note
	description: "Summary description for {STRIPE_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_ADMIN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_handler
		end

feature {NONE} -- Creation

	make (a_stripe_api: STRIPE_API)
		do
			stripe_api := a_stripe_api
			make_handler (a_stripe_api.cms_api)
		end

	stripe_api: STRIPE_API

feature -- Menu

	add_primary_tabs (r: like new_generic_response)
		do
			if api.has_permission ("manage stripe") then
				r.add_to_primary_tabs (api.administration_link ("Settings", "/stripe/settings/"))
			end
		end

end
