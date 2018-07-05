note
	description: "A provider of data required to add an explicit manifest array type to a manifest array."

class
	CA_MANIFEST_ARRAY_TYPE_PROVIDER

inherit
	FIX_PROVIDER_FOR_MANIFEST_ARRAY_TYPE

create
	make

feature {NONE} -- Creation

	make (c: like source_class; f: like source_feature; t: like type_to_add; a: like array)
			-- Initialize an object with the source class `c`, source feature `f`, manifest array type to be added `t`, array node `a`.
		do
			source_class := c
			source_feature := f
			type_to_add := t
			array := a
		ensure
			source_class_set: source_class = c
			source_feature_set: source_feature = f
			type_to_add_set: type_to_add = t
			array_set: array = a
		end

feature -- Access

	source_class: CLASS_I
			-- <Precursor>

	source_feature: E_FEATURE
			-- <Precursor>

	type_to_add: GEN_TYPE_A
			-- <Precursor>

	array: ARRAY_AS
			-- <Precursor>

;note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 2018, Eiffel Software"
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
