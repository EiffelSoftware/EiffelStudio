note
	description: "Summary description for {XEB_CALL_TAG}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"
	xeb_tag: "call"
	xeb_argument: "feature: BOOLEAN"

class
	XEB_CALL_TAG

inherit
	TAG_SERIALIZER
		redefine
			generate
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			feature_name := "####wrong_feature####"
		end

feature -- Access

	feature_name: STRING
			-- The name of the feature to call

feature -- Implementation

	generate (a_feature: FEATURE_ELEMENT)
			-- <Precursor>
		do
			a_feature.append_expression ("controller." + feature_name)
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal ("feature") then
				feature_name := a_attribute
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
