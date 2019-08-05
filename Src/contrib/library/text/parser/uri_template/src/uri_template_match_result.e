note
	description: "Summary description for {URI_TEMPLATE_MATCH_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	URI_TEMPLATE_MATCH_RESULT

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (p: like path_variables; q: like query_variables)
		do
			path_variables := p
			query_variables := q
		end

	make_empty
		do
			make (create {like path_variables}.make (0), create {like query_variables}.make (0))
		end

feature -- Access

	path_variables: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Variables being part of the path segments

	query_variables: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Variables being part of the query segments (i.e: after the ?)

feature -- Query

	path_variable (n: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Value related to query variable name `n'
		do
			Result := path_variables.item (n)
		end

	query_variable (n: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Value related to path variable name `n'
		do
			Result := query_variables.item (n)
		end

	variable (n: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Value related to variable name `n'
		do
			Result := query_variable (n)
			if Result = Void then
				Result := path_variable (n)
			end
		end

feature -- Query: url-decoded

	encoded_name (n: READABLE_STRING_GENERAL): READABLE_STRING_8
			-- URL encoded name `n' 
			-- to be used with ..._variable functions
		do
			if attached {READABLE_STRING_32} n as n32 then
				Result := url_encoded_string (n32)
			else
				Result := n.to_string_8
			end
		end

	url_decoded_query_variable (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Unencoded value related to variable name `n'
		do
			if attached query_variable (encoded_name (n)) as v then
				Result := url_decoded_string (v)
			end
		end

	url_decoded_path_variable (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Unencoded value related to variable name `n'
		do
			if attached path_variable (encoded_name (n)) as v then
				Result := url_decoded_string (v)
			end
		end

	url_decoded_variable (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Unencoded value related to variable name `n'
		do
			if attached variable (encoded_name (n)) as v then
				Result := url_decoded_string (v)
			end
		end

feature {NONE} -- Implementation

	url_decoded_string (s: READABLE_STRING_8): READABLE_STRING_32
		do
			Result := url_encoder.decoded_string (s)
		end

	url_encoded_string (s: READABLE_STRING_32): READABLE_STRING_8
		do
			Result := url_encoder.encoded_string (s)
		end

	url_encoder: URL_ENCODER
		once
			create Result
		end

;note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

