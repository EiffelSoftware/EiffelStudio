note
	description: "Descriptor of a dependence of a feature (or class invariant) on a formal generic parameter."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

class
	INSTANCE_DEPENDENCE_ON_FORMAL

inherit
	INSTANCE_DEPENDENCE

create {INSTANCE_DEPENDENCE_GENERATOR}
	make

feature {NONE} -- Creation

	make (t: FORMAL_A; w: CLASS_C; k: like {INSTANCE_DEPENDENCE_GENERATOR}.kind)
			-- Initialize a dependence on type `t` written in class `w` with a kind `k`.
		require
			{INSTANCE_DEPENDENCE_GENERATOR}.is_valid_kind (k)
			w.is_valid_formal_position (t.position)
		do
			position := t.position
			class_id := w.class_id
			kind := k
		ensure
			position = t.position
			class_id = w.class_id
			kind = k
		end

feature {NONE} -- Access

	position: like {FORMAL_A}.position
			-- Position of the formal generic parameter.

	class_id: like {CLASS_C}.class_id
			-- ID of the class where the formal generic is written.

feature -- Status report

	has_removed_class (v: CLASS_ID_VALIDATOR): BOOLEAN
			-- <Precursor>
		do
			Result := not v.is_valid (class_id) or else not v.has (class_id)
		end

feature -- Access

	hash_code: INTEGER_32
			-- <Precursor>
		do
			Result := (31 * (class_id.hash_code + 1) + position).max (0)
		end

feature -- Traversal

	record (r: CLASS_RECORDER)
			-- <Precursor>
		do
			record_formal (position, class_id, r)
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
