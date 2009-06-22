note
	description: "Summary description for {NS_FONT_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_API

feature -- Access

--/********* Factory *********/
--+ (NSFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize;
--+ (NSFont *)fontWithName:(NSString *)fontName matrix:(const CGFloat *)fontMatrix;
--/* Instantiates an NSFont object matching fontDescriptor. If fontSize is greater than 0.0, it has precedence over NSFontSizeAttribute in fontDescriptor.
--*/

	frozen font_with_descriptor (a_font_descriptor: POINTER; a_size: REAL): POINTER
			-- + (NSFont *)fontWithDescriptor:(NSFontDescriptor *)fontDescriptor size:(CGFloat)fontSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithDescriptor: $a_font_descriptor size: $a_size];"
		end


--/* Instantiates an NSFont object matching fontDescriptor. If textTransform is non-nil, it has precedence over NSFontMatrixAttribute in fontDescriptor.
--*/
--+ (NSFont *)fontWithDescriptor:(NSFontDescriptor *)fontDescriptor textTransform:(NSAffineTransform *)textTransform;

	frozen font_with_name (a_font_name: POINTER; a_size: REAL): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithName: $a_font_name size: $a_size];"
		end


--/********* Meta Font *********/
--/* User font settings
--*/
--+ (NSFont *)userFontOfSize:(CGFloat)fontSize;	// Aqua Application font
--+ (NSFont *)userFixedPitchFontOfSize:(CGFloat)fontSize; // Aqua fixed-pitch font
--+ (void)setUserFont:(NSFont *)aFont;	// set preference for Application font.
--+ (void)setUserFixedPitchFont:(NSFont *)aFont; // set preference for fixed-pitch.

--/* UI font settings
--*/
	frozen system_font_of_size (a_font_size: REAL): POINTER
			--+ (NSFont *)systemFontOfSize:(CGFloat)fontSize;	// Aqua System font
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont systemFontOfSize: $a_font_size];"
		end

	frozen bold_system_font_of_size (a_font_size: REAL): POINTER
			--+ (NSFont *)boldSystemFontOfSize:(CGFloat)fontSize; // Aqua System font (emphasized)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont boldSystemFontOfSize: $a_font_size];"
		end

	frozen label_font_of_size (a_font_size: REAL): POINTER
			--+ (NSFont *)labelFontOfSize:(CGFloat)fontSize; // Aqua label font
			-- Returns the Aqua label font used for standard interface labels in the specified size
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont labelFontOfSize: $a_font_size];"
		end

--+ (NSFont *)titleBarFontOfSize:(CGFloat)fontSize;
--+ (NSFont *)menuFontOfSize:(CGFloat)fontSize;
--+ (NSFont *)menuBarFontOfSize:(CGFloat)fontSize;
--+ (NSFont *)messageFontOfSize:(CGFloat)fontSize;
--+ (NSFont *)paletteFontOfSize:(CGFloat)fontSize;
--+ (NSFont *)toolTipsFontOfSize:(CGFloat)fontSize;
	frozen control_content_font_of_size (a_font_size: REAL): POINTER
			--+ (NSFont *)controlContentFontOfSize:(CGFloat)fontSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont controlContentFontOfSize: $a_font_size];"
		end

--/* UI font size settings
--*/
--+ (CGFloat)systemFontSize; // size of the standard System font.
--+ (CGFloat)smallSystemFontSize; // size of standard small System font.
--+ (CGFloat)labelFontSize;	// size of the standard Label Font.

--+ (CGFloat)systemFontSizeForControlSize:(NSControlSize)controlSize;

--/********* Core font attribute *********/
	frozen font_name (a_font: POINTER): POINTER
			--- (NSString *)fontName;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_font fontName];"
		end

	frozen point_size (a_font: POINTER): REAL
			--- (CGFloat)pointSize;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_font pointSize];"
		end
--- (const CGFloat *)matrix;
	frozen family_name (a_font: POINTER): POINTER
			--- (NSString *)familyName;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_font familyName];"
		end

	frozen display_name (a_font: POINTER): POINTER
			--- (NSString *)displayName;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_font displayName];"
		end
--- (NSFontDescriptor *)fontDescriptor;
--- (NSAffineTransform *)textTransform;

--/********* Glyph coverage *********/
--- (NSUInteger)numberOfGlyphs;
--- (NSStringEncoding)mostCompatibleStringEncoding;
--- (NSGlyph)glyphWithName:(NSString *)aName;
--- (NSCharacterSet *)coveredCharacterSet;

--/********* Font instance-wide metrics *********/
--/* These methods return scaled numbers.  If the font was created with a matrix, the matrix is applied automatically; otherwise the coordinates are multiplied by size.
--*/
--- (NSRect)boundingRectForFont;
--- (NSSize)maximumAdvancement;

--- (CGFloat)ascender;
--- (CGFloat)descender;
--- (CGFloat)leading;

--- (CGFloat)underlinePosition;
--- (CGFloat)underlineThickness;
--- (CGFloat)italicAngle;
--- (CGFloat)capHeight;
--- (CGFloat)xHeight;
	frozen is_fixed_pitch (a_font: POINTER): BOOLEAN
			--- (BOOL)isFixedPitch;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_font isFixedPitch];"
		end
--/********* Glyph metrics *********/
--- (NSRect)boundingRectForGlyph:(NSGlyph)aGlyph;
--- (NSSize)advancementForGlyph:(NSGlyph)ag;

--// bulk query
--- (void)getBoundingRects:(NSRectArray)bounds forGlyphs:(const NSGlyph *)glyphs count:(NSUInteger)glyphCount;
--- (void)getAdvancements:(NSSizeArray)advancements forGlyphs:(const NSGlyph *)glyphs count:(NSUInteger)glyphCount;
--- (void)getAdvancements:(NSSizeArray)advancements forPackedGlyphs:(const void *)packedGlyphs length:(NSUInteger)length; // only supports NSNativeShortGlyphPacking

--/********* NSGraphicsContext-related *********/
--- (void)set;
--- (void)setInContext:(NSGraphicsContext *)graphicsContext;

--/********* Rendering mode *********/
--- (NSFont *)printerFont;
--- (NSFont *)screenFont; // Same as screenFontWithRenderingMode:NSFontDefaultRenderingMode
--- (NSFont *)screenFontWithRenderingMode:(NSFontRenderingMode)renderingMode;
--- (NSFontRenderingMode)renderingMode;
--@end

--/********* Glyph packing *********/
--/* Take a buffer of NSGlyphs, of some given length, and a packing type, and a place to put some packed glyphs.  Pack up the NSGlyphs according to the NSMultibyteGlyphPacking, null-terminate the bytes, and then put them into the output buffer.  Return the count of bytes output, including the null-terminator.  The output buffer (packedGlyphs) provided by the caller is guaranteed to be at least "count*4+1" bytes long. This function only supports NSNativeShortGlyphPacking on Mac OS X.
--*/
--APPKIT_EXTERN NSInteger NSConvertGlyphsToPackedGlyphs(NSGlyph *glBuf, NSInteger count, NSMultibyteGlyphPacking packing, char *packedGlyphs);

--/********* Notifications *********/
--/* This notification is posted when the antialias threshold is changed by the user.
--*/
--APPKIT_EXTERN NSString *NSAntialiasThresholdChangedNotification AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;

--/* This notification is posted when the available font set is modified as a result of activation/deactivation.
--*/
--APPKIT_EXTERN NSString *NSFontSetChangedNotification AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;

end
