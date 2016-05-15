note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDictionaryCreation

	dictionary: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dictionary_with_object__for_key_ (a_object: detachable NS_OBJECT; a_key: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_object__item: POINTER
			a_key__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary_with_object__for_key_ (l_objc_class.item, a_object__item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_object__for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_object__for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	dictionary_with_objects__for_keys__count_ (a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE; a_cnt: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_objects__item: POINTER
--			a_keys__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_dictionary_with_objects__for_keys__count_ (l_objc_class.item, a_objects__item, a_keys__item, a_cnt)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like dictionary_with_objects__for_keys__count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like dictionary_with_objects__for_keys__count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	dictionary_with_dictionary_ (a_dict: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary_with_dictionary_ (l_objc_class.item, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_dictionary_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_dictionary_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dictionary_with_objects__for_keys_ (a_objects: detachable NS_ARRAY; a_keys: detachable NS_ARRAY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_objects__item: POINTER
			a_keys__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary_with_objects__for_keys_ (l_objc_class.item, a_objects__item, a_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_objects__for_keys_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_objects__for_keys_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dictionary_with_contents_of_file_ (a_path: detachable NS_STRING): detachable NS_OBJECT
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
			result_pointer := objc_dictionary_with_contents_of_file_ (l_objc_class.item, a_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_contents_of_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_contents_of_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dictionary_with_contents_of_ur_l_ (a_url: detachable NS_URL): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary_with_contents_of_ur_l_ (l_objc_class.item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_contents_of_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_contents_of_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDictionaryCreation Externals

	objc_dictionary (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionary];
			 ]"
		end

	objc_dictionary_with_object__for_key_ (a_class_object: POINTER; a_object: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithObject:$a_object forKey:$a_key];
			 ]"
		end

--	objc_dictionary_with_objects__for_keys__count_ (a_class_object: POINTER; a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE; a_cnt: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithObjects: forKeys: count:$a_cnt];
--			 ]"
--		end

	objc_dictionary_with_dictionary_ (a_class_object: POINTER; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithDictionary:$a_dict];
			 ]"
		end

	objc_dictionary_with_objects__for_keys_ (a_class_object: POINTER; a_objects: POINTER; a_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithObjects:$a_objects forKeys:$a_keys];
			 ]"
		end

	objc_dictionary_with_contents_of_file_ (a_class_object: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithContentsOfFile:$a_path];
			 ]"
		end

	objc_dictionary_with_contents_of_ur_l_ (a_class_object: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryWithContentsOfURL:$a_url];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDictionary"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
