note
	description: "URI Launcher using the preference `internet_browser_preference`."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_URI_LAUNCHER

inherit
	EB_SHARED_PREFERENCES

feature	-- Execution

	launch (a_uri: READABLE_STRING_GENERAL): BOOLEAN
		do
			if
				attached {STRING_32_PREFERENCE} preferences.misc_data.internet_browser_preference as pref and then
				attached pref.value as l_default_browser and then
				not l_default_browser.is_empty
			then
				Result := (create {URI_LAUNCHER}).launch_with_default_app (a_uri, l_default_browser)
			else
				Result := (create {URI_LAUNCHER}).launch (a_uri)
					-- This check is here because it lets us know if the preference wasn't initialized.
				check internet_browser_preference_set: False end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
