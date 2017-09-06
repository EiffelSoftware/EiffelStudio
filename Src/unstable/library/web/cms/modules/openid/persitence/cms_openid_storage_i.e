note
	description: "[
		API to handle Openid storage
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_OPENID_STORAGE_I

inherit
	SHARED_LOGGER

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: Users

	user_openid_by_userid_identity (a_uid: like {CMS_USER}.id; a_consumer_table: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_uid' for the consumer `a_consumer', if aby.
		deferred
		end

	user_openid_by_identity (a_identity: READABLE_STRING_GENERAL;): detachable CMS_USER
			-- Retrieve a user by identity `a_identity'.
		deferred
		end

feature -- Access: Consumers

	openid_consumers: LIST [STRING]
			-- Return a list of consumers, or empty
		deferred
		end

	openid_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OPENID_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		deferred
		end

feature -- Change: User Oauth2

	new_user_openid (a_identity: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- Add a new user with openid  authentication.
		deferred
		end



end
