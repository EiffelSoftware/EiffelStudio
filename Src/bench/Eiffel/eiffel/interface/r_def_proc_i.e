indexing
	description: "Representation of a replicated deferred procedure"
	date: "$Date$"
	revision: "$Revision$"

class R_DEF_PROC_I

inherit
	DEF_PROC_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, set_code_id
		end

feature

	code_id: INTEGER;
			-- Code id

	set_code_id (i: INTEGER) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end;

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: RD2_DEF_PROC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (i);
			Result := unselect
		end; -- unselected

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_DEF_PROC_I
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			Precursor {DEF_PROC_I} (f);
			f.set_code_id (code_id);
		end;

    is_replicated: BOOLEAN is True;
            -- Is Current feature conceptually replicated (True)
 
end
