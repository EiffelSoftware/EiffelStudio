indexing
	description: "Representation of a replicated attribute"
	date: "$Date$"
	revision: "$Revision$"

class R_ATTRIBUTE_I

inherit
	ATTRIBUTE_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, set_code_id
		end

create
	make
	
feature

	code_id: INTEGER
			-- Code id

	set_code_id (i: INTEGER) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: RD2_ATTRIBUTE_I
		do
			create unselect.make
			transfer_to (unselect)
			unselect.set_access_in (i)
			Result := unselect
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_ATTRIBUTE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	transfer_to (f: like Current) is
			-- Data transfer
		do
			precursor {ATTRIBUTE_I} (f)
			f.set_code_id (code_id)
		end

	is_replicated: BOOLEAN is True
			-- Is Current feature conceptually replicated (True)

end
