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

