note
	description: "[
		Class providing shared access to testing tool preferences.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_PREFERENCES

feature -- Access

	preferences: TEST_PREFERENCES
			-- Testing preferences
		local
			l_result: detachable like preferences
		do
			l_result := preferences_cell.item
			if l_result = Void then
				l_result := create_preferences
				preferences_cell.put (l_result)
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	preferences_cell: CELL [detachable TEST_PREFERENCES]
			-- Once cell for `preferences'
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Factory

	create_preferences: like preferences
			-- Create testing preferences instance
		local
			l_shared: EB_SHARED_PREFERENCES
		do
			create l_shared
			create Result.make (l_shared.preferences.preferences)
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
