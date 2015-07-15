note
	description: "[
		API to manage CMS User OAuth authentication.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create {CMS_OAUTH_20_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_oauth_storage: CMS_OAUTH_20_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_oauth_storage'.
		do
			oauth_20_storage := a_oauth_storage
			make (a_api)
		ensure
			oauht_20_storage_set:  oauth_20_storage = a_oauth_storage
		end

feature {CMS_MODULE} -- Access: User oauth storage.

	oauth_20_storage: CMS_OAUTH_20_STORAGE_I
			-- storage interface.

feature -- Access: User Oauth20

	user_oauth2_by_id (a_uid: like {CMS_USER}.id; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_uid' for the consumer `a_consumer', if any.
		do
			Result := oauth_20_storage.user_oauth2_by_id (a_uid, a_consumer)
		end

	user_oauth2_by_email (a_email: like {CMS_USER}.email; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by email `a_email' for the consumer `a_consumer', if any.
		do
			Result := oauth_20_storage.user_oauth2_by_email (a_email, a_consumer)
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

	oauth_consumer_by_name (a_name: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		do
			Result := oauth_20_storage.oauth_consumer_by_name (a_name)
		end

	oauth_consumer_by_callback  (a_callback: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		do
			Result := oauth_20_storage.oauth_consumer_by_callback (a_callback)
		end

feature	-- Change: User OAuth20


	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer: READABLE_STRING_GENERAL)
			-- Add a new user with oauth20 using the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.new_user_oauth2 (a_token, a_user_profile, a_user, a_consumer)
		end


	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL)
			-- Update user `a_user' with oauth2 for the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.update_user_oauth2 (a_token, a_user_profile, a_user, a_consumer_table)
		end


	remove_user_oauth2 (a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL)
			-- Remove user `a_user' with oauth2 for the consumer `a_consumer'.
		require
			has_id: a_user.has_id
		do
			oauth_20_storage.remove_user_oauth2 (a_user, a_consumer_table)
		end



end
