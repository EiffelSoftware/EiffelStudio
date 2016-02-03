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

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
