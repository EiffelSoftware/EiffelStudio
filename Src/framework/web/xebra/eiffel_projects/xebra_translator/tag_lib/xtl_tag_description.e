note
	description: "[
		Contains all the data for a tag meta description.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_TAG_DESCRIPTION

inherit
	XTL_TAG_LIB_ITEM

create
	make

feature {NONE} -- Initialization

	make
		do
			class_name := ""
			name := ""
			create {HASH_TABLE [XTL_TAG_DESCRIPTION_ATTRIBUTE, STRING]} attributes.make (2)
		ensure
			class_name_attached: attached class_name
			name_attached: attached name
			attributes_attached: attached attributes
		end

feature {NONE} -- Access

	attributes: HASH_TABLE [XTL_TAG_DESCRIPTION_ATTRIBUTE, STRING]
			-- A list of all the possible attributes

feature -- Access

	name: STRING
			-- The name of the tag

	class_name: STRING
			-- The name of the associated class

	put (a_child: XTL_TAG_LIB_ITEM)
			-- <Precursor>
		do
			if attached {XTL_TAG_DESCRIPTION_ATTRIBUTE} a_child as child then
				attributes.put (child, child.id)
			end
		ensure then
			child_has_been_added: attributes.count = old attributes.count + 1
		end

	set_attribute (id: STRING; value: STRING)
			-- <Precursor>
		do
			if id.is_equal ("class") then
				class_name := value
			end
			if id.is_equal ("id") then
				name := value
			end
		ensure then
			class_or_id_has_been_set: (id.is_empty implies not class_name.is_empty) and
										(class_name.is_empty implies not id.is_empty)
		end

	has_argument (a_name: STRING): BOOLEAN
			-- Does this tag allow the argument `a_name'?
		require
			a_name_is_valid: not a_name.is_empty
		do
			Result := attached attributes [a_name]
		end

invariant
		class_name_attached: attached class_name
		name_attached: attached name
		attributes_attached: attached attributes

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
