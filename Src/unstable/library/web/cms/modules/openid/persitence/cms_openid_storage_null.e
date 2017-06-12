note
	description: "Summary description for {CMS_OPENID_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_STORAGE_NULL

inherit

	CMS_OPENID_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access: Users

	user_openid_by_userid_identity (a_uid: like {CMS_USER}.id; a_identity: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		do
		end

	user_openid_by_identity (a_identity: READABLE_STRING_GENERAL;): detachable CMS_USER
			-- <Precursor>
		do
		end

feature -- Access: Consumers

	openid_consumers: LIST [STRING]
			-- <Precursor>
		do
			create {ARRAYED_LIST[STRING]}Result.make(0)
		end

	openid_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OPENID_CONSUMER
			-- <Precursor>
		do
		end

feature -- Change: User Oauth2

	new_user_openid (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- <Precursor>
		do
		end

	update_user_openid (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer_table: READABLE_STRING_GENERAL )
			-- Update user `a_user' with oauth2 authentication.
		do
		end


end
