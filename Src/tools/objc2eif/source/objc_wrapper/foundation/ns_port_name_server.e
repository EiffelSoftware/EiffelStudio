note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PORT_NAME_SERVER

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

feature -- NSPortNameServer

--	port_for_name_ (a_name: detachable NS_STRING): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_name__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			result_pointer := objc_port_for_name_ (item, a_name__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like port_for_name_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like port_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	port_for_name__host_ (a_name: detachable NS_STRING; a_host: detachable NS_STRING): UNSUPPORTED_TYPE
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
--			result_pointer := objc_port_for_name__host_ (item, a_name__item, a_host__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like port_for_name__host_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like port_for_name__host_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	register_port__name_ (a_port: UNSUPPORTED_TYPE; a_name: detachable NS_STRING): BOOLEAN
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
--			Result := objc_register_port__name_ (item, a_port__item, a_name__item)
--		end

	remove_port_for_name_ (a_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_remove_port_for_name_ (item, a_name__item)
		end

feature {NONE} -- NSPortNameServer Externals

--	objc_port_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortNameServer *)$an_item portForName:$a_name];
--			 ]"
--		end

--	objc_port_for_name__host_ (an_item: POINTER; a_name: POINTER; a_host: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortNameServer *)$an_item portForName:$a_name host:$a_host];
--			 ]"
--		end

--	objc_register_port__name_ (an_item: POINTER; a_port: POINTER; a_name: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSPortNameServer *)$an_item registerPort:$a_port name:$a_name];
--			 ]"
--		end

	objc_remove_port_for_name_ (an_item: POINTER; a_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPortNameServer *)$an_item removePortForName:$a_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPortNameServer"
		end

end
