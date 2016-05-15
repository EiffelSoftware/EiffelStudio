note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NET_SERVICE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_domain__type__name__port_,
	make_with_domain__type__name_,
	make

feature {NONE} -- Initialization

	make_with_domain__type__name__port_ (a_domain: detachable NS_STRING; a_type: detachable NS_STRING; a_name: detachable NS_STRING; a_port: INTEGER_32)
			-- Initialize `Current'.
		local
			a_domain__item: POINTER
			a_type__item: POINTER
			a_name__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_domain__type__name__port_(allocate_object, a_domain__item, a_type__item, a_name__item, a_port))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_domain__type__name_ (a_domain: detachable NS_STRING; a_type: detachable NS_STRING; a_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_domain__item: POINTER
			a_type__item: POINTER
			a_name__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_domain__type__name_(allocate_object, a_domain__item, a_type__item, a_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSNetService Externals

	objc_init_with_domain__type__name__port_ (an_item: POINTER; a_domain: POINTER; a_type: POINTER; a_name: POINTER; a_port: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item initWithDomain:$a_domain type:$a_type name:$a_name port:$a_port];
			 ]"
		end

	objc_init_with_domain__type__name_ (an_item: POINTER; a_domain: POINTER; a_type: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item initWithDomain:$a_domain type:$a_type name:$a_name];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_schedule_in_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item scheduleInRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_remove_from_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item removeFromRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_domain (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item domain];
			 ]"
		end

	objc_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item type];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item name];
			 ]"
		end

	objc_addresses (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item addresses];
			 ]"
		end

	objc_port (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNetService *)$an_item port];
			 ]"
		end

	objc_publish (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item publish];
			 ]"
		end

	objc_publish_with_options_ (an_item: POINTER; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item publishWithOptions:$a_options];
			 ]"
		end

	objc_stop (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item stop];
			 ]"
		end

	objc_host_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item hostName];
			 ]"
		end

	objc_resolve_with_timeout_ (an_item: POINTER; a_timeout: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item resolveWithTimeout:$a_timeout];
			 ]"
		end

--	objc_get_input_stream__output_stream_ (an_item: POINTER; a_input_stream: UNSUPPORTED_TYPE; a_output_stream: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSNetService *)$an_item getInputStream: outputStream:];
--			 ]"
--		end

	objc_set_txt_record_data_ (an_item: POINTER; a_record_data: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNetService *)$an_item setTXTRecordData:$a_record_data];
			 ]"
		end

	objc_txt_record_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNetService *)$an_item TXTRecordData];
			 ]"
		end

	objc_start_monitoring (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item startMonitoring];
			 ]"
		end

	objc_stop_monitoring (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNetService *)$an_item stopMonitoring];
			 ]"
		end

feature -- NSNetService

	delegate: detachable NS_NET_SERVICE_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_NET_SERVICE_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	schedule_in_run_loop__for_mode_ (a_run_loop: detachable NS_RUN_LOOP; a_mode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_run_loop__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_run_loop as a_run_loop_attached then
				a_run_loop__item := a_run_loop_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			objc_schedule_in_run_loop__for_mode_ (item, a_run_loop__item, a_mode__item)
		end

	remove_from_run_loop__for_mode_ (a_run_loop: detachable NS_RUN_LOOP; a_mode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_run_loop__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_run_loop as a_run_loop_attached then
				a_run_loop__item := a_run_loop_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			objc_remove_from_run_loop__for_mode_ (item, a_run_loop__item, a_mode__item)
		end

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

	type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	addresses: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_addresses (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like addresses} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like addresses} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	publish
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_publish (item)
		end

	publish_with_options_ (a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_publish_with_options_ (item, a_options)
		end

	stop
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop (item)
		end

	host_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_host_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like host_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like host_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resolve_with_timeout_ (a_timeout: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resolve_with_timeout_ (item, a_timeout)
		end

--	get_input_stream__output_stream_ (a_input_stream: UNSUPPORTED_TYPE; a_output_stream: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_input_stream__item: POINTER
--			a_output_stream__item: POINTER
--		do
--			if attached a_input_stream as a_input_stream_attached then
--				a_input_stream__item := a_input_stream_attached.item
--			end
--			if attached a_output_stream as a_output_stream_attached then
--				a_output_stream__item := a_output_stream_attached.item
--			end
--			Result := objc_get_input_stream__output_stream_ (item, a_input_stream__item, a_output_stream__item)
--		end

	set_txt_record_data_ (a_record_data: detachable NS_DATA): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_record_data__item: POINTER
		do
			if attached a_record_data as a_record_data_attached then
				a_record_data__item := a_record_data_attached.item
			end
			Result := objc_set_txt_record_data_ (item, a_record_data__item)
		end

	txt_record_data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_txt_record_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like txt_record_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like txt_record_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	start_monitoring
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start_monitoring (item)
		end

	stop_monitoring
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_monitoring (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNetService"
		end

end
