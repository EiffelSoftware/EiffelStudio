note
	description: "Information about an inherited feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INHERIT_INFO

inherit
	COMPARABLE

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	SHARED_DEGREES
		undefine
			is_equal
		end

	SHARED_TMP_SERVER
		export {NONE} all
		undefine
			is_equal
		end

create
	set_with_feature_and_parent

feature -- Initialization

	set_with_feature_and_parent (f: like a_feature; p: like parent; a_parent_type: like parent_type)
			-- Set inheritance information object for feature `f' in parent `p'.
		require
			parent_type_valid: a_parent_type /= Void implies (f /= Void and p /= Void)
			p_valid: p /= Void implies (f /= Void and a_parent_type /= Void)
		do
			internal_a_feature := f
			parent := p
			parent_type := a_parent_type
			if parent_type /= Void then
					-- Flag that `a_feature' has yet to be instantiated.
				status_flags := a_feature_needs_instantiation_mask
			elseif f /= Void then

				status_flags := a_feature_instantiated_for_feature_table_mask
			else
					-- We are creating an empty object so we reset the flags.
				status_flags := 0
			end
		ensure
			internal_a_feature_set: internal_a_feature = f
			parent_set: parent = p
		end

feature -- Access

	a_feature: FEATURE_I
			-- Inherited feature
		do
			if a_feature_needs_instantiation then
				instantiate_a_feature
			end
			Result := internal_a_feature
		end

	feature_has_alias_name_id (a_alias_name_id: INTEGER): BOOLEAN
			-- Does `internal_a_feature` has an alias name id `a_alias_name_id`?
		do
				-- There is no need to instantiate the feature just to get its name since it
				-- does not change via instantiation.

			Result := internal_a_feature.has_alias_name_id (a_alias_name_id)
		end

	internal_a_feature: like a_feature

	parent: PARENT_C
			-- Parent from which the feature is inherited

	parent_type: LIKE_CURRENT
			-- Parent type of `parent' for current class.

	renaming_processed: BOOLEAN
			-- Has Current already been processed for renaming?
		do
			Result := status_flags & renaming_processed_mask = renaming_processed_mask
		end

	a_feature_needs_instantiation: BOOLEAN
			-- Does `a_feature' need instantiation with `parent' before use?
		do
			Result := status_flags & a_feature_needs_instantiation_mask = a_feature_needs_instantiation_mask
		end

	a_feature_instantiated_for_feature_table: BOOLEAN
			-- Has `a_feature' instantiated a new object for feature table?
		do
			Result := status_flags & a_feature_instantiated_for_feature_table_mask = a_feature_instantiated_for_feature_table_mask
		end

	a_feature_copied_for_feature_table: BOOLEAN
			-- Is `a_feature' copied specifically for feature table (ie: new object created for feature table)?
		do
			Result := status_flags & a_feature_copied_for_feature_table_mask = a_feature_copied_for_feature_table_mask
		end

	a_feature_aliased: BOOLEAN
			-- Is `a_feature' aliased from `parent'.
		do
			Result := not (a_feature_instantiated_for_feature_table or else a_feature_copied_for_feature_table)
		end

