note
	description: "Wrapper for NSButton"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON

inherit
	NS_CONTROL
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
			-- Create a new NSButton
		do
			make_shared (button_new)
		end

feature -- Access

	cell: NS_CELL
		do
			create Result.make_shared (button_cell (item))
		end

	set_button_type (a_button_type: INTEGER)
		require
			valid_button_type: a_button_type = push_on_push_off_button or a_button_type = toggle_button or a_button_type = switch_button or a_button_type = radio_button
		do
			button_set_button_type (item, a_button_type)
		end

	set_key_equivalent (a_string: STRING_GENERAL)
		do
			button_set_key_equivalent (item, (create {NS_STRING}.make_with_string (a_string)).item)
		end

	set_title (a_title: STRING_GENERAL)
		do
			button_set_title (item, (create {NS_STRING}.make_with_string (a_title)).item)
		end

	set_bezel_style (a_style: INTEGER)
		require
			valid_style: a_style = rounded_bezel_style
		do
			button_set_bezel_style (item, a_style)
		end

feature {NONE} -- Objective-C interface

	frozen button_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSButton new];"
		end

	frozen button_cell (a_button: POINTER) : POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSButton*)$a_button cell];"
		end

	frozen button_set_key_equivalent (a_button: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setKeyEquivalent: $a_nsstring];"
		end

	frozen button_set_title (a_button: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setTitle: $a_nsstring];"
		end

	frozen button_set_bezel_style (a_button: POINTER; a_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setBezelStyle:$a_style];"
		end

	frozen button_set_button_type (a_button: POINTER; a_button_type: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_button setButtonType: $a_button_type];"
		end

--- (NSString *)title;
--- (void)setTitle:(NSString *)aString;
--- (NSString *)alternateTitle;
--- (void)setAlternateTitle:(NSString *)aString;
--- (NSImage *)image;
--- (void)setImage:(NSImage *)image;
--- (NSImage *)alternateImage;
--- (void)setAlternateImage:(NSImage *)image;
--- (NSCellImagePosition)imagePosition;
--- (void)setImagePosition:(NSCellImagePosition)aPosition;
--- (void)setButtonType:(NSButtonType)aType;
--- (NSInteger)state;
--- (void)setState:(NSInteger)value;
--- (BOOL)isBordered;
--- (void)setBordered:(BOOL)flag;
--- (BOOL)isTransparent;
--- (void)setTransparent:(BOOL)flag;
--- (void)setPeriodicDelay:(float)delay interval:(float)interval;
--- (void)getPeriodicDelay:(float *)delay interval:(float *)interval;
--- (NSString *)keyEquivalent;
--- (void)setKeyEquivalent:(NSString *)charCode;
--- (NSUInteger)keyEquivalentModifierMask;
--- (void)setKeyEquivalentModifierMask:(NSUInteger)mask;
--- (void)highlight:(BOOL)flag;
--- (BOOL)performKeyEquivalent:(NSEvent *)key;


--@interface NSButton(NSKeyboardUI)
--- (void)setTitleWithMnemonic:(NSString *)stringWithAmpersand;

--@interface NSButton(NSButtonAttributedStringMethods)
--- (NSAttributedString *)attributedTitle;
--- (void)setAttributedTitle:(NSAttributedString *)aString;
--- (NSAttributedString *)attributedAlternateTitle;
--- (void)setAttributedAlternateTitle:(NSAttributedString *)obj;

--@interface NSButton(NSButtonBezelStyles)
--- (void) setBezelStyle:(NSBezelStyle)bezelStyle;
--- (NSBezelStyle)bezelStyle;

--@interface NSButton(NSButtonMixedState)
--- (void)setAllowsMixedState:(BOOL)flag;
--- (BOOL)allowsMixedState;
--- (void)setNextState;

--@interface NSButton(NSButtonBorder)
--- (void) setShowsBorderOnlyWhileMouseInside:(BOOL)show;
--- (BOOL) showsBorderOnlyWhileMouseInside;

--@interface NSButton (NSButtonSoundExtensions)
--- (void)setSound:(NSSound *)aSound;
--- (NSSound *)sound;


feature -- NSButtonType Constants

--    NSMomentaryLightButton		= 0,	// was NSMomentaryPushButton

	frozen push_on_push_off_button: INTEGER
			--    NSPushOnPushOffButton		= 1,
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSPushOnPushOffButton;"
		end

	frozen toggle_button: INTEGER
    		-- NSToggleButton			= 2
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSToggleButton;"
		end

	frozen switch_button: INTEGER
			-- NSSwitchButton			= 3
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSSwitchButton;"
		end

	frozen radio_button: INTEGER
			-- NSRadioButton			= 4,
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSRadioButton;"
		end
--    NSMomentaryChangeButton		= 5,
--    NSOnOffButton			= 6,
--    NSMomentaryPushInButton		= 7,	// was NSMomentaryLight

--    /* These constants were accidentally reversed so that NSMomentaryPushButton lit and
--       NSMomentaryLight pushed. These names are now deprecated */
--
--    NSMomentaryPushButton		= 0,
--    NSMomentaryLight			= 7


feature -- NSBezelStyle Constants

	frozen rounded_bezel_style: INTEGER
			-- NSRoundedBezelStyle          = 1,
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSRoundedBezelStyle;"
		end

--    NSRegularSquareBezelStyle    = 2,
--    NSThickSquareBezelStyle      = 3,
--    NSThickerSquareBezelStyle    = 4,
--    NSDisclosureBezelStyle       = 5,
--    NSShadowlessSquareBezelStyle = 6,
--    NSCircularBezelStyle         = 7,
--    NSTexturedSquareBezelStyle   = 8,
--    NSHelpButtonBezelStyle       = 9,
--    NSSmallSquareBezelStyle       = 10,
--    NSTexturedRoundedBezelStyle   = 11,
--    NSRoundRectBezelStyle         = 12,
--    NSRecessedBezelStyle          = 13,
--    NSRoundedDisclosureBezelStyle = 14,

end
