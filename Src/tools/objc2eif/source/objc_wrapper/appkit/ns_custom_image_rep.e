note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CUSTOM_IMAGE_REP

inherit
	NS_IMAGE_REP
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_draw_selector__delegate_,
	make

feature {NONE} -- Initialization

	make_with_draw_selector__delegate_ (a_method: detachable OBJC_SELECTOR; an_object: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_method__item: POINTER
			an_object__item: POINTER
		do
			if attached a_method as a_method_attached then
				a_method__item := a_method_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			make_with_pointer (objc_init_with_draw_selector__delegate_(allocate_object, a_method__item, an_object__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCustomImageRep Externals

	objc_init_with_draw_selector__delegate_ (an_item: POINTER; a_method: POINTER; an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCustomImageRep *)$an_item initWithDrawSelector:$a_method delegate:$an_object];
			 ]"
		end

	objc_draw_selector (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCustomImageRep *)$an_item drawSelector];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCustomImageRep *)$an_item delegate];
			 ]"
		end

feature -- NSCustomImageRep

	draw_selector: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_draw_selector (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	delegate: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCustomImageRep"
		end

end
