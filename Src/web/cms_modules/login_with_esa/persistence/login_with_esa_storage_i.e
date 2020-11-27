note
	description: "[
		API to handle OAUTH storage
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOGIN_WITH_ESA_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: Users

	esa_account_for_user (u: CMS_USER): detachable ESA_ACCOUNT
		deferred
		end

	user_for_esa_name (a_esa_name: READABLE_STRING_GENERAL): detachable CMS_USER
		deferred
		end

	user_for_esa_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
		deferred
		end

feature -- Record

	associate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		deferred
		end

	dissociate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		deferred
		end

end
