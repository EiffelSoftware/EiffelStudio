indexing

	description:
		"Access to environment variables set by the HTTP server when the %
		%CGI application is executed. This class may be used as ancestor %
		%by classes needing its facilities.";

	status: "See notice at end of class"; 
	date: "$Date$";
	revision: "$Revision$"

class
	CGI_ENVIRONMENT

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		redefine
			eif_getenv, eif_putenv
		end

feature -- Not request-specific environment variables

	Gateway_interface: STRING is
			-- Revision of the CGI specification to which this server complies.
		once
			Result := get_env_variable ("GATEWAY_INTERFACE")
		end

	Server_name: STRING is
			-- Server's hostname, DNS alias, or IP address.
		once
			Result := get_env_variable ("SERVER_NAME")
		end

	Server_software: STRING is
			-- Name and version of information server answering the request.
		once
			Result := get_env_variable ("SERVER_SOFTWARE")
		end

feature -- Request specific environment variables

	Auth_type: STRING is
			-- Protocol-specific authentication method used to validate user.
		once
			Result := get_env_variable ("AUTH_TYPE")
		end

	Content_length: STRING is
			-- Length of the said content as given by the client.
		once
			Result := get_env_variable ("CONTENT_LENGTH")
		end

	Content_type: STRING is
			-- Content type of data.
		once
			Result := get_env_variable ("CONTENT_TYPE")
		end

	Path_info: STRING is
			-- Extra path information, as given by the client.
		once
			Result := get_env_variable ("PATH_INFO")
		end

	Path_translated: STRING is
			-- Translated version of PATH_INFO provided by server.
		once
			Result := get_env_variable ("PATH_TRANSLATED")
		end

	Query_string: STRING is
			-- Information which follows ? in URL referencing CGI program.
		once
			Result := get_env_variable ("QUERY_STRING")
		end

	Remote_host: STRING is
			-- Hostname making the request.
		once
			Result := get_env_variable ("REMOTE_HOST")
		end

	Remote_addr: STRING is
			-- IP address of the remote host making the request.
		once
			Result := get_env_variable ("REMOTE_ADDR")
		end

	Remote_ident: STRING is
			-- User name retrieved from server if RFC 931 supported.
		once
			Result := get_env_variable ("REMOTE_IDENT")
		end

	Request_method: STRING is
			-- Method with which the request was made.
		once
			Result := get_env_variable ("REQUEST_METHOD")
		end

	Remote_user: STRING is
			-- Username, if applicable.
		once
			Result := get_env_variable ("REMOTE_USER")
		end

	Script_name: STRING is
			-- Virtual path to the script being executed.
		once
			Result := get_env_variable ("SCRIPT_NAME")
		end

	Server_port: STRING is
			-- Port number to which request was sent.
		once
			Result := get_env_variable ("SERVER_PORT")
		end

	Server_protocol: STRING is
			-- Name and revision of information protocol of this request.
		once
			Result := get_env_variable ("SERVER_PROTOCOL")
		end

feature -- Cookies

	Cookies: HASH_TABLE[STRING,STRING] is
			-- Cookie Information relative to data
		local
			i,j: INTEGER
			s: STRING
		once
			Create Result.make(20)
			s := get_env_variable ("HTTP_COOKIE")
			from
				i := 1
			until
				i<1 
			loop
				i := s.index_of('=',1)
				if i>0 then
					j:= s.index_of(';',i)
					if j>i then
						Result.put(s.substring(1,i-1),s.substring(i+1,j-1))
						if j< s.count-1 then
							s.tail(s.count-j-1)
						else
							i := 0
						end
					else
						i := 0
					end
				end
			end
		end

feature -- Headerline based environment variables

	Http_accept: STRING is
			-- MIME types which the client will accept.
		once
			Result := get_env_variable ("HTTP_ACCEPT")
		end

	Http_user_agent: STRING is
			-- Browser the client is using to send the request.
		once
			Result := get_env_variable ("HTTP_USER_AGENT")
		end

feature -- Environment variable setting

	set_environment_variable (variable, val: STRING) is
			-- Set environment variable `variable' to `val'.
		require
			valid_variable: variable /= Void and then variable.count > 0;
			valid_value: val /= Void
		do
			variable.to_upper;
			put (val, variable)
		end


feature {NONE} -- Implementation

	get_env_variable (v: STRING): STRING is
			-- Get value of environment variable `v'.
		do
			Result := get (v);
			if Result = Void then
				Result := ""
			end
		end;

	eif_getenv (s : POINTER): POINTER is
			-- Value of environment variable `s',
			-- even on Windows.
		external
			"C (char *): char * | <stdlib.h>"
		alias
			"getenv"
		end;

	eif_putenv (v, k: POINTER): INTEGER is
			-- Safe eiffel putenv using environment variables,
			-- even on Windows.
		external
			"C | %"eif_misc.h%""
		alias
			"eif_safe_putenv"
		end;

end -- class CGI_ENVIRONMENT

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

