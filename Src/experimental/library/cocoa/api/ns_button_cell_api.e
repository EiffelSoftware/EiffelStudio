note
	description: "Eiffel to native wrapper for NSButtonCell."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL_API

feature -- Creation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSButtonCell new];"
		end

feature -- Setting Titles

	frozen alternate_mnemonic (a_ns_button_cell: POINTER): POINTER
			-- - (NSString *)alternateMnemonic
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell alternateMnemonic];"
		end

	frozen alternate_mnemonic_location (a_ns_button_cell: POINTER): INTEGER
			-- - (NSUInteger)alternateMnemonicLocation
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell alternateMnemonicLocation];"
		end

	frozen alternate_title (a_ns_button_cell: POINTER): POINTER
			-- - (NSString *)alternateTitle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell alternateTitle];"
		end

	frozen attributed_alternate_title (a_ns_button_cell: POINTER): POINTER
			-- - (NSAttributedString *)attributedAlternateTitle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell attributedAlternateTitle];"
		end

	frozen attributed_title (a_ns_button_cell: POINTER): POINTER
			-- - (NSAttributedString *)attributedTitle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell attributedTitle];"
		end

	frozen set_alternate_mnemonic_location (a_ns_button_cell: POINTER; a_location: INTEGER)
			-- - (void)setAlternateMnemonicLocation: (NSUInteger) location
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAlternateMnemonicLocation: $a_location];"
		end

	frozen set_alternate_title (a_ns_button_cell: POINTER; a_string: POINTER)
			-- - (void)setAlternateTitle: (NSString *) aString
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAlternateTitle: $a_string];"
		end

	frozen set_alternate_title_with_mnemonic (a_ns_button_cell: POINTER; a_string_with_ampersand: POINTER)
			-- - (void)setAlternateTitleWithMnemonic: (NSString *) stringWithAmpersand
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAlternateTitleWithMnemonic: $a_string_with_ampersand];"
		end

	frozen set_attributed_alternate_title (a_ns_button_cell: POINTER; a_obj: POINTER)
			-- - (void)setAttributedAlternateTitle: (NSAttributedString *) obj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAttributedAlternateTitle: $a_obj];"
		end

	frozen set_attributed_title (a_ns_button_cell: POINTER; a_obj: POINTER)
			-- - (void)setAttributedTitle: (NSAttributedString *) obj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAttributedTitle: $a_obj];"
		end

	frozen set_font (a_ns_button_cell: POINTER; a_font_obj: POINTER)
			-- - (void)setFont: (NSFont *) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setFont: $a_font_obj];"
		end

	frozen set_title (a_ns_button_cell: POINTER; a_string: POINTER)
			-- - (void)setTitle: (NSString *) aString
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setTitle: $a_string];"
		end

	frozen set_title_with_mnemonic (a_ns_button_cell: POINTER; a_string_with_ampersand: POINTER)
			-- - (void)setTitleWithMnemonic: (NSString *) stringWithAmpersand
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setTitleWithMnemonic: $a_string_with_ampersand];"
		end

	frozen title (a_ns_button_cell: POINTER): POINTER
			-- - (NSString *)title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell title];"
		end

feature -- Managing Images

	frozen alternate_image (a_ns_button_cell: POINTER): POINTER
			-- - (NSImage *)alternateImage
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell alternateImage];"
		end

	frozen image_position (a_ns_button_cell: POINTER): NATURAL
			-- - (NSCellImagePosition)imagePosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell imagePosition];"
		end

	frozen set_alternate_image (a_ns_button_cell: POINTER; a_image: POINTER)
			-- - (void)setAlternateImage: (NSImage *) image
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setAlternateImage: $a_image];"
		end

	frozen set_image_position (a_ns_button_cell: POINTER; a_position: NATURAL)
			-- - (void)setImagePosition: (NSCellImagePosition) aPosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setImagePosition: $a_position];"
		end

	frozen image_scaling (a_ns_button_cell: POINTER): NATURAL
			-- - (NSImageScaling)imageScaling
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell imageScaling];"
		end

	frozen set_image_scaling (a_ns_button_cell: POINTER; a_scaling: NATURAL)
			-- - (void)setImageScaling: (NSImageScaling) scaling
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setImageScaling: $a_scaling];"
		end

