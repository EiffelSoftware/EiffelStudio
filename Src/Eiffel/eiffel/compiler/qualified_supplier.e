note
	description: "Supplier in a qualified type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QUALIFIED_SUPPLIER

inherit
	HASHABLE

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c: CLASS_C)
			-- Associate supplier with the given feature `f' and class `c'.
		require
			attached_f: attached f
			attached_c: attached c
		do
			set (f, c)
		ensure
			class_id_set: class_id = c.class_id
			feature_name_id_set: feature_name_id = f.feature_name_id
		end

feature -- Access

	class_id: INTEGER_32
			-- ID of the supplier class with feature identified by `feature_name_id'

	feature_name_id: INTEGER_32
			-- ID of the supplier feature from the class identified by `class_id'

	hash_code: INTEGER_32
			-- <Precursor>
		do
			Result := class_id.hash_code.bit_xor (feature_name_id).hash_code
		end

feature -- Modification

	set (f: FEATURE_I; c: CLASS_C)
		require
			attached_f: attached f
			attached_c: attached c
		do
			class_id := c.class_id
			feature_name_id := f.feature_name_id
		ensure
			class_id_set: class_id = c.class_id
			feature_name_id_set: feature_name_id = f.feature_name_id
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
