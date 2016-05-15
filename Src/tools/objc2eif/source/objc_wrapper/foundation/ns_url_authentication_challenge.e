note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_AUTHENTICATION_CHALLENGE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_protection_space__proposed_credential__previous_failure_count__failure_response__error__sender_,
	make_with_authentication_challenge__sender_,
	make

feature {NONE} -- Initialization

	make_with_protection_space__proposed_credential__previous_failure_count__failure_response__error__sender_ (a_space: detachable NS_URL_PROTECTION_SPACE; a_credential: detachable NS_URL_CREDENTIAL; a_previous_failure_count: INTEGER_64; a_response: detachable NS_URL_RESPONSE; a_error: detachable NS_ERROR; a_sender: detachable NS_URL_AUTHENTICATION_CHALLENGE_SENDER_PROTOCOL)
			-- Initialize `Current'.
		local
			a_space__item: POINTER
			a_credential__item: POINTER
			a_response__item: POINTER
			a_error__item: POINTER
			a_sender__item: POINTER
		do
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			if attached a_credential as a_credential_attached then
				a_credential__item := a_credential_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			make_with_pointer (objc_init_with_protection_space__proposed_credential__previous_failure_count__failure_response__error__sender_(allocate_object, a_space__item, a_credential__item, a_previous_failure_count, a_response__item, a_error__item, a_sender__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_authentication_challenge__sender_ (a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE; a_sender: detachable NS_URL_AUTHENTICATION_CHALLENGE_SENDER_PROTOCOL)
			-- Initialize `Current'.
		local
			a_challenge__item: POINTER
			a_sender__item: POINTER
		do
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			make_with_pointer (objc_init_with_authentication_challenge__sender_(allocate_object, a_challenge__item, a_sender__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLAuthenticationChallenge Externals

	objc_init_with_protection_space__proposed_credential__previous_failure_count__failure_response__error__sender_ (an_item: POINTER; a_space: POINTER; a_credential: POINTER; a_previous_failure_count: INTEGER_64; a_response: POINTER; a_error: POINTER; a_sender: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item initWithProtectionSpace:$a_space proposedCredential:$a_credential previousFailureCount:$a_previous_failure_count failureResponse:$a_response error:$a_error sender:$a_sender];
			 ]"
		end

	objc_init_with_authentication_challenge__sender_ (an_item: POINTER; a_challenge: POINTER; a_sender: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item initWithAuthenticationChallenge:$a_challenge sender:$a_sender];
			 ]"
		end

	objc_protection_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item protectionSpace];
			 ]"
		end

	objc_proposed_credential (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item proposedCredential];
			 ]"
		end

	objc_previous_failure_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSURLAuthenticationChallenge *)$an_item previousFailureCount];
			 ]"
		end

	objc_failure_response (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item failureResponse];
			 ]"
		end

	objc_error (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item error];
			 ]"
		end

	objc_sender (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLAuthenticationChallenge *)$an_item sender];
			 ]"
		end

feature -- NSURLAuthenticationChallenge

	protection_space: detachable NS_URL_PROTECTION_SPACE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_protection_space (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like protection_space} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like protection_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	proposed_credential: detachable NS_URL_CREDENTIAL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_proposed_credential (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like proposed_credential} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like proposed_credential} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	previous_failure_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_previous_failure_count (item)
		end

	failure_response: detachable NS_URL_RESPONSE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_failure_response (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like failure_response} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like failure_response} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	error: detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_error (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like error} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like error} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sender: detachable NS_URL_AUTHENTICATION_CHALLENGE_SENDER_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sender (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sender} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sender} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLAuthenticationChallenge"
		end

end
