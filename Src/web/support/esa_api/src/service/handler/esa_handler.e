note
	description: "Summary description for {ESA_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HANDLER

inherit

	ESA_SHARED_LOGGER

feature -- User

	current_user_name (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current user name or Void in case of Guest users.
		note
			EIS: "name=Authentication Filter", "src=https://svn.eiffel.com/eiffelstudio/trunk/Src/web/support/esa_api/src/service/filter/esa_authentication_filter.e", "protocol=URI"
			EIS: "src=eiffel:?class=ESA_AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {ESA_USER} current_user (req) as l_user then
				Result := l_user.name
			end
		end

	current_user (req: WSF_REQUEST): detachable ESA_USER
			-- Current user or Void in case of Guest user.
		note
			EIS: "name=Authentication Filter", "src=https://svn.eiffel.com/eiffelstudio/trunk/Src/web/support/esa_api/src/service/filter/esa_authentication_filter.e", "protocol=URI"
			EIS: "eiffel:?class=ESA_AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {ESA_USER} req.execution_variable ("user") as l_user then
				Result := l_user
			end
		end

feature -- Media Type

	current_media_type (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current media type of Void if it's not acceptable.
		do
			if attached {STRING} req.execution_variable ("media_type") as l_type then
				Result := l_type
			end
		end

	absolute_host (req: WSF_REQUEST; a_path:STRING): STRING
		do
			Result := req.absolute_script_url (a_path)
			if Result.last_index_of ('/', Result.count) = Result.count then
				Result.remove_tail (1)
			end
			log.write_debug (generator + ".absolute_host " + Result )
		end

end
