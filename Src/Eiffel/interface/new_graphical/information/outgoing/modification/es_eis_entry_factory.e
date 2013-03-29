note
	description: "Factory for speical entries"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_ENTRY_FACTORY

feature -- Access

	create_default_entry (a_id: like {EIS_ENTRY}.target_id): EIS_ENTRY
			-- Create default entry
		require
			a_id_not_void: a_id /= Void
		do
			create Result.make (default_name, default_protocol, default_source, Void, a_id, Void)
		end

feature {NONE} -- Access

	default_protocol: STRING_32 = "URI"
	default_name: STRING_32 = "Unnamed"
	default_source: STRING_32 = "http://www.yourwebsite.com"
			-- Default source

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
