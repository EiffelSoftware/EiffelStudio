note
	description: "Wrapper for NSScreen."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT

create
	main_screen
create {NS_OBJECT}
	make_shared

feature {NONE} -- Getting NSScreen Objects

	main_screen
		do
			make_shared (screen_main_screen)
		end

feature -- Getting Screen Information

	frame: NS_RECT
		do
			create Result.make
			screen_frame (item, Result.item)
		end

	device_description: NS_DICTIONARY
		do
			create Result.make_shared (screen_device_description (item))
		end

feature {NONE} -- Objective-C implementation

	frozen screen_screens: POINTER
			--+ (NSArray *)screens;		/* All screens; first one is "zero" screen */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen mainScreen];"
		end

	frozen screen_main_screen: POINTER
			--+ (NSScreen *)mainScreen;	/* Screen with key window */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen mainScreen];"
		end

	frozen screen_deepest_screen: POINTER
			--+ (NSScreen *)deepestScreen;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen deepestScreen];"
		end

--- (NSWindowDepth)depth;
	frozen screen_frame (a_screen: POINTER; a_res: POINTER)
			--- (NSRect)frame;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSScreen*)$a_screen frame];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen screen_visible_frame (a_screen: POINTER; a_res: POINTER)
			--- (NSRect)visibleFrame;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSScreen*)$a_screen visibleFrame];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen screen_device_description (a_screen: POINTER): POINTER
			--- (NSDictionary *)deviceDescription;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScreen*)$a_screen deviceDescription];"
		end

--- (const NSWindowDepth *)supportedWindowDepths; /* 0 terminated */

--/* Returns scale factor applied by default to windows created on this screen
--*/
--- (CGFloat)userSpaceScaleFactor;

end
