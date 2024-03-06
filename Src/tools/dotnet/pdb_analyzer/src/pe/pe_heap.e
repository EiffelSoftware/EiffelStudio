note
	description: "Summary description for {PE_HEAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_HEAP

feature -- Initialization

	make (pe: PDB_FILE; add: NATURAL_32; sz: NATURAL_32)
		do
			address := add
			size := sz
			read (pe)
		end

feature -- Access

	read (pe: PDB_FILE)
		deferred
		end

feature -- Access

	address: NATURAL_32

	size: NATURAL_32

	count: INTEGER
		deferred
		end

feature {NONE} -- Helpers

	offset (i: PE_ITEM): NATURAL_32
		do
			Result := i.declaration_address - address
		end

end
