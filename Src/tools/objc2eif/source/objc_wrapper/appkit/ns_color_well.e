note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_WELL

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSColorWell

	deactivate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deactivate (item)
		end

	activate_ (a_exclusive: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_activate_ (item, a_exclusive)
		end

	is_active: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_active (item)
		end

	draw_well_inside_ (a_inside_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_well_inside_ (item, a_inside_rect.item)
		end

	is_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bordered (item)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	take_color_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_color_from_ (item, a_sender__item)
		end

	set_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_color_ (item, a_color__item)
		end

	color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSColorWell Externals

	objc_deactivate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item deactivate];
			 ]"
		end

	objc_activate_ (an_item: POINTER; a_exclusive: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item activate:$a_exclusive];
			 ]"
		end

	objc_is_active (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorWell *)$an_item isActive];
			 ]"
		end

	objc_draw_well_inside_ (an_item: POINTER; a_inside_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item drawWellInside:*((NSRect *)$a_inside_rect)];
			 ]"
		end

	objc_is_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorWell *)$an_item isBordered];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_take_color_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item takeColorFrom:$a_sender];
			 ]"
		end

	objc_set_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorWell *)$an_item setColor:$a_color];
			 ]"
		end

	objc_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorWell *)$an_item color];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColorWell"
		end

end
