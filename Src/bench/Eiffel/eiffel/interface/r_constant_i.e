indexing
	description: "Representation of a replicated constant"
	date: "$Date$"
	revision: "$Revision$"

class R_CONSTANT_I

inherit
	CONSTANT_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, set_code_id
		end;

create
	make

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
			create unselect.make
			transfer_to (unselect);
			unselect.set_access_in (i);
			Result := unselect
		end; -- unselected

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_CONSTANT_I
		do
			create rep.make
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	transfer_to (f: like Current) is
			-- Data transfer
		do
			Precursor {CONSTANT_I} (f);
			f.set_code_id (code_id);
		end;

	is_replicated: BOOLEAN is True;
			-- Is Current feature conceptually replicated (True)

end
