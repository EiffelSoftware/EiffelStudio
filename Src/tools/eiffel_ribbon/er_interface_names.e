note
	description: "[
					GUI names
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_INTERFACE_NAMES

feature -- Query

	cannot_find_images (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find images...
		do
			Result := {STRING_32} "Cannot find images in " + a_ise_eiffel + "\tools\ribbon\images"
		end

	cannot_find_templates (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find templates...
		do
			Result := {STRING_32} "Cannot find templates in " + a_ise_eiffel + "\tools\ribbon\template"
		end

	cannot_find_ribbon_folders (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find ribbon folders...
		require
			not_void: a_ise_eiffel /= Void
		do
			Result := {STRING_32} "Cannot find EiffelRibbon folders in " + a_ise_eiffel + "\tools\ribbon"
		end

	ise_eiffel_not_defined: STRING_32 = "The $ISE_EIFFEL is not defined"
			-- ISE_EIFFEL not defined

	ok: STRING_32 = "OK"
			-- OK

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
