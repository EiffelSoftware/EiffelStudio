note
	description: "[
		Contains all the data for a tag meta description.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_TAG_DESCRIPTION

inherit
	XTL_TAG_LIB_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_id, a_class_name: STRING)
		require
			a_id_valid: attached a_id and not a_id.is_empty
			a_class_name_valid: attached a_class_name and not a_class_name.is_empty
		do
			class_name := a_class_name
			id := a_id
			create {HASH_TABLE [XTL_TAG_DESCRIPTION_ATTRIBUTE, STRING]} attributes.make (2)
		ensure
			class_name_attached: attached class_name
			id_attached: attached id
			attributes_attached: attached attributes
		end

feature {XTL_TAG_LIBRARY} -- Access

	attributes: HASH_TABLE [XTL_TAG_DESCRIPTION_ATTRIBUTE, STRING]
			-- A list of all the possible attributes

feature -- Access

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

	put_attribute_description (a_description: XTL_TAG_DESCRIPTION_ATTRIBUTE)
		require
			a_description_attached: attached a_description
		do
			attributes.put (a_description, a_description.id)
		end

	set_attribute (a_id: STRING; a_value: STRING)
			-- <Precursor>
		do
			if a_id.is_equal ("class") then
				class_name := a_value
			end
			if a_id.is_equal ("id") then
				id := a_value
			end
		ensure then
			class_or_id_has_been_set: (a_id.is_empty implies not class_name.is_empty) and
										(class_name.is_empty implies not a_id.is_empty)
		end

	description: STRING
			-- <Precursor>
		do
			Result := "XTL_TAG_DESCRIPTION_ATTRIBUTE with name: " + id
		end

	has_argument (a_name: STRING): BOOLEAN
			-- Does this tag allow the argument `a_name'?
		require
			a_name_is_valid: not a_name.is_empty
		do
			Result := attached attributes [a_name]
		end

feature -- Validation

	valid (a_tag: XP_TAG_ELEMENT): LIST [STRING]
			-- Validates a_tag to be conform to <Current> definition, i.e. if all mandatory attributes are set
			-- Returns a list of errors
		require
			a_tag_attached: attached a_tag
		do
			create {ARRAYED_LIST [STRING]} Result.make (1)
			from
				attributes.start
			until
				attributes.after
			loop
				if attached attributes.item_for_iteration as l_item and then not l_item.optional then
					if not a_tag.has_attribute (attributes.key_for_iteration) then
						Result.extend ("Missing '" + attributes.key_for_iteration + "' attribute for tag '" + a_tag.id + "'.")
					end
				end
				attributes.forth
			end
		ensure
			Result_attached: attached Result
		end

invariant
		class_name_attached: attached class_name
		id_attached: attached id
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
