note
	description: "[
		Used to render a call to the controller that writes to the xhtml page of the response
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_CALL_ELEMENT

inherit
	OUTPUT_ELEMENT

create
	make

feature -- Access

	feature_name: STRING
			-- Name of the feature that should be called on the controller

feature -- Initialization

	make (a_feature_name: STRING)
			-- `a_feature_name' Name of the feature that should be called on the controller
		require
			feature_name_valid: not a_feature_name.is_empty
		do
			make_empty
			feature_name := a_feature_name
		end

feature -- Processing

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (response_var + ".append (" + controller_var + "." + feature_name + ")")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
