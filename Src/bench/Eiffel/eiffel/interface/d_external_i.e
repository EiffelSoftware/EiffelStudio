-- Unselected feature

class D_EXTERNAL_I

inherit

	EXTERNAL_I
		rename
			transfer_to as external_transfer_to
		redefine
			unselected, access_in, replicated, is_unselected
		end;
	EXTERNAL_I
		redefine
			unselected, access_in, replicated, is_unselected, transfer_to
		select
			transfer_to
		end;

feature

	access_in: INTEGER;
			-- Access class id

	set_access_in (i: INTEGER) is
			-- Assign `i' to `access_in'
		do
			access_in := i
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD1_EXTERNAL_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end; -- replicated

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			rep: RD1_EXTERNAL_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_access_in (i);
			Result := rep
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			external_transfer_to (f);
			f.set_access_in (access_in);
		end;

	is_unselected: BOOLEAN is True;
			-- Is the feature a non-selected one ?

end
