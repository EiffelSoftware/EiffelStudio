note
	description: "Summary description for {CONF_ERROR_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CONTAINER

inherit
	CONF_ERROR_OBSERVER

feature -- Access

	report_error (e: CONF_ERROR)
			-- Report an error `e`.
		local
			lst: like last_errors
		do
			lst := last_errors
			if lst = Void then
				create {ARRAYED_LIST [CONF_ERROR]} lst.make (1)
				last_errors := lst
			end
			lst.force (e)
		end

	report_warning (e: CONF_ERROR)
			-- Report a warning `e`.
		local
			lst: like last_warnings
		do
			lst := last_warnings
			if lst = Void then
				create {ARRAYED_LIST [CONF_ERROR]} lst.make (1)
				last_warnings := lst
			end
			lst.force (e)
		end

feature -- Access

	last_errors: detachable LIST [CONF_ERROR]

	last_warnings: detachable LIST [CONF_ERROR]

feature -- Status

	has_error: BOOLEAN
		do
			Result := attached last_errors as lst and then not lst.is_empty
		end

	has_warning: BOOLEAN
		do
			Result := attached last_warnings as lst and then not lst.is_empty
		end

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
