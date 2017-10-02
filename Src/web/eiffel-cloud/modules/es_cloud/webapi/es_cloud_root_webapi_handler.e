note
	description: "Summary description for {ES_CLOUD_ROOT_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ROOT_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER
		redefine
			report_version_missing_error
		end

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: like new_response
			l_url: READABLE_STRING_8
		do
			rep := new_response (req, res)
			l_url := api.url (rep.location + "account/", Void)
			if attached api.user as u then
				l_url := l_url + u.id.out
				rep.add_link ("es:account", Void, l_url)
				rep.add_link ("es:installations", Void, l_url + "/installations")
				add_user_links_to (u, rep)
			else
				rep.add_link ("es:account", Void, l_url)
			end
			rep.add_self (req.request_uri)
			rep.execute
		end

	report_version_missing_error (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_error_response
		do
			r := new_error_response ("Missing {version} parameter", req, res)
			r.set_redirection (api.absolute_url (api.webapi_path ("/cloud/v1/"), Void))
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

