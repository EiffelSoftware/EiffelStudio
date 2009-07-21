note
	description: "Wrapper for NSTextField."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_FIELD

inherit
	NS_CONTROL
		redefine
			make
		end

	NS_TEXT_DELEGATE

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer (text_field_new)
			insert_in_table
			init_delegate
		end

feature

	set_background_color (a_color: NS_COLOR)
		do
			text_field_set_background_color (item, a_color.item)
		end

	background_color: NS_COLOR
		do
			create Result.make_from_pointer (text_field_background_color (item))
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			text_field_set_draws_background (item, a_flag)
		end

	draws_background: BOOLEAN
		do
			Result := text_field_draws_background (item)
		end

	set_text_color (a_color: NS_COLOR)
		do
			text_field_set_text_color (item, a_color.item)
		end

	text_color: NS_COLOR
		do
			create Result.make_from_pointer (text_field_text_color (item))
		end

	is_bordered: BOOLEAN
		do
			Result := text_field_is_bordered (item)
		end

	set_bordered (a_flag: BOOLEAN)
		do
			text_field_set_bordered (item, a_flag)
		end

	is_bezeled: BOOLEAN
		do
			Result := text_field_is_bezeled (item)
		end

	set_bezeled (a_flag: BOOLEAN)
		do
			text_field_set_bezeled (item, a_flag)
		end

	is_editable: BOOLEAN
		do
			Result := text_field_is_editable (item)
		end

	set_editable (a_flag: BOOLEAN)
		do
			text_field_set_editable (item, a_flag)
		end

	is_selectable: BOOLEAN
		do
			Result := text_field_is_selectable (item)
		end

	set_selectable (a_flag: BOOLEAN)
		do
			text_field_set_selectable (item, a_flag)
		end

	select_text (a_sender: NS_OBJECT)
		do
			text_field_select_text (item, a_sender.item)
		end

--	delegate: NS_OBJECT
--		do
--			create Result.make
--			text_field_delegate (cocoa_object, Result.item)
--		end

--	set_delegate (a_an_object: NS_OBJECT)
--		do
--			text_field_set_delegate (cocoa_object, a_an_object.item)
--		end

	accepts_first_responder: BOOLEAN
		do
			Result := text_field_accepts_first_responder (item)
		end

	set_bezel_style (a_style: INTEGER)
		do
			text_field_set_bezel_style (item, a_style)
		end

	bezel_style: INTEGER
		do
			Result := text_field_bezel_style (item)
		end

	set_title_with_mnemonic (a_string_with_ampersand: NS_STRING)
		do
			text_field_set_title_with_mnemonic (item, a_string_with_ampersand.item)
		end

	allows_editing_text_attributes: BOOLEAN
		do
			Result := text_field_allows_editing_text_attributes (item)
		end

	set_allows_editing_text_attributes (a_flag: BOOLEAN)
		do
			text_field_set_allows_editing_text_attributes (item, a_flag)
		end

	imports_graphics: BOOLEAN
		do
			Result := text_field_imports_graphics (item)
		end

	set_imports_graphics (a_flag: BOOLEAN)
		do
			text_field_set_imports_graphics (item, a_flag)
		end

feature {NONE} -- Objective-C implementation

	frozen text_field_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTextField new];"
		end

	frozen text_field_set_background_color (a_text_field: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBackgroundColor: $a_color];"
		end

	frozen text_field_background_color (a_text_field: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field backgroundColor];"
		end

	frozen text_field_set_draws_background (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setDrawsBackground: $a_flag];"
		end

	frozen text_field_draws_background (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field drawsBackground];"
		end

	frozen text_field_set_text_color (a_text_field: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setTextColor: $a_color];"
		end

	frozen text_field_text_color (a_text_field: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field textColor];"
		end

	frozen text_field_is_bordered (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field isBordered];"
		end

	frozen text_field_set_bordered (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBordered: $a_flag];"
		end

	frozen text_field_is_bezeled (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field isBezeled];"
		end

	frozen text_field_set_bezeled (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBezeled: $a_flag];"
		end

	frozen text_field_is_editable (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field isEditable];"
		end

	frozen text_field_set_editable (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setEditable: $a_flag];"
		end

	frozen text_field_is_selectable (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field isSelectable];"
		end

	frozen text_field_set_selectable (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setSelectable: $a_flag];"
		end

	frozen text_field_select_text (a_text_field: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field selectText: $a_sender];"
		end

	frozen text_field_delegate (a_text_field: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field delegate];"
		end

	frozen text_field_set_delegate (a_text_field: POINTER; a_an_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setDelegate: $a_an_object];"
		end

	frozen text_field_accepts_first_responder (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field acceptsFirstResponder];"
		end

	frozen text_field_set_bezel_style (a_text_field: POINTER; a_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBezelStyle: $a_style];"
		end

	frozen text_field_bezel_style (a_text_field: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field bezelStyle];"
		end

	frozen text_field_set_title_with_mnemonic (a_text_field: POINTER; a_string_with_ampersand: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setTitleWithMnemonic: $a_string_with_ampersand];"
		end

	frozen text_field_allows_editing_text_attributes (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field allowsEditingTextAttributes];"
		end

	frozen text_field_set_allows_editing_text_attributes (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setAllowsEditingTextAttributes: $a_flag];"
		end

	frozen text_field_imports_graphics (a_text_field: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field importsGraphics];"
		end

	frozen text_field_set_imports_graphics (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setImportsGraphics: $a_flag];"
		end

feature -- NSTextFieldBezelStyle constants

	frozen square_bezel: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTextFieldSquareBezel;"
		end

	frozen rounded_bezel: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTextFieldSquareBezel;"
		end
end
