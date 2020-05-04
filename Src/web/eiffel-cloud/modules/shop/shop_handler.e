note
	description: "Summary description for {SHOP_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: SHOP_MODULE; a_mod_api: SHOP_API; a_base_url: READABLE_STRING_8)
		do
			module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			shop_api := a_mod_api
		end

feature -- API

	module: SHOP_MODULE

	shop_api: SHOP_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: like new_generic_response
		do
			if shop_api.config.is_valid then
				send_bad_request (req, res)
			else
				rep := new_generic_response (req, res)
				rep.set_main_content ("<div class=%"error%">Shop module is not correctly configured!</div>")
				rep.execute
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
