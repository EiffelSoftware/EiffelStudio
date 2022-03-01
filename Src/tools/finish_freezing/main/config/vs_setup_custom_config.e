note
	description: "[
		Locator for C/C++ compiler for Visual Studio 2015, 2017, 2019, 2022.
		
		VS 2017 changed their install process and now we have to use a COM interface to locate VS 2017, and later versions.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	VS_SETUP_CUSTOM_CONFIG

inherit
	VS_SETUP_CONFIG
		rename
			make as mscl_make
		end

create
	make

feature {NONE} -- Initalization

	make (a_use_32bit: like use_32bit; a_code: like code; a_desc: like description; a_version: like version; a_vs_version: like vs_version)
			-- <Precursor>
			-- And for VisualStudio version `a_vs_version`.
		do
			vs_version := a_vs_version
			mscl_make (a_use_32bit, a_code, a_desc, a_version)
		end

feature -- Access

	vs_version: INTEGER
			-- Internal version of Visual Studio

invariant
	vs_version_set: vs_version > 0

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
