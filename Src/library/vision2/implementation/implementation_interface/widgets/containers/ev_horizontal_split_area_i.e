indexing
	description:
		"Displays two widgets side by side, seperated by an adjustable divider."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HORIZONTAL_SPLIT_AREA_I

inherit
	
	EV_SPLIT_AREA_I
		redefine
			interface
		end

feature

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		do
			if first_visible then
				Result := first.minimum_width
			end
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		local
			a_sec_width: INTEGER
		do
			if second_visible then
				a_sec_width := second.minimum_width
			end
			Result := width - a_sec_width - splitter_width
			if Result < minimum_split_position then
				Result := minimum_split_position
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SPLIT_AREA

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.7  2000/08/08 18:17:45  manus
--| Moved `first_visible' and `second_visible' to EV_SPLIT_AREA_I since it is needed for
--| `EV_HORIZONTAL_SPLIT_AREA_I' and `EV_VERTICAL_SPLIT_AREA_I' to compute a correct
--| `minimum_split_position' and `maximum_split_position'. This is only exported to
--| EV_SPLIT_AREA_I and descendants, not to the interface.
--|
--| Revision 1.5.4.6  2000/08/02 18:27:39  rogers
--| Comments, formatting, Added CVS log and copyright clause.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

