note
	description: "Start an iPhone application."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_STARTUP

feature

	run
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[
				int retVal;
			    NSAutoreleasePool *pool;
			    
			    pool = [[NSAutoreleasePool alloc] init];
    			retVal = UIApplicationMain(eif_argc, eif_argv, @"UIApplication", @"EiffeliPhoneAppDelegate");
    			[pool release];
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
