indexing
	description: "Linkable cells containing a reference to their right neighbor"
	external_name: "ISE.Base.Linkable"

class 
	LINKABLE [G] 

inherit
	CELL [G]
		export
			{CELL, CHAIN}
				put
			{ANY}
				item
		end

feature -- Access

	right: LINKABLE [G]
		indexing
			description: "Right neighbor"
		end

feature {CELL, CHAIN} -- Implementation

	put_right (other: LINKABLE [G]) is
		indexing
			description: "Put `other' to the right of current cell."
		do
			right := other
		ensure
			chained: right = other
		end

	forget_right is
		indexing
			description: "Remove right link."
		do
			right := Void
		ensure
			not_chained: right = Void
		end

end -- class LINKABLE



