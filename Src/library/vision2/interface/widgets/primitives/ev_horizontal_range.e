indexing 
	description:
		"[
			Interactive horizontal range widget. A sliding thumb displays the
			current `value' and allows it to be adjusted.
		]"
	appearance:
		"[
			+-------------+
			|  |#|        |
			+-------------+
		]"
	status: "See notice at end of class"
	keywords: "range, slide, adjust"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE

inherit
	EV_RANGE
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_RANGE_I
			-- Platform dependent access.
			
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of horizontal range.
		do
			create {EV_HORIZONTAL_RANGE_IMP} implementation.make (Current)
		end

end -- class EV_HORIZONTAL_RANGE

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

