class
	TEST1

feature -- Status Report

	is_po_quoted: BOOLEAN
			-- Is Current "Quoted"?

		do
			Result := (Current = po_quoted)
		end

feature {MODEL_THREADED} -- Access

	po_quoted: STRING
			-- access to status "Quoted"
		do
			if attached internal_po_quoted as al_po_quoted then
				Result := al_po_quoted
			else
				Result := "test"
				internal_po_quoted := Result
			end
		end

feature {TEST_SET_HELPER} -- Implementation

	internal_po_quoted: detachable STRING
			-- internal storage for `po_quoted'

	po_quoted_description: STRING = "Quoted"
			-- String constant for description of po_quoted

end

