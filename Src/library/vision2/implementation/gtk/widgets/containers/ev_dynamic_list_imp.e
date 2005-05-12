indexing
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [reference G -> EV_CONTAINABLE]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end
		
feature -- Initialization

	initialize is
			-- Initialize the dynamic list.
		do
			create child_array.make (5)
			set_is_initialized (True)
		end

feature -- Access

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		do
			if child_array /= Void then
				Result := child_array.i_th (i)
			end	
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			if child_array /= Void then
				Result := child_array.count
			end	
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		deferred
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		deferred
		end

feature {NONE} -- Implementation

	child_array: ARRAYED_LIST [G]

	interface: EV_DYNAMIC_LIST [G]

invariant

	child_array_not_void: is_usable implies child_array /= Void

end -- class EV_DYNAMIC_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

