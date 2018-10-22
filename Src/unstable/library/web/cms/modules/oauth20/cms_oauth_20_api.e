note
	description: "[
			API to manage CMS User OAuth authentication.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_API

inherit
	CMS_AUTH_API_I

	REFACTORING_HELPER

create {CMS_OAUTH_20_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_oauth_storage: CMS_OAUTH_20_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_oauth_storage'.
		local
			s: detachable READABLE_STRING_8
		do
			oauth_20_storage := a_oauth_storage
			make (a_api)

				-- Initialize session related settings.
			s := a_api.setup.site_auth_token ("oauth")
			if s = Void then
				s := a_api.setup.site_id + default_session_token_suffix
			end
			create session_token.make_from_string (s)
			session_max_age := a_api.setup.site_auth_max_age ("oauth")
		ensure
			oauth_20_storage_set:  oauth_20_storage = a_oauth_storage
		end

feature {CMS_MODULE} -- Access: Oauth storage.

	oauth_20_storage: CMS_OAUTH_20_STORAGE_I
			-- storage interface.

feature -- Access: tokens

	default_session_token_suffix: STRING = "_OAUTH_TOKEN_"
			-- Default value for `session_token'.

	session_token: IMMUTABLE_STRING_8
			-- Name of Cookie used to keep the session info.

	session_max_age: INTEGER
			-- Max age.	

feature -- Access: Oauth20

	user_oauth2_by_user_id (a_uid: like {CMS_USER}.id; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_uid' for the consumer `a_consumer', if any.
		do
			Result := oauth_20_storage.user_oauth2_by_user_id (a_uid, a_consumer)
		end

	user_oauth2_by_id (a_oauth_id: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_oauth_id' for the consumer `a_consumer', if any.
		do
			Result := oauth_20_storage.user_oauth2_by_id (a_oauth_id, a_consumer)
		end

	user_oauth2_by_token (a_token: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by token `a_token' for the consumer `a_consumer'.
		do
			Result := oauth_20_storage.user_oauth2_by_token (a_token, a_consumer)
		end

	user_oauth2_without_consumer_by_token (a_token: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve user by token `a_token' searching in all the registered consumers in the system.
		do
			Result := oauth_20_storage.user_oauth2_without_consumer_by_token (a_token)
		end

feature -- Access: Consumers OAuth20

	oauth2_consumers: LIST [STRING]
			-- List of Oauth_20 consumers, if any, empty in other case.
		do
			Result := oauth_20_storage.oauth2_consumers
		end

	oauth_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		do
			Result := oauth_20_storage.oauth_consumer_by_name (a_name)
		end

	oauth_consumer_by_callback (a_callback: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		do
			Result := oauth_20_storage.oauth_consumer_by_callback (a_callback)
		end

feature	-- Change: User OAuth20

	save_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
		do
			oauth_20_storage.save_oauth_consumer (a_cons)
		end

	delete_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
		do
			oauth_20_storage.delete_oauth_consumer (a_cons)
		end

	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL)
			-- Add a new user with oauth20 using the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.new_user_oauth2 (a_token, a_user_profile, a_user, a_oauth_id, a_consumer)
		end

	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL)
			-- Update user `a_user' with oauth2 for the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.update_user_oauth2 (a_token, a_user_profile, a_user, a_oauth_id, a_consumer_table)
		end

	remove_user_oauth2 (a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL)
			-- Remove user `a_user' with oauth2 for the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.remove_user_oauth2 (a_user, a_consumer_table)
		end

end
