note
	description: "Summary description for {CMS_ROOT_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROOT_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
		do
			rep := new_webapi_response (req, res)
			rep.add_string_field ("site_name", api.setup.site_name)
			if attached api.user as u then
				add_user_links_to (u, rep)
			end
			rep.add_self (req.percent_encoded_path_info)
			rep.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
