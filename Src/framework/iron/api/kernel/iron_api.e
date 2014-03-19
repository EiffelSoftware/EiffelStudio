note
	description: "Summary description for {IRON_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_API

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature {NONE} -- Initialization

	make_with_layout (a_layout: like layout; a_urls: like urls)
		do
			urls := a_urls
			layout := a_layout
			initialize
		end

	initialize
		do
		end

feature -- Access

	layout: IRON_LAYOUT

	urls: IRON_URL_BUILDER

feature {NONE} -- Implementation

	file_content (p: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				create Result.make (1_024)
				from
				until
					f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
