indexing
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
	make

feature {NONE} -- Initialization

	make (f: like a_feature) is
		do
			a_feature := f
		ensure
			a_feature_set: a_feature = f
		end

feature -- Access

	a_feature: FEATURE_I
			-- Inherited feature

	parent: PARENT_C
			-- Parent from which the feature is inherited

	renaming_processed: BOOLEAN
			-- Has Current already been processed for renaming?

feature -- Settings

	set_renaming_processed is
			-- Set True to `renaming_processed'.			
		do
			renaming_processed := True
		ensure
			renaming_processed: renaming_processed
		end

	set_a_feature (f: like a_feature) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f
		ensure
			a_feature_set: a_feature = f
		end

	set_parent (p: like parent) is
			-- Assign `p' to `parent'.
		do
			parent:= p
		ensure
			parent_set: parent = p
		end

feature -- Comparison

	infix "<" (other: INHERIT_INFO): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := a_feature.body_index < other.a_feature.body_index
		end

feature -- Status

	inherited_assertion: BOOLEAN is
			-- (For merging)
		local
			i: INTEGER
			assert_set: ASSERT_ID_SET
		do
			assert_set := a_feature.assert_id_set
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

feature -- Debug

	trace is
		do
			if
				a_feature/= Void and then
				a_feature.written_class > System.any_class.compiled_class
			then
				io.error.put_string ("set a feature in inherit info%N")
				a_feature.trace
				io.error.put_string (a_feature.generator)
				io.put_new_line
			end
		end
			
indexing
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
			
