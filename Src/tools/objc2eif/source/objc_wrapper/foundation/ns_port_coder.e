note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PORT_CODER

inherit
	NS_CODER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPortCoder

	is_bycopy: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bycopy (item)
		end

	is_byref: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_byref (item)
		end

	connection: detachable NS_CONNECTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_connection (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	encode_port_object_ (a_aport: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_aport__item: POINTER
--		do
--			if attached a_aport as a_aport_attached then
--				a_aport__item := a_aport_attached.item
--			end
--			objc_encode_port_object_ (item, a_aport__item)
--		end

--	decode_port_object: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_decode_port_object (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like decode_port_object} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like decode_port_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	dispatch
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_dispatch (item)
		end

feature {NONE} -- NSPortCoder Externals

	objc_is_bycopy (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPortCoder *)$an_item isBycopy];
			 ]"
		end

	objc_is_byref (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPortCoder *)$an_item isByref];
			 ]"
		end

	objc_connection (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPortCoder *)$an_item connection];
			 ]"
		end

--	objc_encode_port_object_ (an_item: POINTER; a_aport: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSPortCoder *)$an_item encodePortObject:$a_aport];
--			 ]"
--		end

--	objc_decode_port_object (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortCoder *)$an_item decodePortObject];
--			 ]"
--		end

--	objc_init_with_receive_port__send_port__components_ (an_item: POINTER; a_rcv_port: POINTER; a_snd_port: POINTER; a_comps: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPortCoder *)$an_item initWithReceivePort:$a_rcv_port sendPort:$a_snd_port components:$a_comps];
--			 ]"
--		end

	objc_dispatch (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPortCoder *)$an_item dispatch];
			 ]"
		end

feature {NONE} -- Initialization

--	make_with_receive_port__send_port__components_ (a_rcv_port: UNSUPPORTED_TYPE; a_snd_port: UNSUPPORTED_TYPE; a_comps: detachable NS_ARRAY)
--			-- Initialize `Current'.
--		local
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
--			make_with_pointer (objc_init_with_receive_port__send_port__components_(allocate_object, a_rcv_port__item, a_snd_port__item, a_comps__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPortCoder"
		end

end
