note
	description: "Descriptor of a dependence of a feature (or class invariant) on a feature-based anchored type."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

class
	INSTANCE_DEPENDENCE_ON_FEATURE

inherit
	INSTANCE_DEPENDENCE_ON_ANCHOR
		redefine
			debug_output
		end

create {INSTANCE_DEPENDENCE_GENERATOR}
	make

feature {NONE} -- Creation

	make (t: LIKE_FEATURE; w: CLASS_C; k: like {INSTANCE_DEPENDENCE_GENERATOR}.kind)
			-- Initialize a dependence on type `t` written in class `w` with a kind `k`.
		require
			{INSTANCE_DEPENDENCE_GENERATOR}.is_valid_kind (k)
		do
			class_id := w.class_id
			routine_id := t.routine_id
			kind := k
		ensure
			class_id = w.class_id
			routine_id = t.routine_id
			kind = k
		end

feature {INSTANCE_DEPENDENCE_GENERATOR} -- Access

	routine_id: like {ROUT_TABLE}.rout_id
			-- Routine ID of the acnhor

feature -- Access

	hash_code: INTEGER_32
			-- <Precursor>
		do
			Result := (31 * (class_id.hash_code + 1) + routine_id).max (0)
		end

feature {NONE} -- Traversal

	anchor_type (c: CLASS_C): detachable TYPE_A
			-- <Precursor>
		do
			if attached c.feature_of_rout_id (routine_id) as f then
				Result := f.type.conformance_type
			end
		end

feature {NONE} -- Debugging

	debug_output: READABLE_STRING_32
			-- <Precursor>
		do
			Result := {STRING_32} "like " +
				if attached system.class_of_id (class_id) as c then
					c.name.as_string_32 + {STRING_32} "." +
					if attached c.feature_of_rout_id (routine_id) as f then
						f.feature_name_32
					else
						{STRING_32} "(unknown)"
					end
				else
					{STRING_32} "(unknown)"
				end +
				{STRING_32} " " +
				Precursor
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
