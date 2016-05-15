note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SOCKET_PORT_NAME_SERVER

inherit
	NS_PORT_NAME_SERVER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSSocketPortNameServer

--	port_for_name__host__name_server_port_number_ (a_name: detachable NS_STRING; a_host: detachable NS_STRING; a_port_number: NATURAL_16): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_name__item: POINTER
--			a_host__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_host as a_host_attached then
--				a_host__item := a_host_attached.item
--			end
--			result_pointer := objc_port_for_name__host__name_server_port_number_ (item, a_name__item, a_host__item, a_port_number)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like port_for_name__host__name_server_port_number_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like port_for_name__host__name_server_port_number_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	register_port__name__name_server_port_number_ (a_port: UNSUPPORTED_TYPE; a_name: detachable NS_STRING; a_port_number: NATURAL_16): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_port__item: POINTER
--			a_name__item: POINTER
--		do
--			if attached a_port as a_port_attached then
--				a_port__item := a_port_attached.item
--			end
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			Result := objc_register_port__name__name_server_port_number_ (item, a_port__item, a_name__item, a_port_number)
--		end

	set_default_name_server_port_number_ (a_port_number: NATURAL_16)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_default_name_server_port_number_ (item, a_port_number)
		end

	default_name_server_port_number: NATURAL_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_default_name_server_port_number (item)
		end

feature {NONE} -- NSSocketPortNameServer Externals

--	objc_port_for_name__host__name_server_port_number_ (an_item: POINTER; a_name: POINTER; a_host: POINTER; a_port_number: NATURAL_16): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSocketPortNameServer *)$an_item portForName:$a_name host:$a_host nameServerPortNumber:$a_port_number];
--			 ]"
--		end

--	objc_register_port__name__name_server_port_number_ (an_item: POINTER; a_port: POINTER; a_name: POINTER; a_port_number: NATURAL_16): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSSocketPortNameServer *)$an_item registerPort:$a_port name:$a_name nameServerPortNumber:$a_port_number];
--			 ]"
--		end

	objc_set_default_name_server_port_number_ (an_item: POINTER; a_port_number: NATURAL_16)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSSocketPortNameServer *)$an_item setDefaultNameServerPortNumber:$a_port_number];
			 ]"
		end

	objc_default_name_server_port_number (an_item: POINTER): NATURAL_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSocketPortNameServer *)$an_item defaultNameServerPortNumber];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSocketPortNameServer"
		end

end
