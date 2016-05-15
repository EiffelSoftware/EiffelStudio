note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PANEL

inherit
	NS_WINDOW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_rect__style_mask__backing__defer_,
	make_with_content_rect__style_mask__backing__defer__screen_,
	makeial_first_responder,
	make

feature -- NSPanel

	set_floating_panel_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_floating_panel_ (item, a_flag)
		end

	becomes_key_only_if_needed: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_becomes_key_only_if_needed (item)
		end

	set_becomes_key_only_if_needed_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_becomes_key_only_if_needed_ (item, a_flag)
		end

	set_works_when_modal_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_works_when_modal_ (item, a_flag)
		end

feature {NONE} -- NSPanel Externals

	objc_set_floating_panel_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPanel *)$an_item setFloatingPanel:$a_flag];
			 ]"
		end

	objc_becomes_key_only_if_needed (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPanel *)$an_item becomesKeyOnlyIfNeeded];
			 ]"
		end

	objc_set_becomes_key_only_if_needed_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPanel *)$an_item setBecomesKeyOnlyIfNeeded:$a_flag];
			 ]"
		end

	objc_set_works_when_modal_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPanel *)$an_item setWorksWhenModal:$a_flag];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPanel"
		end

end
