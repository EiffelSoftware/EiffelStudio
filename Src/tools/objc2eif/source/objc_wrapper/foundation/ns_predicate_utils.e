note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PREDICATE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPredicate

	predicate_with_format__argument_array_ (a_predicate_format: detachable NS_STRING; a_arguments: detachable NS_ARRAY): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_predicate_format__item: POINTER
			a_arguments__item: POINTER
		do
			if attached a_predicate_format as a_predicate_format_attached then
				a_predicate_format__item := a_predicate_format_attached.item
			end
			if attached a_arguments as a_arguments_attached then
				a_arguments__item := a_arguments_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_predicate_with_format__argument_array_ (l_objc_class.item, a_predicate_format__item, a_arguments__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_format__argument_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_format__argument_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	predicate_with_format__arguments_ (a_predicate_format: detachable NS_STRING; a_arg_list: UNSUPPORTED_TYPE): detachable NS_PREDICATE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_predicate_format__item: POINTER
--			a_arg_list__item: POINTER
--		do
--			if attached a_predicate_format as a_predicate_format_attached then
--				a_predicate_format__item := a_predicate_format_attached.item
--			end
--			if attached a_arg_list as a_arg_list_attached then
--				a_arg_list__item := a_arg_list_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_predicate_with_format__arguments_ (l_objc_class.item, a_predicate_format__item, a_arg_list__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like predicate_with_format__arguments_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like predicate_with_format__arguments_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	predicate_with_value_ (a_value: BOOLEAN): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_predicate_with_value_ (l_objc_class.item, a_value)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	predicate_with_block_ (a_block: UNSUPPORTED_TYPE): detachable NS_PREDICATE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_predicate_with_block_ (l_objc_class.item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like predicate_with_block_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like predicate_with_block_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSPredicate Externals

	objc_predicate_with_format__argument_array_ (a_class_object: POINTER; a_predicate_format: POINTER; a_arguments: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object predicateWithFormat:$a_predicate_format argumentArray:$a_arguments];
			 ]"
		end

--	objc_predicate_with_format__arguments_ (a_class_object: POINTER; a_predicate_format: POINTER; a_arg_list: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object predicateWithFormat:$a_predicate_format arguments:];
--			 ]"
--		end

	objc_predicate_with_value_ (a_class_object: POINTER; a_value: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object predicateWithValue:$a_value];
			 ]"
		end

--	objc_predicate_with_block_ (a_class_object: POINTER; a_block: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object predicateWithBlock:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPredicate"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
