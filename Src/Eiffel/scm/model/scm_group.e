note
	description: "Summary description for {SCM_GROUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_GROUP

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; a_location: PATH; a_root: SCM_LOCATION)
		do
			is_included := True
			name := a_name
			location := a_location
			root := a_root
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	location: PATH

	root: SCM_LOCATION

	is_included: BOOLEAN

	unversioned_files_included: BOOLEAN

	is_parent_of (g: SCM_GROUP): BOOLEAN
		local
			n, gn: READABLE_STRING_32
		do
			n := location.name
			gn := g.location.name
			Result := gn.count > n.count and then gn.starts_with (n)
		end


feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name + " %"" + location.name + "%""
		end

feature -- Element change

	toggle_include
		do
			if is_included then
				exclude
			else
				include
			end
		end

	include
		do
			is_included := True
		end

	exclude
		do
			is_included := False
		end

	include_unversioned_files (b: BOOLEAN)
		do
			unversioned_files_included := b
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
