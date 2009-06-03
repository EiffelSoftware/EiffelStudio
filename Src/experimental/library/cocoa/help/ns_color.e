note
	description: "Wrapper for NSColor."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR

inherit
	NS_OBJECT

create
	blue_color,
	white_color,
	control_color,
	control_background_color,
	control_text_color,
	shadow_color,
	highlight_color,
	color_with_calibrated_red_green_blue_alpha,
	color_with_pattern_image
create {NS_OBJECT}
	make_shared

feature {NONE} -- Creation

	blue_color
		do
			item := color_blue_color
		end

	white_color
		do
			item := color_white_color
		end

	control_color
		do
			item := color_control_color
		end

	control_background_color
		do
			item := color_control_background_color
		end

	control_text_color
		do
			item := color_control_text_color
		end

	shadow_color
		do
			item := color_shadow_color
		end

	highlight_color
		do
			item := color_highlight_color
		end

	color_with_calibrated_red_green_blue_alpha (r, g, b, a: REAL)
		do
			item := color_color_with_calibrated_red_green_blue_alpha (r, g, b, a)
		end

	color_with_pattern_image (a_image: NS_IMAGE)
		do
			item := color_color_with_pattern_image (a_image.item)
		end

feature

	set
		do
			color_set (item)
		end

	set_fill
		do
			color_set_fill (item)
		end

	set_stroke
		do
			color_set_stroke (item)
		end

feature -- Components

	red_component: REAL
		require
			-- Color is of the right type
		do
			Result := color_red_component (item)
		ensure
			0.0 <= Result and Result <= 1.0
		end

	green_component: REAL
		require
			-- Color is of the right type
		do
			Result := color_green_component (item)
		ensure
			0.0 <= Result and Result <= 1.0
		end

	blue_component: REAL
		require
			-- Color is of the right type
		do
			Result := color_blue_component (item)
		ensure
			0.0 <= Result and Result <= 1.0
		end

	color_using_color_space (a_color_space: NS_COLOR_SPACE): NS_COLOR
		do
			Result := create {NS_COLOR}.make_shared (color_color_using_color_space (item, a_color_space.item))
		end

	color_using_color_space_name (a_color_space: NS_STRING): NS_COLOR
		do
			Result := create {NS_COLOR}.make_shared (color_color_using_color_space_name (item, a_color_space.item))
		end

feature {NONE} -- Objective-C implementation

--/* Create NSCalibratedWhiteColorSpace colors.
--*/
--+ (NSColor *)colorWithCalibratedWhite:(CGFloat)white alpha:(CGFloat)alpha;


--/* Create NSCalibratedRGBColorSpace colors.
--*/
--+ (NSColor *)colorWithCalibratedHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
	frozen color_color_with_calibrated_red_green_blue_alpha (r, g, b, a: REAL): POINTER
			--+ (NSColor *)colorWithCalibratedRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor colorWithCalibratedRed:$r green: $g blue: $b alpha: $a];"
		end


--/* Create colors in various device color spaces. In PostScript these colorspaces correspond directly to the device-dependent operators setgray, sethsbcolor, setrgbcolor, and setcmykcolor.
--*/
--+ (NSColor *)colorWithDeviceWhite:(CGFloat)white alpha:(CGFloat)alpha;
--+ (NSColor *)colorWithDeviceHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
--+ (NSColor *)colorWithDeviceRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
--+ (NSColor *)colorWithDeviceCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black alpha:(CGFloat)alpha;


--/* Create named colors from standard color catalogs (such as Pantone).
--*/
--+ (NSColor *)colorWithCatalogName:(NSString *)listName colorName:(NSString *)colorName;


--/* Create colors with arbitrary colorspace. The number of components in the provided array should match the number dictated by the specified colorspace, plus one for alpha (supply 1.0 for opaque colors); otherwise an exception will be raised.  If the colorspace is one which cannot be used with NSColors, nil is returned.
--*/
--+ (NSColor *)colorWithColorSpace:(NSColorSpace *)space components:(const CGFloat *)components count:(NSInteger)numberOfComponents;


