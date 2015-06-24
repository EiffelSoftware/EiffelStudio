note
	description: "[
		API to handle OAUTH storage
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_OAUTH_20_STORAGE_I

inherit
	SHARED_LOGGER

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: Users

	user_oauth2_by_id (a_uid: like {CMS_USER}.id; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_uid' for the consumer `a_consumer', if aby.
		deferred
		end

	user_oauth2_by_token (a_token: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by token `a_token' for the consumer `a_consumer'.
		deferred
		end

	user_oauth2_without_consumer_by_token (a_token: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve user by token `a_token' searching in all the registered consumers in the system.
		deferred
		end

feature -- Access: Consumers

	oauth2_consumers: LIST [STRING]
		deferred
		end

	oauth_consumer_by_name (a_name: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		deferred
		end

	oauth_consumer_by_callback  (a_callback: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		deferred
		end

feature -- Change: User Oauth2

	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL)
			-- Add a new user with oauth2  authentication.
		deferred
		end

	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL )
			-- Update user `a_user' with oauth2 authentication.
		deferred
		end

end
