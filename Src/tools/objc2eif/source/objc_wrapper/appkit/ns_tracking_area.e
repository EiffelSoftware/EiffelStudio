note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TRACKING_AREA

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
	make_with_rect__options__owner__user_info_,
	make

feature {NONE} -- Initialization

	make_with_rect__options__owner__user_info_ (a_rect: NS_RECT; a_options: NATURAL_64; a_owner: detachable NS_OBJECT; a_user_info: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_owner__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_owner as a_owner_attached then
				a_owner__item := a_owner_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			make_with_pointer (objc_init_with_rect__options__owner__user_info_(allocate_object, a_rect.item, a_options, a_owner__item, a_user_info__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTrackingArea Externals

	objc_init_with_rect__options__owner__user_info_ (an_item: POINTER; a_rect: POINTER; a_options: NATURAL_64; a_owner: POINTER; a_user_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTrackingArea *)$an_item initWithRect:*((NSRect *)$a_rect) options:$a_options owner:$a_owner userInfo:$a_user_info];
			 ]"
		end

	objc_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTrackingArea *)$an_item rect];
			 ]"
		end

	objc_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTrackingArea *)$an_item options];
			 ]"
		end

	objc_owner (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTrackingArea *)$an_item owner];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTrackingArea *)$an_item userInfo];
			 ]"
		end

feature -- NSTrackingArea

	rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect (item, Result.item)
		end

	options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_options (item)
		end

	owner: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_owner (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like owner} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like owner} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_info: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTrackingArea"
		end

end
