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
		redefine
			new_response
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

	new_response (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
			if attached es_cloud_api.config.api_secret as sec then
				Result := new_signed_response (sec, req, res)
			else
				Result := Precursor (req, res)
			end
		end

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

	add_cloud_user_links_to (a_version: READABLE_STRING_GENERAL; u: ES_CLOUD_USER; rep: HM_WEBAPI_RESPONSE)
		do
			rep.add_link ("cloud_account", "user/" + u.id.out, cloud_user_link (a_version, u))
		end

	add_cloud_link_to (a_version: READABLE_STRING_GENERAL; rep: HM_WEBAPI_RESPONSE)
		do
			rep.add_link ("cloud", "cloud", cloud_link (a_version))
		end

	cloud_link (a_version: READABLE_STRING_GENERAL): STRING
		do
			Result := api.webapi_path ("/cloud/" + url_encoded (a_version) + "/")
		end

	cloud_plans_link (a_version: READABLE_STRING_GENERAL): STRING
		do
			Result := cloud_link (a_version) + "plan/"
		end

	cloud_plan_link (a_version: READABLE_STRING_GENERAL; pid: INTEGER): STRING
		do
			Result := cloud_plans_link (a_version) + pid.out
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

	cloud_user_licenses_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER): STRING
		do
			Result := cloud_user_link (a_version, a_user) + "/licenses/"
		end

	cloud_user_license_link (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; a_lic_key: READABLE_STRING_GENERAL): STRING
		do
			Result := cloud_user_licenses_link (a_version, a_user) + url_encoded (a_lic_key)
		end

feature {NONE} -- Response helper

	license_to_table (lic: ES_CLOUD_LICENSE): STRING_TABLE [detachable ANY]
		do
			create Result.make (8)
--			Result.force (lic.id, "id")
			Result.force (lic.key, "key")
			Result.force (lic.plan.id, "plan_id")
			Result.force (lic.plan.name, "plan")
			Result.force (date_time_to_string (lic.creation_date), "creation")
			Result.force (lic.is_active, "is_active")
			Result.force (lic.is_fallback, "is_fallback")
			if attached lic.expiration_date as exp then
				Result.force (date_time_to_string (exp), "expiration")
				Result.force (lic.days_remaining, "days_remaining")
			end
		end

	license_to_plan_table (lic: ES_CLOUD_LICENSE): STRING_TABLE [detachable ANY]
		do
			create Result.make (8)
			Result.force (lic.plan.name, "name")
			Result.force (lic.plan.id, "plan_id")
			Result.force (date_time_to_string (lic.creation_date), "creation")
			Result.force (lic.is_active, "is_active")
			if attached lic.expiration_date as exp then
				Result.force (date_time_to_string (exp), "expiration")
				Result.force (lic.days_remaining, "days_remaining")
			end
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
