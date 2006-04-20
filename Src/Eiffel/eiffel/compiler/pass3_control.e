indexing
	description: "Third pass controler for a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PASS3_CONTROL 

inherit
	PASS_CONTROL
		redefine
			wipe_out, make
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			Precursor {PASS_CONTROL}
			create changed_status.make
		end

feature -- Access

	invariant_changed: BOOLEAN
			-- Did the invaraint clause changed ?

	invariant_removed: BOOLEAN
			-- Is the invariant clause removed ?

	changed_status: TWO_WAY_SORTED_SET [INTEGER]
			-- Set of class ids for the classes for which the
			-- expanded or deferred status has changed

feature -- Settings

	set_invariant_removed (b: BOOLEAN) is
			-- Assign `b' to `invariant_removed'.
		do
			invariant_removed := b
		end

	set_invariant_changed (b: BOOLEAN) is
			-- Assign `b' to `invariant_changed'.
		do
			invariant_changed := b
		end

	set_removed_features (r: like removed_features) is
			-- Assign `r' to `removed_features'.
		do
			removed_features := r
		end

	add_changed_status (an_id: INTEGER) is
			-- Add `an_id' to the set of ids for the classes for which the
			-- expanded or deferred status has changed
		do
			changed_status.extend (an_id)
		end

	update (pass2_control: PASS2_CONTROL) is
			-- Update with a second pass controler
		require
			good_argument: pass2_control /= Void
		do
			propagators.merge (pass2_control.propagators)
			melted_propagators.merge (pass2_control.melted_propagators)
		end

feature -- Removal

	wipe_out is
			-- Empty the controller
		do
			Precursor {PASS_CONTROL}
			changed_status.wipe_out
			invariant_changed := False
			invariant_removed := False
		end

feature -- Status report

	empty_intersection (depend_list: FEATURE_DEPENDANCE): BOOLEAN is
			-- Is the intersection of `depend_list' and `propagators'
			-- empty ?
		require
			depend_list_not_void: depend_list /= Void
		do
			Result := internal_is_empty_intersection (propagators, depend_list)
		end
	
	melted_empty_intersection (depend_list: FEATURE_DEPENDANCE): BOOLEAN is
		  	-- Is the intersection of `depend_list' and `melted_propagators'
			-- empty ?
		require
			depend_list_not_void: depend_list /= Void
		do
			Result := internal_is_empty_intersection (melted_propagators, depend_list)
		end

	changed_status_empty_intersection (feature_suppliers: TWO_WAY_SORTED_SET [INTEGER]): BOOLEAN is
			-- Is the intersection of `feature_suppliers' and `changed_status' empty ?
		require
			good_argument: feature_suppliers /= Void
		do
			Result := changed_status.disjoint (feature_suppliers)
		end

feature {NONE} -- Implementation

	internal_is_empty_intersection (a_propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT]; depend_list: FEATURE_DEPENDANCE): BOOLEAN is
		require
			a_propagators_not_void: a_propagators /= Void
			depend_list_not_void: depend_list /= Void
		local
			old_cursor: CURSOR
		do
				-- To find if intersection is empty, we instead search
				-- if an element of `a_propagators' is in `depend_list'.
				-- if it is the case then the intersection is not empty
				-- thus the final result which is `not Result'.
			old_cursor := depend_list.cursor
			from
				depend_list.start
			until
				depend_list.after or else Result
			loop
				from
					a_propagators.start
				until
					a_propagators.after or else Result
				loop
					Result := depend_list.item.same_as (a_propagators.item)
					a_propagators.forth
				end
				depend_list.forth
			end
			depend_list.go_to (old_cursor)
			Result := not Result
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
