indexing
	description: "Representation of a procedure"
	date: "$Date$"
	revision: "$Revision$"

class DYN_PROC_I 

inherit
	PROCEDURE_I
		redefine
			replicated, unselected, is_do
		end
	
feature 

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_DYN_PROC_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DYN_PROC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	is_do: BOOLEAN is true

end
