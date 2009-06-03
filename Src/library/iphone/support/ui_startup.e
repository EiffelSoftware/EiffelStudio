note
	description: "Start an iPhone application."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_STARTUP

create
	make

feature {NONE} -- Initialization

	make
		do
			create dispatcher.make
		end

feature -- Event loop

	run
		local
			l_res: INTEGER
		do
			l_res := c_run
		end

feature {NONE} -- Externals

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

feature {NONE} -- Implementation

	dispatcher: UI_DISPATCHER
			-- Handling of events.

invariant

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
