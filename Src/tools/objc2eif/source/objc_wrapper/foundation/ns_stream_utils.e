note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STREAM_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSSocketStreamCreationExtensions

--	get_streams_to_host__port__input_stream__output_stream_ (a_host: detachable NS_HOST; a_port: INTEGER_64; a_input_stream: UNSUPPORTED_TYPE; a_output_stream: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_host__item: POINTER
--			a_input_stream__item: POINTER
--			a_output_stream__item: POINTER
--		do
--			if attached a_host as a_host_attached then
--				a_host__item := a_host_attached.item
--			end
--			if attached a_input_stream as a_input_stream_attached then
--				a_input_stream__item := a_input_stream_attached.item
--			end
--			if attached a_output_stream as a_output_stream_attached then
--				a_output_stream__item := a_output_stream_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			objc_get_streams_to_host__port__input_stream__output_stream_ (l_objc_class.item, a_host__item, a_port, a_input_stream__item, a_output_stream__item)
--		end

feature {NONE} -- NSSocketStreamCreationExtensions Externals

--	objc_get_streams_to_host__port__input_stream__output_stream_ (a_class_object: POINTER; a_host: POINTER; a_port: INTEGER_64; a_input_stream: UNSUPPORTED_TYPE; a_output_stream: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(Class)$a_class_object getStreamsToHost:$a_host port:$a_port inputStream: outputStream:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSStream"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
