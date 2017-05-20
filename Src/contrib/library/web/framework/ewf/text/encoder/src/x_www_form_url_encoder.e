note
	description: "Summary description for {X_WWW_FORM_URL_ENCODER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	X_WWW_FORM_URL_ENCODER

inherit
	URL_ENCODER
		redefine
			append_percent_encoded_ascii_character_code_to
		end

feature {NONE} -- Implementation: character encoding

	append_percent_encoded_ascii_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- <Precursor>
			-- Note: space is encoded with '+' for x-www-form-urlencoding.
		do
			inspect a_code
			when
				32 -- 32 ' '
			then
				a_result.append_code (43) -- 43 '+'
			when
				33, 39,		-- ! '
				40, 41, 42 -- ( ) *
			then
				a_result.append_code (a_code) -- Keep slash
			else
				Precursor (a_code, a_result)
			end
		end

note
	copyright: "Copyright (c) 2011-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
