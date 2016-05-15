note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SORT_DESCRIPTOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSSortDescriptor

	sort_descriptor_with_key__ascending_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_sort_descriptor_with_key__ascending_ (l_objc_class.item, a_key__item, a_ascending)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptor_with_key__ascending_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptor_with_key__ascending_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sort_descriptor_with_key__ascending__selector_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN; a_selector: detachable OBJC_SELECTOR): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
			a_selector__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_sort_descriptor_with_key__ascending__selector_ (l_objc_class.item, a_key__item, a_ascending, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptor_with_key__ascending__selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptor_with_key__ascending__selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	sort_descriptor_with_key__ascending__comparator_ (a_key: detachable NS_STRING; a_ascending: BOOLEAN; a_cmptr: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_key__item: POINTER
--		do
--			if attached a_key as a_key_attached then
--				a_key__item := a_key_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_sort_descriptor_with_key__ascending__comparator_ (l_objc_class.item, a_key__item, a_ascending, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like sort_descriptor_with_key__ascending__comparator_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like sort_descriptor_with_key__ascending__comparator_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSSortDescriptor Externals

	objc_sort_descriptor_with_key__ascending_ (a_class_object: POINTER; a_key: POINTER; a_ascending: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sortDescriptorWithKey:$a_key ascending:$a_ascending];
			 ]"
		end

	objc_sort_descriptor_with_key__ascending__selector_ (a_class_object: POINTER; a_key: POINTER; a_ascending: BOOLEAN; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sortDescriptorWithKey:$a_key ascending:$a_ascending selector:$a_selector];
			 ]"
		end

--	objc_sort_descriptor_with_key__ascending__comparator_ (a_class_object: POINTER; a_key: POINTER; a_ascending: BOOLEAN; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object sortDescriptorWithKey:$a_key ascending:$a_ascending comparator:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSortDescriptor"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
