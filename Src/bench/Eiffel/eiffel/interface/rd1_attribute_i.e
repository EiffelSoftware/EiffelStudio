indexing
	description: "Representation of an unselected replicated attribute"
	date: "$Date$"
	revision: "$Revision$"

class RD1_ATTRIBUTE_I

inherit
	D_ATTRIBUTE_I
		redefine
			code_id, transfer_to, is_replicated, set_code_id
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

	transfer_to (f: like Current) is
			-- Data transfer
		do
			Precursor {D_ATTRIBUTE_I} (f)
			f.set_code_id (code_id)
		end

    is_replicated: BOOLEAN is True
            -- Is Current feature conceptually replicated (True)
 
end
