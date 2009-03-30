note
	description: "Summary description for {TAG_DESCRIPTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_TAG_DESCRIPTION

inherit
	XTL_TAG_LIB_ITEM

create
	make

feature

	make
		do
			class_name := ""
			name := ""
			create {ARRAYED_LIST [XTL_TAG_DESCRIPTION_ATTRIBUTE]} attributes.make (10)
		end

feature {NONE} -- Access

	attributes: LIST [XTL_TAG_DESCRIPTION_ATTRIBUTE]
			-- A list of all the possible attributes

feature -- Access

	name: STRING
			-- The name of the tag

	class_name: STRING
			-- The name of the associated class

	put (a_child: XTL_TAG_LIB_ITEM)
			-- <Precursor>
		local
			child: detachable XTL_TAG_DESCRIPTION_ATTRIBUTE
		do
			child ?= a_child
			if attached child then
				attributes.extend (child)
			end
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
		end

	is_call_feature (a_name: STRING): BOOLEAN
			-- Is the attribute with the name `a_name' a feature name?
		require
			a_name_is_not_empty: not a_name.is_empty
		do
			Result := False
			from
				attributes.start
			until
				attributes.after
			loop
				if attributes.item.id.is_equal (a_name) then
					Result := attributes.item.call
				end
				attributes.forth
			end
		end

	is_call_with_result_feature (a_name: STRING): BOOLEAN
			-- Is the attribute with the name `a_name' a name of a feature which returns something?
		require
			a_name_is_not_empty: not a_name.is_empty
		do
			Result := False
			from
				attributes.start
			until
				attributes.after
			loop
				if attributes.item.id.is_equal (a_name) then
					Result := attributes.item.call_with_result
				end
				attributes.forth
			end
		end

	has_argument (a_name: STRING): BOOLEAN
			-- Does this tag allow any arguments?
		require
			a_name_is_not_empty: not a_name.is_empty
		do
			Result := False
			from
				attributes.start
			until
				attributes.after or Result
			loop
				if attributes.item.id.is_equal (a_name) then
					Result := True
				end
				attributes.forth
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
