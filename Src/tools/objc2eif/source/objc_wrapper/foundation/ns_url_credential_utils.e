note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CREDENTIAL_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSInternetPassword

	credential_with_user__password__persistence_ (a_user: detachable NS_STRING; a_password: detachable NS_STRING; a_persistence: NATURAL_64): detachable NS_URL_CREDENTIAL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_user__item: POINTER
			a_password__item: POINTER
		do
			if attached a_user as a_user_attached then
				a_user__item := a_user_attached.item
			end
			if attached a_password as a_password_attached then
				a_password__item := a_password_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_credential_with_user__password__persistence_ (l_objc_class.item, a_user__item, a_password__item, a_persistence)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like credential_with_user__password__persistence_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like credential_with_user__password__persistence_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSInternetPassword Externals

	objc_credential_with_user__password__persistence_ (a_class_object: POINTER; a_user: POINTER; a_password: POINTER; a_persistence: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object credentialWithUser:$a_user password:$a_password persistence:$a_persistence];
			 ]"
		end

feature -- NSClientCertificate

--	credential_with_identity__certificates__persistence_ (a_identity: UNSUPPORTED_TYPE; a_cert_array: detachable NS_ARRAY; a_persistence: NATURAL_64): detachable NS_URL_CREDENTIAL
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_identity__item: POINTER
--			a_cert_array__item: POINTER
--		do
--			if attached a_identity as a_identity_attached then
--				a_identity__item := a_identity_attached.item
--			end
--			if attached a_cert_array as a_cert_array_attached then
--				a_cert_array__item := a_cert_array_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_credential_with_identity__certificates__persistence_ (l_objc_class.item, a_identity__item, a_cert_array__item, a_persistence)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like credential_with_identity__certificates__persistence_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like credential_with_identity__certificates__persistence_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSClientCertificate Externals

--	objc_credential_with_identity__certificates__persistence_ (a_class_object: POINTER; a_identity: UNSUPPORTED_TYPE; a_cert_array: POINTER; a_persistence: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object credentialWithIdentity: certificates:$a_cert_array persistence:$a_persistence];
--			 ]"
--		end

feature -- NSServerTrust

--	credential_for_trust_ (a_trust: UNSUPPORTED_TYPE): detachable NS_URL_CREDENTIAL
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_trust__item: POINTER
--		do
--			if attached a_trust as a_trust_attached then
--				a_trust__item := a_trust_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_credential_for_trust_ (l_objc_class.item, a_trust__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like credential_for_trust_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like credential_for_trust_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSServerTrust Externals

--	objc_credential_for_trust_ (a_class_object: POINTER; a_trust: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object credentialForTrust:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLCredential"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
