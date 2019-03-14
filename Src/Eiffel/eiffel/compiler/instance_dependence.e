note
	description: "Descriptor of a dependence of a feature (or class invariant) on a type."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

deferred class
	INSTANCE_DEPENDENCE

inherit
	DEBUG_OUTPUT
	HASHABLE
	SHARED_WORKBENCH

feature -- Status report

	kind: like {INSTANCE_DEPENDENCE_GENERATOR}.kind
			-- The dependence kind.

	has_removed_class (v: CLASS_ID_VALIDATOR): BOOLEAN
			-- Does the dependence record a removed class ID in `v`?
		deferred
		end

feature -- Traversal

	record (r: CLASS_RECORDER)
			-- Record, in `r`, classes that can be used to instantiate an object or be instances themselves.
		deferred
		end

	record_new_dependence (r: CLASS_RECORDER; d: DEPENDENCE_RECORDER)
			-- Record, in `r`, classes that can be used to instantiate an object or be instances themselves.
			-- Register the dependence in `d` if it has to be re-evaluated when the context changes.
		do
			record (r)
		end

feature {NONE} -- Traversal

	record_class_id (c: like {CLASS_C}.class_id; r: CLASS_RECORDER)
			-- Record class ID `c` in `r` according to the dependency kind `kind`.
		do
			if kind = {INSTANCE_DEPENDENCE_GENERATOR}.call_kind then
					-- TODO: this should be `r.mark_class_reachable (c)`,
					-- but the remover does distinguish between qualified and unqualified calls.
					-- As a result, when an instance-free feature makes an unqualified call, it is considered polymorphic,
					-- and is not marked as reachable if the class is only reachable, but not alive.
				if
					attached workbench.system as s and then
					attached s.class_of_id (c) as compiled_class and then
					not compiled_class.is_deferred
				then
					r.mark_class_alive (c)
				else
					r.mark_class_reachable (c)
				end
			elseif
				kind = {INSTANCE_DEPENDENCE_GENERATOR}.expanded_creation_kind implies
				attached workbench.system as s and then
				attached s.class_of_id (c) as compiled_class and then
				compiled_class.is_used_as_expanded
			then
				r.mark_class_alive (c)
			end
		end

	record_formal (p: like {FORMAL_A}.position; i: like {CLASS_C}.class_id; r: CLASS_RECORDER)
			-- Record, in `r`, classes that can be used to instantiate an object or be instances themselves for a formal generic parameter at position `p` in the class if ID `i`.
		do
			if
				attached workbench.system as s and then
				attached s.class_of_id (i) as c and then
				c.is_valid_formal_position (p)
			then
					-- Look through all class types.
				across
					c.types as t
				loop
					if
						attached t.item.type.generics as gs and then
						attached {CL_TYPE_A} gs [p] as a
					then
						record_class_id (a.class_id, r)
					end
				end
					-- Look through all instantiated types.
				across
					r.derivations (i) as t
				loop
					if
						attached t.item.generics as gs and then
						attached {CL_TYPE_A} gs [p] as a
					then
						record_class_id (a.class_id, r)
					end
				end
				if attached c.filters as ts then
					across
						ts as t
					loop
						if
							t.item.class_id = i and then
							attached t.item.generics as gs and then
							attached {CL_TYPE_A} gs [p] as a
						then
							record_class_id (a.class_id, r)
						end
					end
				end
			end
		end

feature {NONE} -- Debugging

	debug_output: READABLE_STRING_32
			-- <Precursor>
		do
			inspect
				kind
			when {INSTANCE_DEPENDENCE_GENERATOR}.call_kind then
				Result := {STRING_32} "[call]"
			when {INSTANCE_DEPENDENCE_GENERATOR}.expanded_creation_kind then
				Result := {STRING_32} "[expanded creation]"
			when {INSTANCE_DEPENDENCE_GENERATOR}.regular_creation_kind then
				Result := {STRING_32} "[creation]"
			else
				Result := {STRING_32} "[invalid]"
			end
		end

invariant
	{INSTANCE_DEPENDENCE_GENERATOR}.is_valid_kind (kind)

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
