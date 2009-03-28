note
	description: "[
		Contains all information to generate a cookie in the browser
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_COOKIE

create
	make

feature {NONE} -- Initialization

	make --(a_name: STRING; a_value: STRING)
			-- Initialization for `Current'.
--		require
--			a_name_not_empty: not a_name.is_empty
--			a_value_not_empty: not a_value.is_empty
		do
			-- Initialize to default values
			name := ""
			value := ""
			max_age := default_max_age
			path := "/xebra"
			is_http_only := true
			is_secure := false
			version := "1"
		end

feature -- Access

	name: STRING assign set_name
		-- The name of the cooklie

	value: STRING assign set_value
		-- The value of the cookie

	max_age: NATURAL assign set_max_age
		-- The expiration date of the cookie in unix time	

	version: STRING --assign set_version
		-- The cookie version

	path: STRING assign set_path
		-- The cookie path

--	domain: STRING --assign set_domain
		-- The cookie domain	

	is_http_only: BOOLEAN --assign set_http_only
		-- Sets the httponly atrribute

	is_secure: BOOLEAN --assign set_secure
		-- Sets the secure attribute	

feature {NONE} -- Constants

	Cookie_start: STRING = "#C#"
	Cookie_end: STRING = "#CE#"

	Key_eq: STRING = "="
	Key_sq: STRING = ";"
	Key_max_age: STRING = "Max-Age="
	Key_path: STRING = "path="
	Key_http_only: STRING = "HttpOly"
	Key_version: STRING = "Version="
	Key_domain: STRING = "domain="
	Key_secure: STRING = "secure"

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

	set_max_age (a_max_age: NATURAL)
			-- Setter
		do
			max_age := a_max_age
		ensure
			max_age_set: max_age = a_max_age
		end

	set_name (a_name: STRING)
			-- Setter
		require
			a_name_not_empty: not a_name.is_empty
		do
			name := escape_bad_chars (a_name)
		ensure
			name_set: name = a_name
		end

	set_value (a_value: STRING)
			-- Setter
		require
			a_value_not_empty: not a_value.is_empty
		do
			value := escape_bad_chars (a_value)
		ensure
			value_set: value = a_value
		end

	set_path (a_path : STRING)
			-- Setter
		require
			a_path_not_empty: not a_path.is_empty
		do
			path  := escape_bad_chars (a_path)
		ensure
			path_set: path  = a_path
		end

feature -- Basic operations

	render_to_string: STRING
			-- Generates the string value for headers_out
		do
			Result := Cookie_start + name + Key_eq + value + Key_sq +
			          Key_max_age + max_age.out + Key_sq +
			          Key_path + path +  Key_sq;

			if is_secure then
				Result := Result + Key_secure + Key_sq
			end

			if is_http_only then
				Result := Result + Key_http_only + Key_sq
			end
				-- No Key_sq at the end
			Result := Result + Key_version + version + Cookie_end
		ensure
			Result_not_empty: not Result.is_empty
		end

feature -- Constants



feature {NONE} -- Implementation

	escape_bad_chars (a_s: STRING): STRING
			-- Check for bad characters
		do
			--TODO: complete, better mechanism
			Result := a_s

			Result.replace_substring_all ("=", "#eq#")
			Result.replace_substring_all (";", "#sq#")
			Result.replace_substring_all (Cookie_end, "tue nid ae froemde ids fuedli boeggele!")


		end


	default_max_age: NATURAL
			-- Generates a default max ages of 5min
		local
			l_t: TIME
		do
			create l_t.make_now

			Result := 1238173200
		end

end
