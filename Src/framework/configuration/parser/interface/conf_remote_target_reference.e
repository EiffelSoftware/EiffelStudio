note
	description: "Summary description for {CONF_REMOTE_TARGET_REFERENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_REMOTE_TARGET_REFERENCE

inherit
	CONF_TARGET_REFERENCE

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location)
		do
			location := a_location
			name := a_name
				-- By default, remote parent targets are editable, as other local parent targets.!
			is_readonly := False
		end

feature -- Access

	name: detachable READABLE_STRING_32
			-- target name.

	location: READABLE_STRING_32
			-- location of remote target.

	is_readonly: BOOLEAN
			-- Parent target is readonly?
			-- For now, this can not be changed.

feature -- Status report

	has_name: BOOLEAN
		do
			Result := name /= Void
		end

	has_location: BOOLEAN = True

	is_remote: BOOLEAN = True

feature -- Error report

	associated_error: detachable CONF_ERROR

	set_associated_error (e: like associated_error)
		do
			associated_error := e
		end

feature -- Element change

	set_name (a_name: like name)
		do
			name := a_name
		end

	set_location (a_loc: like location)
		require
			a_loc_attached: a_loc /= Void and then not a_loc.is_whitespace
		do
			location := a_loc
		ensure
			location_set: location = a_loc
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
