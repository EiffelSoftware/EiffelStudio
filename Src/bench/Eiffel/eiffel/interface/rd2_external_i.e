indexing
	description: "Representation of an replicated unselected external procedure"
	date: "$Date$"
	revision: "$Revision$"

class RD2_EXTERNAL_I

inherit
	R_EXTERNAL_I
		redefine
			access_in, transfer_to, is_unselected
		end

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
			Precursor {R_EXTERNAL_I} (f);
			f.set_access_in (access_in);
		end;

	is_unselected: BOOLEAN is True;
			-- Is the feature a non-selected one ?
 
end
