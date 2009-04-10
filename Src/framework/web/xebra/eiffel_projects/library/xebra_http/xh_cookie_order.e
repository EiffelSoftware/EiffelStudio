note
	description: "[
		Contains all information to be handed to the request 
		out header in order create a rfc2109 cookie in the browser
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_COOKIE_ORDER

inherit
	XH_COOKIE

	redefine
		make
	end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING)
			-- Initialization for `Current'.
		do
			-- Initialize to default values
			name := a_name
			value := a_value
			max_age := default_max_age
			path := ""
			domain := ""
			comment := ""
			is_secure := false
			version := "1"
		end

feature -- Access


	max_age: NATURAL assign set_max_age
		-- Optional.  The Max-Age attribute defines the lifetime of the
		-- cookie, in seconds.  The delta-seconds value is a decimal non-
		-- negative integer.  After delta-seconds seconds elapse, the client
		-- should discard the cookie.  A value of zero means the cookie
		-- should be discarded immediately. Set to < 0 to ignore this parameter.

	version: STRING
		-- Required.  The Version attribute, a decimal integer, identifies to
		-- which version of the state management specification the cookie
		-- conforms.  For this specification, Version=1 applies.

	path: STRING assign set_path
		-- Optional.  The Path attribute specifies the subset of URLs to
		-- which this cookie applies.

	comment: STRING assign set_comment
		-- Optional.  Because cookies can contain private information about a
	    -- user, the Cookie attribute allows an origin server to document its
	    -- intended use of a cookie.  The user can inspect the information to
	    -- decide whether to initiate or continue a session with this cookie.

	domain: STRING  assign set_domain
		-- Optional.  The Domain attribute specifies the domain for which the
		-- cookie is valid.  An explicitly specified domain must always start
		-- with a dot.

	is_secure: BOOLEAN assign set_secure
		-- Optional.  The Secure attribute (with no value) directs the user
		-- agent to use only (unspecified) secure means to contact the origin
		-- server whenever it sends back this cookie.
		-- The user agent (possibly under the user's control) may determine
		-- what level of security it considers appropriate for "secure"
		-- cookies.  The Secure attribute should be considered security
		-- advice from the server to the user agent, indicating that it is in
		-- the session's interest to protect the cookie contents.



feature {NONE} -- Constants

	Cookie_start: STRING = "#C#"
	Cookie_end: STRING = "#CE#"

	Key_eq: STRING = "="
	Key_sq: STRING = ";"
	Key_max_age: STRING = "Max-Age="
	Key_path: STRING = "Path="
	Key_version: STRING = "Version="
	Key_domain: STRING = "Domain="
	Key_secure: STRING = "Secure"
	Key_comment: STRING = "comment="

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

	set_max_age (a_max_age: NATURAL)
			-- Setter.
		do
			max_age := a_max_age
		ensure
			max_age_set: max_age = a_max_age
		end

	set_name (a_name: STRING)
			-- Setter.
		require
			a_name_not_empty: not a_name.is_empty
		do
			name := escape_bad_chars (a_name)
		ensure
			name_set: name = a_name
		end

	set_value (a_value: STRING)
			-- Setter.
		require
			a_value_not_empty: not a_value.is_empty
		do
			value := escape_bad_chars (a_value)
		ensure
			value_set: value = a_value
		end

	set_path (a_path : STRING)
			-- Setter.
		do
			path  := escape_bad_chars (a_path)
		ensure
			path_set: path  = a_path
		end

	set_comment (a_comment : STRING)
			-- Setter.
		do
			comment  := escape_bad_chars (a_comment)
		ensure
			comment_set: comment  = a_comment
		end

	set_domain (a_domain : STRING)
			-- Setter.
		do
			domain  := escape_bad_chars (a_domain)
		ensure
			domain_set: domain  = a_domain
		end

	set_secure (a_secure: BOOLEAN)
			-- Setter.	
		do
			is_secure := a_secure
		end

feature -- Basic operations


	render_to_string: STRING
			-- Generates the string value for headers_out:
			--	 set-cookie      =       "Set-Cookie:" cookies
			--   cookies         =       1#cookie
			--   cookie          =       NAME "=" VALUE *(";" cookie-av)
			--   NAME            =       attr
			--   VALUE           =       value
			--   cookie-av       =       "Comment" "=" value
			--                   |       "Domain" "=" value
			--                   |       "Max-Age" "=" value
			--                   |       "Path" "=" value
			--                   |       "Secure"
			--                   |       "Version" "=" 1*DIGIT
		do
				-- Name and Value are required
			Result := Cookie_start + name + Key_eq + value
				-- Comment is optional
			if not comment.is_empty then
				Result := Result + Key_sq + Key_comment + comment
			end
				-- Domain is optional
			if not domain.is_empty then
				Result := Result + Key_sq + Key_domain + domain
			end
				-- Max-age is optional
			if max_age >= 0 then
		 		Result := Result + Key_sq + Key_max_age + max_age.out
		 	end
				-- Path is optional
			if not path.is_empty then
				Result := Result +Key_sq + Key_path + path
			end
				-- Secure is optional
			if is_secure then
				Result := Result + Key_sq + Key_secure
			end
				-- Version is required
			Result := Result + Key_sq + Key_version + version + Cookie_end
		ensure
			Result_not_empty: not Result.is_empty
		end


feature {NONE} -- Implementation

	escape_bad_chars (a_s: STRING): STRING
			-- Check for bad characters
		do
			--TODO: complete, better mechanism
			Result := a_s.twin

			Result.replace_substring_all ("=", "#eq#")
			Result.replace_substring_all (";", "#sq#")
			Result.replace_substring_all (Cookie_end, "tue nid ae froemde ids fuedli boeggele!")
		end


	default_max_age: NATURAL
			-- Generates a default max age of 5min
		do
			Result := 300;
		end

end
