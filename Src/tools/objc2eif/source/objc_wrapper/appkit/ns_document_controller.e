note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DOCUMENT_CONTROLLER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL
		undefine
			validate_user_interface_item_,
			objc_validate_user_interface_item_
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSDocumentController

	documents: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_documents (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like documents} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like documents} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_document: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_document (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_document} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_document} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_directory: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_directory (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_directory} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_directory} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_for_ur_l_ (a_absolute_url: detachable NS_URL): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_absolute_url__item: POINTER
		do
			if attached a_absolute_url as a_absolute_url_attached then
				a_absolute_url__item := a_absolute_url_attached.item
			end
			result_pointer := objc_document_for_ur_l_ (item, a_absolute_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_for_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_for_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_for_window_ (a_window: detachable NS_WINDOW): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			result_pointer := objc_document_for_window_ (item, a_window__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_for_window_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_for_window_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_document_ (a_document: detachable NS_DOCUMENT)
			-- Auto generated Objective-C wrapper.
		local
			a_document__item: POINTER
		do
			if attached a_document as a_document_attached then
				a_document__item := a_document_attached.item
			end
			objc_add_document_ (item, a_document__item)
		end

	remove_document_ (a_document: detachable NS_DOCUMENT)
			-- Auto generated Objective-C wrapper.
		local
			a_document__item: POINTER
		do
			if attached a_document as a_document_attached then
				a_document__item := a_document_attached.item
			end
			objc_remove_document_ (item, a_document__item)
		end

	new_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_new_document_ (item, a_sender__item)
		end

--	open_untitled_document_and_display__error_ (a_display_document: BOOLEAN; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_open_untitled_document_and_display__error_ (item, a_display_document, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like open_untitled_document_and_display__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like open_untitled_document_and_display__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	make_untitled_document_of_type__error_ (a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_make_untitled_document_of_type__error_ (item, a_type_name__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like make_untitled_document_of_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like make_untitled_document_of_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	open_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_open_document_ (item, a_sender__item)
		end

	ur_ls_from_running_open_panel: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ur_ls_from_running_open_panel (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ur_ls_from_running_open_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ur_ls_from_running_open_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	run_modal_open_panel__for_types_ (a_open_panel: detachable NS_OPEN_PANEL; a_types: detachable NS_ARRAY): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_open_panel__item: POINTER
			a_types__item: POINTER
		do
			if attached a_open_panel as a_open_panel_attached then
				a_open_panel__item := a_open_panel_attached.item
			end
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			Result := objc_run_modal_open_panel__for_types_ (item, a_open_panel__item, a_types__item)
		end

--	open_document_with_contents_of_ur_l__display__error_ (a_absolute_url: detachable NS_URL; a_display_document: BOOLEAN; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_absolute_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_url as a_absolute_url_attached then
--				a_absolute_url__item := a_absolute_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_open_document_with_contents_of_ur_l__display__error_ (item, a_absolute_url__item, a_display_document, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like open_document_with_contents_of_ur_l__display__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like open_document_with_contents_of_ur_l__display__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	make_document_with_contents_of_ur_l__of_type__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_absolute_url__item: POINTER
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_url as a_absolute_url_attached then
--				a_absolute_url__item := a_absolute_url_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_make_document_with_contents_of_ur_l__of_type__error_ (item, a_absolute_url__item, a_type_name__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like make_document_with_contents_of_ur_l__of_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like make_document_with_contents_of_ur_l__of_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	reopen_document_for_ur_l__with_contents_of_ur_l__error_ (a_absolute_document_url: detachable NS_URL; a_absolute_document_contents_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_absolute_document_url__item: POINTER
--			a_absolute_document_contents_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_document_url as a_absolute_document_url_attached then
--				a_absolute_document_url__item := a_absolute_document_url_attached.item
--			end
--			if attached a_absolute_document_contents_url as a_absolute_document_contents_url_attached then
--				a_absolute_document_contents_url__item := a_absolute_document_contents_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_reopen_document_for_ur_l__with_contents_of_ur_l__error_ (item, a_absolute_document_url__item, a_absolute_document_contents_url__item, a_out_error__item)
--		end

--	make_document_for_ur_l__with_contents_of_ur_l__of_type__error_ (a_absolute_document_url: detachable NS_URL; a_absolute_document_contents_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_absolute_document_url__item: POINTER
--			a_absolute_document_contents_url__item: POINTER
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_document_url as a_absolute_document_url_attached then
--				a_absolute_document_url__item := a_absolute_document_url_attached.item
--			end
--			if attached a_absolute_document_contents_url as a_absolute_document_contents_url_attached then
--				a_absolute_document_contents_url__item := a_absolute_document_contents_url_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_make_document_for_ur_l__with_contents_of_ur_l__of_type__error_ (item, a_absolute_document_url__item, a_absolute_document_contents_url__item, a_type_name__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like make_document_for_ur_l__with_contents_of_ur_l__of_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like make_document_for_ur_l__with_contents_of_ur_l__of_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_autosaving_delay_ (a_autosaving_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autosaving_delay_ (item, a_autosaving_delay)
		end

	autosaving_delay: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autosaving_delay (item)
		end

	save_all_documents_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_save_all_documents_ (item, a_sender__item)
		end

	has_edited_documents: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_edited_documents (item)
		end

--	review_unsaved_documents_with_alert_title__cancellable__delegate__did_review_all_selector__context_info_ (a_title: detachable NS_STRING; a_cancellable: BOOLEAN; a_delegate: detachable NS_OBJECT; a_did_review_all_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_title__item: POINTER
--			a_delegate__item: POINTER
--			a_did_review_all_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_title as a_title_attached then
--				a_title__item := a_title_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_review_all_selector as a_did_review_all_selector_attached then
--				a_did_review_all_selector__item := a_did_review_all_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_review_unsaved_documents_with_alert_title__cancellable__delegate__did_review_all_selector__context_info_ (item, a_title__item, a_cancellable, a_delegate__item, a_did_review_all_selector__item, a_context_info__item)
--		end

--	close_all_documents_with_delegate__did_close_all_selector__context_info_ (a_delegate: detachable NS_OBJECT; a_did_close_all_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_did_close_all_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_close_all_selector as a_did_close_all_selector_attached then
--				a_did_close_all_selector__item := a_did_close_all_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_close_all_documents_with_delegate__did_close_all_selector__context_info_ (item, a_delegate__item, a_did_close_all_selector__item, a_context_info__item)
--		end

--	present_error__modal_for_window__delegate__did_present_selector__context_info_ (a_error: detachable NS_ERROR; a_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_present_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--			a_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_present_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			if attached a_window as a_window_attached then
--				a_window__item := a_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_present_selector as a_did_present_selector_attached then
--				a_did_present_selector__item := a_did_present_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_present_error__modal_for_window__delegate__did_present_selector__context_info_ (item, a_error__item, a_window__item, a_delegate__item, a_did_present_selector__item, a_context_info__item)
--		end

	present_error_ (a_error: detachable NS_ERROR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			Result := objc_present_error_ (item, a_error__item)
		end

	will_present_error_ (a_error: detachable NS_ERROR): detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			result_pointer := objc_will_present_error_ (item, a_error__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like will_present_error_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like will_present_error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	maximum_recent_document_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_recent_document_count (item)
		end

	clear_recent_documents_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_clear_recent_documents_ (item, a_sender__item)
		end

	note_new_recent_document_ (a_document: detachable NS_DOCUMENT)
			-- Auto generated Objective-C wrapper.
		local
			a_document__item: POINTER
		do
			if attached a_document as a_document_attached then
				a_document__item := a_document_attached.item
			end
			objc_note_new_recent_document_ (item, a_document__item)
		end

	note_new_recent_document_ur_l_ (a_absolute_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_absolute_url__item: POINTER
		do
			if attached a_absolute_url as a_absolute_url_attached then
				a_absolute_url__item := a_absolute_url_attached.item
			end
			objc_note_new_recent_document_ur_l_ (item, a_absolute_url__item)
		end

	recent_document_ur_ls: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_recent_document_ur_ls (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like recent_document_ur_ls} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like recent_document_ur_ls} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	type_for_contents_of_ur_l__error_ (a_in_absolute_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_in_absolute_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_in_absolute_url as a_in_absolute_url_attached then
--				a_in_absolute_url__item := a_in_absolute_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_type_for_contents_of_ur_l__error_ (item, a_in_absolute_url__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like type_for_contents_of_ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like type_for_contents_of_ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	document_class_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_document_class_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_class_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_class_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_class_for_type_ (a_type_name: detachable NS_STRING): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			result_pointer := objc_document_class_for_type_ (item, a_type_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_class_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_class_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	display_name_for_type_ (a_type_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			result_pointer := objc_display_name_for_type_ (item, a_type_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_name_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_name_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	validate_user_interface_item_ (an_item: detachable NS_VALIDATED_USER_INTERFACE_ITEM_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			an_item__item: POINTER
		do
			if attached an_item as an_item_attached then
				an_item__item := an_item_attached.item
			end
			Result := objc_validate_user_interface_item_ (item, an_item__item)
		end

feature {NONE} -- NSDocumentController Externals

	objc_documents (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item documents];
			 ]"
		end

	objc_current_document (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item currentDocument];
			 ]"
		end

	objc_current_directory (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item currentDirectory];
			 ]"
		end

	objc_document_for_ur_l_ (an_item: POINTER; a_absolute_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item documentForURL:$a_absolute_url];
			 ]"
		end

	objc_document_for_window_ (an_item: POINTER; a_window: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item documentForWindow:$a_window];
			 ]"
		end

	objc_add_document_ (an_item: POINTER; a_document: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item addDocument:$a_document];
			 ]"
		end

	objc_remove_document_ (an_item: POINTER; a_document: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item removeDocument:$a_document];
			 ]"
		end

	objc_new_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item newDocument:$a_sender];
			 ]"
		end

--	objc_open_untitled_document_and_display__error_ (an_item: POINTER; a_display_document: BOOLEAN; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item openUntitledDocumentAndDisplay:$a_display_document error:];
--			 ]"
--		end

--	objc_make_untitled_document_of_type__error_ (an_item: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item makeUntitledDocumentOfType:$a_type_name error:];
--			 ]"
--		end

	objc_open_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item openDocument:$a_sender];
			 ]"
		end

	objc_ur_ls_from_running_open_panel (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item URLsFromRunningOpenPanel];
			 ]"
		end

	objc_run_modal_open_panel__for_types_ (an_item: POINTER; a_open_panel: POINTER; a_types: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item runModalOpenPanel:$a_open_panel forTypes:$a_types];
			 ]"
		end

--	objc_open_document_with_contents_of_ur_l__display__error_ (an_item: POINTER; a_absolute_url: POINTER; a_display_document: BOOLEAN; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item openDocumentWithContentsOfURL:$a_absolute_url display:$a_display_document error:];
--			 ]"
--		end

--	objc_make_document_with_contents_of_ur_l__of_type__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item makeDocumentWithContentsOfURL:$a_absolute_url ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_reopen_document_for_ur_l__with_contents_of_ur_l__error_ (an_item: POINTER; a_absolute_document_url: POINTER; a_absolute_document_contents_url: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocumentController *)$an_item reopenDocumentForURL:$a_absolute_document_url withContentsOfURL:$a_absolute_document_contents_url error:];
--			 ]"
--		end

--	objc_make_document_for_ur_l__with_contents_of_ur_l__of_type__error_ (an_item: POINTER; a_absolute_document_url: POINTER; a_absolute_document_contents_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item makeDocumentForURL:$a_absolute_document_url withContentsOfURL:$a_absolute_document_contents_url ofType:$a_type_name error:];
--			 ]"
--		end

	objc_set_autosaving_delay_ (an_item: POINTER; a_autosaving_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item setAutosavingDelay:$a_autosaving_delay];
			 ]"
		end

	objc_autosaving_delay (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item autosavingDelay];
			 ]"
		end

	objc_save_all_documents_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item saveAllDocuments:$a_sender];
			 ]"
		end

	objc_has_edited_documents (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item hasEditedDocuments];
			 ]"
		end

--	objc_review_unsaved_documents_with_alert_title__cancellable__delegate__did_review_all_selector__context_info_ (an_item: POINTER; a_title: POINTER; a_cancellable: BOOLEAN; a_delegate: POINTER; a_did_review_all_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocumentController *)$an_item reviewUnsavedDocumentsWithAlertTitle:$a_title cancellable:$a_cancellable delegate:$a_delegate didReviewAllSelector:$a_did_review_all_selector contextInfo:];
--			 ]"
--		end

