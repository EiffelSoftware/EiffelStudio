-- Replicated procedure

class R_ATTRIBUTE_I

inherit
	ATTRIBUTE_I
		redefine
			replicated, code_id, unselected, transfer_to,
			is_replicated, is_code_replicated,
			set_is_code_replicated,
			set_code_id
		end

feature

	code_id: BODY_ID
			-- Code id

	set_code_id (i: BODY_ID) is
			-- Assign `i' to `code_id'.
		do
			code_id := i
		end

	unselected (i: CLASS_ID): FEATURE_I is
			-- Unselected feature
		local
			unselect: RD2_ATTRIBUTE_I
		do
			!!unselect
			transfer_to (unselect)
			unselect.set_access_in (i)
			Result := unselect
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD2_ATTRIBUTE_I
		do
			!!rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	transfer_to (f: like Current) is
			-- Data transfer
		do
			{ATTRIBUTE_I} precurosr (f)
			f.set_code_id (code_id)
		end

	set_is_code_replicated is
			-- Set `is_code_replicated' to True.
		do
			is_code_replicated := True
		end

	is_code_replicated: BOOLEAN
			-- Is Current feature code replicated

	is_replicated: BOOLEAN is True
			-- Is Current feature conceptually replicated (True)

end
