note
	description:
		"Access to environment variables set by the HTTP server when the %
		%CGI application is executed. This class may be used as ancestor %
		%by classes needing its facilities."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CGI_ENVIRONMENT

inherit
	ANY

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Not request-specific environment variables

	Gateway_interface: STRING
			-- Revision of the CGI specification to which this server complies.
		once
			Result := get_env_variable ("GATEWAY_INTERFACE")
		end

	Server_name: STRING
			-- Server's hostname, DNS alias, or IP address.
		once
			Result := get_env_variable ("SERVER_NAME")
		end

	Server_software: STRING
			-- Name and version of information server answering the request.
		once
			Result := get_env_variable ("SERVER_SOFTWARE")
		end

feature -- Request specific environment variables

	Auth_type: STRING
			-- Protocol-specific authentication method used to validate user.
		once
			Result := get_env_variable ("AUTH_TYPE")
		end

	Content_length: STRING
			-- Length of the said content as given by the client.
		once
			Result := get_env_variable ("CONTENT_LENGTH")
		end

	Content_type: STRING
			-- Content type of data.
		once
			Result := get_env_variable ("CONTENT_TYPE")
		end

	Path_info: STRING
			-- Extra path information, as given by the client.
		once
			Result := get_env_variable ("PATH_INFO")
		end

	Path_translated: STRING
			-- Translated version of PATH_INFO provided by server.
		once
			Result := get_env_variable ("PATH_TRANSLATED")
		end

	Query_string: STRING
			-- Information which follows ? in URL referencing CGI program.
		once
			Result := get_env_variable ("QUERY_STRING")
		end

	Remote_host: STRING
			-- Hostname making the request.
		once
			Result := get_env_variable ("REMOTE_HOST")
		end

	Remote_addr: STRING
			-- IP address of the remote host making the request.
		once
			Result := get_env_variable ("REMOTE_ADDR")
		end

	Remote_ident: STRING
			-- User name retrieved from server if RFC 931 supported.
		once
			Result := get_env_variable ("REMOTE_IDENT")
		end

	Request_method: STRING
			-- Method with which the request was made.
		once
			Result := get_env_variable ("REQUEST_METHOD")
		end

	Remote_user: STRING
			-- Username, if applicable.
		once
			Result := get_env_variable ("REMOTE_USER")
		end

	Script_name: STRING
			-- Virtual path to the script being executed.
		once
			Result := get_env_variable ("SCRIPT_NAME")
		end

	Server_port: STRING
			-- Port number to which request was sent.
		once
			Result := get_env_variable ("SERVER_PORT")
		end

	Server_protocol: STRING
			-- Name and revision of information protocol of this request.
		once
			Result := get_env_variable ("SERVER_PROTOCOL")
		end

feature -- Cookies

	Cookies: HASH_TABLE [STRING,STRING]
			-- Cookie Information relative to data.
		local
			i,j: INTEGER
			s: STRING
		once
			Create Result.make(20)
			s := get_env_variable ("HTTP_COOKIE")
			s.append_character (';')
			from
				i := 1
			until
				i < 1
			loop
				i := s.index_of ('=', 1)
				if i > 0 then
					j := s.index_of (';', i)
					if j > i then
						Result.put (s.substring (i + 1, j - 1), s.substring (1, i - 1))
						if j < s.count - 1 then
							s.remove_head (j + 1)
						else
								-- Force termination.
							i := 0
						end
					else
							-- Force termination.
						i := 0
					end
				end
			end
		end

feature -- Headerline based environment variables

	Http_accept: STRING
			-- MIME types which the client will accept.
		once
			Result := get_env_variable ("HTTP_ACCEPT")
		end

	Http_user_agent: STRING
			-- Browser the client is using to send the request.
		once
			Result := get_env_variable ("HTTP_USER_AGENT")
		end

feature -- Environment variable setting

	set_environment_variable (variable, val: STRING)
			-- Set environment variable `variable' to `val'.
		require
			valid_variable: variable /= Void and then variable.count > 0
			valid_value: val /= Void
		do
			variable.to_upper
			put (val, variable)
		end


feature {NONE} -- Implementation

	get_env_variable (v: STRING): STRING
			-- Get value of environment variable `v'.
		do
			if {l_result: STRING} get (v) then
				Result := l_result
			else
				create Result.make_empty
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CGI_ENVIRONMENT

