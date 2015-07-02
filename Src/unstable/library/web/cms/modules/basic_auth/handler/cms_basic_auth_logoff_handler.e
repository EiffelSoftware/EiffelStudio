note
	description: "Summary description for {CMS_BASIC_AUTH_LOGOFF_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_AUTH_LOGOFF_HANDLER

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
				l_page.set_status_code ({HTTP_STATUS_CODE}.unauthorized) -- Note: can not use {HTTP_STATUS_CODE}.unauthorized for redirection
				l_url := req.absolute_script_url ("")
				i := l_url.substring_index ("://", 1)
				if i > 0 then
						-- Note: this is a hack to have the logout effective on various browser
						-- (firefox requires this).
					l_url.replace_substring ("://_logout_basic_auth_@", i, i + 2)
				end
				if
					attached req.http_user_agent as l_user_agent and then
					browser_name (l_user_agent).is_case_insensitive_equal_general ("Firefox")
				then
					-- Set status to refirect
					-- and redirect to the host page.
					l_page.set_status_code ({HTTP_STATUS_CODE}.found)
					l_page.set_redirection (l_url)
				end
				l_page.execute
			end
		end


	browser_name (a_user_agent: READABLE_STRING_8): READABLE_STRING_32
            -- Browser name.
            --                      Must contain    Must not contain
            --  Firefox             Firefox/xyz     Seamonkey/xyz
            --  Seamonkey           Seamonkey/xyz
            --  Chrome              Chrome/xyz      Chromium/xyz
            --  Chromium            Chromium/xyz
            --  Safari              Safari/xyz      Chrome/xyz
            --                                      Chromium/xyz
            --  Opera               OPR/xyz [1]
            --                      Opera/xyz [2]
            --  Internet Explorer   ;MSIE xyz;      Internet Explorer doesn't put its name in the BrowserName/VersionNumber format

        do
            if
                a_user_agent.has_substring ("Firefox") and then
                not a_user_agent.has_substring ("Seamonkey")
            then
                Result := "Firefox"
            elseif a_user_agent.has_substring ("Seamonkey") then
                Result := "Seamonkey"
            elseif a_user_agent.has_substring ("Chrome") and then not a_user_agent.has_substring ("Chromium")then
                Result := "Chrome"
            elseif a_user_agent.has_substring ("Chromium") then
                Result := "Chromiun"
            elseif a_user_agent.has_substring ("Safari") and then not (a_user_agent.has_substring ("Chrome") or else a_user_agent.has_substring ("Chromium"))  then
                Result := "Safari"
            elseif a_user_agent.has_substring ("OPR") or else  a_user_agent.has_substring ("Opera") then
                Result := "Opera"
            elseif a_user_agent.has_substring ("MSIE") or else a_user_agent.has_substring ("Trident")then
                Result := "Internet Explorer"
            else
                Result := "Unknown"
            end
        end

end
