note
	description: "Generator of instance dependence descriptors."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

class INSTANCE_DEPENDENCE_GENERATOR

inherit
	TYPE_A_VISITOR
	SHARED_WORKBENCH

feature -- Access

	dependence: detachable INSTANCE_DEPENDENCE
			-- Dependence on a type used to instantiate an object computed by `generate`.

feature -- Dependence kind

	call_kind: NATURAL_8 = 0
			-- A class (rather than an object) is used as a target of a call.

	expanded_creation_kind: NATURAL_8 = 1
			-- An instance of a class is created if it is expanded.

	regular_creation_kind: NATURAL_8 = 2
			-- An instance of a class is created unconditionally.

feature -- Status report

	is_valid_kind (k: like kind): BOOLEAN
			-- Does value `k` correspond to a valid kind?
		do
			Result :=
				k = regular_creation_kind or
				k = expanded_creation_kind or
				k = call_kind
		ensure
			class
		end

feature -- Basic operations

	generate (t: TYPE_A; k: like call_kind; w: CLASS_C)
			-- Compute `dependence` corresponding to the type `t` written in class `w` and
			-- used to instantiate an object or used as a target of a non-object call depending on `k`.
		require
			is_valid_kind (k)
		do
			kind := k
			written_class := w
			dependence := Void
			t.process (Current)
			if
				kind = expanded_creation_kind and then
				attached {INSTANCE_DEPENDENCE_ON_CLASS} dependence as d and then
				not system.class_of_id (d.class_id).is_expanded
			then
					-- Ignore dependencies on non-expanded class types because they do not involve automatic creation.
				dependence := Void
			end
		end

feature {NONE} -- Status report

	kind: like call_kind
			-- The kind of the dependency.
			-- See: `regular_creation_kind`, `expanded_creation_kind`, `call_kind`.

	written_class: CLASS_C
			-- The class where the type is written.

feature {TYPE_A} -- Visitor

	process_boolean_a (t: BOOLEAN_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_character_a (t: CHARACTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_cl_type_a (t: CL_TYPE_A)
			-- <Precursor>
		do
			create {INSTANCE_DEPENDENCE_ON_CLASS} dependence.make (t, kind)
		end

	process_formal_a (t: FORMAL_A)
			-- <Precursor>
		do
			create {INSTANCE_DEPENDENCE_ON_FORMAL} dependence.make (t, written_class, kind)
		end

	process_gen_type_a (t: GEN_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_integer_a (t: INTEGER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_like_argument (t: LIKE_ARGUMENT)
			-- <Precursor>
		do
				-- The type declaration is local to the routine.
				-- Just use the type is relies on.
			t.actual_type.process (Current)
		end

	process_like_current (t: LIKE_CURRENT)
			-- <Precursor>
		do
				-- Instantiation is performed on an existing object, therefore its class is already in the system, nothing to do here.
		end

	process_like_feature (t: LIKE_FEATURE)
			-- <Precursor>
		do
				-- Check to what type the anchor evaluates to.
			t.actual_type.process (Current)
			if
				attached {INSTANCE_DEPENDENCE_ON_CLASS} dependence as d and then
				attached workbench.system as s and then
				attached s.class_of_id (d.class_id) as c and then
				c.is_frozen
			then
					-- Use class dependence because there is no variation.
			else
					-- Create a new dependence on the feature type.
				create {INSTANCE_DEPENDENCE_ON_FEATURE} dependence.make (t, written_class, kind)
			end
		end

	process_local (t: LOCAL_TYPE_A)
			-- <Precursor>
		do
		end

	process_manifest_integer_a (t: MANIFEST_INTEGER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_manifest_natural_64_a (t: MANIFEST_NATURAL_64_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_manifest_real_a (t: MANIFEST_REAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_named_tuple_type_a (t: NAMED_TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_native_array_type_a (t: NATIVE_ARRAY_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_natural_a (t: NATURAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_none_a (a_type: NONE_A)
			-- <Precursor>
		do
		end

	process_pointer_a (t: POINTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_qualified_anchored_type_a (t: QUALIFIED_ANCHORED_TYPE_A)
			-- <Precursor>
		do
				-- Check to what type the anchor evaluates to.
			t.actual_type.process (Current)
			if
				attached {INSTANCE_DEPENDENCE_ON_CLASS} dependence as d and then
				(t.is_loose implies
					attached workbench.system as s and then
					attached s.class_of_id (d.class_id) as c and then
					c.is_frozen)
			then
					-- Use class dependence because there is no variation.
			else
					-- Create a new dependence on the feature type.
				create {INSTANCE_DEPENDENCE_ON_QUALIFIED} dependence.make (t, written_class, kind)
			end
		end

	process_real_a (t: REAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_tuple_type_a (t: TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_typed_pointer_a (t: TYPED_POINTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_unevaluated_like_type (t: UNEVALUATED_LIKE_TYPE)
			-- <Precursor>
		do
		end

	process_unevaluated_qualified_anchored_type (t: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- <Precursor>
		do
		end

	process_unknown (t: UNKNOWN_TYPE_A)
			-- Process `t'.
			-- <Precursor>
		do
		end

	process_void_a (t: VOID_A)
			-- <Precursor>
		do
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
