note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_USER_DEFAULTS

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_user_

feature {NONE} -- Initialization

	make_with_user_ (a_username: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_username__item: POINTER
		do
			if attached a_username as a_username_attached then
				a_username__item := a_username_attached.item
			end
			make_with_pointer (objc_init_with_user_(allocate_object, a_username__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSUserDefaults Externals

	objc_init_with_user_ (an_item: POINTER; a_username: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item initWithUser:$a_username];
			 ]"
		end

	objc_object_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item objectForKey:$a_default_name];
			 ]"
		end

	objc_set_object__for_key_ (an_item: POINTER; a_value: POINTER; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setObject:$a_value forKey:$a_default_name];
			 ]"
		end

	objc_remove_object_for_key_ (an_item: POINTER; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item removeObjectForKey:$a_default_name];
			 ]"
		end

	objc_string_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item stringForKey:$a_default_name];
			 ]"
		end

	objc_array_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item arrayForKey:$a_default_name];
			 ]"
		end

	objc_dictionary_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item dictionaryForKey:$a_default_name];
			 ]"
		end

	objc_data_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item dataForKey:$a_default_name];
			 ]"
		end

	objc_string_array_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item stringArrayForKey:$a_default_name];
			 ]"
		end

	objc_integer_for_key_ (an_item: POINTER; a_default_name: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item integerForKey:$a_default_name];
			 ]"
		end

	objc_float_for_key_ (an_item: POINTER; a_default_name: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item floatForKey:$a_default_name];
			 ]"
		end

	objc_double_for_key_ (an_item: POINTER; a_default_name: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item doubleForKey:$a_default_name];
			 ]"
		end

	objc_bool_for_key_ (an_item: POINTER; a_default_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item boolForKey:$a_default_name];
			 ]"
		end

	objc_url_for_key_ (an_item: POINTER; a_default_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item URLForKey:$a_default_name];
			 ]"
		end

	objc_set_integer__for_key_ (an_item: POINTER; a_value: INTEGER_64; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setInteger:$a_value forKey:$a_default_name];
			 ]"
		end

	objc_set_float__for_key_ (an_item: POINTER; a_value: REAL_32; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setFloat:$a_value forKey:$a_default_name];
			 ]"
		end

	objc_set_double__for_key_ (an_item: POINTER; a_value: REAL_64; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setDouble:$a_value forKey:$a_default_name];
			 ]"
		end

	objc_set_bool__for_key_ (an_item: POINTER; a_value: BOOLEAN; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setBool:$a_value forKey:$a_default_name];
			 ]"
		end

	objc_set_ur_l__for_key_ (an_item: POINTER; a_url: POINTER; a_default_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setURL:$a_url forKey:$a_default_name];
			 ]"
		end

	objc_register_defaults_ (an_item: POINTER; a_registration_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item registerDefaults:$a_registration_dictionary];
			 ]"
		end

	objc_add_suite_named_ (an_item: POINTER; a_suite_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item addSuiteNamed:$a_suite_name];
			 ]"
		end

	objc_remove_suite_named_ (an_item: POINTER; a_suite_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item removeSuiteNamed:$a_suite_name];
			 ]"
		end

	objc_dictionary_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item dictionaryRepresentation];
			 ]"
		end

	objc_volatile_domain_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item volatileDomainNames];
			 ]"
		end

	objc_volatile_domain_for_name_ (an_item: POINTER; a_domain_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item volatileDomainForName:$a_domain_name];
			 ]"
		end

	objc_set_volatile_domain__for_name_ (an_item: POINTER; a_domain: POINTER; a_domain_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setVolatileDomain:$a_domain forName:$a_domain_name];
			 ]"
		end

	objc_remove_volatile_domain_for_name_ (an_item: POINTER; a_domain_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item removeVolatileDomainForName:$a_domain_name];
			 ]"
		end

	objc_persistent_domain_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item persistentDomainNames];
			 ]"
		end

	objc_persistent_domain_for_name_ (an_item: POINTER; a_domain_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUserDefaults *)$an_item persistentDomainForName:$a_domain_name];
			 ]"
		end

	objc_set_persistent_domain__for_name_ (an_item: POINTER; a_domain: POINTER; a_domain_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item setPersistentDomain:$a_domain forName:$a_domain_name];
			 ]"
		end

	objc_remove_persistent_domain_for_name_ (an_item: POINTER; a_domain_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUserDefaults *)$an_item removePersistentDomainForName:$a_domain_name];
			 ]"
		end

	objc_synchronize (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item synchronize];
			 ]"
		end

	objc_object_is_forced_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item objectIsForcedForKey:$a_key];
			 ]"
		end

	objc_object_is_forced_for_key__in_domain_ (an_item: POINTER; a_key: POINTER; a_domain: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUserDefaults *)$an_item objectIsForcedForKey:$a_key inDomain:$a_domain];
			 ]"
		end

