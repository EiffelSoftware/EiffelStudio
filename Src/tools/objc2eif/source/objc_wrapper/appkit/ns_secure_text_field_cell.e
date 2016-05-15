note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SECURE_TEXT_FIELD_CELL

inherit
	NS_TEXT_FIELD_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSSecureTextFieldCell

	set_echos_bullets_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_echos_bullets_ (item, a_flag)
		end

	echos_bullets: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_echos_bullets (item)
		end

feature {NONE} -- NSSecureTextFieldCell Externals

	objc_set_echos_bullets_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSecureTextFieldCell *)$an_item setEchosBullets:$a_flag];
			 ]"
		end

	objc_echos_bullets (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSecureTextFieldCell *)$an_item echosBullets];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSecureTextFieldCell"
		end

end