--/* Some convenience methods to create colors in the calibrated color spaces...
--*/
--+ (NSColor *)blackColor;	/* 0.0 white */
--+ (NSColor *)darkGrayColor;	/* 0.333 white */
--+ (NSColor *)lightGrayColor;	/* 0.667 white */
	frozen color_white_color: POINTER
			--+ (NSColor *)whiteColor;	/* 1.0 white */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor whiteColor];"
		end
--+ (NSColor *)grayColor;		/* 0.5 white */
--+ (NSColor *)redColor;		/* 1.0, 0.0, 0.0 RGB */
--+ (NSColor *)greenColor;	/* 0.0, 1.0, 0.0 RGB */
	frozen color_blue_color: POINTER
			--+ (NSColor *)blueColor;		/* 0.0, 0.0, 1.0 RGB */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor blueColor];"
		end
--+ (NSColor *)cyanColor;		/* 0.0, 1.0, 1.0 RGB */
--+ (NSColor *)yellowColor;	/* 1.0, 1.0, 0.0 RGB */
--+ (NSColor *)magentaColor;	/* 1.0, 0.0, 1.0 RGB */
--+ (NSColor *)orangeColor;	/* 1.0, 0.5, 0.0 RGB */
--+ (NSColor *)purpleColor;	/* 0.5, 0.0, 0.5 RGB */
--+ (NSColor *)brownColor;	/* 0.6, 0.4, 0.2 RGB */
--+ (NSColor *)clearColor;	/* 0.0 white, 0.0 alpha */

	frozen color_control_shadow_color: POINTER
			--+ (NSColor *)controlShadowColor;		// Dark border for controls
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlShadowColor];"
		end

	frozen color_control_dark_shadow_color: POINTER
			--+ (NSColor *)controlDarkShadowColor;		// Darker border for controls
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlDarkShadowColor];"
		end

	frozen color_control_color: POINTER
			--+ (NSColor *)controlColor;			// Control face and old window background color
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlColor];"
		end

	frozen color_control_highlight_color: POINTER
			--+ (NSColor *)controlHighlightColor;		// Light border for controls
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlHighlightColor];"
		end

	frozen color_control_light_highlight_color: POINTER
			--+ (NSColor *)controlLightHighlightColor;	// Lighter border for controls
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlLightHighlightColor];"
		end

	frozen color_control_background_color: POINTER
			--+ (NSColor *)controlBackgroundColor;		// Background of large controls (browser, tableview, clipview, ...)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlBackgroundColor];"
		end

	frozen color_control_text_color: POINTER
			--+ (NSColor *)controlTextColor;			// Text on controls
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlTextColor];"
		end

--+ (NSColor *)selectedControlColor;		// Control face for selected controls
--+ (NSColor *)secondarySelectedControlColor;	// Color for selected controls when control is not active (that is, not focused)
--+ (NSColor *)selectedControlTextColor;		// Text on selected controls
--+ (NSColor *)disabledControlTextColor;		// Text on disabled controls
--+ (NSColor *)textColor;				// Document text
--+ (NSColor *)textBackgroundColor;		// Document text background
--+ (NSColor *)selectedTextColor;			// Selected document text
--+ (NSColor *)selectedTextBackgroundColor;	// Selected document text background
--+ (NSColor *)gridColor;				// Grids in controls
--+ (NSColor *)keyboardFocusIndicatorColor;	// Keyboard focus ring around controls
--+ (NSColor *)windowBackgroundColor;		// Background fill for window contents

--+ (NSColor *)scrollBarColor;			// Scroll bar slot color
--+ (NSColor *)knobColor;     			// Knob face color for controls
--+ (NSColor *)selectedKnobColor;       		// Knob face color for selected controls

--+ (NSColor *)windowFrameColor;			// Window frames
--+ (NSColor *)windowFrameTextColor;		// Text on window frames

--+ (NSColor *)selectedMenuItemColor;		// Highlight color for menus
--+ (NSColor *)selectedMenuItemTextColor;		// Highlight color for menu text

	frozen color_highlight_color: POINTER
			--+ (NSColor *)highlightColor;     	     	// Highlight color for UI elements (this is abstract and defines the color all highlights tend toward)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor highlightColor];"
		end

	frozen color_shadow_color: POINTER
			--+ (NSColor *)shadowColor;     			// Shadow color for UI elements (this is abstract and defines the color all shadows tend toward)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor shadowColor];"
		end

