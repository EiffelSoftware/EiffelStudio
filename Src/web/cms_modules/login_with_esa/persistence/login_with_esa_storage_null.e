note
	description: "Summary description for {CMS_OAUTH_20_STORAGE_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_STORAGE_NULL

inherit
	LOGIN_WITH_ESA_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access

	esa_account_for_user (u: CMS_USER): detachable ESA_ACCOUNT
		do
		end

	user_for_esa_name (a_esa_name: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

	user_for_esa_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

feature -- Record

	associate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		do
		end

	dissociate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		do
		end


end
