note
	description: "Summary description for {BASIC_AUTH_LOGOFF_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_LOGOFF_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
			l_url: STRING
			i: INTEGER
		do
			api.logger.put_information (generator + ".do_get Processing basic auth logoff", Void)
			if attached req.query_parameter ("prompt") as l_prompt then
				unset_current_user (req)
				send_access_denied_message (res)
			else
				create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
				unset_current_user (req)
				l_page.set_status_code ({HTTP_STATUS_CODE}.found) -- Note: can not use {HTTP_STATUS_CODE}.unauthorized for redirection
				if attached {WSF_STRING} req.query_parameter ("destination") as l_uri then
					l_url := req.absolute_script_url (l_uri.url_encoded_value)
				else
					l_url := req.absolute_script_url ("")
				end
				i := l_url.substring_index ("://", 1)
				if i > 0 then
						-- Note: this is a hack to have the logout effective on various browser
						-- (firefox requires this).
					l_url.replace_substring ("://_logout_basic_auth_@", i, i + 2)
				end
				l_page.set_redirection (l_url)
				l_page.execute
			end
		end

end