--+ (NSColor *)headerColor;			// Background color for header cells in Table/OutlineView
--+ (NSColor *)headerTextColor;			// Text color for header cells in Table/OutlineView

--+ (NSColor *)alternateSelectedControlColor;	// Similar to selectedControlColor; for use in lists and tables
--+ (NSColor *)alternateSelectedControlTextColor;		// Similar to selectedControlTextColor; see alternateSelectedControlColor

--+ (NSArray *)controlAlternatingRowBackgroundColors;	// Standard colors for alternating colored rows in tables and lists (for instance, light blue/white; don't assume just two colors)

--- (NSColor *)highlightWithLevel:(CGFloat)val;	// val = 0 => receiver, val = 1 => highlightColor
--- (NSColor *)shadowWithLevel:(CGFloat)val;	// val = 0 => receiver, val = 1 => shadowColor

--+ (NSColor *)colorForControlTint:(NSControlTint)controlTint;	// pass in valid tint to get rough color matching. returns default if invalid tint

--+ (NSControlTint) currentControlTint;	// returns current system control tint


	frozen color_set (a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_color set];"
		end

	frozen color_set_fill (a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_color setFill];"
		end

	frozen color_set_stroke (a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_color setStroke];"
		end

--/* Get the color space of the color. Should be implemented by subclassers.
--*/
--- (NSString *)colorSpaceName;


--/* Convert the color to another colorspace, using a colorspace name. This may return nil if the specified conversion cannot be done. The abstract implementation of this method returns the receiver if the specified colorspace matches that of the receiver; otherwise it returns nil. Subclassers who can convert themselves to other colorspaces override this method to do something better.

--The version of this method which takes a device description allows the color to specialize itself for the given device.  Device descriptions can be obtained from windows, screens, and printers with the "deviceDescription" method.

--If device is nil then the current device (as obtained from the currently lockFocus'ed view's window or, if printing, the current printer) is used. The method without the device: argument passes nil for the device.

--If colorSpace is nil, then the most appropriate color space is used.
--*/
	frozen color_color_using_color_space_name (a_color: POINTER; a_color_space: POINTER): POINTER
			--- (NSColor *)colorUsingColorSpaceName:(NSString *)colorSpace;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color colorUsingColorSpaceName: $a_color_space];"
		end
--- (NSColor *)colorUsingColorSpaceName:(NSString *)colorSpace device:(NSDictionary *)deviceDescription;


--/* colorUsingColorSpace: will convert existing color to a new colorspace and create a new color, which will likely have different component values but look the same. It will return the same color if the colorspace is already the same as the one specified.  Will return nil if conversion is not possible.
--*/
	frozen color_color_using_color_space (a_color: POINTER; a_color_space: POINTER): POINTER
			--- (NSColor *)colorUsingColorSpace:(NSColorSpace *)space;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color colorUsingColorSpace: $a_color_space];"
		end


--/* Blend using the NSCalibratedRGB color space. Both colors are converted into the calibrated RGB color space, and they are blended by taking fraction of color and 1 - fraction of the receiver. The result is in the calibrated RGB color space. If the colors cannot be converted into the calibrated RGB color space the blending fails and nil is returned.
--*/
--- (NSColor *)blendedColorWithFraction:(CGFloat)fraction ofColor:(NSColor *)color;


--/* Returns a color in the same color space as the receiver with the specified alpha component. The abstract implementation of this method returns the receiver if alpha is 1.0, otherwise it returns nil; subclassers who have explicit opacity components override this method to actually return a color with the specified alpha.
--*/
--- (NSColor *)colorWithAlphaComponent:(CGFloat)alpha;


--/*** Methods to get various components of colors. Not all of the methods apply to all colors; if called, they raise. ***/

--/* Get the catalog and color name of standard colors from catalogs. These colors are special colors which are usually looked up on each device by their name.
--*/
--- (NSString *)catalogNameComponent;
--- (NSString *)colorNameComponent;

