indexing
	description:
		"Displays two widgets one above the other separated by an adjustable%
		%divider"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VERTICAL_SPLIT_AREA_I

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
				Result := first.minimum_height
			end
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		local
			a_sec_height: INTEGER
		do
			if second_visible then
				a_sec_height := second.minimum_height
			end
			Result := height - a_sec_height - splitter_width
			if Result < minimum_split_position then
				Result := minimum_split_position
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SPLIT_AREA

end -- class EV_HORIZONTAL_SPLIT_AREA_I

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

