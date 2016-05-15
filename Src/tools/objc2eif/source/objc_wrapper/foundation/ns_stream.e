note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STREAM

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

feature -- NSStream

	open
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_open (item)
		end

	close
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close (item)
		end

	delegate: detachable NS_STREAM_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_STREAM_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	property_for_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_property_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_property__for_key_ (a_property: detachable NS_OBJECT; a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_property__item: POINTER
			a_key__item: POINTER
		do
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_set_property__for_key_ (item, a_property__item, a_key__item)
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

	stream_status: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_stream_status (item)
		end

	stream_error: detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_stream_error (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like stream_error} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like stream_error} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSStream Externals

	objc_open (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSStream *)$an_item open];
			 ]"
		end

	objc_close (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSStream *)$an_item close];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStream *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSStream *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_property_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStream *)$an_item propertyForKey:$a_key];
			 ]"
		end

	objc_set_property__for_key_ (an_item: POINTER; a_property: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSStream *)$an_item setProperty:$a_property forKey:$a_key];
			 ]"
		end

	objc_schedule_in_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSStream *)$an_item scheduleInRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_remove_from_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSStream *)$an_item removeFromRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_stream_status (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSStream *)$an_item streamStatus];
			 ]"
		end

	objc_stream_error (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStream *)$an_item streamError];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSStream"
		end

end
