note
	description: "Summary description for {NS_SLIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SLIDER

inherit
	NS_CONTROL
		redefine
			new
		end

create
	new

feature

	new
		do
			cocoa_object := slider_new
		end

	set_min_value (a_value: DOUBLE)
		do
			slider_set_min_value (cocoa_object, a_value)
		end

	set_max_value (a_value: DOUBLE)
		do
			slider_set_max_value (cocoa_object, a_value)
		end

feature {NONE} -- Objective-C implementation

	frozen slider_new: POINTER
			-- Create a new NSSlider
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSlider new];"
		end

--- (double)minValue;
	frozen slider_set_min_value (a_slider: POINTER; a_double: DOUBLE)
			--- (void)setMinValue:(double)aDouble;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSlider*) $a_slider setMinValue: $a_double];"
		end

--- (double)maxValue;
	frozen slider_set_max_value (a_slider: POINTER; a_double: DOUBLE)
			--- (void)setMaxValue:(double)aDouble;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSlider*) $a_slider setMaxValue: $a_double];"
		end
--- (void)setAltIncrementValue:(double)incValue;
--- (double)altIncrementValue;
--- (void)setTitleCell:(NSCell *)aCell;
--- (id)titleCell;
--- (void)setTitleColor:(NSColor *)newColor;
--- (NSColor *)titleColor;
--- (void)setTitleFont:(NSFont *)fontObj;
--- (NSFont *)titleFont;
--- (NSString *)title;
--- (void)setTitle:(NSString *)aString;
--- (void)setKnobThickness:(CGFloat)aFloat;
--- (CGFloat)knobThickness;
--- (void)setImage:(NSImage *)backgroundImage;
--- (NSImage *)image;
--- (NSInteger)isVertical;
--- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent;



--@interface NSSlider(NSTickMarkSupport)

--// For setting and retrieving the number of tick marks on a slider.
--//   0 indicates no tick marks are present, which is the default
--- (void)setNumberOfTickMarks:(NSInteger)count;
--- (NSInteger)numberOfTickMarks;

--// For setting and retrieving the position tick marks will be displayed in.
--//   This has no effect if numberOfTickMarks is 0.
--- (void)setTickMarkPosition:(NSTickMarkPosition)position;
--- (NSTickMarkPosition)tickMarkPosition;

--// For setting and retrieving whether values on the slider can be anything
--//   the slider normally allows, or only values that correspond to a tick mark.
--//   This has no effect if numberOfTickMarks is 0.
--- (void)setAllowsTickMarkValuesOnly:(BOOL)yorn;
--- (BOOL)allowsTickMarkValuesOnly;

--// Determine the slider value for a particular tick mark.
--//   An NSRangeException will be raised if the index is invalid.
--- (double)tickMarkValueAtIndex:(NSInteger)index;

--// Determine the bounding rectangle of a particular tick mark.
--//   An NSRangeException will be raised if the index is invalid.
--- (NSRect)rectOfTickMarkAtIndex:(NSInteger)index;

--// Determine whether a particular point is "near" a tick mark and return its
--// index if so.  NSNotFound will be returned if no tick mark is close enough
--// to qualify.
--- (NSInteger)indexOfTickMarkAtPoint:(NSPoint)point;

--- (double)closestTickMarkValueToValue:(double)value;



end
