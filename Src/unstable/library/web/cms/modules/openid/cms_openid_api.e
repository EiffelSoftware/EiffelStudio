note
	description: "[
		API to manage CMS User Openid authentication.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_API

inherit
	CMS_AUTH_API_I

	REFACTORING_HELPER

create {CMS_OPENID_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_openid_storage: CMS_OPENID_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_openid_storage'.
		local
			s: detachable READABLE_STRING_8
		do
			openid_storage := a_openid_storage
			make (a_api)

				-- Initialize openid related settings.
			s := a_api.setup.site_auth_token ({CMS_OPENID_MODULE}.name)
			if s = Void then
				s := a_api.setup.site_id + default_session_token_suffix
			end
			create session_token.make_from_string (s)

			session_max_age := a_api.setup.site_auth_max_age ({CMS_OPENID_MODULE}.name)
		ensure
			openid_storage_set: openid_storage = a_openid_storage
		end

feature {CMS_MODULE} -- Access: User openid storage.

	openid_storage: CMS_OPENID_STORAGE_I
			-- storage interface.

feature -- Access: token

	default_session_token_suffix: STRING = "_OPENID_TOKEN_"

	session_token: IMMUTABLE_STRING_8
			-- Name of Cookie used to keep the session info.

	session_max_age: INTEGER
			-- Max age.		

feature -- Access: User Openid

	user_openid_by_userid_identity (a_uid: like {CMS_USER}.id; a_identity: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve a user by id `a_uid' with identity `a_identity', if any.
		do
			Result := openid_storage.user_openid_by_userid_identity (a_uid, a_identity)
		end

	user_openid_by_identity (a_identity: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := openid_storage.user_openid_by_identity (a_identity)
		end

feature -- Access: Consumers OAuth20

	openid_consumers: LIST [STRING]
			-- List of Openid consumers, if any, empty in other case.
		do
			Result := openid_storage.openid_consumers
		end

	openid_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OPENID_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		do
			Result := openid_storage.openid_consumer_by_name (a_name)
		end

feature	-- Change: User Openid

	new_user_openid (a_identity: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- Add a new user with openid using the identity `a_identity'.
		require
			has_id: a_user.has_id
		do
			openid_storage.new_user_openid (a_identity,a_user)
		end

end
