indexing
	description: 
		"Displays two widgets side by side, seperated by an adjustable divider."
	apearance:
		"------------------------------%N%
		%|             ||             |%N%
		%|   `first'   ||   `second'  |%N%
		%|             ||             |%N%
		%------------------------------"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end
	

create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_SPLIT_AREA_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HORIZONTAL_SPLIT_AREA_IMP} implementation.make (Current)
		end
	
end -- class EV_HORIZONTAL_SPLIT_AREA_I

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
