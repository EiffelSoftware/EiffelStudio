class DEF_PROC_I 

inherit

	PROCEDURE_I			
		redefine
			is_deferred, has_entry, to_generate_in,
			to_melt_in, can_be_inlined, update_api
		end
	
feature 

	has_entry: BOOLEAN is False;
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
			Result := equal (a_class.id, written_in) and then 
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

	unselected (in: CLASS_ID): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DEF_PROC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

feature -- Inlining

	can_be_inlined: BOOLEAN is False

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE) is
		do
			{PROCEDURE_I} Precursor (f);
			f.set_deferred (True);
		end;

end
