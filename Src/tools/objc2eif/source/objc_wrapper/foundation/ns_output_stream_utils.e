note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTPUT_STREAM_UTILS

inherit
	NS_STREAM_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSOutputStreamExtensions

	output_stream_to_memory: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_output_stream_to_memory (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like output_stream_to_memory} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like output_stream_to_memory} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	output_stream_to_buffer__capacity_ (a_buffer: UNSUPPORTED_TYPE; a_capacity: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_output_stream_to_buffer__capacity_ (l_objc_class.item, , a_capacity)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like output_stream_to_buffer__capacity_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like output_stream_to_buffer__capacity_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	output_stream_to_file_at_path__append_ (a_path: detachable NS_STRING; a_should_append: BOOLEAN): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_output_stream_to_file_at_path__append_ (l_objc_class.item, a_path__item, a_should_append)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like output_stream_to_file_at_path__append_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like output_stream_to_file_at_path__append_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	output_stream_with_ur_l__append_ (a_url: detachable NS_URL; a_should_append: BOOLEAN): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_output_stream_with_ur_l__append_ (l_objc_class.item, a_url__item, a_should_append)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like output_stream_with_ur_l__append_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like output_stream_with_ur_l__append_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSOutputStreamExtensions Externals

	objc_output_stream_to_memory (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object outputStreamToMemory];
			 ]"
		end

	objc_output_stream_to_buffer__capacity_ (a_class_object: POINTER; a_buffer: POINTER; a_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object outputStreamToBuffer:$a_buffer capacity:$a_capacity];
			 ]"
		end

	objc_output_stream_to_file_at_path__append_ (a_class_object: POINTER; a_path: POINTER; a_should_append: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object outputStreamToFileAtPath:$a_path append:$a_should_append];
			 ]"
		end

	objc_output_stream_with_ur_l__append_ (a_class_object: POINTER; a_url: POINTER; a_should_append: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object outputStreamWithURL:$a_url append:$a_should_append];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOutputStream"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
