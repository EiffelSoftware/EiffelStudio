indexing
	description: 
		"Displays two widgets one above the other separated by an adjustable%
		%divider"
	appearance:
		"---------------%N%
		%|             |%N%
		%|   'first'   |%N%
		%|             |%N%
		%|_____________|%N%
		%|-------------|%N%
		%|             |%N%
		%|   `second'  |%N%
		%|             |%N%
		%---------------"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end 
	
create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_SPLIT_AREA_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_SPLIT_AREA_IMP} implementation.make (Current)
		end

end -- class EV_VERTICAL_SPLIT_AREA 

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

