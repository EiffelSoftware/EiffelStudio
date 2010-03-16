note
	description: "Summary description for {NS_PROGRESS_INDICATOR_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROGRESS_INDICATOR_API

feature -- Creation

	frozen new: POINTER
			-- Create a new NSProgressIndicator
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSProgressIndicator new];"
		end

feature -- Animating the Progress Indicator

--- (BOOL)usesThreadedAnimation;				// returns YES if the PI uses a thread instead of a timer (default in NO)
--- (void)setUsesThreadedAnimation:(BOOL)threadedAnimation;

	frozen start_animation (a_progress_indicator: POINTER)
			-- - (void)startAnimation:(id)sender;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*) $a_progress_indicator startAnimation: nil];"
		end

	frozen stop_animation (a_progress_indicator: POINTER)
			--- (void)stopAnimation:(id)sender;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*) $a_progress_indicator stopAnimation: nil];"
		end

--//================================================================================
--//	NSprogressIndicator can support any size (for both determinate and indeterminate).
--//	But to get the best result the height of a progress indicator should be as follow:
--//
--//           	    with bezel    without bezel
--//	small		10		8	
--//	regular		14		12	
--//	large		18		16
--//	Aqua		12		12

--enum {
--    NSProgressIndicatorPreferredThickness 	= 14,
--    NSProgressIndicatorPreferredSmallThickness 	= 10,
--    NSProgressIndicatorPreferredLargeThickness	= 18,
--    NSProgressIndicatorPreferredAquaThickness	= 12
--};
--typedef NSUInteger NSProgressIndicatorThickness;


--enum {
--    NSProgressIndicatorBarStyle = 0,
--    NSProgressIndicatorSpinningStyle = 1
--};
--typedef NSUInteger NSProgressIndicatorStyle;

--	/* Options */

feature -- Advancing the Progress Bar



feature -- Setting the Appearance

--- (BOOL)isIndeterminate;				
	frozen set_indeterminate (a_progress_indicator: POINTER; a_flag: BOOLEAN)
			-- - (void)setIndeterminate:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*) $a_progress_indicator setIndeterminate: $a_flag];"
		end

--- (BOOL)isBezeled;
--- (void)setBezeled:(BOOL)flag;

--- (NSControlTint)controlTint;
--- (void)setControlTint:(NSControlTint)tint;

--- (NSControlSize)controlSize;
--- (void)setControlSize:(NSControlSize)size;

--	/* Determinate progress indicator */

--- (double)doubleValue;
	frozen set_double_value (a_progress_indicator: POINTER; a_double: DOUBLE)
			-- - (void)setDoubleValue:(double)doubleValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*)$a_progress_indicator setDoubleValue: $a_double];"
		end

--- (void)incrementBy:(double)delta;			// equivalent to [self setDoubleValue:[self doubleValue] + delta]

--- (double)minValue;
--- (double)maxValue;
	frozen set_min_value (a_progress_indicator: POINTER; a_double: DOUBLE)
			-- - (void)setMinValue:(double)newMinimum;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*) $a_progress_indicator setMinValue: $a_double];"
		end

	frozen set_max_value (a_progress_indicator: POINTER; a_double: DOUBLE)
			-- - (void)setMaxValue:(double)newMaximum;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSProgressIndicator*) $a_progress_indicator setMaxValue: $a_double];"
		end

--	/* Indeterminate progress indicator */

--- (NSTimeInterval)animationDelay;			// in seconds
--- (void)setAnimationDelay:(NSTimeInterval)delay;	// in seconds

--- (void) setStyle: (NSProgressIndicatorStyle) style;
--- (NSProgressIndicatorStyle) style;

--// For the spinning style, it will size the spinning arrows to their default size.
--// For the bar style, the height will be set to the recommended height.
--- (void) sizeToFit;

--- (BOOL) isDisplayedWhenStopped;
--- (void) setDisplayedWhenStopped: (BOOL) isDisplayed;

end
