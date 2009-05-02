note
	description: "Summary description for {NS_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT

create
	make_shared

feature

	frame: NS_RECT
		do
			create Result.make
			screen_frame (cocoa_object, Result.item)
		end

feature {NONE} -- Objective-C implementation

--+ (NSArray *)screens;		/* All screens; first one is "zero" screen */
--+ (NSScreen *)mainScreen;	/* Screen with key window */
--+ (NSScreen *)deepestScreen;

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
--- (NSRect)visibleFrame;
--- (NSDictionary *)deviceDescription;

--- (const NSWindowDepth *)supportedWindowDepths; /* 0 terminated */

--/* Returns scale factor applied by default to windows created on this screen
--*/
--- (CGFloat)userSpaceScaleFactor;

end
