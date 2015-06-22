note
	description: " Default implementation of BASE_STRING_EXTRACTOR. Conforms to OAuth 1.0a"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_EXTRACTOR_10

inherit
	BASE_STRING_EXTRACTOR

	OAUTH_SHARED_ENCODER

feature -- Extractor

	extract (a_request: OAUTH_REQUEST): STRING_8
			-- Extract an url-encoded base string from the `a_request'
		require else
			has_oauth_parameters: not a_request.oauth_parameters.is_empty
		local
			l_verb: STRING
			l_url: STRING
			l_params: STRING
		do
			l_verb := oauth_encoded_string (a_request.verb)
			l_url := oauth_encoded_string (a_request.sanitized_url)
			l_params := sorted_and_encoded_params (a_request)
			create Result.make_from_string (Ampersand_separated_string)
			Result.replace_substring_all ("$VERB", l_verb)
			Result.replace_substring_all ("$URL", l_url)
			Result.replace_substring_all ("$PARAM", l_params)
		end

feature {NONE} -- Implementation

	sorted_and_encoded_params (a_request: OAUTH_REQUEST): STRING
		local
			l_params: OAUTH_PARAMETER_LIST
		do
			create l_params.make (6)
			l_params.add_all (a_request.query_string_parameters)
			l_params.add_all (a_request.body_parameters)
			l_params.add_all (build_oauth_parameters(a_request))
			Result := l_params.sort.as_oauth_base_string
		end

feature {NONE}-- Implementation

	 Ampersand_separated_string: STRING = "$VERB&$URL&$PARAM";

	 build_oauth_parameters (a_request: OAUTH_REQUEST): OAUTH_PARAMETER_LIST
	 	do
	 		create Result.make (a_request.oauth_parameters.count)
	 		across
	 			a_request.oauth_parameters as ic
	 		loop
	 			Result.add_parameter (ic.key, ic.item)
	 		end
	 	end
note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
