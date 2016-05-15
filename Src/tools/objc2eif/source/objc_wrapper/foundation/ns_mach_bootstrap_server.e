note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MACH_BOOTSTRAP_SERVER

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

feature -- NSMachBootstrapServer

--	service_port_with_name_ (a_name: detachable NS_STRING): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_name__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			result_pointer := objc_service_port_with_name_ (item, a_name__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like service_port_with_name_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like service_port_with_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSMachBootstrapServer Externals

--	objc_service_port_with_name_ (an_item: POINTER; a_name: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMachBootstrapServer *)$an_item servicePortWithName:$a_name];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMachBootstrapServer"
		end

end
