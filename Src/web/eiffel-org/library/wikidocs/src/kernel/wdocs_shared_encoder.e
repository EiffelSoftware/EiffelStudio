note
	description: "[
			Objects to access the shared encoding facilities.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_SHARED_ENCODER

inherit
	SHARED_HTML_ENCODER

feature -- Helpers		

	wiki_name_to_url_encoded_string (wn: READABLE_STRING_GENERAL): STRING
			-- Wiki name converted to path parameter string.
		local
			enc: like percent_encoder
		do
			enc := percent_encoder
			Result := enc.percent_encoded_string (wn)
--				-- Note: percent encoded twice to avoid issue with '/' or %2F for apache.
--			Result := enc.percent_encoded_string (Result)
		end

	url_encoded_string_to_wiki_name (s: READABLE_STRING_GENERAL): STRING
			-- Path parameter string converted to wiki name.
		local
			enc: like percent_encoder
		do
			enc := percent_encoder
			Result := enc.percent_decoded_string (s)
--				-- Note: percent decoded twice , see `wiki_name_to_url_encoded_string'.
--			Result := enc.percent_decoded_string (Result)
		end

feature -- Encoder

	percent_encoder: PERCENT_ENCODER
			-- Shared Percent encoding engine.
		once
			create Result
		end

end
