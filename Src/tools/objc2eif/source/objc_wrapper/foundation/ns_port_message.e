note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PORT_MESSAGE

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

feature {NONE} -- Initialization

--	make_with_send_port__receive_port__components_ (a_send_port: UNSUPPORTED_TYPE; a_reply_port: UNSUPPORTED_TYPE; a_components: detachable NS_ARRAY)
--			-- Initialize `Current'.
--		local
--			a_send_port__item: POINTER
--			a_reply_port__item: POINTER
--			a_components__item: POINTER
--		do
--			if attached a_send_port as a_send_port_attached then
--				a_send_port__item := a_send_port_attached.item
--			end
--			if attached a_reply_port as a_reply_port_attached then
--				a_reply_port__item := a_reply_port_attached.item
--			end
--			if attached a_components as a_components_attached then
--				a_components__item := a_components_attached.item
--			end
--			make_with_pointer (objc_init_with_send_port__receive_port__components_(allocate_object, a_send_port__item, a_reply_port__item, a_components__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSPortMessage Externals

--	objc_init_with_send_port__receive_port__components_ (an_item: POINTER; a_send_port: POINTER; a_reply_port: POINTER; a_components: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortMessage *)$an_item initWithSendPort:$a_send_port receivePort:$a_reply_port components:$a_components];
--			 ]"
--		end

	objc_components (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPortMessage *)$an_item components];
			 ]"
		end

--	objc_receive_port (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortMessage *)$an_item receivePort];
--			 ]"
--		end

--	objc_send_port (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortMessage *)$an_item sendPort];
--			 ]"
--		end

	objc_send_before_date_ (an_item: POINTER; a_date: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPortMessage *)$an_item sendBeforeDate:$a_date];
			 ]"
		end

	objc_msgid (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPortMessage *)$an_item msgid];
			 ]"
		end

	objc_set_msgid_ (an_item: POINTER; a_msgid: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPortMessage *)$an_item setMsgid:$a_msgid];
			 ]"
		end

feature -- NSPortMessage

	components: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_components (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

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

	send_before_date_ (a_date: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			Result := objc_send_before_date_ (item, a_date__item)
		end

	msgid: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_msgid (item)
		end

	set_msgid_ (a_msgid: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_msgid_ (item, a_msgid)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPortMessage"
		end

end
