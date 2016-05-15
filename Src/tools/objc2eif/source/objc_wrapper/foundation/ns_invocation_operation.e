note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INVOCATION_OPERATION

inherit
	NS_OPERATION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_target__selector__object_,
	make_with_invocation_,
	make

feature {NONE} -- Initialization

	make_with_target__selector__object_ (a_target: detachable NS_OBJECT; a_sel: detachable OBJC_SELECTOR; a_arg: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_target__item: POINTER
			a_sel__item: POINTER
			a_arg__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_sel as a_sel_attached then
				a_sel__item := a_sel_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			make_with_pointer (objc_init_with_target__selector__object_(allocate_object, a_target__item, a_sel__item, a_arg__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_invocation_ (a_inv: detachable NS_INVOCATION)
			-- Initialize `Current'.
		local
			a_inv__item: POINTER
		do
			if attached a_inv as a_inv_attached then
				a_inv__item := a_inv_attached.item
			end
			make_with_pointer (objc_init_with_invocation_(allocate_object, a_inv__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSInvocationOperation Externals

	objc_init_with_target__selector__object_ (an_item: POINTER; a_target: POINTER; a_sel: POINTER; a_arg: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocationOperation *)$an_item initWithTarget:$a_target selector:$a_sel object:$a_arg];
			 ]"
		end

	objc_init_with_invocation_ (an_item: POINTER; a_inv: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocationOperation *)$an_item initWithInvocation:$a_inv];
			 ]"
		end

	objc_invocation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocationOperation *)$an_item invocation];
			 ]"
		end

	objc_result_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocationOperation *)$an_item result];
			 ]"
		end

feature -- NSInvocationOperation

	invocation: detachable NS_INVOCATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_invocation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like invocation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like invocation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	result_objc: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_result_objc (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like result_objc} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like result_objc} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInvocationOperation"
		end

end
