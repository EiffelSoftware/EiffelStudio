indexing
	description: "Representation of a once procedure"
	date: "$Date$"
	revision: "$Revision$"

class ONCE_PROC_I 

inherit
	DYN_PROC_I
		redefine
			is_once,
			replicated,
			unselected,
			update_api
		end
	
feature 

	is_once: BOOLEAN is True;
			-- Is the current feature a once one ?

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

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE) is
			-- Update api feature `f' attribute features.
		do
			Precursor {DYN_PROC_I} (f);
			f.set_once (True)
		end;

end
