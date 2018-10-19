note
	description: "Summary description for {CMS_OAUTH_20_STORAGE_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_STORAGE_NULL

inherit

	CMS_OAUTH_20_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access: Users

	user_oauth2_by_user_id (a_uid: like {CMS_USER}.id; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- CMS User with Oauth credential by id if any.
		do
		end

	user_oauth2_by_id (a_oauth_id: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		do
		end

	user_oauth2_by_token (a_token: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- -- CMS User with Oauth credential by access token `a_token' if any.
		do
		end

	user_oauth2_without_consumer_by_token (a_token: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

feature -- Access: Consumers

	oauth2_consumers: LIST [STRING]
		do
			create {ARRAYED_LIST [STRING]} Result.make (0)
		end

	oauth_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		do
		end

	oauth_consumer_by_callback (a_callback: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		do
		end

feature -- Change: User Oauth2

	save_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
		do
		end

	delete_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
		do
		end

	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL)
			-- Add a new user with oauth2  authentication.
		do
		end

	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer_table: READABLE_STRING_GENERAL )
			-- Update user `a_user' with oauth2 authentication.
		do
		end

	remove_user_oauth2 (a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL)
			-- Remove user `a_user' with oauth2 for the consumer `a_consumer'.
		do
		end



end
