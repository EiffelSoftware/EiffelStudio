note
	description: "List of parameters for OAuth."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_PARAMETER_LIST

inherit
	ANY

	OAUTH_SHARED_ENCODER

create
	make, make_with_parameters

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Make Current with a capacity of `n'.
		do
			create {ARRAYED_LIST [OAUTH_PARAMETER]} parameters.make (n)
		end

	make_with_parameters (a_params: like parameters)
		do
			parameters := a_params
		end

feature {OAUTH_PARAMETER_LIST}

	parameters: LIST [OAUTH_PARAMETER]

feature -- Add: parameter

	add_parameter (key: READABLE_STRING_8; value: READABLE_STRING_8)
		local
			l_param: OAUTH_PARAMETER
		do
			create l_param.make (key, value)
			parameters.force (l_param)
		ensure
			one_more_element: old parameters.count + 1 = parameters.count
		end

	add_all (a_params : OAUTH_PARAMETER_LIST)
			-- Add all parameters from `a_params' to `Current'
		do
			across
				a_params.parameters as ic
			loop
				parameters.force (ic.item)
			end
		ensure
			-- Added_parameters: old parameters + a_params.parameters = parameters
		end

feature -- Access

	query_string_separator: CHARACTER = '?'

	param_separator: CHARACTER = '&'

	pair_separator: CHARACTER = '='

	empty_string: STRING = ""

feature -- Conversion

	append_to_url (a_url: STRING_8)
		local
			l_query_string: READABLE_STRING_8
		do
			l_query_string := as_form_url_encoded_string
			if l_query_string.same_string (empty_string) then
					-- Done
			else
				if a_url.has (query_string_separator) then
					a_url.append_character (param_separator)
				else
					a_url.append_character (query_string_separator)
				end
				a_url.append (l_query_string)
			end
		end

	as_form_url_encoded_string: STRING_8
		local
			l_builder: STRING
		do
			if parameters.is_empty then
				Result := empty_string
			else
				create l_builder.make_empty
				across
					parameters as ic
				loop
					l_builder.append_character (param_separator)
					l_builder.append (ic.item.as_url_encoded)
				end
				l_builder.remove (1)
				Result := l_builder
			end
		end

	as_oauth_base_string: STRING_8
		do
			Result := oauth_encoder.encoded_string (as_form_url_encoded_string)
		end

feature -- Change Elements

	add_query_string (query_string: READABLE_STRING_8)
		require
			not_empty: not query_string.is_empty
		local
			l_pair: LIST [READABLE_STRING_8]
			l_key: READABLE_STRING_8
			l_value: READABLE_STRING_8
			l_oauth_encoder: OAUTH_ENCODER
		do
			l_oauth_encoder := oauth_encoder
			across
				query_string.split (param_separator) as ic
			loop
				l_pair := ic.item.split (param_separator)
				l_key := l_oauth_encoder.encoded_string (l_pair [1])
				if l_pair.count > 1 then
					l_value := l_oauth_encoder.encoded_string (l_pair [2])
				else
					l_value := empty_string
				end
				parameters.force (create {OAUTH_PARAMETER}.make (l_key, l_value))
			end
		end

feature -- Status Report

	has (a_param: OAUTH_PARAMETER): BOOLEAN
		do
			parameters.compare_objects
			Result := parameters.has (a_param)
		end

	count: INTEGER_32
		do
			Result := parameters.count
		end

feature -- Sort

	sort: OAUTH_PARAMETER_LIST
		local
			l_parameters: like parameters
			l_sort: QUICK_SORTER [OAUTH_PARAMETER]
			l_comp: COMPARABLE_COMPARATOR [OAUTH_PARAMETER]
		do
			l_parameters := parameters.twin
			create l_comp
			create l_sort.make (l_comp)
			l_sort.sort (l_parameters)
			create Result.make_with_parameters (l_parameters)
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
