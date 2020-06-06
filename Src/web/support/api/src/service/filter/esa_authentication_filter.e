note
	description: "Authentication filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_AUTHENTICATION_FILTER

inherit
	WSF_URI_TEMPLATE_HANDLER

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end
	WSF_FILTER


create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_auth: HTTP_AUTHORIZATION
		do
				-- Basic Authentication
			if attached req.http_authorization then
				debug
					log.write_debug (generator + ".execute " )
				end
				create l_auth.make (req.http_authorization)
				if attached req.raw_header_data as l_raw_data then
				   log.write_debug (generator + ".execute " + l_raw_data )
				end
					-- A valid user
				if (attached l_auth.type as l_auth_type and then l_auth_type.is_case_insensitive_equal ("basic")) and then
					attached l_auth.login as l_auth_login and then attached l_auth.password as l_auth_password then
					if attached {USER} api_service.user_login_valid (l_auth_login, l_auth_password) as l_user then
						req.set_execution_variable ("user", l_user)
						execute_next (req, res)
					else
						log.write_error (generator + ".execute login_valid failed for: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_auth_login))
						execute_next (req, res)
					end
				else
					log.write_error (generator + ".execute Not valid")
					execute_next (req, res)
				end
			else
					-- Session Authentication
				if
					attached {WSF_STRING} req.cookie (esa_session_token) as l_esa_auth_session_token
				then
					if attached api_service.user_by_session_token (l_esa_auth_session_token.value.to_string_8) as l_user then
						req.set_execution_variable ("user", l_user)
					else
						log.write_error (generator + ".execute login_valid failed for: " + Esa_session_token )
					end
				end
				execute_next (req, res)
			end
		end

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
