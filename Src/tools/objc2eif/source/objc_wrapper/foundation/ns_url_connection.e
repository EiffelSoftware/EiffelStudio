note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_CONNECTION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_request__delegate_,
	make_with_request__delegate__start_immediately_,
	make

feature {NONE} -- Initialization

	make_with_request__delegate_ (a_request: detachable NS_URL_REQUEST; a_delegate: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_request__item: POINTER
			a_delegate__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			make_with_pointer (objc_init_with_request__delegate_(allocate_object, a_request__item, a_delegate__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_request__delegate__start_immediately_ (a_request: detachable NS_URL_REQUEST; a_delegate: detachable NS_OBJECT; a_start_immediately: BOOLEAN)
			-- Initialize `Current'.
		local
			a_request__item: POINTER
			a_delegate__item: POINTER
		do
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			make_with_pointer (objc_init_with_request__delegate__start_immediately_(allocate_object, a_request__item, a_delegate__item, a_start_immediately))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSURLConnection Externals

	objc_init_with_request__delegate_ (an_item: POINTER; a_request: POINTER; a_delegate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLConnection *)$an_item initWithRequest:$a_request delegate:$a_delegate];
			 ]"
		end

	objc_init_with_request__delegate__start_immediately_ (an_item: POINTER; a_request: POINTER; a_delegate: POINTER; a_start_immediately: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSURLConnection *)$an_item initWithRequest:$a_request delegate:$a_delegate startImmediately:$a_start_immediately];
			 ]"
		end

	objc_start (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLConnection *)$an_item start];
			 ]"
		end

	objc_cancel (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLConnection *)$an_item cancel];
			 ]"
		end

	objc_schedule_in_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLConnection *)$an_item scheduleInRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

	objc_unschedule_from_run_loop__for_mode_ (an_item: POINTER; a_run_loop: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSURLConnection *)$an_item unscheduleFromRunLoop:$a_run_loop forMode:$a_mode];
			 ]"
		end

feature -- NSURLConnection

	start
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start (item)
		end

	cancel
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel (item)
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

	unschedule_from_run_loop__for_mode_ (a_run_loop: detachable NS_RUN_LOOP; a_mode: detachable NS_STRING)
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
			objc_unschedule_from_run_loop__for_mode_ (item, a_run_loop__item, a_mode__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLConnection"
		end

end
