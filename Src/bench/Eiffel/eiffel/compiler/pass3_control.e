-- Third pass controler for a class

class PASS3_CONTROL 

inherit

	PASS_CONTROL
		rename
			wipe_out as basic_wipe_out,
			make as basic_make
		end;

	PASS_CONTROL
		redefine
			wipe_out, make
		select
			wipe_out, make
		end

creation

	make
	
feature 

	invariant_changed: BOOLEAN;
			-- Did the invaraint clause changed ?

	invariant_removed: BOOLEAN;
			-- Is the invariant clause removed ?

	changed_status: TWO_WAY_SORTED_SET [INTEGER];
			-- Set of class ids for the classes for which the
			-- expanded or deferred status has changed

	make is
		do
			basic_make;
			!!changed_status.make;
		end;

	set_invariant_removed (b: BOOLEAN) is
			-- Assign `b' to `invariant_removed'.
		do
			invariant_removed := b;
		end;

	set_invariant_changed (b: BOOLEAN) is
			-- Assign `b' to `invariant_changed'.
		do
			invariant_changed := b;
		end;

	add_changed_status (an_id: INTEGER) is
			-- Add `an_id' to the set of ids for the classes for which the
			-- expanded or deferred status has changed
		do
			changed_status.extend (an_id)
		end;

	update (pass2_control: PASS2_CONTROL) is
			-- Update with a second pass controler
		require
			good_argument: pass2_control /= Void
		do
			propagators.merge (pass2_control.propagators);
			melted_propagators.merge (pass2_control.melted_propagators);
		end;

	empty_intersection (depend_list: FEATURE_DEPENDANCE): BOOLEAN is
			-- Is the intersection of `depend_list' and `propagators'
			-- empty ?
		require
			good_argument: depend_list /= Void
		local
			old_cursor: CURSOR;
			prop: like propagators
		do
-- FIXME: use `disjoint'
			prop := propagators
			old_cursor := depend_list.cursor;
			from
				Result := True;
				depend_list.start;
			until
				depend_list.after or else not Result
			loop
				prop.start;
				prop.search (depend_list.item);				
				Result := prop.off;
				depend_list.forth;
			end;
			depend_list.go_to (old_cursor);
		end;

	melted_empty_intersection (depend_list: FEATURE_DEPENDANCE): BOOLEAN is
		  	-- Is the intersection of `depend_list' and `melted_propagators'
			-- empty ?
		require
			good_argument: depend_list /= Void
		local
			old_cursor: CURSOR;
			prop: like melted_propagators
		do
-- FIXME: use `disjoint'
			prop := melted_propagators
			old_cursor := depend_list.cursor;
			from
				Result := True;
				depend_list.start;
			until
				depend_list.after or else not Result
			loop
				prop.start;
				prop.search (depend_list.item);
				Result := prop.off;
				depend_list.forth;
			end;
			depend_list.go_to (old_cursor);
		end;

	changed_status_empty_intersection (feature_suppliers: TWO_WAY_SORTED_SET [INTEGER]): BOOLEAN is
			-- Is the intersection of `feature_suppliers' and `changed_status' empty ?
		require
			good_argument: feature_suppliers /= Void
		do
			Result := changed_status.disjoint (feature_suppliers);
		end;

	set_removed_features (r: like removed_features) is
			-- Assign `r' to `removed_features'.
		do
			removed_features := r;
		end;

	wipe_out is
			-- Empty the controller
		do
			basic_wipe_out;
			changed_status.wipe_out;
			invariant_changed := False;
			invariant_removed := False;
		end;

end
