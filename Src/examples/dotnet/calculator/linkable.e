indexing
	description: "Linkable cells containing a reference to their right neighbor"
	external_name: "ISE.Examples.Calculator.Linkable"

class 
	LINKABLE [G]

feature -- Access

	right: like Current
		indexing
			description: "Right neighbor"
			external_name: "Right"
		end

	item: G
		indexing
			description: "Object stored in current cell"
			external_name: "Item"
		end

feature -- Element change

	replace (v: like item) is
		indexing
			description: "Make `v' the cell's `item'."
			external_name: "Replace"
		require
			non_void_item: v /= Void
		do
			item := v
		ensure
			item_inserted: item = v
		end
	
feature {LINKED_STACK} -- Element change

	put (v: like item) is
		indexing
			description: "Make `v' the cell's `item'."
			external_name: "Put"
		require
			non_void_item: v /= Void
		do
			item := v
		ensure
			item_inserted: item = v
		end

feature {LINKED_STACK} -- Implementation

	put_right (other: like Current) is
		indexing
			description: "Put `other' to the right of current cell."
			external_name: "PutRight"
		require
			non_void_item: other /= Void
		do
			right := other
		ensure
			chained: right = other
		end

	forget_right is
		indexing
			description: "Remove right link."
			external_name: "ForgetRight"
		do
			right := Void
		ensure
			not_chained: right = Void
		end

end -- class LINKABLE


--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

