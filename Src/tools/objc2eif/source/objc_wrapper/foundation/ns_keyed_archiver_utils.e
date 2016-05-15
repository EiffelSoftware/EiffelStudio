note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_KEYED_ARCHIVER_UTILS

inherit
	NS_CODER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSKeyedArchiver

	archived_data_with_root_object_ (a_root_object: detachable NS_OBJECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_root_object__item: POINTER
		do
			if attached a_root_object as a_root_object_attached then
				a_root_object__item := a_root_object_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_archived_data_with_root_object_ (l_objc_class.item, a_root_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like archived_data_with_root_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like archived_data_with_root_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	archive_root_object__to_file_ (a_root_object: detachable NS_OBJECT; a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_root_object__item: POINTER
			a_path__item: POINTER
		do
			if attached a_root_object as a_root_object_attached then
				a_root_object__item := a_root_object_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_archive_root_object__to_file_ (l_objc_class.item, a_root_object__item, a_path__item)
		end

	set_class_name__for_class_ (a_coded_name: detachable NS_STRING; a_cls: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_coded_name__item: POINTER
			a_cls__item: POINTER
		do
			if attached a_coded_name as a_coded_name_attached then
				a_coded_name__item := a_coded_name_attached.item
			end
			if attached a_cls as a_cls_attached then
				a_cls__item := a_cls_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_class_name__for_class_ (l_objc_class.item, a_coded_name__item, a_cls__item)
		end

	class_name_for_class_ (a_cls: detachable OBJC_CLASS): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_cls__item: POINTER
		do
			if attached a_cls as a_cls_attached then
				a_cls__item := a_cls_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_name_for_class_ (l_objc_class.item, a_cls__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_name_for_class_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_name_for_class_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyedArchiver Externals

	objc_archived_data_with_root_object_ (a_class_object: POINTER; a_root_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object archivedDataWithRootObject:$a_root_object];
			 ]"
		end

	objc_archive_root_object__to_file_ (a_class_object: POINTER; a_root_object: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object archiveRootObject:$a_root_object toFile:$a_path];
			 ]"
		end

	objc_set_class_name__for_class_ (a_class_object: POINTER; a_coded_name: POINTER; a_cls: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setClassName:$a_coded_name forClass:$a_cls];
			 ]"
		end

	objc_class_name_for_class_ (a_class_object: POINTER; a_cls: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object classNameForClass:$a_cls];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSKeyedArchiver"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
