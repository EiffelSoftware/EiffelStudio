note
	description: "[
		Contains all the data to meta describe a tag library
	]"
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_TAG_LIBRARY

inherit
	XTL_TAG_LIB_ITEM

create
	make

feature -- Initialization

	make
		do
			create {HASH_TABLE [XTL_TAG_DESCRIPTION, STRING]} tags.make (10)
			id := ""
		ensure
			tags_attached: tags /= Void
			id_attached: id /= Void
		end

feature {XTL_TAG_LIBRARY} -- Access

	tags: HASH_TABLE [XTL_TAG_DESCRIPTION, STRING]
			-- All the tags defined in th is tag library

feature -- Access

	id: STRING
			-- Namespace of this tag library

	put (a_child: XTL_TAG_LIB_ITEM)
			-- <Precursor>
		require else
			a_child_attached: attached a_child
		do
			if attached {XTL_TAG_DESCRIPTION} a_child as child then
				tags.put (child, child.name)
			end
		ensure then
			child_has_been_added: tags.count = old tags.count + 1
		end

	set_attribute (a_id: STRING; a_value: STRING)
			-- <Precursor>
		require else
			a_value_attached: a_value /= Void
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			if a_id.is_equal ("id") then
				id := a_value
			end
		end

feature -- Query

	get_class_for_name (a_name: STRING): STRING
			-- Searches for the class corresponding to
			-- the tag name. If no class is found
			-- the empty string is returned
		require
			a_name_attached: attached a_name
			a_name_is_not_empty: not a_name.is_empty
		do
			Result := ""
			if attached tags [a_name] as tag then
				Result := tag.class_name
			end
		ensure
			attached_result: attached Result
		end

	argument_belongs_to_tag (a_attribute, a_tag: STRING) : BOOLEAN
			-- Verifies that `a_attribute' belongs to `a_tag'
		require
			a_tag_is_valid: not a_tag.is_empty
		do
			if attached tags [a_tag] as tag then
				Result := a_attribute.is_equal ("render") or tag.has_argument (a_attribute)
			end
		end

	contains (a_tag_id: STRING): BOOLEAN
			-- Checks, if the tag is available in the tag library
		require
			a_tag_id_attached: a_tag_id /= Void
			not_a_tag_id_is_empty: not a_tag_id.is_empty
		do
			Result := attached tags [a_tag_id]
		end

	create_tag (a_prefix, a_local_part, a_class_name, a_debug_information: STRING): XP_TAG_ELEMENT
			-- Creates the appropriate XP_TAG_ELEMENT
		require
			a_prefix_attached: a_prefix /= Void
			a_local_part_attached: a_local_part /= Void
			a_class_name_attached: a_class_name /= Void
			a_debug_information_attached: a_debug_information /= Void
			not_a_debug_information_empty: not a_debug_information.is_empty
		do
			create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
		ensure
			result_attached: attached Result
		end

invariant
	id_attached: attached id

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