feature -- Settings

	set_renaming_processed
			-- Set `renaming_processed' to True.			
		do
			status_flags := status_flags.set_bit_with_mask (True, renaming_processed_mask)
		ensure
			renaming_processed: renaming_processed
		end

	set_a_feature_needs_instantiation (b: BOOLEAN)
			-- Set `a_feature_needs_instantiating' to `b'.			
		do
			status_flags := status_flags.set_bit_with_mask (b, a_feature_needs_instantiation_mask)
		ensure
			a_feature_needs_instantiating: a_feature_needs_instantiation = b
		end

	set_a_feature_instantiated_for_feature_table (b: BOOLEAN)
			-- Set `a_feature_instantiated_for_feature_table' to `b'.			
		do
			status_flags := status_flags.set_bit_with_mask (b, a_feature_instantiated_for_feature_table_mask)
		ensure
			a_feature_instantiated_for_feature_table: a_feature_instantiated_for_feature_table = b
		end

	set_a_feature_copied_for_feature_table (b: BOOLEAN)
			-- Set `a_feature_copied_for_feature_table' to `b'.			
		do
			status_flags := status_flags.set_bit_with_mask (b, a_feature_copied_for_feature_table_mask)
		ensure
			a_feature_copied_for_feature_table: a_feature_copied_for_feature_table = b
		end

	set_a_feature (f: like a_feature)
			-- Assign `f' to `a_feature'.
		require
			f_not_void: f /= Void
		do
			internal_a_feature := f
		ensure
			internal_a_feature_set: internal_a_feature = f
		end

	delayed_instantiate_a_feature
			-- Instantiate `a_feature' for `parent_type' with a possible delay.
		require
			a_feature_needs_instantiation: a_feature_needs_instantiation
			parent_type_not_void: parent_type /= Void
			a_feature_not_void: internal_a_feature /= Void
		local
			f: FEATURE_I
			g: FEATURE_I
		do
				-- Record current feature for delayed instantiation.
			f := internal_a_feature
			if f.is_type_evaluation_delayed then
					-- Make a clone of the current feature that will be updated later.
					-- `f.twin' cannot be used here because descendant may change
					-- arguments types thus preventing ancestor features from correct
					-- type checking.
				g := f.duplicate
					-- Register update action.
				degree_4.put_action (
					agent (destination: FEATURE_I; source: FEATURE_I; instantiation_type: TYPE_A)
						local
							i: FEATURE_I
						do
							i := source.instantiated (instantiation_type)
							destination.set_type (i.type, destination.assigner_name_id)
							destination.set_arguments (i.arguments)
							destination.set_pattern_id (i.pattern_id)
						end
					(g, f, parent_type)
				)
				internal_a_feature := g
				set_a_feature_instantiated_for_feature_table (True)
				set_a_feature_needs_instantiation (False)
			else
				instantiate_a_feature
			end
		end

	instantiate_a_feature
			-- Instantiate `a_feature' for `parent_type'.
		require
			a_feature_needs_instantiation: a_feature_needs_instantiation
			parent_type_not_void: parent_type /= Void
			a_feature_not_void: internal_a_feature /= Void
		local
			l_feature: FEATURE_I
		do
				-- Store previous `internal_a_feature' so that we can check whether a new object is created.
			l_feature := internal_a_feature
			internal_a_feature := l_feature.instantiated (parent_type)
			if l_feature /= internal_a_feature then
				set_a_feature_instantiated_for_feature_table (True)
			end
			set_a_feature_needs_instantiation (False)
		end

	copy_a_feature_for_feature_table
			-- Make sure that `a_feature' is copied directly for feature_table.
		require
			not_a_feature_needs_instantiation: not a_feature_needs_instantiation
		do
			if a_feature_aliased then
				internal_a_feature := internal_a_feature.twin
				set_a_feature_copied_for_feature_table (True)
			end
		end

	set_parent (p: like parent)
			-- Assign `p' to `parent'.
		require
			p_not_void: p /= Void
		do
			parent := p
		ensure
			parent_set: parent = p
		end

feature -- Comparison

	is_less alias "<" (other: INHERIT_INFO): BOOLEAN
			-- Is `other' greater than Current ?
		do
			Result := other.internal_a_feature = Void
			if not Result then
				Result := internal_a_feature.feature_id < other.internal_a_feature.feature_id
			end
		end

feature -- Status

	inherited_assertion: BOOLEAN
			-- (For merging)
		local
			i: INTEGER
			assert_set: ASSERT_ID_SET
		do
			assert_set := internal_a_feature.assert_id_set
			if assert_set /= Void then
				from
					i := 1
				until
					i > assert_set.count or else Result
				loop
					Result := (assert_set.item (i).has_assertion)
					i := i + 1
				end
			end
		end

	has_property_getter: BOOLEAN
			-- Has an associated feature a property getter?
		require
			a_feature_attached: internal_a_feature /= Void
		do
			Result := internal_a_feature.has_property_getter
		ensure
			definition: Result = internal_a_feature.has_property_getter
		end

	has_property_setter: BOOLEAN
			-- Has an associated feature a property setter?
		require
			a_feature_attached: internal_a_feature /= Void
		do
			Result := internal_a_feature.has_property_setter
		ensure
			definition: Result = internal_a_feature.has_property_setter
		end

feature -- Implementation

	reset
			-- Reset `Current' for reuse.
		do
			status_flags := 0
			internal_a_feature := Void
			parent := Void
			parent_type := Void
		end

feature {NONE} -- Implementation

	status_flags: NATURAL_8
		-- Flags used for signifying status of `Current'

	renaming_processed_mask: NATURAL_8 = 0x1
	a_feature_instantiated_for_feature_table_mask: NATURAL_8 = 0x2
	a_feature_needs_instantiation_mask: NATURAL_8 = 0x4
	a_feature_copied_for_feature_table_mask: NATURAL_8 = 0x8

feature -- Debug

	trace
		do
			if
				internal_a_feature/= Void and then
				internal_a_feature.written_class > System.any_class.compiled_class
			then
				io.error.put_string ("set a feature in inherit info%N")
				a_feature.trace
				io.error.put_string (internal_a_feature.generator)
				io.put_new_line
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
