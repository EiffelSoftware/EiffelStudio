-- Replicated procedure

class R_CONSTANT_I

inherit

	CONSTANT_I
		rename
			transfer_to as constant_transfer_to
		redefine
			replicated, code_id, unselected, is_replicated,
			is_code_replicated, set_is_code_replicated,
			set_code_id
		end;
	CONSTANT_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, is_code_replicated,
			set_is_code_replicated,
			set_code_id
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
			unselect: RD2_CONSTANT_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (i);
			Result := unselect
		end; -- unselected

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_CONSTANT_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			constant_transfer_to (f);
			f.set_code_id (code_id);
		end;

	is_code_replicated: BOOLEAN;
			-- Is Current feature code replicated

	is_replicated: BOOLEAN is True;
			-- Is Current feature conceptually replicated (True)

	set_is_code_replicated is
			-- Set `is_code_replicated' to True.
		do
			is_code_replicated := True;
		end;

end
