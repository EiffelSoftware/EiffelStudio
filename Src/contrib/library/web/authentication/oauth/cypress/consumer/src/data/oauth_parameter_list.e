note
	description: "Summary description for {OAUTH_PARAMETER_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_PARAMETER_LIST

inherit

	ANY
		redefine
			default_create
		end

create
	default_create, make_with_parameters

feature {NONE} -- Initialization

	default_create
		do
			create {ARRAYED_LIST [OAUTH_PARAMETER]} parameters.make (5)
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
			across a_params.parameters as elem loop parameters.force (elem.item) end
		ensure
			-- Added_parameters: old parameters + a_params.parameters = parameters
		end

feature -- Access

	QUERY_STRING_SEPARATOR: CHARACTER = '?'

	PARAM_SEPARATOR: STRING = "&"

	PAIR_SEPARATOR: STRING = "="

	EMPTY_STRING: STRING = ""

feature --

	append_to (a_url: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		local
			l_query_string: READABLE_STRING_GENERAL
			l_url: STRING
		do
			l_query_string := as_form_url_encoded_string;
			if l_query_string.same_string (empty_string) then
				Result := a_url
			else
				create l_url.make_from_string (a_url.as_string_32)
				if a_url.index_of (query_string_separator, 1) /= 0 then
					l_url.append (param_separator)
				else
					l_url.append_character (query_string_separator)
				end
				l_url.append (l_query_string.as_string_32)
				Result := l_url
			end
		end

	as_form_url_encoded_string: READABLE_STRING_GENERAL
		local
			l_builder: STRING
		do
			if parameters.count = 0 then
				Result := empty_string
			else
				create l_builder.make_empty
				across
					parameters as elem
				loop
					l_builder.append (param_separator)
					l_builder.append (elem.item.as_url_encoded)
				end
				l_builder.remove (1)
				Result := l_builder
			end
		end

	as_oauht_base_string: READABLE_STRING_GENERAL
		do
			Result := (create {OAUTH_ENCODER}).encoded_string (as_form_url_encoded_string.as_string_32)
		end

feature -- Change Elements

	add_query_string (query_string: READABLE_STRING_GENERAL)
		require
			not_empty: not query_string.is_empty
		local
			l_pair: LIST [READABLE_STRING_GENERAL]
			l_key: READABLE_STRING_GENERAL
			l_value: READABLE_STRING_GENERAL
			l_oauth_encoder: OAUTH_ENCODER
		do
			create l_oauth_encoder
			across
				query_string.split (param_separator.at (1)) as elem
			loop
				l_pair := elem.item.split (param_separator.at (1))
				l_key := l_oauth_encoder.encoded_string (l_pair [1].as_string_32)
				if l_pair.count > 1 then
					l_value := l_oauth_encoder.encoded_string (l_pair [2].as_string_32)
				else
					l_value := empty_string
				end
				parameters.force (create {OAUTH_PARAMETER}.make (l_key.as_string_32, l_value.as_string_32))
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
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
