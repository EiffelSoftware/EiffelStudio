note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONNECTION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSConnection

	all_connections: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_all_connections (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_connections} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_connections} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection_with_registered_name__host_ (a_name: detachable NS_STRING; a_host_name: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_host_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_host_name as a_host_name_attached then
				a_host_name__item := a_host_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_connection_with_registered_name__host_ (l_objc_class.item, a_name__item, a_host_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection_with_registered_name__host_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection_with_registered_name__host_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection_with_registered_name__host__using_name_server_ (a_name: detachable NS_STRING; a_host_name: detachable NS_STRING; a_server: detachable NS_PORT_NAME_SERVER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_host_name__item: POINTER
			a_server__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_host_name as a_host_name_attached then
				a_host_name__item := a_host_name_attached.item
			end
			if attached a_server as a_server_attached then
				a_server__item := a_server_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_connection_with_registered_name__host__using_name_server_ (l_objc_class.item, a_name__item, a_host_name__item, a_server__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection_with_registered_name__host__using_name_server_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection_with_registered_name__host__using_name_server_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	root_proxy_for_connection_with_registered_name__host_ (a_name: detachable NS_STRING; a_host_name: detachable NS_STRING): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_name__item: POINTER
--			a_host_name__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_host_name as a_host_name_attached then
--				a_host_name__item := a_host_name_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_root_proxy_for_connection_with_registered_name__host_ (l_objc_class.item, a_name__item, a_host_name__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like root_proxy_for_connection_with_registered_name__host_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like root_proxy_for_connection_with_registered_name__host_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	root_proxy_for_connection_with_registered_name__host__using_name_server_ (a_name: detachable NS_STRING; a_host_name: detachable NS_STRING; a_server: detachable NS_PORT_NAME_SERVER): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_name__item: POINTER
--			a_host_name__item: POINTER
--			a_server__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_host_name as a_host_name_attached then
--				a_host_name__item := a_host_name_attached.item
--			end
--			if attached a_server as a_server_attached then
--				a_server__item := a_server_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_root_proxy_for_connection_with_registered_name__host__using_name_server_ (l_objc_class.item, a_name__item, a_host_name__item, a_server__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like root_proxy_for_connection_with_registered_name__host__using_name_server_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like root_proxy_for_connection_with_registered_name__host__using_name_server_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	service_connection_with_name__root_object__using_name_server_ (a_name: detachable NS_STRING; a_root: detachable NS_OBJECT; a_server: detachable NS_PORT_NAME_SERVER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_root__item: POINTER
			a_server__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_root as a_root_attached then
				a_root__item := a_root_attached.item
			end
			if attached a_server as a_server_attached then
				a_server__item := a_server_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_service_connection_with_name__root_object__using_name_server_ (l_objc_class.item, a_name__item, a_root__item, a_server__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like service_connection_with_name__root_object__using_name_server_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like service_connection_with_name__root_object__using_name_server_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	service_connection_with_name__root_object_ (a_name: detachable NS_STRING; a_root: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_root__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_root as a_root_attached then
				a_root__item := a_root_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_service_connection_with_name__root_object_ (l_objc_class.item, a_name__item, a_root__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like service_connection_with_name__root_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like service_connection_with_name__root_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	connection_with_receive_port__send_port_ (a_receive_port: UNSUPPORTED_TYPE; a_send_port: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_receive_port__item: POINTER
--			a_send_port__item: POINTER
--		do
--			if attached a_receive_port as a_receive_port_attached then
--				a_receive_port__item := a_receive_port_attached.item
--			end
--			if attached a_send_port as a_send_port_attached then
--				a_send_port__item := a_send_port_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_connection_with_receive_port__send_port_ (l_objc_class.item, a_receive_port__item, a_send_port__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like connection_with_receive_port__send_port_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like connection_with_receive_port__send_port_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	current_conversation: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_current_conversation (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_conversation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_conversation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSConnection Externals

	objc_all_connections (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object allConnections];
			 ]"
		end

	objc_connection_with_registered_name__host_ (a_class_object: POINTER; a_name: POINTER; a_host_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object connectionWithRegisteredName:$a_name host:$a_host_name];
			 ]"
		end

	objc_connection_with_registered_name__host__using_name_server_ (a_class_object: POINTER; a_name: POINTER; a_host_name: POINTER; a_server: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object connectionWithRegisteredName:$a_name host:$a_host_name usingNameServer:$a_server];
			 ]"
		end

	objc_root_proxy_for_connection_with_registered_name__host_ (a_class_object: POINTER; a_name: POINTER; a_host_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object rootProxyForConnectionWithRegisteredName:$a_name host:$a_host_name];
			 ]"
		end

	objc_root_proxy_for_connection_with_registered_name__host__using_name_server_ (a_class_object: POINTER; a_name: POINTER; a_host_name: POINTER; a_server: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object rootProxyForConnectionWithRegisteredName:$a_name host:$a_host_name usingNameServer:$a_server];
			 ]"
		end

	objc_service_connection_with_name__root_object__using_name_server_ (a_class_object: POINTER; a_name: POINTER; a_root: POINTER; a_server: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object serviceConnectionWithName:$a_name rootObject:$a_root usingNameServer:$a_server];
			 ]"
		end

	objc_service_connection_with_name__root_object_ (a_class_object: POINTER; a_name: POINTER; a_root: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object serviceConnectionWithName:$a_name rootObject:$a_root];
			 ]"
		end

	objc_connection_with_receive_port__send_port_ (a_class_object: POINTER; a_receive_port: POINTER; a_send_port: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object connectionWithReceivePort:$a_receive_port sendPort:$a_send_port];
			 ]"
		end

	objc_current_conversation (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object currentConversation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSConnection"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
