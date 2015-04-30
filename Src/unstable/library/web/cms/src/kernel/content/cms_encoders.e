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

	url_encoded,
	percent_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded with percent encoding, mainly used for url.
		do
			Result := percent_encoder.percent_encoded_string (a_string)
		end

end
