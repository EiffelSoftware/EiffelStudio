-- Replicated procedure

class R_ONCE_PROC_I

inherit

	ONCE_PROC_I
		rename
			transfer_to as once_proc_transfer_to
		redefine
			replicated, code_id, unselected
		end;
	ONCE_PROC_I
		redefine
			replicated, code_id, unselected, transfer_to
		select
			transfer_to
		end;

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
			unselect: RD2_ONCE_PROC_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (i);
			Result := unselect
		end; -- unselected

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_ONCE_PROC_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			once_proc_transfer_to (f);
			f.set_code_id (code_id);
		end;

end
