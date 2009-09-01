note
	description: "[
		Replaces {XP_REGION_TAG_ELEMENT} of a template by the implementation stored in `regions'.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_REGION_TAG_ELEMENT_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make

feature -- Initialization

	make (a_regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING])
			-- `regions': Mapping between region name and tag tree
		require
			a_regions_attached:
		do
			regions := a_regions
		ensure
			regions_attached: attached regions
			regions_set: regions = a_regions
		end

feature -- Access

	regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
			-- Regions of a template

feature -- Access

	visit_tag_element (a_tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_include_tag_element (a_tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_region_tag_element (a_tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			if attached a_tag.retrieve_value ("id") as l_region_id then
				if attached regions [l_region_id.value] as l_region then
					a_tag.set_region (l_region)
					regions.remove (l_region_id.value)
				end
			end
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
