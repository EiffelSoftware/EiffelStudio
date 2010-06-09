note
	description: "Feature lookup facility for {TYPE_A}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_A_FEATURE_FINDER

inherit
	TYPE_A_VISITOR
		redefine
			is_type_valid,
			is_valid,
			process_multi_formal_a
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
			{ANY} names_heap
		end

	SHARED_AST_CONTEXT export {NONE} all end
	SHARED_WORKBENCH export {NONE} all end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
			-- `True' iff context class is set in {AST_CONTEXT}.
		do
			Result := attached context_class
		end

	is_type_valid (t: TYPE_A): BOOLEAN
			-- <Precursor>
			-- `True' iff `t' is valid for the context class.
		do
			Result := is_type_valid_for_class (t, context_class)
		end

	is_type_valid_for_class (t: TYPE_A; c: CLASS_C): BOOLEAN
			-- Is type `t' valid for context class `c'?
		require
			t_attached: attached t
			c_attached: attached c
		do
			if
				not t.is_renamed_type and then
				not t.is_like_argument and then
				not t.is_void and then
				not attached {OPEN_TYPE_A} t and then
				not attached {UNEVALUATED_BITS_SYMBOL_A} t and then
				not attached {UNEVALUATED_LIKE_TYPE} t and then
				not attached {UNEVALUATED_QUALIFIED_ANCHORED_TYPE} t
			then
				Result := t.is_valid_for_class (c)
			end
		end

feature -- Access

	found_feature: detachable FEATURE_I
			-- Feature found by `find' (if any) which is called on the class identified by `found_site'

	found_site: INTEGER
			-- Class ID on which `found_feature' is called

feature {NONE} -- Context

	context_class: CLASS_C
			-- Class in which search is performed

	name_id: INTEGER
			-- Name ID of the feature being searched

feature -- Search

	find (n: INTEGER; t: TYPE_A; c: CLASS_C)
			-- Find feature of name ID `n' called on type `t' and make it available in `found_feature'
			-- assuming that the code is written in `c'.
		require
			valid_n: names_heap.has (n)
			attached_t: attached t
			attached_c: attached c
			valid_t: is_type_valid_for_class (t, c)
		do
			found_feature := Void
			found_site := 0
			name_id := n
			context_class := c
			t.process (Current)
		ensure
			same_name: attached found_feature as f implies f.feature_name_id = n
			valid_site: attached found_feature as f implies system.classes.has (found_site)
			feature_from_class: attached found_feature as f implies attached system.class_of_id (found_site) as s and then s.feature_of_name_id (n) ~ f
		end

feature {TYPE_A} -- Visitor

	process_bits_a (t: BITS_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_bits_symbol_a (t: BITS_SYMBOL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

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
			if
				attached t.associated_class as c and then
				attached c.feature_of_name_id (name_id) as f
			then
				found_site := c.class_id
				found_feature := f
			end
		end

	process_renamed_type_a (t: RENAMED_TYPE_A [TYPE_A])
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_formal_a (t: FORMAL_A)
			-- <Precursor>
		local
			last_feature: detachable FEATURE_I
			last_site: INTEGER
			has_multiple: BOOLEAN
		do
			across
				context_class.constrained_types (t.position) as c
			until
				has_multiple
			loop
				find (name_id, c.item.type, context_class)
				if attached found_feature as f then
					if attached last_feature then
							-- More than one feature is found.
						last_feature := Void
						last_site := 0
						has_multiple := True
					else
							-- Record found data for future use.
						last_feature := found_feature
						last_site := found_site
					end
				end
			end
			found_feature := last_feature
			found_site := last_site
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
			check valid_t: False end
		end

	process_like_current (t: LIKE_CURRENT)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
		end

	process_like_feature (t: LIKE_FEATURE)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
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

	process_multi_formal_a (t: MULTI_FORMAL_A)
			-- <Precursor>
		do
			process_formal_a (t)
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

	process_none_a (t: NONE_A)
			-- <Precursor>
		do
		end

	process_open_type_a (t: OPEN_TYPE_A)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_pointer_a (t: POINTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_qualified_anchored_type_a (t: QUALIFIED_ANCHORED_TYPE_A)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
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

	process_unevaluated_bits_symbol_a (t: UNEVALUATED_BITS_SYMBOL_A)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_unevaluated_like_type (t: UNEVALUATED_LIKE_TYPE)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_unevaluated_qualified_anchored_type (t: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_void_a (t: VOID_A)
			-- <Precursor>
		do
			check valid_t: False end
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
