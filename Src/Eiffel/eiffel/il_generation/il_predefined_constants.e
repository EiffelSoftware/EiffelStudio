note
	description: "[
			EiffelSoftware.Runtime assembly information.
			
			See also $EIFFEL_SRC/Eiffel/eiffel/com_il_generation/Core/run-time/runtime_assembly_info.cs
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_CONSTANTS

feature -- Common constants

	eiffel_runtime_netcore_info : TUPLE [major_version, minor_version, build_number, revision_number: NATURAL_16]
		once
			Result := [{NATURAL_16} 23, {NATURAL_16} 6, {NATURAL_16} 10, {NATURAL_16} 7006]
		ensure
			class
		end

	eiffel_runtime_framework_info : TUPLE [major_version, minor_version, build_number, revision_number: NATURAL_16]
		once
			Result := [{NATURAL_16} 7, {NATURAL_16} 3, {NATURAL_16} 9, {NATURAL_16} 2490]
		ensure
			class
		end

	eiffel_runtime_public_key_string: STRING_8 = "def26f296efef469"


invariant

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
