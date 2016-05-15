note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SHADOW

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
	make

feature -- NSShadow

	shadow_offset: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_shadow_offset (item, Result.item)
		end

	set_shadow_offset_ (a_offset: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shadow_offset_ (item, a_offset.item)
		end

	shadow_blur_radius: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shadow_blur_radius (item)
		end

	set_shadow_blur_radius_ (a_val: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shadow_blur_radius_ (item, a_val)
		end

	shadow_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shadow_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shadow_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shadow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_shadow_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_shadow_color_ (item, a_color__item)
		end

	set
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (item)
		end

feature {NONE} -- NSShadow Externals

	objc_shadow_offset (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSShadow *)$an_item shadowOffset];
			 ]"
		end

	objc_set_shadow_offset_ (an_item: POINTER; a_offset: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSShadow *)$an_item setShadowOffset:*((NSSize *)$a_offset)];
			 ]"
		end

	objc_shadow_blur_radius (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSShadow *)$an_item shadowBlurRadius];
			 ]"
		end

	objc_set_shadow_blur_radius_ (an_item: POINTER; a_val: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSShadow *)$an_item setShadowBlurRadius:$a_val];
			 ]"
		end

	objc_shadow_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSShadow *)$an_item shadowColor];
			 ]"
		end

	objc_set_shadow_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSShadow *)$an_item setShadowColor:$a_color];
			 ]"
		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSShadow *)$an_item set];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSShadow"
		end

end
