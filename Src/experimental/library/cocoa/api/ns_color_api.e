note
	description: "Summary description for {NS_COLOR_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_API

feature -- Objective-C implementation

	frozen color_with_calibrated_red_green_blue_alpha (r, g, b, a: REAL): POINTER
			--+ (NSColor *)colorWithCalibratedRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor colorWithCalibratedRed:$r green: $g blue: $b alpha: $a];"
		end

	frozen black_color : POINTER
			-- + (NSColor *)blackColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor blackColor];"
		end

	frozen dark_gray_color : POINTER
			-- + (NSColor *)darkGrayColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor darkGrayColor];"
		end

	frozen light_gray_color : POINTER
			-- + (NSColor *)lightGrayColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor lightGrayColor];"
		end

	frozen white_color : POINTER
			-- + (NSColor *)whiteColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor whiteColor];"
		end

	frozen gray_color : POINTER
			-- + (NSColor *)grayColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor grayColor];"
		end

	frozen red_color : POINTER
			-- + (NSColor *)redColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor redColor];"
		end

	frozen green_color : POINTER
			-- + (NSColor *)greenColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor greenColor];"
		end

	frozen blue_color : POINTER
			-- + (NSColor *)blueColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor blueColor];"
		end

	frozen cyan_color : POINTER
			-- + (NSColor *)cyanColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor cyanColor];"
		end

	frozen yellow_color : POINTER
			-- + (NSColor *)yellowColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor yellowColor];"
		end

	frozen magenta_color : POINTER
			-- + (NSColor *)magentaColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor magentaColor];"
		end

	frozen orange_color : POINTER
			-- + (NSColor *)orangeColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor orangeColor];"
		end

	frozen purple_color : POINTER
			-- + (NSColor *)purpleColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor purpleColor];"
		end

	frozen brown_color : POINTER
			-- + (NSColor *)brownColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor brownColor];"
		end

	frozen clear_color : POINTER
			-- + (NSColor *)clearColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor clearColor];"
		end

	frozen control_shadow_color : POINTER
			-- + (NSColor *)controlShadowColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlShadowColor];"
		end

	frozen control_dark_shadow_color : POINTER
			-- + (NSColor *)controlDarkShadowColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlDarkShadowColor];"
		end

	frozen control_color : POINTER
			-- + (NSColor *)controlColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlColor];"
		end

	frozen control_highlight_color : POINTER
			-- + (NSColor *)controlHighlightColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlHighlightColor];"
		end

	frozen control_light_highlight_color : POINTER
			-- + (NSColor *)controlLightHighlightColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlLightHighlightColor];"
		end

	frozen control_text_color : POINTER
			-- + (NSColor *)controlTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlTextColor];"
		end

	frozen control_background_color : POINTER
			-- + (NSColor *)controlBackgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlBackgroundColor];"
		end

	frozen selected_control_color : POINTER
			-- + (NSColor *)selectedControlColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedControlColor];"
		end

	frozen secondary_selected_control_color : POINTER
			-- + (NSColor *)secondarySelectedControlColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor secondarySelectedControlColor];"
		end

	frozen selected_control_text_color : POINTER
			-- + (NSColor *)selectedControlTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedControlTextColor];"
		end

	frozen disabled_control_text_color : POINTER
			-- + (NSColor *)disabledControlTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor disabledControlTextColor];"
		end

	frozen text_color : POINTER
			-- + (NSColor *)textColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor textColor];"
		end

	frozen text_background_color : POINTER
			-- + (NSColor *)textBackgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor textBackgroundColor];"
		end

	frozen selected_text_color : POINTER
			-- + (NSColor *)selectedTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedTextColor];"
		end

	frozen selected_text_background_color : POINTER
			-- + (NSColor *)selectedTextBackgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedTextBackgroundColor];"
		end

	frozen grid_color : POINTER
			-- + (NSColor *)gridColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor gridColor];"
		end

	frozen keyboard_focus_indicator_color : POINTER
			-- + (NSColor *)keyboardFocusIndicatorColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor keyboardFocusIndicatorColor];"
		end

	frozen window_background_color : POINTER
			-- + (NSColor *)windowBackgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor windowBackgroundColor];"
		end

	frozen scroll_bar_color : POINTER
			-- + (NSColor *)scrollBarColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor scrollBarColor];"
		end

	frozen knob_color : POINTER
			-- + (NSColor *)knobColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor knobColor];"
		end

	frozen selected_knob_color : POINTER
			-- + (NSColor *)selectedKnobColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedKnobColor];"
		end

	frozen window_frame_color : POINTER
			-- + (NSColor *)windowFrameColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor windowFrameColor];"
		end

	frozen window_frame_text_color : POINTER
			-- + (NSColor *)windowFrameTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor windowFrameTextColor];"
		end

	frozen selected_menu_item_color : POINTER
			-- + (NSColor *)selectedMenuItemColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedMenuItemColor];"
		end

	frozen selected_menu_item_text_color : POINTER
			-- + (NSColor *)selectedMenuItemTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor selectedMenuItemTextColor];"
		end

	frozen highlight_color : POINTER
			-- + (NSColor *)highlightColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor highlightColor];"
		end

	frozen shadow_color : POINTER
			-- + (NSColor *)shadowColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor shadowColor];"
		end

	frozen header_color : POINTER
			-- + (NSColor *)headerColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor headerColor];"
		end

	frozen header_text_color : POINTER
			-- + (NSColor *)headerTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor headerTextColor];"
		end

	frozen alternate_selected_control_color : POINTER
			-- + (NSColor *)alternateSelectedControlColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor alternateSelectedControlColor];"
		end

	frozen alternate_selected_control_text_color : POINTER
			-- + (NSColor *)alternateSelectedControlTextColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor alternateSelectedControlTextColor];"
		end

	frozen control_alternating_row_background_colors : POINTER
			-- + (NSArray *)controlAlternatingRowBackgroundColors
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor controlAlternatingRowBackgroundColors];"
		end

	frozen color_using_color_space_name (a_color: POINTER; a_color_space: POINTER): POINTER
			--- (NSColor *)colorUsingColorSpaceName:(NSString *)colorSpace;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color colorUsingColorSpaceName: $a_color_space];"
		end

	frozen color_using_color_space (a_color: POINTER; a_color_space: POINTER): POINTER
			--- (NSColor *)colorUsingColorSpace:(NSColorSpace *)space;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_color colorUsingColorSpace: $a_color_space];"
		end

	frozen color_with_pattern_image (a_image: POINTER): POINTER
			--+ (NSColor *)colorWithPatternImage:(NSImage*)image;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColor colorWithPatternImage: $a_image];"
		end

