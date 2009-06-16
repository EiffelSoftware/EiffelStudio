note
	description: "Wrapper for functions of NSControl."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL_API

feature -- Initializing an NSControl

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSControl new];"
		end

feature -- Setting the Control's Cell

	frozen cell (a_control: POINTER): POINTER
			--- (id)cell;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control cell];"
		end

	frozen set_cell (a_control: POINTER; a_cell: POINTER)
			--- (void)setCell:(NSCell *)aCell;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setCell: $a_cell];"
		end

feature -- Enabling and Disabling the Control

	frozen is_enabled (a_control: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control isEnabled];"
		end

	frozen set_enabled (a_control: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setEnabled: $a_flag];"
		end

feature -- Identifying the Selected Cell

feature -- Setting the Control's Value

	frozen set_string_value (a_control: POINTER; a_string: POINTER)
			--- (void)setStringValue:(NSString *)aString;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setStringValue: $a_string];"
		end

	frozen string_value (a_control: POINTER): POINTER
			-- - (NSString *)stringValue
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control stringValue];"
		end

	frozen set_double_value (a_control: POINTER; a_double: DOUBLE)
			--- (void)setDoubleValue:(double)aDouble;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setDoubleValue: $a_double];"
		end

	frozen double_value (a_control: POINTER): DOUBLE
			-- - (double)doubleValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control doubleValue];"
		end

feature -- Interacting with Other Controls

feature -- Formatting Text

	frozen alignment (a_control: POINTER): INTEGER
			-- - (NSTextAlignment)alignment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control alignment];"
		end

	frozen set_alignment (a_control: POINTER; a_alignment: INTEGER)
			-- - (void)setAlignment:(NSTextAlignment)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control setAlignment: $a_alignment];"
		end

	frozen font (a_control: POINTER): POINTER
			--- (void)setStringValue:(NSString *)aString;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control font];"
		end

feature -- Managing the Field Editor

feature -- Editing Text in a Control

feature -- Working with Text Completion

feature -- Resizing the Control

feature -- Displaying a Cell

feature -- Implementing the Target/action Mechanism

	frozen set_target (a_control: POINTER; a_target: POINTER)
			-- - (void)setTarget:(id)anObject;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setTarget: $a_target];"
		end

	frozen set_action (a_control: POINTER)
			-- - (void)setAction:(SEL)aSelector;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setAction:@selector(handle_action_event:)];"
		end

feature -- Working with Key Bindings

feature -- Getting and Setting Tags

feature -- Activating from the Keyboard

feature -- Tracking the Mouse

end
