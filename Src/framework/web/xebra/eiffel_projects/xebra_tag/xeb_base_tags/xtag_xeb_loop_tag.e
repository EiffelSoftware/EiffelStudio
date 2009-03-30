note
	description: "Summary description for {XEB_LOOP_TAG}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_LOOP_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generate
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			times := "0"
		end

feature {NONE} -- Access

	times: STRING
			-- Number of repetitions of the body

feature {NONE} -- Implementation

	generate (a_feature: XEL_FEATURE_ELEMENT)
			-- <Precursor>
		do
			a_feature.append_local ("i", "NATURAL")
			a_feature.append_expression ("from")
			a_feature.append_expression ("i := 1")
			a_feature.append_expression ("until")
			a_feature.append_expression ("i > controller." + times)
			a_feature.append_expression ("loop")
			generate_children (a_feature)
			a_feature.append_expression ("i := i + 1")
			a_feature.append_expression ("end")
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal ("times") then
				times := a_attribute
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

