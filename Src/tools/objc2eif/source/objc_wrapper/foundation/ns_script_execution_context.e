note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_EXECUTION_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSScriptExecutionContext

	top_level_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_top_level_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like top_level_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like top_level_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_top_level_object_ (a_obj: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_top_level_object_ (item, a_obj__item)
		end

	object_being_tested: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_being_tested (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_being_tested} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_being_tested} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_object_being_tested_ (a_obj: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_object_being_tested_ (item, a_obj__item)
		end

	range_container_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_range_container_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like range_container_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like range_container_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_range_container_object_ (a_obj: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_range_container_object_ (item, a_obj__item)
		end

feature {NONE} -- NSScriptExecutionContext Externals

	objc_top_level_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptExecutionContext *)$an_item topLevelObject];
			 ]"
		end

	objc_set_top_level_object_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptExecutionContext *)$an_item setTopLevelObject:$a_obj];
			 ]"
		end

	objc_object_being_tested (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptExecutionContext *)$an_item objectBeingTested];
			 ]"
		end

	objc_set_object_being_tested_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptExecutionContext *)$an_item setObjectBeingTested:$a_obj];
			 ]"
		end

	objc_range_container_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptExecutionContext *)$an_item rangeContainerObject];
			 ]"
		end

	objc_set_range_container_object_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptExecutionContext *)$an_item setRangeContainerObject:$a_obj];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptExecutionContext"
		end

end
