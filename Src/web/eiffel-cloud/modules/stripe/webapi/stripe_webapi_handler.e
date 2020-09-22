note
	description: "Summary description for {STRIPE_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as handler_execute
		end

feature {NONE} -- Initialization

	make (a_mod_api: STRIPE_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			stripe_api := a_mod_api
		end

feature -- API

	stripe_api: STRIPE_API

	default_version: detachable STRING_8
		deferred
		end

feature -- Execution

	handler_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if attached {WSF_STRING} req.path_parameter ("version") as p_version then
				execute (p_version.value, req, res)
			elseif attached default_version as v then
			execute (v, req, res)
			else
				report_version_missing_error (req, res)
			end
		end

	report_version_missing_error (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			new_bad_request_error_response ("Missing {version} parameter", req, res).execute
		end

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		deferred
		end

feature -- Helper

	user_by_uid (a_uid: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := api.user_api.user_by_id_or_name (a_uid)
		end

feature {NONE} -- Implementation

	remove_last_segment (a_location: STRING_8; a_keep_ending_slash: BOOLEAN)
		local
			i: INTEGER
		do
			if a_location.ends_with_general ("/") then
				i := a_location.count - 1
			else
				i := a_location.count
			end
			i := a_location.last_index_of ('/', i)
			if i > 0 then
				if a_keep_ending_slash then
					a_location.keep_head (i)
				else
					a_location.keep_head (i - 1)
				end
			end
		end

	detachable_html_encoded (s: detachable READABLE_STRING_GENERAL): detachable STRING_8
			-- html encoded version of `s` if set, otherwise Void.
		do
			if s /= Void then
				Result := api.html_encoded (s)
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
