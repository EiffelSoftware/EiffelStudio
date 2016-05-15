note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CONNECTION_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	make_new_connection__sender_ (a_conn: detachable NS_CONNECTION; a_ancestor: detachable NS_CONNECTION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_make_new_connection__sender_: has_make_new_connection__sender_
		local
			a_conn__item: POINTER
			a_ancestor__item: POINTER
		do
			if attached a_conn as a_conn_attached then
				a_conn__item := a_conn_attached.item
			end
			if attached a_ancestor as a_ancestor_attached then
				a_ancestor__item := a_ancestor_attached.item
			end
			Result := objc_make_new_connection__sender_ (item, a_conn__item, a_ancestor__item)
		end

	connection__should_make_new_connection_ (a_ancestor: detachable NS_CONNECTION; a_conn: detachable NS_CONNECTION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_connection__should_make_new_connection_: has_connection__should_make_new_connection_
		local
			a_ancestor__item: POINTER
			a_conn__item: POINTER
		do
			if attached a_ancestor as a_ancestor_attached then
				a_ancestor__item := a_ancestor_attached.item
			end
			if attached a_conn as a_conn_attached then
				a_conn__item := a_conn_attached.item
			end
			Result := objc_connection__should_make_new_connection_ (item, a_ancestor__item, a_conn__item)
		end

	authentication_data_for_components_ (a_components: detachable NS_ARRAY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		require
			has_authentication_data_for_components_: has_authentication_data_for_components_
		local
			result_pointer: POINTER
			a_components__item: POINTER
		do
			if attached a_components as a_components_attached then
				a_components__item := a_components_attached.item
			end
			result_pointer := objc_authentication_data_for_components_ (item, a_components__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like authentication_data_for_components_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like authentication_data_for_components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	authenticate_components__with_data_ (a_components: detachable NS_ARRAY; a_signature: detachable NS_DATA): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_authenticate_components__with_data_: has_authenticate_components__with_data_
		local
			a_components__item: POINTER
			a_signature__item: POINTER
		do
			if attached a_components as a_components_attached then
				a_components__item := a_components_attached.item
			end
			if attached a_signature as a_signature_attached then
				a_signature__item := a_signature_attached.item
			end
			Result := objc_authenticate_components__with_data_ (item, a_components__item, a_signature__item)
		end

	create_conversation_for_connection_ (a_conn: detachable NS_CONNECTION): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_create_conversation_for_connection_: has_create_conversation_for_connection_
		local
			result_pointer: POINTER
			a_conn__item: POINTER
		do
			if attached a_conn as a_conn_attached then
				a_conn__item := a_conn_attached.item
			end
			result_pointer := objc_create_conversation_for_connection_ (item, a_conn__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like create_conversation_for_connection_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like create_conversation_for_connection_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection__handle_request_ (a_connection: detachable NS_CONNECTION; a_doreq: detachable NS_DISTANT_OBJECT_REQUEST): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_connection__handle_request_: has_connection__handle_request_
		local
			a_connection__item: POINTER
			a_doreq__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_doreq as a_doreq_attached then
				a_doreq__item := a_doreq_attached.item
			end
			Result := objc_connection__handle_request_ (item, a_connection__item, a_doreq__item)
		end

feature -- Status Report

	has_make_new_connection__sender_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_make_new_connection__sender_ (item)
		end

	has_connection__should_make_new_connection_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_connection__should_make_new_connection_ (item)
		end

	has_authentication_data_for_components_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_authentication_data_for_components_ (item)
		end

	has_authenticate_components__with_data_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_authenticate_components__with_data_ (item)
		end

	has_create_conversation_for_connection_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_create_conversation_for_connection_ (item)
		end

	has_connection__handle_request_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_connection__handle_request_ (item)
		end

feature -- Status Report Externals

	objc_has_make_new_connection__sender_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(makeNewConnection:sender:)];
			 ]"
		end

	objc_has_connection__should_make_new_connection_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(connection:shouldMakeNewConnection:)];
			 ]"
		end

	objc_has_authentication_data_for_components_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(authenticationDataForComponents:)];
			 ]"
		end

	objc_has_authenticate_components__with_data_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(authenticateComponents:withData:)];
			 ]"
		end

	objc_has_create_conversation_for_connection_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(createConversationForConnection:)];
			 ]"
		end

	objc_has_connection__handle_request_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(connection:handleRequest:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_make_new_connection__sender_ (an_item: POINTER; a_conn: POINTER; a_ancestor: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSConnectionDelegate>)$an_item makeNewConnection:$a_conn sender:$a_ancestor];
			 ]"
		end

	objc_connection__should_make_new_connection_ (an_item: POINTER; a_ancestor: POINTER; a_conn: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSConnectionDelegate>)$an_item connection:$a_ancestor shouldMakeNewConnection:$a_conn];
			 ]"
		end

	objc_authentication_data_for_components_ (an_item: POINTER; a_components: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSConnectionDelegate>)$an_item authenticationDataForComponents:$a_components];
			 ]"
		end

	objc_authenticate_components__with_data_ (an_item: POINTER; a_components: POINTER; a_signature: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSConnectionDelegate>)$an_item authenticateComponents:$a_components withData:$a_signature];
			 ]"
		end

	objc_create_conversation_for_connection_ (an_item: POINTER; a_conn: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSConnectionDelegate>)$an_item createConversationForConnection:$a_conn];
			 ]"
		end

	objc_connection__handle_request_ (an_item: POINTER; a_connection: POINTER; a_doreq: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSConnectionDelegate>)$an_item connection:$a_connection handleRequest:$a_doreq];
			 ]"
		end

end
