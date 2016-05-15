note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW_ANIMATION

inherit
	NS_ANIMATION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_view_animations_,
	make_with_duration__animation_curve_,
	make

feature {NONE} -- Initialization

	make_with_view_animations_ (a_view_animations: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_view_animations__item: POINTER
		do
			if attached a_view_animations as a_view_animations_attached then
				a_view_animations__item := a_view_animations_attached.item
			end
			make_with_pointer (objc_init_with_view_animations_(allocate_object, a_view_animations__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSViewAnimation Externals

	objc_init_with_view_animations_ (an_item: POINTER; a_view_animations: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewAnimation *)$an_item initWithViewAnimations:$a_view_animations];
			 ]"
		end

	objc_view_animations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSViewAnimation *)$an_item viewAnimations];
			 ]"
		end

	objc_set_view_animations_ (an_item: POINTER; a_view_animations: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSViewAnimation *)$an_item setViewAnimations:$a_view_animations];
			 ]"
		end

feature -- NSViewAnimation

	view_animations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view_animations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view_animations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view_animations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_view_animations_ (a_view_animations: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_view_animations__item: POINTER
		do
			if attached a_view_animations as a_view_animations_attached then
				a_view_animations__item := a_view_animations_attached.item
			end
			objc_set_view_animations_ (item, a_view_animations__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSViewAnimation"
		end

end
