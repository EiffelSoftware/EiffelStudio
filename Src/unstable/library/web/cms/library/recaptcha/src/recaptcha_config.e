note
	description: "Summary description for {RECAPTCHA_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RECAPTCHA_CONFIG

create
	make_with_version,
	make

feature {NONE} -- Initialization

	make_with_version (v: READABLE_STRING_8)
		do
			set_version (v)
		end

	make
		do
			set_version (default_version)
		end

feature -- Access

	version: IMMUTABLE_STRING_8

	secret_key: detachable IMMUTABLE_STRING_8

	site_key: detachable IMMUTABLE_STRING_8

	is_version_2: BOOLEAN
		do
			Result := version.is_case_insensitive_equal_general ("v2")
		end

	is_version_3: BOOLEAN
		do
			Result := version.is_case_insensitive_equal_general ("v3")
		end

feature -- Constants

	recaptcha_base_uri: STRING_8 = "https://www.google.com/recaptcha"
			-- Recaptcha base URI

	default_version: STRING_8 = "v2"

feature -- Element change

	set_version (v: detachable READABLE_STRING_8)
		do
			if v = Void or else v.is_empty then
				version := default_version
			else
				create version.make_from_string (v)
			end
		end

	set_secret_key (k: detachable READABLE_STRING_8)
		do
			if k = Void or else k.is_empty then
				secret_key := Void
			else
				create secret_key.make_from_string (k)
			end
		end

	set_site_key (k: detachable READABLE_STRING_8)
		do
			if k = Void or else k.is_empty then
				site_key := Void
			else
				create site_key.make_from_string (k)
			end
		end

note
	copyright: "2011-2020 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
