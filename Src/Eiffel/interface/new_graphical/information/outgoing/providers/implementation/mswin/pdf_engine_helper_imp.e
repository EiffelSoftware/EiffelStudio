note
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_ENGINE_HELPER_IMP

inherit

	PDF_ENGINE_HELPER

feature -- Access

	acrobat_version_from_settings: detachable STRING_32
			-- Programmatically determine whether Reader or Acrobat is installed and return the path to it, if any.
		local
			l_reg: WEL_REGISTRY
			l_key: detachable WEL_REGISTRY_KEY_VALUE
			l_acrobat: STRING_32
			l_acrobat_reader: STRING_32
		do
			l_acrobat := {STRING_32} "\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Acrobat.exe"
			create l_reg
				-- Lookup Acrobat installation
			l_key := l_reg.open_key_value (l_acrobat, "Path")
			if l_key /= Void then
				create Result.make_from_string (l_key.string_value)
				Result.append ("Acrobat ")
			else
					-- Lookup Acrobat Reader.
				l_acrobat_reader := {STRING_32} "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AcroRd32.exe"
				l_key := l_reg.open_key_value (l_acrobat_reader, "Path")
				if l_key /= Void then
					create Result.make_from_string (l_key.string_value)
					Result.append ("AcroRd32 ")
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
