indexing
	description: 
		"Container that holds only one widget."
	appearance:
		"---------------%N%
		%|             |%N%
		%|   `item'    |%N%
		%|             |%N%
		%---------------"
	status: "See notice at end of class"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_CELL

inherit
	EV_CONTAINER
		redefine
			implementation
		end

create
	default_create

feature -- Access

	has (v: EV_WIDGET): BOOLEAN is
			-- Does `Current' include `v'?
		do
			Result := not is_destroyed and
				(v /= Void and then implementation.item = v)	
		end

feature -- Status report

	is_empty, extendible: BOOLEAN is
			-- Is there no element?
		do
			Result := implementation.item = Void and not is_destroyed
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := implementation.item /= Void and not is_destroyed
		end

	prunable: BOOLEAN is
			-- May items be removed?
		do
			Result := not is_destroyed
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not is_destroyed
		end

	readable: BOOLEAN is
			-- Is there a current item that may be accessed?
		do
			Result := full and not is_destroyed
		end
		
	count: INTEGER is
			-- Number of items in `Current'.
		do
			if full then
				Result := 1
			end
		ensure then
			valid_result: Result = 0 or Result = 1
		end
		

feature -- Removal

	prune (v: EV_WIDGET) is
			-- Remove `v' if contained.
		do
			if item = v then
				wipe_out
			end
		ensure then
			not has (v)
		end

	wipe_out is
			-- Remove `item'.
		do
			implementation.replace (Void)
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if implementation.item /= Void then
				l.extend (implementation.item)
			end
			Result := l
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_CELL_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of `Current'.
		do
			create {EV_CELL_IMP} implementation.make (Current) 
		end

end -- class EV_CELL

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
