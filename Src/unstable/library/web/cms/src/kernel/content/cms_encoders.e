note
	description: "Summary description for {CMS_ENCODERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ENCODERS

feature -- Encoders

	url_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		local
			enc: URL_ENCODER
		do
			create enc
			if s /= Void then
				Result := enc.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		local
			enc: HTML_ENCODER
		do
			create enc
			if s /= Void then
				Result := enc.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end
end
