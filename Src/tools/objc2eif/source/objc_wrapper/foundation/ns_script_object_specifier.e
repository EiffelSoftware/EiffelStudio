note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_OBJECT_SPECIFIER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_specifier__key_ (a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_container__item: POINTER
			a_property__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			make_with_pointer (objc_init_with_container_specifier__key_(allocate_object, a_container__item, a_property__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_container_class_description__container_specifier__key_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
		do
			if attached a_class_desc as a_class_desc_attached then
				a_class_desc__item := a_class_desc_attached.item
			end
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key_(allocate_object, a_class_desc__item, a_container__item, a_property__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSScriptObjectSpecifier Externals

	objc_init_with_container_specifier__key_ (an_item: POINTER; a_container: POINTER; a_property: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item initWithContainerSpecifier:$a_container key:$a_property];
			 ]"
		end

	objc_init_with_container_class_description__container_specifier__key_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property];
			 ]"
		end

	objc_child_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item childSpecifier];
			 ]"
		end

	objc_set_child_specifier_ (an_item: POINTER; a_child: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setChildSpecifier:$a_child];
			 ]"
		end

	objc_container_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item containerSpecifier];
			 ]"
		end

	objc_set_container_specifier_ (an_item: POINTER; a_sub_ref: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setContainerSpecifier:$a_sub_ref];
			 ]"
		end

	objc_container_is_object_being_tested (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptObjectSpecifier *)$an_item containerIsObjectBeingTested];
			 ]"
		end

	objc_set_container_is_object_being_tested_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setContainerIsObjectBeingTested:$a_flag];
			 ]"
		end

	objc_container_is_range_container_object (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptObjectSpecifier *)$an_item containerIsRangeContainerObject];
			 ]"
		end

	objc_set_container_is_range_container_object_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setContainerIsRangeContainerObject:$a_flag];
			 ]"
		end

	objc_container_class_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item containerClassDescription];
			 ]"
		end

	objc_set_container_class_description_ (an_item: POINTER; a_class_desc: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setContainerClassDescription:$a_class_desc];
			 ]"
		end

	objc_key_class_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item keyClassDescription];
			 ]"
		end

--	objc_indices_of_objects_by_evaluating_with_container__count_ (an_item: POINTER; a_container: POINTER; a_count: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item indicesOfObjectsByEvaluatingWithContainer:$a_container count:];
--			 ]"
--		end

	objc_objects_by_evaluating_with_containers_ (an_item: POINTER; a_containers: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item objectsByEvaluatingWithContainers:$a_containers];
			 ]"
		end

	objc_objects_by_evaluating_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item objectsByEvaluatingSpecifier];
			 ]"
		end

	objc_evaluation_error_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptObjectSpecifier *)$an_item evaluationErrorNumber];
			 ]"
		end

	objc_set_evaluation_error_number_ (an_item: POINTER; a_error: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptObjectSpecifier *)$an_item setEvaluationErrorNumber:$a_error];
			 ]"
		end

	objc_evaluation_error_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item evaluationErrorSpecifier];
			 ]"
		end

	objc_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptObjectSpecifier *)$an_item descriptor];
			 ]"
		end

feature -- NSScriptObjectSpecifier

	child_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_child_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like child_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like child_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_child_specifier_ (a_child: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_set_child_specifier_ (item, a_child__item)
		end

	container_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_container_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like container_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like container_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_container_specifier_ (a_sub_ref: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_sub_ref__item: POINTER
		do
			if attached a_sub_ref as a_sub_ref_attached then
				a_sub_ref__item := a_sub_ref_attached.item
			end
			objc_set_container_specifier_ (item, a_sub_ref__item)
		end

	container_is_object_being_tested: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_container_is_object_being_tested (item)
		end

	set_container_is_object_being_tested_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_container_is_object_being_tested_ (item, a_flag)
		end

	container_is_range_container_object: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_container_is_range_container_object (item)
		end

	set_container_is_range_container_object_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_container_is_range_container_object_ (item, a_flag)
		end

	container_class_description: detachable NS_SCRIPT_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_container_class_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like container_class_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like container_class_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_container_class_description_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_class_desc__item: POINTER
		do
			if attached a_class_desc as a_class_desc_attached then
				a_class_desc__item := a_class_desc_attached.item
			end
			objc_set_container_class_description_ (item, a_class_desc__item)
		end

	key_class_description: detachable NS_SCRIPT_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_class_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_class_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_class_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	indices_of_objects_by_evaluating_with_container__count_ (a_container: detachable NS_OBJECT; a_count: UNSUPPORTED_TYPE): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_container__item: POINTER
--			a_count__item: POINTER
--		do
--			if attached a_container as a_container_attached then
--				a_container__item := a_container_attached.item
--			end
--			if attached a_count as a_count_attached then
--				a_count__item := a_count_attached.item
--			end
--			result_pointer := objc_indices_of_objects_by_evaluating_with_container__count_ (item, a_container__item, a_count__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indices_of_objects_by_evaluating_with_container__count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indices_of_objects_by_evaluating_with_container__count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	objects_by_evaluating_with_containers_ (a_containers: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_containers__item: POINTER
		do
			if attached a_containers as a_containers_attached then
				a_containers__item := a_containers_attached.item
			end
			result_pointer := objc_objects_by_evaluating_with_containers_ (item, a_containers__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like objects_by_evaluating_with_containers_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like objects_by_evaluating_with_containers_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	objects_by_evaluating_specifier: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_objects_by_evaluating_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like objects_by_evaluating_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like objects_by_evaluating_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	evaluation_error_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_evaluation_error_number (item)
		end

	set_evaluation_error_number_ (a_error: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_evaluation_error_number_ (item, a_error)
		end

	evaluation_error_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_evaluation_error_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like evaluation_error_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like evaluation_error_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_descriptor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptObjectSpecifier"
		end

end
