note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PORT_CODER_UTILS

inherit
	NS_CODER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPortCoder

--	port_coder_with_receive_port__send_port__components_ (a_rcv_port: UNSUPPORTED_TYPE; a_snd_port: UNSUPPORTED_TYPE; a_comps: detachable NS_ARRAY): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_rcv_port__item: POINTER
--			a_snd_port__item: POINTER
--			a_comps__item: POINTER
--		do
--			if attached a_rcv_port as a_rcv_port_attached then
--				a_rcv_port__item := a_rcv_port_attached.item
--			end
--			if attached a_snd_port as a_snd_port_attached then
--				a_snd_port__item := a_snd_port_attached.item
--			end
--			if attached a_comps as a_comps_attached then
--				a_comps__item := a_comps_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_port_coder_with_receive_port__send_port__components_ (l_objc_class.item, a_rcv_port__item, a_snd_port__item, a_comps__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like port_coder_with_receive_port__send_port__components_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like port_coder_with_receive_port__send_port__components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSPortCoder Externals

	objc_port_coder_with_receive_port__send_port__components_ (a_class_object: POINTER; a_rcv_port: POINTER; a_snd_port: POINTER; a_comps: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object portCoderWithReceivePort:$a_rcv_port sendPort:$a_snd_port components:$a_comps];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPortCoder"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
