note
	description: "Summary description for {NS_FONT_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_API

feature -- Creating Arbitrary Fonts

	frozen font_with_name_size (a_font_name: POINTER; a_font_size: REAL): POINTER
			-- + (NSFont *)fontWithName: (NSString *) fontName size: (NSString *) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithName: $a_font_name size: $a_font_size];"
		end

	frozen font_with_descriptor_size (a_font_descriptor: POINTER; a_font_size: REAL): POINTER
			-- + (NSFont *)fontWithDescriptor: (NSFontDescriptor *) fontDescriptor size: (NSFontDescriptor *) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithDescriptor: $a_font_descriptor size: $a_font_size];"
		end

	frozen font_with_descriptor_text_transform (a_font_descriptor: POINTER; a_text_transform: POINTER): POINTER
			-- + (NSFont *)fontWithDescriptor: (NSFontDescriptor *) fontDescriptor textTransform: (NSFontDescriptor *) textTransform
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithDescriptor: $a_font_descriptor textTransform: $a_text_transform];"
		end

	frozen font_with_name_matrix (a_font_name: POINTER; a_font_matrix: POINTER): POINTER
			-- + (NSFont *)fontWithName: (NSString *) fontName matrix: (NSString *) fontMatrix
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont fontWithName: $a_font_name matrix: $a_font_matrix];"
		end

feature -- Creating User Fonts

	frozen user_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)userFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont userFontOfSize: $a_font_size];"
		end

	frozen user_fixed_pitch_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)userFixedPitchFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont userFixedPitchFontOfSize: $a_font_size];"
		end

feature -- Creating System Fonts

	frozen bold_system_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)boldSystemFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont boldSystemFontOfSize: $a_font_size];"
		end

	frozen control_content_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)controlContentFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont controlContentFontOfSize: $a_font_size];"
		end

	frozen label_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)labelFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont labelFontOfSize: $a_font_size];"
		end

	frozen menu_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)menuFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont menuFontOfSize: $a_font_size];"
		end

	frozen menu_bar_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)menuBarFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont menuBarFontOfSize: $a_font_size];"
		end

	frozen message_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)messageFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont messageFontOfSize: $a_font_size];"
		end

	frozen palette_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)paletteFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont paletteFontOfSize: $a_font_size];"
		end

	frozen system_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)systemFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont systemFontOfSize: $a_font_size];"
		end

	frozen title_bar_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)titleBarFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont titleBarFontOfSize: $a_font_size];"
		end

	frozen tool_tips_font_of_size (a_font_size: REAL): POINTER
			-- + (NSFont *)toolTipsFontOfSize: (CGFloat) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont toolTipsFontOfSize: $a_font_size];"
		end

feature -- Using a Font to Draw

	frozen set (a_ns_font: POINTER)
			-- - (void)set
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFont*)$a_ns_font set];"
		end

	frozen set_in_context (a_ns_font: POINTER; a_graphics_context: POINTER)
			-- - (void)setInContext: (NSGraphicsContext *) graphicsContext
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFont*)$a_ns_font setInContext: $a_graphics_context];"
		end

feature -- Getting General Font Information

	frozen covered_character_set (a_ns_font: POINTER): POINTER
			-- - (NSCharacterSet *)coveredCharacterSet
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font coveredCharacterSet];"
		end

	frozen font_descriptor (a_ns_font: POINTER): POINTER
			-- - (NSFontDescriptor *)fontDescriptor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font fontDescriptor];"
		end

	frozen is_fixed_pitch (a_ns_font: POINTER): BOOLEAN
			-- - (BOOL)isFixedPitch
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font isFixedPitch];"
		end

	frozen most_compatible_string_encoding (a_ns_font: POINTER): NATURAL
			-- - (NSStringEncoding)mostCompatibleStringEncoding
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font mostCompatibleStringEncoding];"
		end

	frozen rendering_mode (a_ns_font: POINTER): INTEGER
			-- - (NSFontRenderingMode)renderingMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font renderingMode];"
		end

feature -- Getting Information About Glyphs

	frozen glyph_with_name (a_ns_font: POINTER; a_name: POINTER): INTEGER
			-- - (NSGlyph)glyphWithName: (NSString *) aName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font glyphWithName: $a_name];"
		end

