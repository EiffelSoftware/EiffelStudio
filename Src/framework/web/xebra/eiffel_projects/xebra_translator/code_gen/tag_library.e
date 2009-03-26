note
	description: "Summary description for {TAG_LIBRARY}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_LIBRARY

inherit
	TAG_LIB_ITEM

create
	make

feature -- Initialization

	make
		do
			create {ARRAYED_LIST [TAG_DESCRIPTION]} tags.make (10)
		end

feature {NONE} -- Access

	id: STRING

	tags: LIST [TAG_DESCRIPTION]

feature -- Access

	put (a_child: TAG_LIB_ITEM)
			-- <Precursor>
		local
			child: TAG_DESCRIPTION
		do
			child ?= a_child
			tags.extend (child)
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
			from
				tags.start
			until
				tags.after
			loop
				if tags.item.name.as_lower.is_equal (a_name.as_lower) then
					Result := tags.item.class_name
				end
				tags.forth
			end
		end

	is_call_feature (a_id, a_name: STRING): BOOLEAN
			-- Searches for the tag with the id `a_id'
			-- and checks if `a_name' is a parameter
			-- which represents a feature name
		do
			Result := False
			from
				tags.start
			until
				tags.after
			loop
				if tags.item.name.as_lower.is_equal (a_id.as_lower) then
					Result := tags.item.is_call_feature (a_name)
				end
				tags.forth
			end
		end

	is_call_with_result_feature (a_id, a_name: STRING): BOOLEAN
			-- Searches for the tag with the id `a_id'
			-- and checks if `a_name' is a parameter
			-- which represents a feature name that returns something
		do
			Result := False
			from
				tags.start
			until
				tags.after
			loop
				if tags.item.name.as_lower.is_equal (a_id.as_lower) then
					Result := tags.item.is_call_with_result_feature (a_name)
				end
				tags.forth
			end
		end

	argument_belongs_to_tag (a_attribute, a_tag: STRING) : BOOLEAN
			-- Verifies that `a_attribute' belongs to `a_tag'
		do
			Result := False
			from
				tags.start
			until
				tags.after
			loop
				if tags.item.name.as_lower.is_equal (a_tag.as_lower) then
					Result := tags.item.has_argument (a_attribute)
				end
				tags.forth
			end
		end

	contains (tag_id: STRING): BOOLEAN
			-- checks, if the tag is available in the tag library
		do
			Result := False
			from
				tags.start
			until
				tags.after
			loop
				if tags.item.name.as_lower.is_equal (tag_id.as_lower) then
					Result := True
				end
				tags.forth
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
