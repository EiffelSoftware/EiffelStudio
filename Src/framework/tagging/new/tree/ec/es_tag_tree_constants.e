note
	description: "[
		Constants used to map tokens in a TAG_TREE to a corresponding ES_TAG_TREE_NODE.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAG_TREE_CONSTANTS

feature -- Access

	delimiter_symbol: CHARACTER = ':'
			-- Character used to separate code from actual token

	class_code: NATURAL = 1
	feature_code: NATURAL = 2
	target_code: NATURAL = 3
	library_code: NATURAL = 4
	cluster_code: NATURAL = 5
	override_code: NATURAL = 6
	directory_code: NATURAL = 7
			-- Codes used to prefix tokens in order to indicate what the token represents

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
