note
	description: "Summary description for {PE_STRUCTURE_ITEM}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_STRUCTURE_ITEM

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (lab: like label)
		do
			label := lab
		end

feature -- Access

	label: READABLE_STRING_8

--	binary_size: NATURAL_8
--			-- 1, 2, 4, 8, ... bytes?
--		deferred
--		end

feature -- Read

	read (pe: PDB_FILE): PE_ITEM
		deferred
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
		do
			Result := label
		end


end
