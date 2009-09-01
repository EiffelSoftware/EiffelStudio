note
	description: "[
		Defines tag denoting a page:region
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_REGION_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		redefine
			accept,
			copy_self
		end

create
	make

feature -- Initialization

feature -- Access

	copy_self: XP_TAG_ELEMENT
		do
			create {XP_REGION_TAG_ELEMENT} Result.make (namespace, id, class_name, debug_information)
		end


	set_region (a_region: LIST [XP_TAG_ELEMENT])
			-- Defines the implementation of a region
		do
			children := a_region
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_region_tag_element (Current)
			accept_children (visitor)
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