feature -- Managing the Repeat Interval

	frozen get_periodic_delay_interval (a_ns_button_cell: POINTER; a_delay: TYPED_POINTER[REAL]; a_interval: TYPED_POINTER[REAL])
			-- - (void)getPeriodicDelay: (float *) delay interval: (float *) interval
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell getPeriodicDelay: $a_delay interval: $a_interval];"
		end

	frozen set_periodic_delay_interval (a_ns_button_cell: POINTER; a_delay: REAL; a_interval: REAL)
			-- - (void)setPeriodicDelay: (float) delay interval: (float) interval
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setPeriodicDelay: $a_delay interval: $a_interval];"
		end

feature -- Managing the Key Equivalent

	frozen key_equivalent (a_ns_button_cell: POINTER): POINTER
			-- - (NSString *)keyEquivalent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell keyEquivalent];"
		end

	frozen key_equivalent_font (a_ns_button_cell: POINTER): POINTER
			-- - (NSFont *)keyEquivalentFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell keyEquivalentFont];"
		end

	frozen key_equivalent_modifier_mask (a_ns_button_cell: POINTER): INTEGER
			-- - (NSUInteger)keyEquivalentModifierMask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell keyEquivalentModifierMask];"
		end

	frozen set_key_equivalent (a_ns_button_cell: POINTER; a_key_equivalent: POINTER)
			-- - (void)setKeyEquivalent: (NSString *) aKeyEquivalent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setKeyEquivalent: $a_key_equivalent];"
		end

	frozen set_key_equivalent_modifier_mask (a_ns_button_cell: POINTER; a_mask: INTEGER)
			-- - (void)setKeyEquivalentModifierMask: (NSUInteger) mask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setKeyEquivalentModifierMask: $a_mask];"
		end

	frozen set_key_equivalent_font (a_ns_button_cell: POINTER; a_font_obj: POINTER)
			-- - (void)setKeyEquivalentFont: (NSFont *) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setKeyEquivalentFont: $a_font_obj];"
		end

	frozen set_key_equivalent_font_size (a_ns_button_cell: POINTER; a_font_name: POINTER; a_font_size: REAL)
			-- - (void)setKeyEquivalentFont: (NSString *) fontName size: (NSString *) fontSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setKeyEquivalentFont: $a_font_name size: $a_font_size];"
		end

feature -- Managing Graphics Attributes

	frozen background_color (a_ns_button_cell: POINTER): POINTER
			-- - (NSColor*)backgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell backgroundColor];"
		end

	frozen set_background_color (a_ns_button_cell: POINTER; a_color: POINTER)
			-- - (void)setBackgroundColor: (NSColor*) color
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setBackgroundColor: $a_color];"
		end

	frozen bezel_style (a_ns_button_cell: POINTER): NATURAL
			-- - (NSBezelStyle)bezelStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell bezelStyle];"
		end

	frozen set_bezel_style (a_ns_button_cell: POINTER; a_bezel_style: NATURAL)
			-- - (void)setBezelStyle: (NSBezelStyle) bezelStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setBezelStyle: $a_bezel_style];"
		end

	frozen gradient_type (a_ns_button_cell: POINTER): NATURAL
			-- - (NSGradientType)gradientType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell gradientType];"
		end

	frozen set_gradient_type (a_ns_button_cell: POINTER; a_type: NATURAL)
			-- - (void)setGradientType: (NSGradientType) type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setGradientType: $a_type];"
		end

	frozen image_dims_when_disabled (a_ns_button_cell: POINTER): BOOLEAN
			-- - (BOOL)imageDimsWhenDisabled
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell imageDimsWhenDisabled];"
		end

	frozen set_image_dims_when_disabled (a_ns_button_cell: POINTER; a_flag: BOOLEAN)
			-- - (void)setImageDimsWhenDisabled: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setImageDimsWhenDisabled: $a_flag];"
		end

	frozen is_opaque (a_ns_button_cell: POINTER): BOOLEAN
			-- - (BOOL)isOpaque
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell isOpaque];"
		end

	frozen is_transparent (a_ns_button_cell: POINTER): BOOLEAN
			-- - (BOOL)isTransparent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell isTransparent];"
		end

	frozen set_transparent (a_ns_button_cell: POINTER; a_flag: BOOLEAN)
			-- - (void)setTransparent: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setTransparent: $a_flag];"
		end

	frozen shows_border_only_while_mouse_inside (a_ns_button_cell: POINTER): BOOLEAN
			-- - (BOOL)showsBorderOnlyWhileMouseInside
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell showsBorderOnlyWhileMouseInside];"
		end

	frozen set_shows_border_only_while_mouse_inside (a_ns_button_cell: POINTER; a_show: BOOLEAN)
			-- - (void)setShowsBorderOnlyWhileMouseInside: (BOOL) show
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setShowsBorderOnlyWhileMouseInside: $a_show];"
		end

