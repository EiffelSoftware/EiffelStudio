note
	description: "[
		An exception to represent an unavailable dynamic API function or variable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_API_UNAVAILABLE_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			tag
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
			-- Initializes a API unavailable exception with an API function or variable name.
			--
			-- `a_name': An API function or variable name.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_str: STRING_32
		do
			create api_feature_name.make_from_string (a_name)

			create l_str.make (40)
			l_str.append_string_general ("The API function or variable `")
			l_str.append_string_general (api_feature_name)
			l_str.append_string_general ("' is not available.")
			set_description (l_str)
		ensure
			api_feature_name_set: api_feature_name.same_string (a_name)
		end

feature -- Access

	api_feature_name: IMMUTABLE_STRING_8
			-- The API feature name.

	tag: IMMUTABLE_STRING_32
			-- <Precursor>
		do
			create Result.make_from_string_8 ("API Missing in dynamic library.")
		ensure then
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

invariant
	api_feature_name_attached: attached api_feature_name
	not_api_feature_name: not api_feature_name.is_empty
	description_attached: attached description as l_desc
	not_description_is_empty: not l_desc.is_empty

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
