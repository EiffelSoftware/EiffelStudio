-- Replicated procedure

class RD2_ATTRIBUTE_I

inherit
	R_ATTRIBUTE_I
		redefine
			access_in, transfer_to, is_unselected
		end

feature

	access_in: CLASS_ID
			-- Access class id

	set_access_in (i: CLASS_ID) is
			-- Assign `i' to `access_in'.
		do
			access_in := i
		end

	transfer_to (f: like Current) is
			-- Data transfer
		do
			{R_ATTRIBUTE_I} precursor (f)
			f.set_access_in (access_in)
		end

	is_unselected: BOOLEAN is True
			-- Is the feature a non-selected one ?
 
end
