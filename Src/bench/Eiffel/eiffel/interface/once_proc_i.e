class ONCE_PROC_I 

inherit

	DYN_PROC_I
		redefine
			is_once,
			--redefinable,
			replicated,
			unselected
		end
	
feature 

	is_once: BOOLEAN is True;
			-- Is the current feature a once one ?

	--redefinable: BOOLEAN is False;
			-- Is a once feature redefinable ?

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_ONCE_PROC_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_ONCE_PROC_I;
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

end
