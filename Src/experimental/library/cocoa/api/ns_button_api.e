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

	frozen set_button_type (a_button: POINTER; a_button_type: INTEGER)
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

	frozen image (a_button: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_button image];"
		end

	frozen set_image (a_button: POINTER; a_image: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setImage: $a_image];"
		end

	frozen set_bezel_style (a_button: POINTER; a_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setBezelStyle:$a_style];"
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
