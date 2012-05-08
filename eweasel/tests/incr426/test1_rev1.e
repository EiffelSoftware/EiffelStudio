class
	TEST1

feature -- Status Report

	is_po_new: BOOLEAN
			-- Is Current "New"?

		do
			Result := (Current = po_new)
		end

feature {MODEL_THREADED} -- Access

	po_new: STRING
			-- access to status "New"
		do
			if attached internal_po_new as al_po_new then
				Result := al_po_new
			else
				Result := "test"
				internal_po_new := Result
			end
		end

feature -- Implementation

	internal_po_new: detachable STRING
			-- internal storage for `po_new'

	po_new_description: STRING = "New"
			-- String constant for description of po_new

end

