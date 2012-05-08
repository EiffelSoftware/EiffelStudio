class
	PROXY_TEST1

create 
	make

feature -- Status Report

	is_po_quoted: BOOLEAN

	item: TEST1

feature {NONE} -- Creation

	make (a_object: like item)
		do
			item := a_object
			is_po_quoted := item.is_po_quoted
		end

end

