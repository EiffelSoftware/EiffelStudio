class DEF_PROC_I 

inherit

	PROCEDURE_I
		redefine
			is_deferred, has_poly_unit, to_generate_in,
			to_melt_in
		end
	
feature 

	has_poly_unit: BOOLEAN is False;
			-- No polymorphic unit for deferred features

	is_deferred: BOOLEAN is
		do
			Result := True
		end;

    to_melt_in (a_class: CLASS_C): BOOLEAN is
            -- Has the current feature to be melted in class `a_class' ?
			-- (Deferred routines with pre or post conditions are
			-- melted)
        do
            Result := (a_class.id = written_in) and then 
					(has_precondition or else has_postcondition);
        end;

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be generated in class `a_class' ?
			-- (Deferred routines with pre or post conditions are
			-- not generated)
		do
			-- Do nothing
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DEF_PROC_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_PROC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

end
