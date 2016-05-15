note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CREDENTIAL_STORAGE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSURLCredentialStorage

	credentials_for_protection_space_ (a_space: detachable NS_URL_PROTECTION_SPACE): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_space__item: POINTER
		do
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			result_pointer := objc_credentials_for_protection_space_ (item, a_space__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like credentials_for_protection_space_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like credentials_for_protection_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_credentials: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_credentials (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_credentials} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_credentials} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_credential__for_protection_space_ (a_credential: detachable NS_URL_CREDENTIAL; a_space: detachable NS_URL_PROTECTION_SPACE)
			-- Auto generated Objective-C wrapper.
		local
			a_credential__item: POINTER
			a_space__item: POINTER
		do
			if attached a_credential as a_credential_attached then
				a_credential__item := a_credential_attached.item
			end
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			objc_set_credential__for_protection_space_ (item, a_credential__item, a_space__item)
		end

	remove_credential__for_protection_space_ (a_credential: detachable NS_URL_CREDENTIAL; a_space: detachable NS_URL_PROTECTION_SPACE)
			-- Auto generated Objective-C wrapper.
		local
			a_credential__item: POINTER
			a_space__item: POINTER
		do
			if attached a_credential as a_credential_attached then
				a_credential__item := a_credential_attached.item
			end
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			objc_remove_credential__for_protection_space_ (item, a_credential__item, a_space__item)
		end

	default_credential_for_protection_space_ (a_space: detachable NS_URL_PROTECTION_SPACE): detachable NS_URL_CREDENTIAL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_space__item: POINTER
		do
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			result_pointer := objc_default_credential_for_protection_space_ (item, a_space__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_credential_for_protection_space_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_credential_for_protection_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_default_credential__for_protection_space_ (a_credential: detachable NS_URL_CREDENTIAL; a_space: detachable NS_URL_PROTECTION_SPACE)
			-- Auto generated Objective-C wrapper.
		local
			a_credential__item: POINTER
			a_space__item: POINTER
		do
			if attached a_credential as a_credential_attached then
				a_credential__item := a_credential_attached.item
			end
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			objc_set_default_credential__for_protection_space_ (item, a_credential__item, a_space__item)
		end

feature {NONE} -- NSURLCredentialStorage Externals

	objc_credentials_for_protection_space_ (an_item: POINTER; a_space: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredentialStorage *)$an_item credentialsForProtectionSpace:$a_space];
			 ]"
		end

	objc_all_credentials (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredentialStorage *)$an_item allCredentials];
			 ]"
		end

	objc_set_credential__for_protection_space_ (an_item: POINTER; a_credential: POINTER; a_space: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCredentialStorage *)$an_item setCredential:$a_credential forProtectionSpace:$a_space];
			 ]"
		end

	objc_remove_credential__for_protection_space_ (an_item: POINTER; a_credential: POINTER; a_space: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCredentialStorage *)$an_item removeCredential:$a_credential forProtectionSpace:$a_space];
			 ]"
		end

	objc_default_credential_for_protection_space_ (an_item: POINTER; a_space: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredentialStorage *)$an_item defaultCredentialForProtectionSpace:$a_space];
			 ]"
		end

	objc_set_default_credential__for_protection_space_ (an_item: POINTER; a_credential: POINTER; a_space: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLCredentialStorage *)$an_item setDefaultCredential:$a_credential forProtectionSpace:$a_space];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLCredentialStorage"
		end

end
