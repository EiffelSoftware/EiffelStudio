indexing
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [G -> EV_CONTAINABLE]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface,
			initialize
		end
		
feature -- Initialization

	initialize is
			-- Initialize the dynamic list.
		do
			create child_array.make (5)
			is_initialized := True
		end

feature -- Access

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		do
			Result := child_array.i_th (i)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			Result := child_array.count
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

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

	list_widget: POINTER is
			-- GtkWidget that holds the list.
		do
			Result := c_object
		end

feature -- Event handling

	on_new_item (an_item: G) is
			-- Called after `an_item' is added.
		deferred
		end

	on_removed_item (an_item: G) is
			-- Called just before `an_item' is removed.
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

