note
	description: "Summary description for {TAG_LIBRARY}."
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
		end

feature {NONE} -- Access

	tags: HASH_TABLE [XTL_TAG_DESCRIPTION, STRING]
			-- All the tags defined in th is tag library

feature -- Access

	id: STRING
			-- Namespace of this tag library

	put (a_child: XTL_TAG_LIB_ITEM)
			-- <Precursor>
		do
			if attached {XTL_TAG_DESCRIPTION} a_child as child then
				tags.put (child, child.name)
			end
		ensure then
			child_has_been_added: tags.count = old tags.count + 1
		end

	set_attribute (a_id: STRING; value: STRING)
			-- <Precursor>
		do
			if a_id.is_equal ("id") then
				id := value
			end
		end

feature -- Query

	get_class_for_name (a_name: STRING): STRING
			-- Searches for the class corresponding to
			-- the tag name. If no class is found
			-- the empty string is returned
		require
			a_name_is_not_empty: not a_name.is_empty
		do
			Result := ""
			if attached tags [a_name] as tag then
				Result := tag.class_name
			end
		end

	argument_belongs_to_tag (a_attribute, a_tag: STRING) : BOOLEAN
			-- Verifies that `a_attribute' belongs to `a_tag'
		do
			if attached tags [a_tag] as tag then
				Result := a_attribute.is_equal ("render") or tag.has_argument (a_attribute)
			end
		end

	contains (tag_id: STRING): BOOLEAN
			-- checks, if the tag is available in the tag library
		do
			Result := attached tags [tag_id]
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
