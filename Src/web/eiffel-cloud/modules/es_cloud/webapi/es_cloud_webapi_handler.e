note
	description: "Summary description for {ES_CLOUD_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_WEBAPI_HANDLER

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

	make (a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	handler_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if attached {WSF_STRING} req.path_parameter ("version") as p_version then
				execute (p_version.value, req, res)
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

	cloud_link (a_version: READABLE_STRING_GENERAL): STRING
		do
			Result := api.webapi_path ("/cloud/" + url_encoded (a_version) + "/")
		end

	cloud_user_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER): STRING
		do
			Result := cloud_link (a_version) + "account/" + a_user.id.out
		end

	cloud_user_installations_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER): STRING
		do
			Result := cloud_user_link (a_version, a_user) + "/installations"
		end

	cloud_user_installation_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; iid: READABLE_STRING_GENERAL): STRING
		do
			Result := cloud_user_installations_link (a_version, a_user) + "/" + url_encoded (iid)
		end

	cloud_user_installation_sessions_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; iid: READABLE_STRING_GENERAL): STRING
		do
			Result := cloud_user_installation_link (a_version, a_user, iid) + "/session/"
		end

	cloud_user_installation_session_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; iid, sid: READABLE_STRING_GENERAL): STRING
		do
			Result := cloud_user_installation_sessions_link (a_version, a_user, iid) + url_encoded (sid)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
