note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CREDENTIAL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_user__password__persistence_,
	make

feature -- NSURLCredential

	persistence: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_persistence (item)
		end

feature {NONE} -- NSURLCredential Externals

	objc_persistence (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCredential *)$an_item persistence];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_user__password__persistence_ (a_user: detachable NS_STRING; a_password: detachable NS_STRING; a_persistence: NATURAL_64)
			-- Initialize `Current'.
		local
			a_user__item: POINTER
			a_password__item: POINTER
		do
			if attached a_user as a_user_attached then
				a_user__item := a_user_attached.item
			end
			if attached a_password as a_password_attached then
				a_password__item := a_password_attached.item
			end
			make_with_pointer (objc_init_with_user__password__persistence_(allocate_object, a_user__item, a_password__item, a_persistence))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_identity__certificates__persistence_ (a_identity: UNSUPPORTED_TYPE; a_cert_array: detachable NS_ARRAY; a_persistence: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_identity__item: POINTER
--			a_cert_array__item: POINTER
--		do
--			if attached a_identity as a_identity_attached then
--				a_identity__item := a_identity_attached.item
--			end
--			if attached a_cert_array as a_cert_array_attached then
--				a_cert_array__item := a_cert_array_attached.item
--			end
--			make_with_pointer (objc_init_with_identity__certificates__persistence_(allocate_object, a_identity__item, a_cert_array__item, a_persistence))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_trust_ (a_trust: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_trust__item: POINTER
--		do
--			if attached a_trust as a_trust_attached then
--				a_trust__item := a_trust_attached.item
--			end
--			make_with_pointer (objc_init_with_trust_(allocate_object, a_trust__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSInternetPassword Externals

	objc_init_with_user__password__persistence_ (an_item: POINTER; a_user: POINTER; a_password: POINTER; a_persistence: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredential *)$an_item initWithUser:$a_user password:$a_password persistence:$a_persistence];
			 ]"
		end

	objc_user (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredential *)$an_item user];
			 ]"
		end

	objc_password (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredential *)$an_item password];
			 ]"
		end

	objc_has_password (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLCredential *)$an_item hasPassword];
			 ]"
		end

feature -- NSInternetPassword

	user: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	password: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_password (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like password} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like password} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	has_password: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_password (item)
		end

feature {NONE} -- NSClientCertificate Externals

--	objc_init_with_identity__certificates__persistence_ (an_item: POINTER; a_identity: UNSUPPORTED_TYPE; a_cert_array: POINTER; a_persistence: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURLCredential *)$an_item initWithIdentity: certificates:$a_cert_array persistence:$a_persistence];
--			 ]"
--		end

--	objc_identity (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURLCredential *)$an_item identity];
--			 ]"
--		end

	objc_certificates (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLCredential *)$an_item certificates];
			 ]"
		end

feature -- NSClientCertificate

--	identity: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_identity (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like identity} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like identity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	certificates: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_certificates (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like certificates} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like certificates} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSServerTrust Externals

--	objc_init_with_trust_ (an_item: POINTER; a_trust: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURLCredential *)$an_item initWithTrust:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLCredential"
		end

end
