note
	description: "Summary description for {ES_IRON_LAYOUT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IRON_LAYOUT

inherit
	IRON_LAYOUT
		redefine
			binaries_path
		end

create
	make

feature {NONE} -- Initialization

	make (e: like eiffel_layout)
			-- Initialize with Eiffel layout `e'
		do
			eiffel_layout := e
			make_with_path (e.iron_path, e.installation_iron_path)
		end

	eiffel_layout: EIFFEL_ENV
			-- Associated Eiffel Layout

feature -- Access		

	binaries_path: detachable PATH
			-- Binaries path if available.
			--| $ISE_EIFFEL/tools/iron/spec/$ISE_PLATFORM/bin
		once
			Result := eiffel_layout.installation_iron_path.extended ("spec").extended (eiffel_layout.eiffel_platform).extended ("bin")
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
