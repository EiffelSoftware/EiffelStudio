note
	description: "Summary description for {PE_GUID_HEAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GUID_HEAP

inherit
	PE_HEAP

	PE_VISITABLE

create
	make

feature -- Initialization

	read (pe: PE_FILE)
		local
			b,e: NATURAL_32
		do
			-- Format: f77279b4-a0e9-4ec3-a5ca-f1bbe35ce4b1
			--	8 4 4 4 12
			b := pe.position.to_natural_32
			if attached pe.read_bytes (size) as mp then
				e := pe.position.to_natural_32
				create item.make (b, b, e, mp, "GUID")
				count := 1
			end
		end

feature -- Access

	item: detachable PE_GUID_ITEM

	valid_index (i: NATURAL_32): BOOLEAN
		do
			Result := i = 0
		end

	guid_item alias "[]" (i: NATURAL_32): like item
		do
			Result := item
		end

	count: INTEGER

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_guid_heap (Current)
		end

end
