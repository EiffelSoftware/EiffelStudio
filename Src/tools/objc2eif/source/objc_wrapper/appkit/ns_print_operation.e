note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_OPERATION

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

feature -- NSPrintOperation

	is_copying_operation: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_copying_operation (item)
		end

	set_job_title_ (a_job_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_job_title__item: POINTER
		do
			if attached a_job_title as a_job_title_attached then
				a_job_title__item := a_job_title_attached.item
			end
			objc_set_job_title_ (item, a_job_title__item)
		end

	job_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_job_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like job_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like job_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_shows_print_panel_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_print_panel_ (item, a_flag)
		end

	shows_print_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_print_panel (item)
		end

	set_shows_progress_panel_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_progress_panel_ (item, a_flag)
		end

	shows_progress_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_progress_panel (item)
		end

	set_print_panel_ (a_panel: detachable NS_PRINT_PANEL)
			-- Auto generated Objective-C wrapper.
		local
			a_panel__item: POINTER
		do
			if attached a_panel as a_panel_attached then
				a_panel__item := a_panel_attached.item
			end
			objc_set_print_panel_ (item, a_panel__item)
		end

	print_panel: detachable NS_PRINT_PANEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_print_panel (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_can_spawn_separate_thread_ (a_can_spawn_separate_thread: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_spawn_separate_thread_ (item, a_can_spawn_separate_thread)
		end

	can_spawn_separate_thread: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_spawn_separate_thread (item)
		end

	set_page_order_ (a_page_order: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_page_order_ (item, a_page_order)
		end

	page_order: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_page_order (item)
		end

--	run_operation_modal_for_window__delegate__did_run_selector__context_info_ (a_doc_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_run_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_doc_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_run_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_doc_window as a_doc_window_attached then
--				a_doc_window__item := a_doc_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_run_selector as a_did_run_selector_attached then
--				a_did_run_selector__item := a_did_run_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_run_operation_modal_for_window__delegate__did_run_selector__context_info_ (item, a_doc_window__item, a_delegate__item, a_did_run_selector__item, a_context_info__item)
--		end

	run_operation: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_run_operation (item)
		end

	view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	print_info: detachable NS_PRINT_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_print_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_print_info_ (a_print_info: detachable NS_PRINT_INFO)
			-- Auto generated Objective-C wrapper.
		local
			a_print_info__item: POINTER
		do
			if attached a_print_info as a_print_info_attached then
				a_print_info__item := a_print_info_attached.item
			end
			objc_set_print_info_ (item, a_print_info__item)
		end

	context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	page_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_page_range (item, Result.item)
		end

	current_page: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_page (item)
		end

	create_context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_create_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like create_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like create_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	destroy_context
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_destroy_context (item)
		end

	deliver_result: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_deliver_result (item)
		end

	clean_up_operation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clean_up_operation (item)
		end

feature {NONE} -- NSPrintOperation Externals

	objc_is_copying_operation (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item isCopyingOperation];
			 ]"
		end

	objc_set_job_title_ (an_item: POINTER; a_job_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setJobTitle:$a_job_title];
			 ]"
		end

	objc_job_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item jobTitle];
			 ]"
		end

	objc_set_shows_print_panel_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setShowsPrintPanel:$a_flag];
			 ]"
		end

	objc_shows_print_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item showsPrintPanel];
			 ]"
		end

	objc_set_shows_progress_panel_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setShowsProgressPanel:$a_flag];
			 ]"
		end

	objc_shows_progress_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item showsProgressPanel];
			 ]"
		end

	objc_set_print_panel_ (an_item: POINTER; a_panel: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setPrintPanel:$a_panel];
			 ]"
		end

	objc_print_panel (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item printPanel];
			 ]"
		end

	objc_set_can_spawn_separate_thread_ (an_item: POINTER; a_can_spawn_separate_thread: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setCanSpawnSeparateThread:$a_can_spawn_separate_thread];
			 ]"
		end

	objc_can_spawn_separate_thread (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item canSpawnSeparateThread];
			 ]"
		end

	objc_set_page_order_ (an_item: POINTER; a_page_order: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setPageOrder:$a_page_order];
			 ]"
		end

	objc_page_order (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item pageOrder];
			 ]"
		end

--	objc_run_operation_modal_for_window__delegate__did_run_selector__context_info_ (an_item: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_run_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSPrintOperation *)$an_item runOperationModalForWindow:$a_doc_window delegate:$a_delegate didRunSelector:$a_did_run_selector contextInfo:];
--			 ]"
--		end

	objc_run_operation (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item runOperation];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item view];
			 ]"
		end

	objc_print_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item printInfo];
			 ]"
		end

	objc_set_print_info_ (an_item: POINTER; a_print_info: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item setPrintInfo:$a_print_info];
			 ]"
		end

	objc_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item context];
			 ]"
		end

	objc_page_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSPrintOperation *)$an_item pageRange];
			 ]"
		end

	objc_current_page (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item currentPage];
			 ]"
		end

	objc_create_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintOperation *)$an_item createContext];
			 ]"
		end

	objc_destroy_context (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item destroyContext];
			 ]"
		end

	objc_deliver_result (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintOperation *)$an_item deliverResult];
			 ]"
		end

	objc_clean_up_operation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintOperation *)$an_item cleanUpOperation];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrintOperation"
		end

end
