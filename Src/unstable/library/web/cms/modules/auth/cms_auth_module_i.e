note
	description: "Common ancestor for Authentication modules."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_AUTH_MODULE_I

inherit
	CMS_MODULE
		redefine
			setup_hooks
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK_HELPER

	SHARED_LOGGER

feature {NONE} -- Initialization

	make
		do
			package := "authentication"
			add_dependency ({CMS_AUTHENTICATION_MODULE})
		end

feature -- Access: auth strategy

	login_title: READABLE_STRING_GENERAL
			-- Module specific login title.
		deferred
		end

	login_location: STRING
			-- Login cms location for Current module.
		deferred
		end

	logout_location: STRING
			-- Logout cms location for Current module.
		deferred
		end

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
			-- Is Current module strategy currently authenticating active user?
		deferred
		ensure
			Result implies a_response.is_authenticated
		end

	has_permission_to_use_authentication (api: CMS_API): BOOLEAN
			-- Is current user (or anonymous) has permssion to use Current authentication?
		do
				-- By default, authorize
			Result := True
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- <Precursor>
		local
			lnk: CMS_LOCAL_LINK
			l_destination: READABLE_STRING_8
		do
			if attached a_response.destination_location as v then
				l_destination := v
			else
				l_destination := a_response.location
			end
			l_destination := secured_url_content (l_destination)
			if is_authenticating (a_response) then

			else
				if
					a_response.location.starts_with ("account/auth/") and then
					has_permission_to_use_authentication (a_response.api)
				then
					create lnk.make (login_title, login_location)
					if not l_destination.starts_with ("account/auth/") then
						lnk.add_query_parameter ("destination", l_destination)
					end
					lnk.set_expandable (True)
					a_response.add_to_primary_tabs (lnk)
				end
			end
		end

feature {NONE} -- Template		

	smarty_template_login_block (a_request: WSF_REQUEST; a_module: CMS_MODULE; a_block_id: READABLE_STRING_8; a_cms_api: CMS_API): like smarty_template_block
		local
			l_destination: detachable READABLE_STRING_GENERAL
		do
			Result := smarty_template_block (a_module, a_block_id, a_cms_api)
			if Result /= Void then
				l_destination := a_cms_api.destination_location (a_request)
				if
					l_destination /= Void and then
					(	l_destination.is_whitespace
						or else	not l_destination.is_valid_as_string_8
					)
				then
					l_destination := Void
				end

				if l_destination /= Void then
					Result.set_value (secured_url_content (l_destination.to_string_8), "site_destination")
				end
				if a_cms_api.has_permission ({CMS_AUTHENTICATION_MODULE}.perm_account_register) then
					if l_destination /= Void then
						Result.set_value ({CMS_AUTHENTICATION_MODULE}.roc_register_location + "?destination=" + secured_url_content (l_destination.to_string_8), "site_register_url")
					else
						Result.set_value ({CMS_AUTHENTICATION_MODULE}.roc_register_location, "site_register_url")
					end
				end
			end
		end

end
