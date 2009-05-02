note
	description: "Summary description for {NS_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL

inherit
	NS_VIEW
		redefine
			new
		end

create
	new

feature -- Creation

	new
		do
			cocoa_object := control_new
		end

feature -- ...

	double_value: DOUBLE
		do
			Result := control_double_value (cocoa_object)
		end

	is_enabled : BOOLEAN
		do
			Result := control_is_enabled (cocoa_object)
		end

	set_action (an_action: PROCEDURE [ANY, TUPLE])
		do
			action := an_action
			control_set_target (cocoa_object, target_new ($current, $target))
			control_set_action (cocoa_object)
		end

	set_double_value (a_double: DOUBLE)
		do
			control_set_double_value (cocoa_object, a_double)
		end

	set_enabled (a_flag: BOOLEAN)
		do
			control_set_enabled (cocoa_object, a_flag)
		end

	set_string_value (a_string: STRING_GENERAL)
		do
			control_set_string_value (cocoa_object, (create {NS_STRING}.make_with_string (a_string)).cocoa_object)
		end

	font: NS_FONT
		do
			create Result.make_shared (control_font (cocoa_object))
		end

	set_cell (a_cell: NS_CELL)
		do
			control_set_cell (cocoa_object, a_cell.cocoa_object)
		end

feature {NONE} -- callback

	target
		do
			action.call([])
		end

	action: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Objective-C implementation

	frozen control_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSControl new];"
		end

--+ (void)setCellClass:(Class)factoryId;
--+ (Class)cellClass;

--- (id)initWithFrame:(NSRect)frameRect;
--- (void)sizeToFit;
--- (void)calcSize;
--- (id)cell;
	frozen control_set_cell (a_control: POINTER; a_cell: POINTER)
			--- (void)setCell:(NSCell *)aCell;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setCell: $a_cell];"
		end
--- (id)selectedCell;
--- (id)target;
	frozen control_set_target (a_control: POINTER; a_target: POINTER)
			-- - (void)setTarget:(id)anObject;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setTarget: $a_target];"
		end
--- (SEL)action;
	frozen control_set_action (a_control: POINTER)
			-- - (void)setAction:(SEL)aSelector;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButton*)$a_control setAction:@selector(handle_action_event:)];"
		end
--- (NSInteger)tag;
--- (void)setTag:(NSInteger)anInt;
--- (NSInteger)selectedTag;
--- (void)setIgnoresMultiClick:(BOOL)flag;
--- (BOOL)ignoresMultiClick;
--- (NSInteger)sendActionOn:(NSInteger)mask;
--- (BOOL)isContinuous;
--- (void)setContinuous:(BOOL)flag;
--- (BOOL)isEnabled;
--- (void)setEnabled:(BOOL)flag;
--- (void)setFloatingPointFormat:(BOOL)autoRange left:(NSUInteger)leftDigits right:(NSUInteger)rightDigits;
--- (NSTextAlignment)alignment;
--- (void)setAlignment:(NSTextAlignment)mode;
--- (NSFont *)font;

	frozen control_is_enabled (a_control: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control isEnabled];"
		end

	frozen control_set_enabled (a_control: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setEnabled: $a_flag];"
		end

	frozen control_font (a_control: POINTER) : POINTER
			--- (void)setStringValue:(NSString *)aString;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control font];"
		end

--- (void)setFont:(NSFont *)fontObj;
--- (void)setFormatter:(NSFormatter *)newFormatter;
--- (id)formatter;
--- (void)setObjectValue:(id<NSCopying>)obj;

	frozen control_set_string_value (a_control: POINTER; a_string: POINTER)
			--- (void)setStringValue:(NSString *)aString;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setStringValue: $a_string];"
		end

--- (void)setIntValue:(int)anInt;
--- (void)setFloatValue:(float)aFloat;
	frozen control_set_double_value (a_control: POINTER; a_double: DOUBLE)
			--- (void)setDoubleValue:(double)aDouble;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSControl*)$a_control setDoubleValue: $a_double];"
		end

--- (id)objectValue;
--- (NSString *)stringValue;
--- (int)intValue;
--- (float)floatValue;
	frozen control_double_value (a_control: POINTER): DOUBLE
			-- - (double)doubleValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSControl*)$a_control doubleValue];"
		end
--- (void)setNeedsDisplay;
--- (void)updateCell:(NSCell *)aCell;
--- (void)updateCellInside:(NSCell *)aCell;
--- (void)drawCellInside:(NSCell *)aCell;
--- (void)drawCell:(NSCell *)aCell;
--- (void)selectCell:(NSCell *)aCell;

--- (BOOL)sendAction:(SEL)theAction to:(id)theTarget;
--- (void)takeIntValueFrom:(id)sender;
--- (void)takeFloatValueFrom:(id)sender;
--- (void)takeDoubleValueFrom:(id)sender;
--- (void)takeStringValueFrom:(id)sender;
--- (void)takeObjectValueFrom:(id)sender;
--- (NSText *)currentEditor;
--- (BOOL)abortEditing;
--- (void)validateEditing;
--- (void)mouseDown:(NSEvent *)theEvent;

--- (NSWritingDirection)baseWritingDirection;
--- (void)setBaseWritingDirection:(NSWritingDirection)writingDirection;

--- (NSInteger)integerValue;
--- (void)setIntegerValue:(NSInteger)anInteger;
--- (void)takeIntegerValueFrom:(id)sender;
end