feature -- Displaying the Cell

	frozen highlights_by (a_ns_button_cell: POINTER): INTEGER
			-- - (NSInteger)highlightsBy
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell highlightsBy];"
		end

	frozen set_highlights_by (a_ns_button_cell: POINTER; a_type: INTEGER)
			-- - (void)setHighlightsBy: (NSInteger) aType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setHighlightsBy: $a_type];"
		end

	frozen set_shows_state_by (a_ns_button_cell: POINTER; a_type: INTEGER)
			-- - (void)setShowsStateBy: (NSInteger) aType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setShowsStateBy: $a_type];"
		end

	frozen set_button_type (a_ns_button_cell: POINTER; a_type: NATURAL)
			-- - (void)setButtonType: (NSButtonType) aType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setButtonType: $a_type];"
		end

	frozen shows_state_by (a_ns_button_cell: POINTER): INTEGER
			-- - (NSInteger)showsStateBy
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell showsStateBy];"
		end

feature -- Managing the Sound

	frozen sound (a_ns_button_cell: POINTER): POINTER
			-- - (NSSound *)sound
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButtonCell*)$a_ns_button_cell sound];"
		end

	frozen set_sound (a_ns_button_cell: POINTER; a_sound: POINTER)
			-- - (void)setSound: (NSSound *) aSound
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell setSound: $a_sound];"
		end

feature -- Handling Events and Action Messages

	frozen mouse_entered (a_ns_button_cell: POINTER; a_event: POINTER)
			-- - (void)mouseEntered: (NSEvent*) event
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell mouseEntered: $a_event];"
		end

	frozen mouse_exited (a_ns_button_cell: POINTER; a_event: POINTER)
			-- - (void)mouseExited: (NSEvent*) event
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell mouseExited: $a_event];"
		end

	frozen perform_click (a_ns_button_cell: POINTER; a_sender: POINTER)
			-- - (void)performClick: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell performClick: *(id*)$a_sender];"
		end

feature -- Drawing the Button Content

	frozen draw_bezel_with_frame_in_view (a_ns_button_cell: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- - (void)drawBezelWithFrame: (NSRect) frame inView: (NSRect) controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell drawBezelWithFrame: *(NSRect*)$a_frame inView: $a_control_view];"
		end

	frozen draw_image_with_frame_in_view (a_ns_button_cell: POINTER; a_image: POINTER; a_frame: POINTER; a_control_view: POINTER)
			-- - (void)drawImage: (NSImage*) image withFrame: (NSImage*) frame inView: (NSImage*) controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$a_ns_button_cell drawImage: $a_image withFrame: *(NSRect*)$a_frame inView: $a_control_view];"
		end

	frozen draw_title_with_frame_in_view (a_ns_button_cell: POINTER; a_title: POINTER; a_frame: POINTER; a_control_view: POINTER; res: POINTER)
			-- - (NSRect)drawTitle: (NSAttributedString*) title withFrame: (NSAttributedString*) frame inView: (NSAttributedString*) controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSButtonCell*)$a_ns_button_cell drawTitle: $a_title withFrame: *(NSRect*)$a_frame inView: $a_control_view]; memcpy($res, &rect, sizeof(NSRect));"
		end
end