--	objc_close_all_documents_with_delegate__did_close_all_selector__context_info_ (an_item: POINTER; a_delegate: POINTER; a_did_close_all_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocumentController *)$an_item closeAllDocumentsWithDelegate:$a_delegate didCloseAllSelector:$a_did_close_all_selector contextInfo:];
--			 ]"
--		end

--	objc_present_error__modal_for_window__delegate__did_present_selector__context_info_ (an_item: POINTER; a_error: POINTER; a_window: POINTER; a_delegate: POINTER; a_did_present_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocumentController *)$an_item presentError:$a_error modalForWindow:$a_window delegate:$a_delegate didPresentSelector:$a_did_present_selector contextInfo:];
--			 ]"
--		end

	objc_present_error_ (an_item: POINTER; a_error: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item presentError:$a_error];
			 ]"
		end

	objc_will_present_error_ (an_item: POINTER; a_error: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item willPresentError:$a_error];
			 ]"
		end

	objc_maximum_recent_document_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item maximumRecentDocumentCount];
			 ]"
		end

	objc_clear_recent_documents_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item clearRecentDocuments:$a_sender];
			 ]"
		end

	objc_note_new_recent_document_ (an_item: POINTER; a_document: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item noteNewRecentDocument:$a_document];
			 ]"
		end

	objc_note_new_recent_document_ur_l_ (an_item: POINTER; a_absolute_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocumentController *)$an_item noteNewRecentDocumentURL:$a_absolute_url];
			 ]"
		end

	objc_recent_document_ur_ls (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item recentDocumentURLs];
			 ]"
		end

	objc_default_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item defaultType];
			 ]"
		end

--	objc_type_for_contents_of_ur_l__error_ (an_item: POINTER; a_in_absolute_url: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocumentController *)$an_item typeForContentsOfURL:$a_in_absolute_url error:];
--			 ]"
--		end

	objc_document_class_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item documentClassNames];
			 ]"
		end

	objc_document_class_for_type_ (an_item: POINTER; a_type_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item documentClassForType:$a_type_name];
			 ]"
		end

	objc_display_name_for_type_ (an_item: POINTER; a_type_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocumentController *)$an_item displayNameForType:$a_type_name];
			 ]"
		end

	objc_validate_user_interface_item_ (an_item: POINTER; an_item_arg: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocumentController *)$an_item validateUserInterfaceItem:$an_item_arg];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDocumentController"
		end

end
