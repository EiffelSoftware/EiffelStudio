indexing
	description: "Set and get the double-click time for the mouse."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DOUBLE_CLICK

feature -- Status report

	double_click_time: INTEGER is
			-- Current double-click time for the mouse (in milliseconds)
		do
			Result := cwin_get_double_click_time
		ensure
			positive_result: Result > 0
		end

feature -- Status setting

	set_double_click_time (time: INTEGER) is
			-- Set `double_click_time' with `time' (in milliseconds).
		require
			positive_time: time > 0
		do
			cwin_set_double_click_time (time)
		ensure
			double_click_time_set: double_click_time = time
		end

feature {NONE} -- Externals

	cwin_get_double_click_time: INTEGER is
			-- SDK GetDoubleClickTime
		external
			"C [macro <wel.h>]: EIF_INTEGER"
		alias
			"GetDoubleClickTime ()"
		end

	cwin_set_double_click_time (time: INTEGER) is
			-- SDK SetDoubleClickTime
		external
			"C [macro <wel.h>] (UINT)"
		alias
			"SetDoubleClickTime"
		end

end -- class WEL_DOUBLE_CLICK


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

