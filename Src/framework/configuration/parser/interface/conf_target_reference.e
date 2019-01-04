note
	description: "Summary description for {CONF_TARGET_REFERENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_TARGET_REFERENCE

feature -- Status report

	has_name: BOOLEAN
		deferred
		end

	has_location: BOOLEAN
		deferred
		end

	is_remote: BOOLEAN
		deferred
		end

feature -- Error report

	associated_error: detachable CONF_ERROR
		deferred
		end

	has_error: BOOLEAN
			-- Check reported error, such as file not found,...
		do
			Result := associated_error /= Void
		end

invariant

	location_or_name_set: has_location or has_name

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
