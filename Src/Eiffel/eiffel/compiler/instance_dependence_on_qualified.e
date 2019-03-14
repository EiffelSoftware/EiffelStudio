note
	description: "Descriptor of a dependence of a feature (or class invariant) on a qualified anchored type."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

class
	INSTANCE_DEPENDENCE_ON_QUALIFIED

inherit
	INSTANCE_DEPENDENCE_ON_ANCHOR
		redefine
			debug_output
		end

create {INSTANCE_DEPENDENCE_GENERATOR}
	make

feature {NONE} -- Creation

	make (t: QUALIFIED_ANCHORED_TYPE_A; w: CLASS_C; k: like {INSTANCE_DEPENDENCE_GENERATOR}.kind)
			-- Initialize a dependence on type `t` written in class `w` with a kind `k`.
		require
			{INSTANCE_DEPENDENCE_GENERATOR}.is_valid_kind (k)
		do
			class_id := w.class_id
			type := t
			kind := k
		ensure
			class_id = w.class_id
			type = t
			kind = k
		end

feature {INSTANCE_DEPENDENCE_GENERATOR} -- Access

	type: QUALIFIED_ANCHORED_TYPE_A
			-- Associated type.

feature -- Access

	hash_code: INTEGER_32
			-- <Precursor>
		do
			Result := (31 * (class_id.hash_code + 1) + type.hash_code).max (0)
		end

feature {NONE} -- Traversal

	anchor_type (c: CLASS_C): detachable TYPE_A
			-- <Precursor>
		do
			Result := type.evaluated_type_in_descendant (system.class_of_id (class_id), c, Void).conformance_type
		end

feature {NONE} -- Debugging

	debug_output: READABLE_STRING_32
			-- <Precursor>
		do
			Result := {STRING_32} "like (QAT) " + Precursor
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
