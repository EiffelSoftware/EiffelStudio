note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_KEYED_UNARCHIVER_UTILS

inherit
	NS_CODER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSKeyedUnarchiver

	unarchive_object_with_data_ (a_data: detachable NS_DATA): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_unarchive_object_with_data_ (l_objc_class.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like unarchive_object_with_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like unarchive_object_with_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	unarchive_object_with_file_ (a_path: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_unarchive_object_with_file_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like unarchive_object_with_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like unarchive_object_with_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_class__for_class_name_ (a_cls: detachable OBJC_CLASS; a_coded_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_cls__item: POINTER
			a_coded_name__item: POINTER
		do
			if attached a_cls as a_cls_attached then
				a_cls__item := a_cls_attached.item
			end
			if attached a_coded_name as a_coded_name_attached then
				a_coded_name__item := a_coded_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_class__for_class_name_ (l_objc_class.item, a_cls__item, a_coded_name__item)
		end

	class_for_class_name_ (a_coded_name: detachable NS_STRING): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_coded_name__item: POINTER
		do
			if attached a_coded_name as a_coded_name_attached then
				a_coded_name__item := a_coded_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_for_class_name_ (l_objc_class.item, a_coded_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_class_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_class_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyedUnarchiver Externals

	objc_unarchive_object_with_data_ (a_class_object: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object unarchiveObjectWithData:$a_data];
			 ]"
		end

	objc_unarchive_object_with_file_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object unarchiveObjectWithFile:$a_path];
			 ]"
		end

	objc_set_class__for_class_name_ (a_class_object: POINTER; a_cls: POINTER; a_coded_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setClass:$a_cls forClassName:$a_coded_name];
			 ]"
		end

	objc_class_for_class_name_ (a_class_object: POINTER; a_coded_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object classForClassName:$a_coded_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSKeyedUnarchiver"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
