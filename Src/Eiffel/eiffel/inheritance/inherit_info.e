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

create
	make, make_with_feature_and_parent

feature {NONE} -- Initialization

	make (f: like a_feature)
			-- Make inheritance information object for feature `f'.
		require
			f_not_void: f /= Void
		do
			internal_a_feature := f
				-- Flag that `a_feature' has already been instantiated for feature table.
			status_flags := a_feature_instantiated_for_feature_table_mask
		ensure
			internal_a_feature_set: internal_a_feature = f
		end

	make_with_feature_and_parent (f: like a_feature; p: like parent; a_parent_type: like parent_type)
			-- Make inheritance information object for feature `f' in parent `p'.
		require
			f_not_void: f /= Void
			p_not_void: p /= Void
			a_parent_type_not_void: a_parent_type /= Void
		do
			internal_a_feature := f
			parent := p
			parent_type := a_parent_type
				-- Flag that `a_feature' has yet to be instantiated.
			status_flags := a_feature_needs_instantiation_mask
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
		do
			Result := status_flags & a_feature_needs_instantiation_mask = a_feature_needs_instantiation_mask
		end

	a_feature_instantiated_for_feature_table: BOOLEAN
			-- Is `a_feature' shared with other objects?
		do
			Result := status_flags & a_feature_instantiated_for_feature_table_mask = a_feature_instantiated_for_feature_table_mask
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

	set_a_feature_instantiated_for_feature_table
			-- Set `a_feature_instantiated_for_feature_table' to True.			
		do
			status_flags := status_flags.set_bit_with_mask (True, a_feature_instantiated_for_feature_table_mask)
		ensure
			a_feature_instantiated_for_feature_table: a_feature_instantiated_for_feature_table
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
			internal_a_feature := internal_a_feature.instantiated (parent_type)
			if l_feature /= internal_a_feature then
				set_a_feature_instantiated_for_feature_table
			end
			set_a_feature_needs_instantiation (False)
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
			Result := internal_a_feature.body_index < other.internal_a_feature.body_index
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

feature {NONE} -- Implementation

	status_flags: NATURAL_8
		-- Flags used for signifying status of `Current'

	renaming_processed_mask: NATURAL_8 = 0x1
	a_feature_instantiated_for_feature_table_mask: NATURAL_8 = 0x2
	a_feature_needs_instantiation_mask: NATURAL_8 = 0x4

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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end



