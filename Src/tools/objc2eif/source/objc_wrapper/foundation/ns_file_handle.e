note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FILE_HANDLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_file_descriptor__close_on_dealloc_,
	make_with_file_descriptor_,
	make

feature -- NSFileHandle

	available_data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_available_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	read_data_to_end_of_file: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_read_data_to_end_of_file (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like read_data_to_end_of_file} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like read_data_to_end_of_file} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	read_data_of_length_ (a_length: NATURAL_64): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_read_data_of_length_ (item, a_length)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like read_data_of_length_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like read_data_of_length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_data_ (a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_write_data_ (item, a_data__item)
		end

	offset_in_file: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_offset_in_file (item)
		end

	seek_to_end_of_file: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_seek_to_end_of_file (item)
		end

	seek_to_file_offset_ (a_offset: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_seek_to_file_offset_ (item, a_offset)
		end

	truncate_file_at_offset_ (a_offset: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_truncate_file_at_offset_ (item, a_offset)
		end

	synchronize_file
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_synchronize_file (item)
		end

	close_file
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close_file (item)
		end

feature {NONE} -- NSFileHandle Externals

	objc_available_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileHandle *)$an_item availableData];
			 ]"
		end

	objc_read_data_to_end_of_file (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileHandle *)$an_item readDataToEndOfFile];
			 ]"
		end

	objc_read_data_of_length_ (an_item: POINTER; a_length: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileHandle *)$an_item readDataOfLength:$a_length];
			 ]"
		end

	objc_write_data_ (an_item: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item writeData:$a_data];
			 ]"
		end

	objc_offset_in_file (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileHandle *)$an_item offsetInFile];
			 ]"
		end

	objc_seek_to_end_of_file (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileHandle *)$an_item seekToEndOfFile];
			 ]"
		end

	objc_seek_to_file_offset_ (an_item: POINTER; a_offset: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item seekToFileOffset:$a_offset];
			 ]"
		end

	objc_truncate_file_at_offset_ (an_item: POINTER; a_offset: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item truncateFileAtOffset:$a_offset];
			 ]"
		end

	objc_synchronize_file (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item synchronizeFile];
			 ]"
		end

	objc_close_file (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item closeFile];
			 ]"
		end

feature -- NSFileHandleAsynchronousAccess

	read_in_background_and_notify_for_modes_ (a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_modes__item: POINTER
		do
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_read_in_background_and_notify_for_modes_ (item, a_modes__item)
		end

	read_in_background_and_notify
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_read_in_background_and_notify (item)
		end

	read_to_end_of_file_in_background_and_notify_for_modes_ (a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_modes__item: POINTER
		do
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_read_to_end_of_file_in_background_and_notify_for_modes_ (item, a_modes__item)
		end

	read_to_end_of_file_in_background_and_notify
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_read_to_end_of_file_in_background_and_notify (item)
		end

	accept_connection_in_background_and_notify_for_modes_ (a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_modes__item: POINTER
		do
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_accept_connection_in_background_and_notify_for_modes_ (item, a_modes__item)
		end

	accept_connection_in_background_and_notify
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_accept_connection_in_background_and_notify (item)
		end

	wait_for_data_in_background_and_notify_for_modes_ (a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_modes__item: POINTER
		do
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_wait_for_data_in_background_and_notify_for_modes_ (item, a_modes__item)
		end

	wait_for_data_in_background_and_notify
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_wait_for_data_in_background_and_notify (item)
		end

feature {NONE} -- NSFileHandleAsynchronousAccess Externals

	objc_read_in_background_and_notify_for_modes_ (an_item: POINTER; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item readInBackgroundAndNotifyForModes:$a_modes];
			 ]"
		end

	objc_read_in_background_and_notify (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item readInBackgroundAndNotify];
			 ]"
		end

	objc_read_to_end_of_file_in_background_and_notify_for_modes_ (an_item: POINTER; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item readToEndOfFileInBackgroundAndNotifyForModes:$a_modes];
			 ]"
		end

	objc_read_to_end_of_file_in_background_and_notify (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item readToEndOfFileInBackgroundAndNotify];
			 ]"
		end

	objc_accept_connection_in_background_and_notify_for_modes_ (an_item: POINTER; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item acceptConnectionInBackgroundAndNotifyForModes:$a_modes];
			 ]"
		end

	objc_accept_connection_in_background_and_notify (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item acceptConnectionInBackgroundAndNotify];
			 ]"
		end

	objc_wait_for_data_in_background_and_notify_for_modes_ (an_item: POINTER; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item waitForDataInBackgroundAndNotifyForModes:$a_modes];
			 ]"
		end

	objc_wait_for_data_in_background_and_notify (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSFileHandle *)$an_item waitForDataInBackgroundAndNotify];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_file_descriptor__close_on_dealloc_ (a_fd: INTEGER_32; a_closeopt: BOOLEAN)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_file_descriptor__close_on_dealloc_(allocate_object, a_fd, a_closeopt))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_file_descriptor_ (a_fd: INTEGER_32)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_file_descriptor_(allocate_object, a_fd))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSFileHandlePlatformSpecific Externals

	objc_init_with_file_descriptor__close_on_dealloc_ (an_item: POINTER; a_fd: INTEGER_32; a_closeopt: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileHandle *)$an_item initWithFileDescriptor:$a_fd closeOnDealloc:$a_closeopt];
			 ]"
		end

	objc_init_with_file_descriptor_ (an_item: POINTER; a_fd: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFileHandle *)$an_item initWithFileDescriptor:$a_fd];
			 ]"
		end

	objc_file_descriptor (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSFileHandle *)$an_item fileDescriptor];
			 ]"
		end

feature -- NSFileHandlePlatformSpecific

	file_descriptor: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_descriptor (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFileHandle"
		end

end
