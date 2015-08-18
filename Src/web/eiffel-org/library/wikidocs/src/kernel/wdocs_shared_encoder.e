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
				-- Note: Url Encoded Slashes (%2F) Problem in Apache
				-- Solution #1
			Result.replace_substring_all ("%%2F", "%%252F") -- '/'
			Result.replace_substring_all ("%%5C", "%%255C") -- '\'
--				-- Solution #2, percent encoded twice.
--			Result := enc.percent_encoded_string (Result)
		end

	url_encoded_string_to_wiki_name (s: READABLE_STRING_GENERAL): STRING_32
			-- Path parameter string converted to wiki name.
		local
			enc: like percent_encoder
		do
			enc := percent_encoder
				-- Note: Url Encoded Slashes (%2F) Problem in Apache
				-- Solution #1
			create Result.make_from_string_general (s)
			Result.replace_substring_all ({STRING_32} "%%252F", {STRING_32} "%%2F") -- '/'
			Result.replace_substring_all ({STRING_32} "%%255C", {STRING_32} "%%5C") -- '\'
			Result := enc.percent_decoded_string (Result)
--				-- Solution #2: percent decoded twice , see `wiki_name_to_url_encoded_string'.
--			Result := enc.percent_decoded_string (Result)
		end

feature -- Encoder

	percent_encoder: PERCENT_ENCODER
			-- Shared Percent encoding engine.
		once
			create Result
		end

end
