indexing
	description: "Objects that ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TAG_VIEW

inherit
	ES_EIS_COMPONENT_VIEW [!STRING_32]
		rename
			component as tag
		end

create
	make

feature {NONE} -- Initialization

	make (a_tag: !STRING_32; a_eis_grid: !ES_EIS_ENTRY_GRID) is
			-- Initialized with `a_conf_notable' and `a_eis_grid'.
		require
			a_eis_grid_not_destroyed: not a_eis_grid.is_destroyed
		do
			tag := a_tag
			eis_grid := a_eis_grid
		end

feature {NONE} -- Implementation

	new_extractor: !ES_EIS_EXTRACTOR is
			-- Create extractor
		do
			create {ES_EIS_TAG_EXTRACTOR}Result.make (tag)
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
