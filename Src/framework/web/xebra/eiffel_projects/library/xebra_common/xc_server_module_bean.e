note
	description: "[
		Data container for sending XC_SERVER_MODULES over sockets.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_SERVER_MODULE_BEAN

inherit
	XC_SERVER_MODULE
		rename
			make as make_with_name
		end

create
	make,
	make_from_module

feature {NONE} -- Initialization

	make
			-- Initializes current
		do
			is_launched := False
			is_running := False
			name := ""
		end

	make_from_module (a_module: XC_SERVER_MODULE)
			-- Initializes current
		require
			a_module_attached: a_module /= Void
		do
			is_launched := a_module.is_launched
			is_running := a_module.is_running
			name := a_module.name
		end

feature -- Status setting

	shutdown
			-- <Precursor>.
		do
		end

	launch
			-- <Precursor>.
		do
		end

	join
			-- <Precursor>.
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

