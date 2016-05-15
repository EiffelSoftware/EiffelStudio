note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ERROR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_domain__code__user_info_,
	make

feature {NONE} -- Initialization

	make_with_domain__code__user_info_ (a_domain: detachable NS_STRING; a_code: INTEGER_64; a_dict: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_domain__item: POINTER
			a_dict__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			make_with_pointer (objc_init_with_domain__code__user_info_(allocate_object, a_domain__item, a_code, a_dict__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSError Externals

	objc_init_with_domain__code__user_info_ (an_item: POINTER; a_domain: POINTER; a_code: INTEGER_64; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item initWithDomain:$a_domain code:$a_code userInfo:$a_dict];
			 ]"
		end

	objc_domain (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item domain];
			 ]"
		end

	objc_code (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSError *)$an_item code];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item userInfo];
			 ]"
		end

	objc_localized_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item localizedDescription];
			 ]"
		end

	objc_localized_failure_reason (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item localizedFailureReason];
			 ]"
		end

	objc_localized_recovery_suggestion (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item localizedRecoverySuggestion];
			 ]"
		end

	objc_localized_recovery_options (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item localizedRecoveryOptions];
			 ]"
		end

	objc_recovery_attempter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item recoveryAttempter];
			 ]"
		end

	objc_help_anchor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSError *)$an_item helpAnchor];
			 ]"
		end

feature -- NSError

	domain: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_domain (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like domain} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like domain} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	code: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_code (item)
		end

	user_info: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_description: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_failure_reason: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_failure_reason (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_failure_reason} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_failure_reason} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_recovery_suggestion: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_recovery_suggestion (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_recovery_suggestion} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_recovery_suggestion} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_recovery_options: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_recovery_options (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_recovery_options} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_recovery_options} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	recovery_attempter: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recovery_attempter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recovery_attempter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recovery_attempter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	help_anchor: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_help_anchor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like help_anchor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like help_anchor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSError"
		end

end
