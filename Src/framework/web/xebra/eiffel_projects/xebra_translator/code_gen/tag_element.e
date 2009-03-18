note
	description: "Summary description for {TAG_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make

feature -- Initialization

	make (a_class_name: STRING)
		do
			class_name := a_class_name
			create {ARRAYED_LIST [TAG_ELEMENT]} children.make (3)
			create {HASH_TABLE [STRING, STRING]} parameters.make (3)
		end

feature -- Access

	class_name: STRING
	parameters: HASH_TABLE [STRING, STRING]
	children: LIST [TAG_ELEMENT]

feature -- Access

	has_children: BOOLEAN
		do
			Result := not children.is_empty
		end

	put_subtag (child: like Current)
		do
			children.extend (child)
		end

	put_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
		do
			parameters.put (a_value, a_local_part)
		end

	serialize (stream: INDENDATION_STREAM)
			-- <Precursor>
		do
			stream.put_string (class_name + ".serialize")
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
