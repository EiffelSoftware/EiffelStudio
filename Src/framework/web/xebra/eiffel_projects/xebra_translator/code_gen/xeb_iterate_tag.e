note
	description: "Summary description for {XEB_ITERATE_TAG}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XEB_ITERATE_TAG [G -> LIST_ITEM_I]

inherit
	TAG_SERIALIZER [G]

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			create {CONSTANT_ATTRIBUTE} times.make ("")
		end

feature {NONE} -- Access

	list: TAG_ATTRIBUTE
			-- The items over which we want to iterate
	variable: TAG_ATTRIBUTE
			-- Name of the variable

feature {NONE} -- Implementation

	output (parent: SERVLET buf: INDENDATION_STREAM; variables: LIST [ANY])
			-- <Precursor>
		do
			if attached {LIST [G]} list.value as l_list then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached l_list.item as l_item then
						
					end
					l_list.forth
				end
			end

		end

	put_attribute (id: STRING; a_attribute: TAG_ATTRIBUTE)
			-- <Precursor>
		do
			if id.is_equal ("list") then
				list := a_attribute
			end
			if id.is_equal ("variable") then
				variable := a_attribute
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
