note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CONNECTION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSURLConnection

	can_handle_request_ (a_request: detachable NS_URL_REQUEST): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_request__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_can_handle_request_ (l_objc_class.item, a_request__item)
		end

	connection_with_request__delegate_ (a_request: detachable NS_URL_REQUEST; a_delegate: detachable NS_OBJECT): detachable NS_URL_CONNECTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_request__item: POINTER
			a_delegate__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_connection_with_request__delegate_ (l_objc_class.item, a_request__item, a_delegate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection_with_request__delegate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection_with_request__delegate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSURLConnection Externals

	objc_can_handle_request_ (a_class_object: POINTER; a_request: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object canHandleRequest:$a_request];
			 ]"
		end

	objc_connection_with_request__delegate_ (a_class_object: POINTER; a_request: POINTER; a_delegate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object connectionWithRequest:$a_request delegate:$a_delegate];
			 ]"
		end

feature -- NSURLConnectionSynchronousLoading

--	send_synchronous_request__returning_response__error_ (a_request: detachable NS_URL_REQUEST; a_response: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_request__item: POINTER
--			a_response__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_request as a_request_attached then
--				a_request__item := a_request_attached.item
--			end
--			if attached a_response as a_response_attached then
--				a_response__item := a_response_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_send_synchronous_request__returning_response__error_ (l_objc_class.item, a_request__item, a_response__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like send_synchronous_request__returning_response__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like send_synchronous_request__returning_response__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSURLConnectionSynchronousLoading Externals

--	objc_send_synchronous_request__returning_response__error_ (a_class_object: POINTER; a_request: POINTER; a_response: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object sendSynchronousRequest:$a_request returningResponse: error:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLConnection"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
