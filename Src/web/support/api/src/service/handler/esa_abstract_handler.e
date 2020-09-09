note
	description: "Abstrat Eiffel Support API Handler."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_ABSTRACT_HANDLER

inherit
	WSF_HANDLER

	ESA_HANDLER

	SHARED_CONNEG_HELPER

feature -- Change

	set_esa_config (a_esa_config: like esa_config)
			-- Set `esa_config' to `a_esa_condig'.
		do
			esa_config := a_esa_config
		ensure
			esa_config_set: esa_config = a_esa_config
		end

feature -- Access

	esa_config: ESA_CONFIG
		-- Configuration.

	api_service: ESA_API_SERVICE
			-- api Service.
		do
			Result := esa_config.api_service
		end

	email_notification_service: ESA_NOTIFICATION_EMAIL_SERVICE
		do
			Result := esa_config.email_notification_service
		end

	cookie_service: ESA_COOKIE_SESSION_SERVICE
		do
			create Result.make ((create {APP_JSON_CONFIGURATION}).cookie_session_remember_me(esa_config.layout.application_config_path))
		end

	Esa_session_token: STRING_8 = "_ESA_SESSION_TOKEN_"


	eiffel_versions: detachable LIST [STRING]
			-- List of stable eiffel versions.
		do
			Result := (create {APP_JSON_CONFIGURATION}).eiffel_stable_versions(esa_config.layout.application_config_path)
		end

feature -- String Helper

	Empty_string:  STRING_32 = ""
			-- Empty manifest string.
end
