-- Replicated procedure

class RD2_UNIQUE_I

inherit

	R_UNIQUE_I
		rename
			transfer_to as r_unique_transfer_to
		redefine
			access_in, is_unselected
		end;
	R_UNIQUE_I
		redefine
			access_in, transfer_to, is_unselected
		select
			transfer_to
		end;

feature

	access_in: INTEGER;
			-- Access class id

	set_access_in (i: INTEGER) is
			-- Assign `i' to `access_in'.
		do
			access_in := i
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			r_unique_transfer_to (f);
			f.set_access_in (access_in);
		end;

	is_unselected: BOOLEAN is True;
			-- Is the feature a non-selected one ?
 
end