feature -- NSUserDefaults

	object_for_key_ (a_default_name: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_object_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_object__for_key_ (a_value: detachable NS_OBJECT; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_default_name__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_object__for_key_ (item, a_value__item, a_default_name__item)
		end

	remove_object_for_key_ (a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_remove_object_for_key_ (item, a_default_name__item)
		end

	string_for_key_ (a_default_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_string_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	array_for_key_ (a_default_name: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_array_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like array_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like array_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dictionary_for_key_ (a_default_name: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_dictionary_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_for_key_ (a_default_name: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_data_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_array_for_key_ (a_default_name: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_string_array_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_array_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_array_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	integer_for_key_ (a_default_name: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			Result := objc_integer_for_key_ (item, a_default_name__item)
		end

	float_for_key_ (a_default_name: detachable NS_STRING): REAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			Result := objc_float_for_key_ (item, a_default_name__item)
		end

	double_for_key_ (a_default_name: detachable NS_STRING): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			Result := objc_double_for_key_ (item, a_default_name__item)
		end

	bool_for_key_ (a_default_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			Result := objc_bool_for_key_ (item, a_default_name__item)
		end

	url_for_key_ (a_default_name: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			result_pointer := objc_url_for_key_ (item, a_default_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_integer__for_key_ (a_value: INTEGER_64; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_integer__for_key_ (item, a_value, a_default_name__item)
		end

	set_float__for_key_ (a_value: REAL_32; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_float__for_key_ (item, a_value, a_default_name__item)
		end

	set_double__for_key_ (a_value: REAL_64; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_double__for_key_ (item, a_value, a_default_name__item)
		end

	set_bool__for_key_ (a_value: BOOLEAN; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_default_name__item: POINTER
		do
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_bool__for_key_ (item, a_value, a_default_name__item)
		end

	set_ur_l__for_key_ (a_url: detachable NS_URL; a_default_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
			a_default_name__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_default_name as a_default_name_attached then
				a_default_name__item := a_default_name_attached.item
			end
			objc_set_ur_l__for_key_ (item, a_url__item, a_default_name__item)
		end

	register_defaults_ (a_registration_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_registration_dictionary__item: POINTER
		do
			if attached a_registration_dictionary as a_registration_dictionary_attached then
				a_registration_dictionary__item := a_registration_dictionary_attached.item
			end
			objc_register_defaults_ (item, a_registration_dictionary__item)
		end

	add_suite_named_ (a_suite_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			objc_add_suite_named_ (item, a_suite_name__item)
		end

	remove_suite_named_ (a_suite_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			objc_remove_suite_named_ (item, a_suite_name__item)
		end

	dictionary_representation: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dictionary_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	volatile_domain_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_volatile_domain_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like volatile_domain_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like volatile_domain_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	volatile_domain_for_name_ (a_domain_name: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_domain_name__item: POINTER
		do
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			result_pointer := objc_volatile_domain_for_name_ (item, a_domain_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like volatile_domain_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like volatile_domain_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_volatile_domain__for_name_ (a_domain: detachable NS_DICTIONARY; a_domain_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_domain__item: POINTER
			a_domain_name__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			objc_set_volatile_domain__for_name_ (item, a_domain__item, a_domain_name__item)
		end

	remove_volatile_domain_for_name_ (a_domain_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_domain_name__item: POINTER
		do
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			objc_remove_volatile_domain_for_name_ (item, a_domain_name__item)
		end

	persistent_domain_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_persistent_domain_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_domain_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_domain_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	persistent_domain_for_name_ (a_domain_name: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_domain_name__item: POINTER
		do
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			result_pointer := objc_persistent_domain_for_name_ (item, a_domain_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_domain_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_domain_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_persistent_domain__for_name_ (a_domain: detachable NS_DICTIONARY; a_domain_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_domain__item: POINTER
			a_domain_name__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			objc_set_persistent_domain__for_name_ (item, a_domain__item, a_domain_name__item)
		end

	remove_persistent_domain_for_name_ (a_domain_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_domain_name__item: POINTER
		do
			if attached a_domain_name as a_domain_name_attached then
				a_domain_name__item := a_domain_name_attached.item
			end
			objc_remove_persistent_domain_for_name_ (item, a_domain_name__item)
		end

	synchronize: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_synchronize (item)
		end

	object_is_forced_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_object_is_forced_for_key_ (item, a_key__item)
		end

	object_is_forced_for_key__in_domain_ (a_key: detachable NS_STRING; a_domain: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_domain__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			Result := objc_object_is_forced_for_key__in_domain_ (item, a_key__item, a_domain__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSUserDefaults"
		end

end
