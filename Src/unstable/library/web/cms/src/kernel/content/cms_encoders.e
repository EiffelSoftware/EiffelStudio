note
	description: "Summary description for {CMS_ENCODERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ENCODERS

inherit
	ANY

	SHARED_HTML_ENCODER
		export
			{NONE} all
		end

	SHARED_WSF_PERCENT_ENCODER
		export
			{NONE} all
		end

feature -- Encoders

	utf_8_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded using UTF-8.
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (a_string)
		end

	html_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded for html output.
		do
			Result := html_encoder.general_encoded_string (a_string)
		end

	safe_html_encoded (a_string: detachable READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded for html output or empty string.
		do
			if a_string /= Void then
				Result := html_encoded (a_string)
			else
				Result := ""
			end
		end

	url_encoded,
	percent_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded with percent encoding, mainly used for url.
		do
			Result := percent_encoder.percent_encoded_string (a_string)
		end

feature -- Helpers / security vulnerabilities

	secured_html_content (a_html_content: READABLE_STRING_8): STRING_8
			-- `a_html_content` cleaned from XSS vulnerabilities.
		do
			create Result.make_from_string (a_html_content)
			secure_text (Result)
		end

	secured_url_content (a_url_content: READABLE_STRING_8): READABLE_STRING_8
			-- `a_url_content` cleaned from XSS vulnerabilities.
		local
			s: STRING_8
		do
			if a_url_content.is_empty then
				Result := a_url_content
			elseif
				a_url_content.starts_with_general ("javascript") and then
				a_url_content.count >= 14 and then (
					a_url_content [11] = ':'
				  	or (a_url_content [11] = '%%' and then a_url_content [12] = '3')
				)
			then
				Result := ""
			elseif
				a_url_content.has ('%"')
				or a_url_content.has ('<') or a_url_content.has ('>')
				or a_url_content.has ('{') or a_url_content.has ('}')
				or a_url_content.has ('|') or a_url_content.has ('\')
				or a_url_content.has ('^') or a_url_content.has ('`')
			then
					-- Unsafe character should should be encoded in URL!
					-- TODO: either consider that as unsecured, or maybe
					--	     encode those unsafe character when found in url.
					--		 but this could propagate the vulnerability to unsecure code.
					--		 so for now, it is better to be strict.
				Result := ""
			else
				create s.make_from_string (a_url_content)
				secure_text (s)
				Result := s
			end
		end

	secure_text (a_text: STRING_GENERAL)
			-- Clean `a_text` from XSS vulnerabilities.
		do
			(create {SECURITY_HTML_CONTENT_FILTER}).filter (a_text)
		end

feature -- Helper conversions to and from string		

	date_time_to_string (dt: DATE_TIME): STRING_8
			-- Date time `dt` converted to standard output (using RFC1123)
		local
			hd: HTTP_DATE
		do
			create hd.make_from_date_time (dt)
			Result := hd.rfc1123_string
		end

	date_time_to_iso8601_string (dt: DATE_TIME): STRING_8
			-- Date time `dt` converted to standard output (using RFC3339 a profile of ISO8601)
		local
			hd: HTTP_DATE
		do
			create hd.make_from_date_time (dt)
			Result := hd.iso8601_string
		ensure
			instance_free: class
		end

	date_time_to_timestamp_string (dt: DATE_TIME): STRING_8
			-- Date time `dt` converted to standard output (using RFC3339)
		local
			hd: HTTP_DATE
		do
			create hd.make_from_date_time (dt)
			Result := hd.rfc3339_string
		end

	date_time_from_string (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			-- Date time from string `s`, if valid.
		local
			hd: HTTP_DATE
		do
			create hd.make_from_string (s)
			check not hd.has_error end
			if not hd.has_error then
				Result := hd.date_time
			end
		end

	date_time_from_iso8601_string (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			-- Date time from RFC3339 (a profile of ISO 8601) string `s`, if valid.
		local
			hd: HTTP_DATE
		do
			create hd.make_from_rfc3339_string (s)
			check not hd.has_error end
			if not hd.has_error then
				Result := hd.date_time
			end
		end

	list_to_csv_string (a_strings: ITERABLE [READABLE_STRING_GENERAL]): STRING_32
			-- `a_strings` as comma separated value string.
		local
			s: READABLE_STRING_GENERAL
		do
			create Result.make (0)
			across
				a_strings as ic
			loop
				s := ic.item
				if not Result.is_empty then
					Result.append_character (',')
				end
				if s.has (',') then
					Result.append_character ('"')
					Result.append_string_general (s)
					Result.append_character ('"')
				else
					Result.append_string_general (s)
				end
			end
		end

	list_from_csv_string (a_csv: READABLE_STRING_32): LIST [READABLE_STRING_32]
			-- List of Comma-separated-value string items.
		local
			i,j,n: INTEGER
			s: STRING_32
		do
			from
				i := 1
				n := a_csv.count
				create s.make_empty
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (1)
				Result.force (s)
			until
				i > n
			loop
				inspect a_csv [i]
				when ',' then
					create s.make_empty
					Result.force (s)
				when '"' then
					j := a_csv.index_of ('"', i + 1)
					if j > 0 then
						s.append (a_csv.substring (i + 1, j - 1))
						i := j
					else
						s.extend (a_csv [i])
					end
				else
					s.extend (a_csv [i])
				end
				i := i + 1
			end
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
