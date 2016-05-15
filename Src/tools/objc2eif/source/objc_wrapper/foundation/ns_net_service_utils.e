note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NET_SERVICE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSNetService

	dictionary_from_txt_record_data_ (a_txt_data: detachable NS_DATA): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_txt_data__item: POINTER
		do
			if attached a_txt_data as a_txt_data_attached then
				a_txt_data__item := a_txt_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dictionary_from_txt_record_data_ (l_objc_class.item, a_txt_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_from_txt_record_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_from_txt_record_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_from_txt_record_dictionary_ (a_txt_dictionary: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_txt_dictionary__item: POINTER
		do
			if attached a_txt_dictionary as a_txt_dictionary_attached then
				a_txt_dictionary__item := a_txt_dictionary_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_data_from_txt_record_dictionary_ (l_objc_class.item, a_txt_dictionary__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_from_txt_record_dictionary_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_from_txt_record_dictionary_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSNetService Externals

	objc_dictionary_from_txt_record_data_ (a_class_object: POINTER; a_txt_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dictionaryFromTXTRecordData:$a_txt_data];
			 ]"
		end

	objc_data_from_txt_record_dictionary_ (a_class_object: POINTER; a_txt_dictionary: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dataFromTXTRecordDictionary:$a_txt_dictionary];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNetService"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
