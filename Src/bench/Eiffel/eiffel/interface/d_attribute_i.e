indexing
	description: "Representation of an inherited attribute which is unselected"
	date: "$Date$"
	revision: "$Revision$"

class D_ATTRIBUTE_I

inherit
	ATTRIBUTE_I
		redefine
			unselected, access_in, replicated, is_unselected, transfer_to
		end

create
	make

feature

	access_in: INTEGER
			-- Access class id

	set_access_in (i: INTEGER) is
			-- Assign `i' to `access_in'
		do
			access_in := i
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: RD1_ATTRIBUTE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end; -- replicated

	unselected (i: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			rep: RD1_ATTRIBUTE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_access_in (i)
			Result := rep
		end

	transfer_to (f: like Current) is
			-- Data transfer
		do
			{ATTRIBUTE_I} Precursor (f)
			f.set_access_in (access_in)
		end

	is_unselected: BOOLEAN is True
			-- Is the feature a non-selected one ?

end