--/* Return localized versions of the above.
--*/
--- (NSString *)localizedCatalogNameComponent;
--- (NSString *)localizedColorNameComponent;

--/* Get the red, green, or blue components of NSCalibratedRGB or NSDeviceRGB colors.
--*/
	frozen color_red_component (a_color: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color redComponent];"
		end

	frozen color_green_component (a_color: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color greenComponent];"
		end

	frozen color_blue_component (a_color: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color blueComponent];"
		end
--- (void)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

--/* Get the components of NSCalibratedRGB or NSDeviceRGB colors as hue, saturation, or brightness.
--*/
--- (CGFloat)hueComponent;
--- (CGFloat)saturationComponent;
--- (CGFloat)brightnessComponent;
--- (void)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha;


--/* Get the white component of NSCalibratedWhite or NSDeviceWhite colors.
--*/
--- (CGFloat)whiteComponent;
--- (void)getWhite:(CGFloat *)white alpha:(CGFloat *)alpha;


--/* Get the CMYK components of NSDeviceCMYK colors.
--*/
--- (CGFloat)cyanComponent;
--- (CGFloat)magentaComponent;
--- (CGFloat)yellowComponent;
--- (CGFloat)blackComponent;
--- (void)getCyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha;


--/* For colors with custom colorspace; get the colorspace and individual floating point components, including alpha. Note that all these methods will work for other NSColors which have floating point components. They will raise exceptions otherwise, like other existing colorspace-specific methods.
--*/
--- (NSColorSpace *)colorSpace;
--- (NSInteger)numberOfComponents;
--- (void)getComponents:(CGFloat *)components;


--/* Get the alpha component. For colors which do not have alpha components, this will return 1.0 (opaque).
--*/
--- (CGFloat)alphaComponent;


--/* Pasteboard methods
--*/
--+ (NSColor *)colorFromPasteboard:(NSPasteboard *)pasteBoard;
--- (void)writeToPasteboard:(NSPasteboard *)pasteBoard;

--/* Pattern methods. Note that colorWithPatternImage: mistakenly returns a non-autoreleased color in 10.1.x and earlier. This has been fixed in (NSAppKitVersionNumber >= NSAppKitVersionNumberWithPatternColorLeakFix), for apps linked post-10.1.x.
--*/
	frozen color_color_with_pattern_image (a_image: POINTER): POINTER
			--+ (NSColor *)colorWithPatternImage:(NSImage*)image;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor colorWithPatternImage: $a_image];"
		end
--- (NSImage *)patternImage;

--/* Draws the color and adorns it to indicate the type of color. Used by colorwells, swatches, and other UI objects that need to display colors. Implementation in NSColor simply draws the color (with an indication of transparency if the color isn't fully opaque); subclassers can draw more stuff as they see fit.
--*/
--- (void)drawSwatchInRect:(NSRect)rect;


--/* Global flag for determining whether an application supports alpha.  This flag is consulted when an application imports alpha (through color dragging, for instance). The value of this flag also determines whether the color panel has an opacity slider. This value is YES by default, indicating that the opacity components of imported colors will be set to 1.0. If an application wants alpha, it can either set the "NSIgnoreAlpha" default to NO or call the set method below.

--This method provides a global approach to removing alpha which might not always be appropriate. Applications which need to import alpha sometimes should set this flag to NO and explicitly make colors opaque in cases where it matters to them.
--*/
--+ (void)setIgnoresAlpha:(BOOL)flag;
--+ (BOOL)ignoresAlpha;

--@end


--#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_4
--@interface NSColor (NSQuartzCoreAdditions)
--+ (NSColor *)colorWithCIColor:(CIColor *)color;
--@end

--@interface CIColor (NSAppKitAdditions)
--- (id)initWithColor:(NSColor *)color;
--@end
--#endif /* MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_4 */

--@interface NSCoder(NSAppKitColorExtensions)

--/* To decode NXColors... Will return nil if the archived color was "invalid" (written out by the kit in a few instances). Otherwise returns autoreleased NSColor. Can't write NSColors as NXColors, so we have no corresponding encode method.
--*/
--- (NSColor *)decodeNXColor;

end
