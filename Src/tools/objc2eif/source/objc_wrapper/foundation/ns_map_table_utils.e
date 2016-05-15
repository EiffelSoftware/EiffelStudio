note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MAP_TABLE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSMapTable

	map_table_with_key_options__value_options_ (a_key_options: NATURAL_64; a_value_options: NATURAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_map_table_with_key_options__value_options_ (l_objc_class.item, a_key_options, a_value_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like map_table_with_key_options__value_options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like map_table_with_key_options__value_options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	map_table_with_strong_to_strong_objects: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_map_table_with_strong_to_strong_objects (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like map_table_with_strong_to_strong_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like map_table_with_strong_to_strong_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	map_table_with_weak_to_strong_objects: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_map_table_with_weak_to_strong_objects (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like map_table_with_weak_to_strong_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like map_table_with_weak_to_strong_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	map_table_with_strong_to_weak_objects: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_map_table_with_strong_to_weak_objects (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like map_table_with_strong_to_weak_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like map_table_with_strong_to_weak_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	map_table_with_weak_to_weak_objects: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_map_table_with_weak_to_weak_objects (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like map_table_with_weak_to_weak_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like map_table_with_weak_to_weak_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSMapTable Externals

	objc_map_table_with_key_options__value_options_ (a_class_object: POINTER; a_key_options: NATURAL_64; a_value_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mapTableWithKeyOptions:$a_key_options valueOptions:$a_value_options];
			 ]"
		end

	objc_map_table_with_strong_to_strong_objects (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mapTableWithStrongToStrongObjects];
			 ]"
		end

	objc_map_table_with_weak_to_strong_objects (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mapTableWithWeakToStrongObjects];
			 ]"
		end

	objc_map_table_with_strong_to_weak_objects (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mapTableWithStrongToWeakObjects];
			 ]"
		end

	objc_map_table_with_weak_to_weak_objects (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mapTableWithWeakToWeakObjects];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMapTable"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
