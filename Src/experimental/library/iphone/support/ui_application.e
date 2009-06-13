note
	description: "[
		Represent the current application object responsible of event handling. To get an instance, you need
		to use {SHARED_UI_APPLICATION}.application.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	UI_APPLICATION

inherit
	NS_OBJECT
		redefine
			default_create
		end

	UI_ENVIRONMENT
		export
			{NONE} all
		undefine
			default_create
		end

create {UI_ENVIRONMENT}
	default_create,
	share_from_pointer

feature {NONE} -- Initialization

	default_create
			-- Initialize Current by setting up UI_ENVIRONMENT and callbacks.
		do
			c_set_dispatcher (Current, $dispatcher)
			application_cell.put (Current)
		end

feature -- Basic operations

	launch
			-- Start the event loop for current.
		local
			l_res: INTEGER
		do
			l_res := c_run
		end

feature -- Action sequences

	post_launch_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions executed when application starts
		do
			if attached post_launch_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				post_launch_actions_internal := Result
			end
		end

feature {NONE} -- Implementation

	post_launch_actions_internal: detachable like post_launch_actions note option: stable attribute end
			-- Storage for `launch_actions'

feature {NONE} -- Dispatching

	dispatcher (a_msg: NATURAL; a_data: POINTER)
		do
			inspect a_msg
			when {UI_DISPATCHER_CONST}.ui_application_did_finish_launching then
				post_launch_actions.call (Void)
			else
			end
		end

feature {NONE} -- Externals

	c_set_dispatcher (a_disp: ANY; a_proc: POINTER)
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"eiffel_iphone_set_dispatcher($a_disp, (EIF_NOTIFY_PROC) $a_proc);"
		end

	c_run: INTEGER
		external
			"C inline use <UIKit/UIKit.h>, %"eif_argv.h%""
		alias
			"[
				int retVal;
			    NSAutoreleasePool *pool;
			    
			    pool = [[NSAutoreleasePool alloc] init];
    			retVal = UIApplicationMain(eif_argc, eif_argv, @"UIApplication", @"EiffeliPhoneAppDelegate");
    			[pool release];
    			
    			return retVal;
			]"
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
