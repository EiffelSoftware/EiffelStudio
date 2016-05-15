note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONNECTION

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

feature -- NSConnection

	statistics: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_statistics (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like statistics} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like statistics} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_request_timeout_ (a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_request_timeout_ (item, a_ti)
		end

	request_timeout: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_request_timeout (item)
		end

	set_reply_timeout_ (a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_reply_timeout_ (item, a_ti)
		end

	reply_timeout: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_reply_timeout (item)
		end

	set_root_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_root_object_ (item, an_object__item)
		end

	root_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_root_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like root_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like root_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	root_proxy: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_root_proxy (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like root_proxy} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like root_proxy} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_delegate_ (an_object: detachable NS_CONNECTION_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_CONNECTION_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_independent_conversation_queueing_ (a_yorn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_independent_conversation_queueing_ (item, a_yorn)
		end

	independent_conversation_queueing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_independent_conversation_queueing (item)
		end

	is_valid: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_valid (item)
		end

	invalidate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate (item)
		end

	add_request_mode_ (a_rmode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_rmode__item: POINTER
		do
			if attached a_rmode as a_rmode_attached then
				a_rmode__item := a_rmode_attached.item
			end
			objc_add_request_mode_ (item, a_rmode__item)
		end

	remove_request_mode_ (a_rmode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_rmode__item: POINTER
		do
			if attached a_rmode as a_rmode_attached then
				a_rmode__item := a_rmode_attached.item
			end
			objc_remove_request_mode_ (item, a_rmode__item)
		end

	request_modes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_request_modes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like request_modes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like request_modes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_name_ (a_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_register_name_ (item, a_name__item)
		end

	register_name__with_name_server_ (a_name: detachable NS_STRING; a_server: detachable NS_PORT_NAME_SERVER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
			a_server__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_server as a_server_attached then
				a_server__item := a_server_attached.item
			end
			Result := objc_register_name__with_name_server_ (item, a_name__item, a_server__item)
		end

--	send_port: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_send_port (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like send_port} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like send_port} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	receive_port: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_receive_port (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like receive_port} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like receive_port} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	enable_multiple_threads
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_multiple_threads (item)
		end

	multiple_threads_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_multiple_threads_enabled (item)
		end

	add_run_loop_ (a_runloop: detachable NS_RUN_LOOP)
			-- Auto generated Objective-C wrapper.
		local
			a_runloop__item: POINTER
		do
			if attached a_runloop as a_runloop_attached then
				a_runloop__item := a_runloop_attached.item
			end
			objc_add_run_loop_ (item, a_runloop__item)
		end

	remove_run_loop_ (a_runloop: detachable NS_RUN_LOOP)
			-- Auto generated Objective-C wrapper.
		local
			a_runloop__item: POINTER
		do
			if attached a_runloop as a_runloop_attached then
				a_runloop__item := a_runloop_attached.item
			end
			objc_remove_run_loop_ (item, a_runloop__item)
		end

	run_in_new_thread
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_run_in_new_thread (item)
		end

	remote_objects: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_remote_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like remote_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like remote_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	local_objects: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_local_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like local_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like local_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSConnection Externals

	objc_statistics (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item statistics];
			 ]"
		end

	objc_set_request_timeout_ (an_item: POINTER; a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item setRequestTimeout:$a_ti];
			 ]"
		end

	objc_request_timeout (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item requestTimeout];
			 ]"
		end

	objc_set_reply_timeout_ (an_item: POINTER; a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item setReplyTimeout:$a_ti];
			 ]"
		end

	objc_reply_timeout (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item replyTimeout];
			 ]"
		end

	objc_set_root_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item setRootObject:$an_object];
			 ]"
		end

	objc_root_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item rootObject];
			 ]"
		end

--	objc_root_proxy (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSConnection *)$an_item rootProxy];
--			 ]"
--		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item delegate];
			 ]"
		end

	objc_set_independent_conversation_queueing_ (an_item: POINTER; a_yorn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item setIndependentConversationQueueing:$a_yorn];
			 ]"
		end

	objc_independent_conversation_queueing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item independentConversationQueueing];
			 ]"
		end

	objc_is_valid (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item isValid];
			 ]"
		end

	objc_invalidate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item invalidate];
			 ]"
		end

	objc_add_request_mode_ (an_item: POINTER; a_rmode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item addRequestMode:$a_rmode];
			 ]"
		end

	objc_remove_request_mode_ (an_item: POINTER; a_rmode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item removeRequestMode:$a_rmode];
			 ]"
		end

	objc_request_modes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item requestModes];
			 ]"
		end

	objc_register_name_ (an_item: POINTER; a_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item registerName:$a_name];
			 ]"
		end

	objc_register_name__with_name_server_ (an_item: POINTER; a_name: POINTER; a_server: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item registerName:$a_name withNameServer:$a_server];
			 ]"
		end

--	objc_init_with_receive_port__send_port_ (an_item: POINTER; a_receive_port: POINTER; a_send_port: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSConnection *)$an_item initWithReceivePort:$a_receive_port sendPort:$a_send_port];
--			 ]"
--		end

--	objc_send_port (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSConnection *)$an_item sendPort];
--			 ]"
--		end

--	objc_receive_port (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSConnection *)$an_item receivePort];
--			 ]"
--		end

	objc_enable_multiple_threads (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item enableMultipleThreads];
			 ]"
		end

	objc_multiple_threads_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSConnection *)$an_item multipleThreadsEnabled];
			 ]"
		end

	objc_add_run_loop_ (an_item: POINTER; a_runloop: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item addRunLoop:$a_runloop];
			 ]"
		end

	objc_remove_run_loop_ (an_item: POINTER; a_runloop: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item removeRunLoop:$a_runloop];
			 ]"
		end

	objc_run_in_new_thread (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSConnection *)$an_item runInNewThread];
			 ]"
		end

	objc_remote_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item remoteObjects];
			 ]"
		end

	objc_local_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSConnection *)$an_item localObjects];
			 ]"
		end

feature {NONE} -- Initialization

--	make_with_receive_port__send_port_ (a_receive_port: UNSUPPORTED_TYPE; a_send_port: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_receive_port__item: POINTER
--			a_send_port__item: POINTER
--		do
--			if attached a_receive_port as a_receive_port_attached then
--				a_receive_port__item := a_receive_port_attached.item
--			end
--			if attached a_send_port as a_send_port_attached then
--				a_send_port__item := a_send_port_attached.item
--			end
--			make_with_pointer (objc_init_with_receive_port__send_port_(allocate_object, a_receive_port__item, a_send_port__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSConnection"
		end

end