feature -- Getting Metrics Information

	frozen label_font_size : REAL
			-- + (CGFloat)labelFontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont labelFontSize];"
		end

	frozen small_system_font_size : REAL
			-- + (CGFloat)smallSystemFontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont smallSystemFontSize];"
		end

	frozen system_font_size : REAL
			-- + (CGFloat)systemFontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont systemFontSize];"
		end

	frozen system_font_size_for_control_size (a_control_size: NATURAL): REAL
			-- + (CGFloat)systemFontSizeForControlSize: (NSControlSize) controlSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFont systemFontSizeForControlSize: $a_control_size];"
		end

	frozen advancement_for_glyph (a_ns_font: POINTER; a_ag: INTEGER; res: POINTER)
			-- - (NSSize)advancementForGlyph: (NSGlyph) ag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSFont*)$a_ns_font advancementForGlyph: $a_ag]; memcpy($res, &size, sizeof(NSSize));"
		end

	frozen ascender (a_ns_font: POINTER): REAL
			-- - (CGFloat)ascender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font ascender];"
		end

	frozen bounding_rect_for_font (a_ns_font: POINTER; res: POINTER)
			-- - (NSRect)boundingRectForFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSFont*)$a_ns_font boundingRectForFont]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen bounding_rect_for_glyph (a_ns_font: POINTER; a_glyph: INTEGER; res: POINTER)
			-- - (NSRect)boundingRectForGlyph: (NSGlyph) aGlyph
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSFont*)$a_ns_font boundingRectForGlyph: $a_glyph]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen cap_height (a_ns_font: POINTER): REAL
			-- - (CGFloat)capHeight
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font capHeight];"
		end

	frozen descender (a_ns_font: POINTER): REAL
			-- - (CGFloat)descender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font descender];"
		end

	frozen get_advancements_for_glyphs_count (a_ns_font: POINTER; a_advancements: POINTER; a_glyphs: POINTER; a_glyph_count: INTEGER)
			-- - (void)getAdvancements: (NSSizeArray) advancements forGlyphs: (NSSizeArray) glyphs count: (NSSizeArray) glyphCount
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFont*)$a_ns_font getAdvancements: *(NSSizeArray*)$a_advancements forGlyphs: $a_glyphs count: $a_glyph_count];"
		end

	frozen get_advancements_for_packed_glyphs_length (a_ns_font: POINTER; a_advancements: POINTER; a_packed_glyphs: POINTER; a_length: INTEGER)
			-- - (void)getAdvancements: (NSSizeArray) advancements forPackedGlyphs: (NSSizeArray) packedGlyphs length: (NSSizeArray) length
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFont*)$a_ns_font getAdvancements: *(NSSizeArray*)$a_advancements forPackedGlyphs: $a_packed_glyphs length: $a_length];"
		end

	frozen get_bounding_rects_for_glyphs_count (a_ns_font: POINTER; a_bounds: POINTER; a_glyphs: POINTER; a_glyph_count: INTEGER)
			-- - (void)getBoundingRects: (NSRectArray) bounds forGlyphs: (NSRectArray) glyphs count: (NSRectArray) glyphCount
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFont*)$a_ns_font getBoundingRects: *(NSRectArray*)$a_bounds forGlyphs: $a_glyphs count: $a_glyph_count];"
		end

	frozen italic_angle (a_ns_font: POINTER): REAL
			-- - (CGFloat)italicAngle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font italicAngle];"
		end

	frozen leading (a_ns_font: POINTER): REAL
			-- - (CGFloat)leading
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font leading];"
		end

	frozen matrix (a_ns_font: POINTER): POINTER
			-- - (const CGFloat *)matrix
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (EIF_REFERENCE)[(NSFont*)$a_ns_font matrix];"
		end

	frozen maximum_advancement (a_ns_font: POINTER; res: POINTER)
			-- - (NSSize)maximumAdvancement
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSFont*)$a_ns_font maximumAdvancement]; memcpy($res, &size, sizeof(NSSize));"
		end

	frozen number_of_glyphs (a_ns_font: POINTER): INTEGER
			-- - (NSUInteger)numberOfGlyphs
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font numberOfGlyphs];"
		end

	frozen point_size (a_ns_font: POINTER): REAL
			-- - (CGFloat)pointSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font pointSize];"
		end

	frozen text_transform (a_ns_font: POINTER): POINTER
			-- - (NSAffineTransform *)textTransform
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font textTransform];"
		end

	frozen underline_position (a_ns_font: POINTER): REAL
			-- - (CGFloat)underlinePosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font underlinePosition];"
		end

	frozen underline_thickness (a_ns_font: POINTER): REAL
			-- - (CGFloat)underlineThickness
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font underlineThickness];"
		end

	frozen x_height (a_ns_font: POINTER): REAL
			-- - (CGFloat)xHeight
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font xHeight];"
		end

feature -- Getting Font Names

	frozen display_name (a_ns_font: POINTER): POINTER
			-- - (NSString *)displayName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font displayName];"
		end

	frozen family_name (a_ns_font: POINTER): POINTER
			-- - (NSString *)familyName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font familyName];"
		end

	frozen font_name (a_ns_font: POINTER): POINTER
			-- - (NSString *)fontName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font fontName];"
		end

feature -- Setting User Fonts

	frozen set_user_font (a_font: POINTER)
			-- + (void)setUserFont: (NSFont *) aFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSFont setUserFont: $a_font];"
		end

	frozen set_user_fixed_pitch_font (a_font: POINTER)
			-- + (void)setUserFixedPitchFont: (NSFont *) aFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSFont setUserFixedPitchFont: $a_font];"
		end

feature -- Getting Corresponding Device Fonts

	frozen printer_font (a_ns_font: POINTER): POINTER
			-- - (NSFont *)printerFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font printerFont];"
		end

	frozen screen_font (a_ns_font: POINTER): POINTER
			-- - (NSFont *)screenFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font screenFont];"
		end

	frozen screen_font_with_rendering_mode (a_ns_font: POINTER; a_rendering_mode: INTEGER): POINTER
			-- - (NSFont *)screenFontWithRenderingMode: (NSFontRenderingMode) renderingMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFont*)$a_ns_font screenFontWithRenderingMode: $a_rendering_mode];"
		end
end
