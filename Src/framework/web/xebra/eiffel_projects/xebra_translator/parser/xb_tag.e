note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_TAG

create
	make

feature {NONE} -- Initialization

	make
			-- Creates XB_TAG
		do
			create attributes.make
			create subtags.make
			reset
		end

feature -- Access

	name: STRING assign set_name
		-- The name of the tag

	attributes: LINKED_LIST [XB_TAG_ATTRIBUTE]
		--	The attributes of the tag	

	subtags: LINKED_LIST [like current]
		-- Represents the children of this tag

feature -- Measurement

feature -- Element change

	set_name (s: STRING)
			-- Sets the name.
		do
			name := s
		ensure
			name_set: name = s
		end

	put_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Adds a new attribute.
		do
			attributes.put_right (create {XB_TAG_ATTRIBUTE}.make (a_namespace, a_prefix, a_local_part, a_value))
		ensure
			more_attributes: attributes.count > old attributes.count
		end

	put_subtag (v: like current)
			-- Adds a child
		do
			subtags.put_right (v)
		ensure
			more_kids: subtags.count > old subtags.count
		end

feature -- Status report



feature -- Status setting

	reset
			-- Clears all elements
		do
			name := ""
			attributes.wipe_out

		end

feature -- Basic operations

feature {NONE} -- Implementation

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
