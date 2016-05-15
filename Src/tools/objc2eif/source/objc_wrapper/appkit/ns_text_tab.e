note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_TAB

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_text_alignment__location__options_,
	make_with_type__location_,
	make

feature {NONE} -- Initialization

	make_with_text_alignment__location__options_ (a_alignment: NATURAL_64; a_loc: REAL_64; a_options: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_options__item: POINTER
		do
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			make_with_pointer (objc_init_with_text_alignment__location__options_(allocate_object, a_alignment, a_loc, a_options__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_type__location_ (a_type: NATURAL_64; a_loc: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_type__location_(allocate_object, a_type, a_loc))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextTab Externals

	objc_init_with_text_alignment__location__options_ (an_item: POINTER; a_alignment: NATURAL_64; a_loc: REAL_64; a_options: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextTab *)$an_item initWithTextAlignment:$a_alignment location:$a_loc options:$a_options];
			 ]"
		end

	objc_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTab *)$an_item alignment];
			 ]"
		end

	objc_options (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextTab *)$an_item options];
			 ]"
		end

	objc_init_with_type__location_ (an_item: POINTER; a_type: NATURAL_64; a_loc: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextTab *)$an_item initWithType:$a_type location:$a_loc];
			 ]"
		end

	objc_location (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTab *)$an_item location];
			 ]"
		end

	objc_tab_stop_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTab *)$an_item tabStopType];
			 ]"
		end

feature -- NSTextTab

	alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alignment (item)
		end

	options: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_options (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like options} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like options} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	location: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_location (item)
		end

	tab_stop_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tab_stop_type (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextTab"
		end

end
