indexing
	description: "Set and get the double-click time for the mouse."
	legal: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_DOUBLE_CLICK

