note
	description: "Summary description for {NS_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT


feature



feature {NONE} -- Objective-C implementation

--+ (NSArray *)screens;		/* All screens; first one is "zero" screen */
--+ (NSScreen *)mainScreen;	/* Screen with key window */
--+ (NSScreen *)deepestScreen;

--- (NSWindowDepth)depth;
--- (NSRect)frame;
--- (NSRect)visibleFrame;
--- (NSDictionary *)deviceDescription;

--- (const NSWindowDepth *)supportedWindowDepths; /* 0 terminated */

--/* Returns scale factor applied by default to windows created on this screen
--*/
--- (CGFloat)userSpaceScaleFactor;

end
