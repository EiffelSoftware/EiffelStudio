note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_PROTECTION_SPACE

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
	make_with_host__port__protocol__realm__authentication_method_,
	make_with_proxy_host__port__type__realm__authentication_method_,
	make

feature {NONE} -- Initialization

	make_with_host__port__protocol__realm__authentication_method_ (a_host: detachable NS_STRING; a_port: INTEGER_64; a_protocol: detachable NS_STRING; a_realm: detachable NS_STRING; a_authentication_method: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_host__item: POINTER
			a_protocol__item: POINTER
			a_realm__item: POINTER
			a_authentication_method__item: POINTER
		do
			if attached a_host as a_host_attached then
				a_host__item := a_host_attached.item
			end
			if attached a_protocol as a_protocol_attached then
				a_protocol__item := a_protocol_attached.item
			end
			if attached a_realm as a_realm_attached then
				a_realm__item := a_realm_attached.item
			end
			if attached a_authentication_method as a_authentication_method_attached then
				a_authentication_method__item := a_authentication_method_attached.item
			end
			make_with_pointer (objc_init_with_host__port__protocol__realm__authentication_method_(allocate_object, a_host__item, a_port, a_protocol__item, a_realm__item, a_authentication_method__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_proxy_host__port__type__realm__authentication_method_ (a_host: detachable NS_STRING; a_port: INTEGER_64; a_type: detachable NS_STRING; a_realm: detachable NS_STRING; a_authentication_method: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_host__item: POINTER
			a_type__item: POINTER
			a_realm__item: POINTER
			a_authentication_method__item: POINTER
		do
			if attached a_host as a_host_attached then
				a_host__item := a_host_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_realm as a_realm_attached then
				a_realm__item := a_realm_attached.item
			end
			if attached a_authentication_method as a_authentication_method_attached then
				a_authentication_method__item := a_authentication_method_attached.item
			end
			make_with_pointer (objc_init_with_proxy_host__port__type__realm__authentication_method_(allocate_object, a_host__item, a_port, a_type__item, a_realm__item, a_authentication_method__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLProtectionSpace Externals

	objc_init_with_host__port__protocol__realm__authentication_method_ (an_item: POINTER; a_host: POINTER; a_port: INTEGER_64; a_protocol: POINTER; a_realm: POINTER; a_authentication_method: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item initWithHost:$a_host port:$a_port protocol:$a_protocol realm:$a_realm authenticationMethod:$a_authentication_method];
			 ]"
		end

	objc_init_with_proxy_host__port__type__realm__authentication_method_ (an_item: POINTER; a_host: POINTER; a_port: INTEGER_64; a_type: POINTER; a_realm: POINTER; a_authentication_method: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item initWithProxyHost:$a_host port:$a_port type:$a_type realm:$a_realm authenticationMethod:$a_authentication_method];
			 ]"
		end

	objc_realm (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item realm];
			 ]"
		end

	objc_receives_credential_securely (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLProtectionSpace *)$an_item receivesCredentialSecurely];
			 ]"
		end

	objc_host (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item host];
			 ]"
		end

	objc_port (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLProtectionSpace *)$an_item port];
			 ]"
		end

	objc_proxy_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item proxyType];
			 ]"
		end

	objc_protocol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item protocol];
			 ]"
		end

	objc_authentication_method (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item authenticationMethod];
			 ]"
		end

feature -- NSURLProtectionSpace

	realm: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_realm (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like realm} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like realm} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	receives_credential_securely: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_receives_credential_securely (item)
		end

	host: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_host (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like host} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like host} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	port: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_port (item)
		end

	proxy_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_proxy_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like proxy_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like proxy_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	protocol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_protocol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like protocol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like protocol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	authentication_method: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_authentication_method (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like authentication_method} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like authentication_method} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSClientCertificateSpace

	distinguished_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_distinguished_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like distinguished_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like distinguished_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSClientCertificateSpace Externals

	objc_distinguished_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item distinguishedNames];
			 ]"
		end

feature -- NSServerTrustValidationSpace

--	server_trust: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_server_trust (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like server_trust} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like server_trust} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSServerTrustValidationSpace Externals

--	objc_server_trust (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSURLProtectionSpace *)$an_item serverTrust];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLProtectionSpace"
		end

end
