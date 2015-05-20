note
	description: "Set of helper features related to CMS Request needs."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_REQUEST_UTIL

inherit
	CMS_ENCODERS

	REFACTORING_HELPER

feature -- User

	current_user_name (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current user name or Void in case of Guest users.
		note
			EIS: "src=eiffel:?class=AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {CMS_USER} current_user (req) as l_user then
				Result := l_user.name
			end
		end

	current_user (req: WSF_REQUEST): detachable CMS_USER
			-- Current user or Void in case of Guest user.
		note
			EIS: "eiffel:?class=AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {CMS_USER} req.execution_variable (current_user_execution_variable_name) as l_user then
				Result := l_user
			end
		end

feature -- Change

	set_current_user (req: WSF_REQUEST; a_user: detachable CMS_USER)
			-- Set `a_user' as `current_user'.
		do
			if a_user = Void then
				req.unset_execution_variable (current_user_execution_variable_name)
			else
				req.set_execution_variable (current_user_execution_variable_name, a_user)
			end
		ensure
			user_set: current_user (req) ~ a_user
		end

	unset_current_user (req: WSF_REQUEST)
			-- Unset current user.
		do
			req.unset_execution_variable (current_user_execution_variable_name)
		ensure
			user_unset: current_user (req) = Void
		end

feature {NONE} -- Implementation: current user

	current_user_execution_variable_name: STRING = "_cms_active_user_"
			-- Execution variable name used to keep current user data.

feature -- Media Type

	current_media_type (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current media type or Void if it's not acceptable.
		do
			if attached {STRING} req.execution_variable ("media_type") as l_type then
				Result := l_type
			end
		end

end
