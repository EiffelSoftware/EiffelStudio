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
	EV_AGGREGATE_CELL

inherit
	EV_CELL
		redefine
			parent_of_items_is_current
		end

create
	make_with_real_parent

feature {NONE} -- Initialization

	make_with_real_parent (a_real_parent: EV_CONTAINER) is
		do
			default_create
			real_parent := a_real_parent
		end

feature {EV_ANY_I} -- Implementation

	real_parent: EV_CONTAINER
		-- The actual widget parent that is seen by the user.

feature {NONE} -- Invariant

	parent_of_items_is_current: BOOLEAN is
		do
			Result := True
			if item /= Void then
				if item.parent /= real_parent then
					Result := False
				end
			end
		end

end -- class EV_AGGREGATE_CELL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
