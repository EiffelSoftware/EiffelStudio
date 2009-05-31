note
	description: "Main dispatcher for iPhone events."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_DISPATCHER

create
	make

feature {NONE} -- Initialization

	make
		do
			c_set_dispatcher (Current, $dispatcher)
		end

feature -- Dispatching

	dispatcher (a_msg: INTEGER; a_data: POINTER)
		do
		end

feature {NONE} -- C externals

	c_set_dispatcher (a_disp: ANY; a_proc: POINTER)
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"eiffel_iphone_set_dispatcher($a_disp, (EIF_NOTIFY_PROC) $a_proc);"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
