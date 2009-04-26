note
	description: "Summary description for {NS_SCROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLLER

inherit
	NS_CONTROL
		redefine
			new
		end

create
	new,
	init_with_frame

feature -- Box

	new
			-- Create the window.
		do
			cocoa_object := scroller_new
		end

	init_with_frame (x, y, w, h: INTEGER)
		do
			cocoa_object := scroller_init_with_frame (x, y, w, h)
		end

feature {NONE} -- Objective-C implementation

	frozen scroller_new: POINTER
			-- Create a new NSScroller
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller new];"
		end

	frozen scroller_init_with_frame (x, y, w, h: INTEGER): POINTER
			-- Create a new NSScroller
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [[NSScroller alloc] initWithFrame: NSMakeRect($x, $y, $w, $h)];"
		end

--+ (CGFloat)scrollerWidth;
--+ (CGFloat)scrollerWidthForControlSize:(NSControlSize)controlSize;

--- (void)drawParts;
--- (NSRect)rectForPart:(NSScrollerPart)partCode;
--- (void)checkSpaceForParts;
--- (NSUsableScrollerParts)usableParts;
--- (void)setArrowsPosition:(NSScrollArrowPosition)where;
--- (NSScrollArrowPosition)arrowsPosition;
--- (void)setControlTint:(NSControlTint)controlTint;
--- (NSControlTint)controlTint;
--- (void)setControlSize:(NSControlSize)controlSize;
--- (NSControlSize)controlSize;
--- (void)drawArrow:(NSScrollerArrow)whichArrow highlight:(BOOL)flag;
--- (void)drawKnob;
--- (void)drawKnobSlotInRect:(NSRect)slotRect highlight:(BOOL)flag;
--- (void)highlight:(BOOL)flag;
--- (NSScrollerPart)testPart:(NSPoint)thePoint;
--- (void)trackKnob:(NSEvent *)theEvent;
--- (void)trackScrollButtons:(NSEvent *)theEvent;
--- (NSScrollerPart)hitPart;
--- (CGFloat)knobProportion;
--- (void)setKnobProportion:(CGFloat)proportion;

feature -- Constant

	frozen scroller_width: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller scrollerWidth];"
		end

end
