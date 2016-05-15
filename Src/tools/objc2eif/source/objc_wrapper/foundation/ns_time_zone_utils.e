note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIME_ZONE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSExtendedTimeZone

	system_time_zone: detachable NS_TIME_ZONE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_system_time_zone (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like system_time_zone} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like system_time_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reset_system_time_zone
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_reset_system_time_zone (l_objc_class.item)
		end

	default_time_zone: detachable NS_TIME_ZONE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_time_zone (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_time_zone} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_time_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_default_time_zone_ (a_time_zone: detachable NS_TIME_ZONE)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_time_zone__item: POINTER
		do
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_time_zone_ (l_objc_class.item, a_time_zone__item)
		end

	local_time_zone: detachable NS_TIME_ZONE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_local_time_zone (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like local_time_zone} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like local_time_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	known_time_zone_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_known_time_zone_names (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like known_time_zone_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like known_time_zone_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	abbreviation_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_abbreviation_dictionary (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like abbreviation_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like abbreviation_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_abbreviation_dictionary_ (a_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_abbreviation_dictionary_ (l_objc_class.item, a_dict__item)
		end

	time_zone_data_version: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_time_zone_data_version (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone_data_version} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone_data_version} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtendedTimeZone Externals

	objc_system_time_zone (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object systemTimeZone];
			 ]"
		end

	objc_reset_system_time_zone (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object resetSystemTimeZone];
			 ]"
		end

	objc_default_time_zone (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultTimeZone];
			 ]"
		end

	objc_set_default_time_zone_ (a_class_object: POINTER; a_time_zone: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultTimeZone:$a_time_zone];
			 ]"
		end

	objc_local_time_zone (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localTimeZone];
			 ]"
		end

	objc_known_time_zone_names (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object knownTimeZoneNames];
			 ]"
		end

	objc_abbreviation_dictionary (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object abbreviationDictionary];
			 ]"
		end

	objc_set_abbreviation_dictionary_ (a_class_object: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setAbbreviationDictionary:$a_dict];
			 ]"
		end

	objc_time_zone_data_version (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timeZoneDataVersion];
			 ]"
		end

feature -- NSTimeZoneCreation

	time_zone_with_name_ (a_tz_name: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_tz_name__item: POINTER
		do
			if attached a_tz_name as a_tz_name_attached then
				a_tz_name__item := a_tz_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_time_zone_with_name_ (l_objc_class.item, a_tz_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone_with_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone_with_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	time_zone_with_name__data_ (a_tz_name: detachable NS_STRING; a_data: detachable NS_DATA): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_tz_name__item: POINTER
			a_data__item: POINTER
		do
			if attached a_tz_name as a_tz_name_attached then
				a_tz_name__item := a_tz_name_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_time_zone_with_name__data_ (l_objc_class.item, a_tz_name__item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone_with_name__data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone_with_name__data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	time_zone_for_seconds_from_gm_t_ (a_seconds: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_time_zone_for_seconds_from_gm_t_ (l_objc_class.item, a_seconds)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone_for_seconds_from_gm_t_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone_for_seconds_from_gm_t_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	time_zone_with_abbreviation_ (a_abbreviation: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_abbreviation__item: POINTER
		do
			if attached a_abbreviation as a_abbreviation_attached then
				a_abbreviation__item := a_abbreviation_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_time_zone_with_abbreviation_ (l_objc_class.item, a_abbreviation__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone_with_abbreviation_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone_with_abbreviation_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTimeZoneCreation Externals

	objc_time_zone_with_name_ (a_class_object: POINTER; a_tz_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timeZoneWithName:$a_tz_name];
			 ]"
		end

	objc_time_zone_with_name__data_ (a_class_object: POINTER; a_tz_name: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timeZoneWithName:$a_tz_name data:$a_data];
			 ]"
		end

	objc_time_zone_for_seconds_from_gm_t_ (a_class_object: POINTER; a_seconds: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timeZoneForSecondsFromGMT:$a_seconds];
			 ]"
		end

	objc_time_zone_with_abbreviation_ (a_class_object: POINTER; a_abbreviation: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timeZoneWithAbbreviation:$a_abbreviation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTimeZone"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
