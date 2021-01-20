note
	description: "API to handle login with eiffel accounts."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			if
				attached cms_api.module_configuration_by_name ({LOGIN_WITH_ESA_MODULE}.name, "config") as cfg and then
				attached cfg.resolved_text_item ("esa.server_url") as l_url and then
				l_url.is_valid_as_string_8
			then
				create server_url.make_from_string (l_url.to_string_8)
			else
				create server_url.make_from_string ("https://support.eiffel.com")
			end
					-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {LOGIN_WITH_ESA_STORAGE_SQL} login_with_esa_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {LOGIN_WITH_ESA_STORAGE_NULL} login_with_esa_storage
			end
		end

feature {CMS_MODULE} -- Access storage.

	login_with_esa_storage: LOGIN_WITH_ESA_STORAGE_I

feature -- Access/ ESA

	server_url: IMMUTABLE_STRING_8

	is_valid_credential (a_username, a_password: READABLE_STRING_GENERAL): BOOLEAN
		local
			acc: ESA_SUPPORT_ACCOUNT
			cfg: ESA_CLIENT_CONFIGURATION
			retried: BOOLEAN
		do
			if not retried then
				reset_error

				create cfg.make (server_url)
				create acc.make (cfg)
				acc.attempt_logon (a_username, a_password, False)
				Result := acc.is_logged_in
			end
		rescue
			error_handler.add_custom_error (-1, "Error occurred", Void)
			retried := True
			retry
		end

	esa_account (a_username, a_password: READABLE_STRING_GENERAL): detachable ESA_ACCOUNT
		local
			acc: ESA_SUPPORT_ACCOUNT
			cfg: ESA_CLIENT_CONFIGURATION
			retried: BOOLEAN
		do
			if not retried then
				reset_error

				create cfg.make (server_url)
				create acc.make (cfg)
				acc.attempt_logon (a_username, a_password, False)
				if acc.is_logged_in then
					Result := acc.account_details
				end
			end
		rescue
			error_handler.add_custom_error (-1, "Error occurred", Void)
			retried := True
			retry
		end

	register_esa_account (a_account: ESA_ACCOUNT; a_password: READABLE_STRING_GENERAL)
		local
			reg: ESA_SUPPORT_USER_REGISTER
			acc: ESA_USER_REGISTER
			cfg: ESA_CLIENT_CONFIGURATION
			retried: BOOLEAN
		do
			if not retried then
				reset_error

				if
					attached a_account.username as l_user_name and then
					attached a_account.first_name as l_first_name and then
					attached a_account.last_name as l_last_name and then
					attached a_account.email as l_email
				then
					create cfg.make (server_url)
					create reg.make (cfg)
					create acc.make
					acc.set_user_name (l_user_name)
					acc.set_password (a_password)
					acc.set_first_name (l_first_name)
					acc.set_last_name (l_last_name)
					acc.set_email (l_email)
					reg.user_register (acc)
				else
					error_handler.add_custom_error (-1, "Missing required values", Void)
				end
			end
		rescue
			error_handler.add_custom_error (-1, "Error occurred", Void)
			retried := True
			retry
		end

feature -- Relation with CMS

	esa_account_for_user (u: CMS_USER): detachable ESA_ACCOUNT
		do
			Result := login_with_esa_storage.esa_account_for_user (u)
		end

	user_for_esa_name (a_esa_name: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := login_with_esa_storage.user_for_esa_name (a_esa_name)
			if Result = Void and then a_esa_name.has ('@') then
				Result := login_with_esa_storage.user_for_esa_email (a_esa_name)
			end
		end

	user_for_esa_email (a_esa_email: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := login_with_esa_storage.user_for_esa_email (a_esa_email)
		end

	associate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		do
			login_with_esa_storage.associate_esa_account (a_user, a_esa_account)
			cms_api.log ("login_with_esa", "Associated eiffel.com accout with " + utf_8_encoded (cms_api.real_user_display_name (a_user)), {CMS_LOG}.level_info, cms_api.user_local_link (a_user, Void))
		end

	dissociate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		do
			login_with_esa_storage.dissociate_esa_account (a_user, a_esa_account)
			cms_api.log ("login_with_esa", "Dissociated eiffel.com account from " + utf_8_encoded (cms_api.real_user_display_name (a_user)), {CMS_LOG}.level_info, cms_api.user_local_link (a_user, Void))
		end

	associated_cms_user (a_esa_username, a_password: READABLE_STRING_GENERAL; a_flag_create_user: BOOLEAN): detachable CMS_USER
			-- CMS user associated with ESA account `a_esa_username:a_password`
			-- and if none and `a_flag_create_user` then register new user
			-- with ESA account.
		require
			is_valid_credential: is_valid_credential (a_esa_username, a_password)
		local
			l_user_api: CMS_USER_API
		do
			l_user_api := cms_api.user_api
			if a_esa_username.has ('@') then
				Result := l_user_api.user_by_email (a_esa_username)
			end
			if Result = Void then
				Result := user_for_esa_name (a_esa_username)
--				Result := l_user_api.user_by_name (a_esa_username)
			end
			if Result = Void then
				if
					attached esa_account (a_esa_username, a_password) as l_esa_account and then
					attached l_esa_account.username as l_esa_user_name and then
					attached l_esa_account.email as l_esa_user_email
				then
						-- Check if ESA name is already registered
					Result := user_for_esa_name (l_esa_user_name)
					if Result = Void then
						Result := user_for_esa_email (l_esa_user_email)
						if Result /= Void then
							associate_esa_account (Result, l_esa_account)
						end
					end
					if Result = Void then
							-- Check if email is not already registered...
						Result := l_user_api.user_by_email (l_esa_user_email)
						if Result = Void and a_flag_create_user then
								-- No user with given username or email,
								-- then register a new user... but without the ESA password!!!
							Result := l_user_api.new_active_user (l_esa_user_name, l_esa_user_email, Void)--a_password)
						end
						if Result /= Void then
							associate_esa_account (Result, l_esa_account)
						end
					end
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

