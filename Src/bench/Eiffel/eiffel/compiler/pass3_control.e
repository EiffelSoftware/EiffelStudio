-- Third pass controler for a class

class PASS3_CONTROL 

inherit

	PASS_CONTROL
		rename
			wipe_out as basic_wipe_out
		end;

	PASS_CONTROL
		redefine
			wipe_out
		select
			wipe_out
		end

creation

	make
	
feature 

	invariant_changed: BOOLEAN;
			-- Did the invaraint clause changed ?

	invariant_removed: BOOLEAN;
			-- Is the invariant clause removed ?

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

	update (pass2_control: PASS2_CONTROL) is
			-- Update with a seond pass controler
		require
			good_argument: pass2_control /= Void
		do
			propagators.merge (pass2_control.propagators);
			melted_propagators.merge (pass2_control.melted_propagators);
		end;

	empty_intersection (depend_list: SORTED_TWO_WAY_LIST [DEPEND_UNIT]): BOOLEAN is
			-- Is the intersection of `depend_list' and `propagators'
			-- empty ?
		require
			good_argument: depend_list /= Void
		local
			pos: INTEGER;
		do
			pos := depend_list.position;
			from
				Result := True;
				depend_list.start;
			until
				depend_list.offright or else not Result
			loop
				propagators.start;
				propagators.search_equal (depend_list.item);				
				Result := propagators.off;
				depend_list.forth;
			end;
			depend_list.go (pos);
		end;

	melted_empty_intersection
				(depend_list: SORTED_TWO_WAY_LIST [DEPEND_UNIT]): BOOLEAN is
		  	-- Is the intersection of `depend_list' and `melted_propagators'
			-- empty ?
		require
			good_argument: depend_list /= Void
		local
			pos: INTEGER;
		do
			pos := depend_list.position;
			from
				Result := True;
				depend_list.start;
			until
				depend_list.offright or else not Result
			loop
				melted_propagators.start;
				melted_propagators.search_equal (depend_list.item);
				Result := melted_propagators.off;
				depend_list.forth;
			end;
			depend_list.go (pos);
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
			invariant_changed := False;
			invariant_removed := False;
		end;

end
