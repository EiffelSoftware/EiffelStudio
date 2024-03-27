note
	description: "Summary description for {GLIB2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLIB2

inherit
	GLIB

feature -- Events		

	frozen events_pending: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_pending (NULL)"
		end

	frozen g_event_iteration: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_iteration(NULL, FALSE)"
		end

	frozen g_main_context_pending (ctx: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_pending ($ctx)"
		end

	frozen g_main_context_iteration (ctx: POINTER; a_may_block: BOOLEAN): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_iteration($ctx, $a_may_block)"
		end

	frozen dispatch_events
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_dispatch(g_main_context_default())"
		end

	frozen g_main_context_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_default()"
		end

	frozen g_main_context_dispatch (a_context: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_dispatch((GMainContext*) $a_context)"
		end

	frozen g_main_context_release (a_context: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_release((GMainContext*) $a_context)"
		end

	frozen g_main_context_acquire (a_context: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_acquire((GMainContext*) $a_context)"
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
