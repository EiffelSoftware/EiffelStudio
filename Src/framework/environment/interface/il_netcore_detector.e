note
	description: "[
			Utility class to help determine if IL runtime version is netcore or .net framework.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_NETCORE_DETECTOR

feature -- Initialization

	is_il_netcore (version: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
				-- TODO: implement a smart netcore detection. [2023-05-19]
			Result := attached version as v and then v.has ('/')
				-- Currently, EiffelStudio internally uses
				--   vx.y.z (such as v4.0.30319) for .net framework
				--   Microsoft.NETCore.App/x.y.z for netcore
				-- So the presence of '/' is a quick hack to detect netcore
		end

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
