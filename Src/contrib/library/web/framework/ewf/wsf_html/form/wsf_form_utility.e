note
	description: "Summary description for {WSF_FORM_UTILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_UTILITY

feature -- Converter

	html_encoded_string (s: READABLE_STRING_GENERAL): READABLE_STRING_8
		do
			Result := html_encoder.general_encoded_string (s)
		end

	html_encoder: HTML_ENCODER
		once
			create Result
		end

end
