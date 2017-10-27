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
--			if attached cms_api.storage.as_sql_storage as l_storage_sql then
--				create {LOGIN_WITH_ESA_STORAGE_SQL} login_with_esa_storage.make (l_storage_sql)
--			else
--					-- FIXME: in case of NULL storage, should Current be disabled?
--				create {LOGIN_WITH_ESA_STORAGE_NULL} login_with_esa_storage
--			end
		end

feature {CMS_MODULE} -- Access storage.

--	login_with_esa_storage: LOGIN_WITH_ESA_STORAGE_I

feature -- Access/ ESA

	server_url: IMMUTABLE_STRING_8

	is_valid_credential (a_username, a_password: READABLE_STRING_GENERAL): BOOLEAN
		local
			log: ESA_SUPPORT_LOGIN
			cfg: ESA_CLIENT_CONFIGURATION
			retried: BOOLEAN
		do
			if not retried then
				reset_error

				create cfg.make (server_url)
				create log.make (cfg)
				log.attempt_logon (a_username, a_password, False)
				if log.is_logged_in then
					Result := True
				end
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

				create cfg.make ("https://support2.eiffel.com")
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
					create cfg.make ("https://support2.eiffel.com")
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

	associated_cms_user (a_esa_username, a_password: READABLE_STRING_GENERAL; a_flag_create_user: BOOLEAN): detachable CMS_USER
			-- CMS user associated with ESA account `a_esa_username:a_password`
			-- and if none and `a_flag_create_user` then register new user
			-- with ESA account.
		local
			l_user_api: CMS_USER_API
		do
			l_user_api := cms_api.user_api
			if a_esa_username.has ('@') then
				Result := l_user_api.user_by_email (a_esa_username)
			end
			if Result = Void then
				Result := l_user_api.user_by_name (a_esa_username)
			end
			if Result = Void then
				if
					attached esa_account (a_esa_username, a_password) as l_esa_account and then
					attached l_esa_account.username as l_esa_user_name and then
					attached l_esa_account.email as l_esa_user_email
				then
						-- Check if email is not already registered...
					Result := l_user_api.user_by_email (l_esa_user_email)
					if Result = Void and a_flag_create_user then
							-- No user with given username or email,
							-- then register a new user...
						create Result.make (l_esa_user_name)
						Result.set_password (a_password.to_string_32)
						Result.set_email (l_esa_user_email)
						l_user_api.new_user (Result)
							-- FIXME: ... store association with ESA in DB?
					end
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

