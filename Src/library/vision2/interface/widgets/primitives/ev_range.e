indexing 
	description:
		"[
			Interactive range widget. A sliding thumb displays the current `value'
			and allows it to be adjusted.
			See EV_HORIZONTAL_RANGE and EV_VERTICAL_RANGE.
		]"
	status: "See notice at end of class"
	keywords: "range, slide, adjust"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_RANGE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_RANGE

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

