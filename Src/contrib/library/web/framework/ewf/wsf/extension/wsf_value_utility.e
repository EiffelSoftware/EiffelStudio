note
	description: "[
			Collection of utilities routines to factorize code related to WSF_VALUE manipulation.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_VALUE_UTILITY

feature -- Parameter

	item (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Variable value for parameter or variable `a_name'
			-- See `{WSF_REQUEST}.item(s)'
		do
			Result := req.item (a_name)
		end

	string_item (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for any variable of parameter `a_name' if relevant.	
		do
			Result := string_from (item (req, a_name))
		end

	string_array_item (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		do
			if attached {WSF_TABLE} req.item (a_name) as tb then
				Result := tb.as_array_of_string
			else
				Result := string_array_for (req, a_name, agent string_item)
			end
		end

feature -- Query parameter	

	query_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Parameter value for query variable `a_name'	
			--| i.e after the ? character
		do
			Result := req.query_parameter (a_name)
		end

	string_query_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for query parameter `a_name' if relevant.	
		do
			Result := string_from (query_parameter (req, a_name))
		end

	string_array_query_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		do
			if attached {WSF_TABLE} req.query_parameter (a_name) as tb then
				Result := tb.as_array_of_string
			else
				Result := string_array_for (req, a_name, agent string_query_parameter)
			end
		end

	is_integer_query_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is query parameter related to `a_name' an integer value?
		do
			Result := attached string_query_parameter (req, a_name) as s and then s.is_integer
		end

	integer_query_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): INTEGER
			-- Integer value for query parameter  `a_name' if relevant.
		require
			is_integer_query_parameter: is_integer_query_parameter (req, a_name)
		do
			Result := integer_from (query_parameter (req, a_name))
		end

feature -- Path parameter

	path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
		do
			Result := req.path_parameter (a_name)
		end


	string_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for path parameter `a_name' if relevant.	
		do
			Result := string_from (path_parameter (req, a_name))
		end

	string_array_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for path parameter `a_name' if relevant.
		do
			if attached {WSF_TABLE} req.path_parameter (a_name) as tb then
				Result := tb.as_array_of_string
			else
				Result := string_array_for (req, a_name, agent string_path_parameter)
			end
		end

	is_integer_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is path parameter related to `a_name' an integer value?
		do
			Result := attached string_path_parameter (req, a_name) as s and then s.is_integer
		end

	integer_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): INTEGER
			-- Integer value for path parameter  `a_name' if relevant.
		require
			is_integer_path_parameter: is_integer_path_parameter (req, a_name)
		do
			Result := integer_from (path_parameter (req, a_name))
		end

feature -- Convertion

	string_from (a_value: detachable WSF_VALUE): detachable READABLE_STRING_32
			-- String value from `a_value' if relevant.
		do
			if attached {WSF_STRING} a_value as val then
				Result := val.value
			end
		end

	integer_from (a_value: detachable WSF_VALUE): INTEGER
			-- String value from `a_value' if relevant.	
		do
			if attached string_from (a_value) as val then
				if val.is_integer then
					Result := val.to_integer
				end
			end
		end

feature {NONE} -- Implementation		

	string_array_for (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_item_fct: FUNCTION [ANY, TUPLE [WSF_REQUEST, READABLE_STRING_GENERAL], detachable READABLE_STRING_32]): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		local
			i: INTEGER
			n: INTEGER
		do
			from
				i := 1
				n := 1
				create Result.make_filled ("", 1, 5)
			until
				i = 0
			loop
				if attached a_item_fct.item ([req, a_name + "[" + i.out + "]"]) as v then
					Result.force (v, n)
					n := n + 1
					i := i + 1
				else
					i := 0 -- Exit
				end
			end
			Result.keep_head (n - 1)
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
