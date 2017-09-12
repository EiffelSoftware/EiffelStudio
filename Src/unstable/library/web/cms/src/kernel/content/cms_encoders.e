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

	date_time_to_string (dt: DATE_TIME): STRING_8
			-- Date time `dt` converted to standard output (using RFC1123)
		local
			hd: HTTP_DATE
		do
			create hd.make_from_date_time (dt)
			Result := hd.rfc1123_string
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

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