feature -- Retrieving Individual Components

	frozen alpha_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)alphaComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color alphaComponent];"
		end

	frozen black_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)blackComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color blackComponent];"
		end

	frozen blue_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)blueComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color blueComponent];"
		end

	frozen brightness_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)brightnessComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color brightnessComponent];"
		end

	frozen catalog_name_component (a_ns_color: POINTER): POINTER
			-- - (NSString *)catalogNameComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color catalogNameComponent];"
		end

	frozen color_name_component (a_ns_color: POINTER): POINTER
			-- - (NSString *)colorNameComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color colorNameComponent];"
		end

	frozen cyan_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)cyanComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color cyanComponent];"
		end

	frozen green_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)greenComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color greenComponent];"
		end

	frozen hue_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)hueComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color hueComponent];"
		end

	frozen localized_catalog_name_component (a_ns_color: POINTER): POINTER
			-- - (NSString *)localizedCatalogNameComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color localizedCatalogNameComponent];"
		end

	frozen localized_color_name_component (a_ns_color: POINTER): POINTER
			-- - (NSString *)localizedColorNameComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color localizedColorNameComponent];"
		end

	frozen magenta_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)magentaComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color magentaComponent];"
		end

	frozen red_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)redComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color redComponent];"
		end

	frozen saturation_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)saturationComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color saturationComponent];"
		end

	frozen white_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)whiteComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color whiteComponent];"
		end

	frozen yellow_component (a_ns_color: POINTER): REAL
			-- - (CGFloat)yellowComponent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color yellowComponent];"
		end


feature -- Changing the Color

	frozen blended_color_with_fraction_of_color (a_ns_color: POINTER; a_fraction: REAL; a_color: POINTER): POINTER
			-- - (NSColor *)blendedColorWithFraction: (CGFloat) fraction ofColor: (CGFloat) color
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color blendedColorWithFraction: $a_fraction ofColor: $a_color];"
		end

	frozen color_with_alpha_component (a_ns_color: POINTER; a_alpha: REAL): POINTER
			-- - (NSColor *)colorWithAlphaComponent: (CGFloat) alpha
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color colorWithAlphaComponent: $a_alpha];"
		end

	frozen highlight_with_level (a_ns_color: POINTER; a_val: REAL): POINTER
			-- - (NSColor *)highlightWithLevel: (CGFloat) val
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color highlightWithLevel: $a_val];"
		end

	frozen shadow_with_level (a_ns_color: POINTER; a_val: REAL): POINTER
			-- - (NSColor *)shadowWithLevel: (CGFloat) val
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSColor*)$a_ns_color shadowWithLevel: $a_val];"
		end

feature -- Drawing

	frozen draw_swatch_in_rect (a_ns_color: POINTER; a_rect: POINTER)
			-- - (void)drawSwatchInRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_ns_color drawSwatchInRect: *(NSRect*)$a_rect];"
		end

	frozen set (a_ns_color: POINTER)
			-- - (void)set
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_ns_color set];"
		end

	frozen set_fill (a_ns_color: POINTER)
			-- - (void)setFill
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_ns_color setFill];"
		end

	frozen set_stroke (a_ns_color: POINTER)
			-- - (void)setStroke
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSColor*)$a_ns_color setStroke];"
		end

end
