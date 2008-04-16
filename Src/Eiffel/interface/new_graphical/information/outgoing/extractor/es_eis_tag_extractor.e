indexing
	description: "[
			Extractor to fetch EIS entries of a tag. The extractor only read from the storage.
			The actually extracting has been done or being done at background by
			other extractors.
			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TAG_EXTRACTOR

inherit
	ES_EIS_EXTRACTOR

create
	make

feature {NONE} -- Initialization

	make (a_tag: like tag) is
			-- Initialize with `a_tag'.
			-- Empty tag indicates to view entries without tag.
		do
			tag := a_tag
			create eis_entries.make (2)
			extract
		end

feature -- Access

	tag: !STRING_32
			-- The tag to extract

	eis_full_entries: !SEARCH_TABLE [!EIS_ENTRY]
			-- EIS entries including all flat entries from all associated component
		do
			Result := eis_entries
		end

feature {NONE} -- Implementation

	extract is
			-- Perform extracting.
			-- Only read from the storage.
			-- The actually extracting has been done or being done at background by
			-- other extractors.
		do
			if storage.tag_server.entries.has (tag) then
				eis_entries := storage.tag_server.entries.item (tag)
			else
				create eis_entries.make (0)
			end
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
