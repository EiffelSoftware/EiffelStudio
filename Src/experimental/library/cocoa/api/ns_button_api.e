note
	description: "Wrapper for NSButton"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_API

feature -- Creating Buttons

	frozen new: POINTER
		external
			"C inline use %"ns_button.h%""
		alias
			"return [NSButton new];"
		end

feature -- Configuring Buttons

	frozen set_button_type (a_button: POINTER; a_button_type: NATURAL)
			-- - (void)setButtonType:(NSButtonType)aType
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setButtonType: $a_button_type];"
		end

	frozen set_title (a_button: POINTER; a_nsstring: POINTER)
			-- - (void)setTitle:(NSString *)aString
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setTitle: $a_nsstring];"
		end

	frozen title (a_button: POINTER): POINTER
			-- - (NSString *)title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_button title];"
		end

feature -- Configuring Button Images

	frozen image (a_ns_button: POINTER): POINTER
			-- - (NSImage *)image
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button image];"
		end

	frozen set_image (a_ns_button: POINTER; a_image: POINTER)
			-- - (void)setImage: (NSImage *) image
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setImage: $a_image];"
		end

	frozen alternate_image (a_ns_button: POINTER): POINTER
			-- - (NSImage *)alternateImage
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button alternateImage];"
		end

	frozen set_alternate_image (a_ns_button: POINTER; a_image: POINTER)
			-- - (void)setAlternateImage: (NSImage *) image
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setAlternateImage: $a_image];"
		end

	frozen image_position (a_ns_button: POINTER): NATURAL
			-- - (NSCellImagePosition)imagePosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button imagePosition];"
		end

	frozen set_image_position (a_ns_button: POINTER; a_position: NATURAL)
			-- - (void)setImagePosition: (NSCellImagePosition) aPosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setImagePosition: $a_position];"
		end

	frozen is_bordered (a_ns_button: POINTER): BOOLEAN
			-- - (BOOL)isBordered
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button isBordered];"
		end

	frozen set_bordered (a_ns_button: POINTER; a_flag: BOOLEAN)
			-- - (void)setBordered: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setBordered: $a_flag];"
		end

	frozen is_transparent (a_ns_button: POINTER): BOOLEAN
			-- - (BOOL)isTransparent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button isTransparent];"
		end

	frozen set_transparent (a_ns_button: POINTER; a_flag: BOOLEAN)
			-- - (void)setTransparent: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setTransparent: $a_flag];"
		end

	frozen bezel_style (a_ns_button: POINTER): NATURAL
			-- - (NSBezelStyle)bezelStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button bezelStyle];"
		end

	frozen set_bezel_style (a_ns_button: POINTER; a_bezel_style: NATURAL)
			-- - (void)setBezelStyle: (NSBezelStyle) bezelStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setBezelStyle: $a_bezel_style];"
		end

	frozen shows_border_only_while_mouse_inside (a_ns_button: POINTER): BOOLEAN
			-- - (BOOL)showsBorderOnlyWhileMouseInside
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_ns_button showsBorderOnlyWhileMouseInside];"
		end

	frozen set_shows_border_only_while_mouse_inside (a_ns_button: POINTER; a_show: BOOLEAN)
			-- - (void)setShowsBorderOnlyWhileMouseInside: (BOOL) show
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_ns_button setShowsBorderOnlyWhileMouseInside: $a_show];"
		end

feature -- Managing Button State

	frozen set_state (a_button: POINTER; a_state: INTEGER)
			-- - (void)setState:(NSInteger)value
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setState: $a_state];"
		end

	frozen state (a_button: POINTER): INTEGER
			-- - (NSInteger)state
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_button state];"
		end

feature -- Accessing Key Equivalents

	frozen set_key_equivalent (a_button: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setKeyEquivalent: $a_nsstring];"
		end

feature -- Handling Keyboard Events

end
