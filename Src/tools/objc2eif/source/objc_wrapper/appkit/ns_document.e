note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DOCUMENT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

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

feature {NONE} -- Initialization

--	make_with_type__error_ (a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			make_with_pointer (objc_init_with_type__error_(allocate_object, a_type_name__item, a_out_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_ur_l__of_type__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
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
--			make_with_pointer (objc_init_with_contents_of_ur_l__of_type__error_(allocate_object, a_absolute_url__item, a_type_name__item, a_out_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_for_ur_l__with_contents_of_ur_l__of_type__error_ (a_absolute_document_url: detachable NS_URL; a_absolute_document_contents_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
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
--			make_with_pointer (objc_init_for_ur_l__with_contents_of_ur_l__of_type__error_(allocate_object, a_absolute_document_url__item, a_absolute_document_contents_url__item, a_type_name__item, a_out_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSDocument Externals

--	objc_init_with_type__error_ (an_item: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item initWithType:$a_type_name error:];
--			 ]"
--		end

--	objc_init_with_contents_of_ur_l__of_type__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item initWithContentsOfURL:$a_absolute_url ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_init_for_ur_l__with_contents_of_ur_l__of_type__error_ (an_item: POINTER; a_absolute_document_url: POINTER; a_absolute_document_contents_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item initForURL:$a_absolute_document_url withContentsOfURL:$a_absolute_document_contents_url ofType:$a_type_name error:];
--			 ]"
--		end

	objc_set_file_type_ (an_item: POINTER; a_type_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setFileType:$a_type_name];
			 ]"
		end

	objc_file_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item fileType];
			 ]"
		end

	objc_set_file_ur_l_ (an_item: POINTER; a_absolute_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setFileURL:$a_absolute_url];
			 ]"
		end

	objc_file_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item fileURL];
			 ]"
		end

	objc_set_file_modification_date_ (an_item: POINTER; a_modification_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setFileModificationDate:$a_modification_date];
			 ]"
		end

	objc_file_modification_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item fileModificationDate];
			 ]"
		end

	objc_revert_document_to_saved_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item revertDocumentToSaved:$a_sender];
			 ]"
		end

--	objc_revert_to_contents_of_ur_l__of_type__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item revertToContentsOfURL:$a_absolute_url ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_read_from_ur_l__of_type__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item readFromURL:$a_absolute_url ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_read_from_file_wrapper__of_type__error_ (an_item: POINTER; a_file_wrapper: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item readFromFileWrapper:$a_file_wrapper ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_read_from_data__of_type__error_ (an_item: POINTER; a_data: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item readFromData:$a_data ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_write_to_ur_l__of_type__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item writeToURL:$a_absolute_url ofType:$a_type_name error:];
--			 ]"
--		end

--	objc_file_wrapper_of_type__error_ (an_item: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item fileWrapperOfType:$a_type_name error:];
--			 ]"
--		end

--	objc_data_of_type__error_ (an_item: POINTER; a_type_name: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item dataOfType:$a_type_name error:];
--			 ]"
--		end

--	objc_write_safely_to_ur_l__of_type__for_save_operation__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item writeSafelyToURL:$a_absolute_url ofType:$a_type_name forSaveOperation:$a_save_operation error:];
--			 ]"
--		end

--	objc_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64; a_absolute_original_contents_url: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item writeToURL:$a_absolute_url ofType:$a_type_name forSaveOperation:$a_save_operation originalContentsURL:$a_absolute_original_contents_url error:];
--			 ]"
--		end

--	objc_file_attributes_to_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64; a_absolute_original_contents_url: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item fileAttributesToWriteToURL:$a_absolute_url ofType:$a_type_name forSaveOperation:$a_save_operation originalContentsURL:$a_absolute_original_contents_url error:];
--			 ]"
--		end

	objc_keep_backup_file (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item keepBackupFile];
			 ]"
		end

	objc_save_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item saveDocument:$a_sender];
			 ]"
		end

	objc_save_document_as_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item saveDocumentAs:$a_sender];
			 ]"
		end

	objc_save_document_to_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item saveDocumentTo:$a_sender];
			 ]"
		end

--	objc_save_document_with_delegate__did_save_selector__context_info_ (an_item: POINTER; a_delegate: POINTER; a_did_save_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item saveDocumentWithDelegate:$a_delegate didSaveSelector:$a_did_save_selector contextInfo:];
--			 ]"
--		end

--	objc_run_modal_save_panel_for_save_operation__delegate__did_save_selector__context_info_ (an_item: POINTER; a_save_operation: NATURAL_64; a_delegate: POINTER; a_did_save_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item runModalSavePanelForSaveOperation:$a_save_operation delegate:$a_delegate didSaveSelector:$a_did_save_selector contextInfo:];
--			 ]"
--		end

	objc_should_run_save_panel_with_accessory_view (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item shouldRunSavePanelWithAccessoryView];
			 ]"
		end

	objc_prepare_save_panel_ (an_item: POINTER; a_save_panel: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item prepareSavePanel:$a_save_panel];
			 ]"
		end

	objc_file_name_extension_was_hidden_in_last_run_save_panel (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item fileNameExtensionWasHiddenInLastRunSavePanel];
			 ]"
		end

	objc_file_type_from_last_run_save_panel (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item fileTypeFromLastRunSavePanel];
			 ]"
		end

--	objc_save_to_ur_l__of_type__for_save_operation__delegate__did_save_selector__context_info_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64; a_delegate: POINTER; a_did_save_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item saveToURL:$a_absolute_url ofType:$a_type_name forSaveOperation:$a_save_operation delegate:$a_delegate didSaveSelector:$a_did_save_selector contextInfo:];
--			 ]"
--		end

--	objc_save_to_ur_l__of_type__for_save_operation__error_ (an_item: POINTER; a_absolute_url: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSDocument *)$an_item saveToURL:$a_absolute_url ofType:$a_type_name forSaveOperation:$a_save_operation error:];
--			 ]"
--		end

	objc_has_unautosaved_changes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item hasUnautosavedChanges];
			 ]"
		end

--	objc_autosave_document_with_delegate__did_autosave_selector__context_info_ (an_item: POINTER; a_delegate: POINTER; a_did_autosave_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item autosaveDocumentWithDelegate:$a_delegate didAutosaveSelector:$a_did_autosave_selector contextInfo:];
--			 ]"
--		end

	objc_autosaving_file_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item autosavingFileType];
			 ]"
		end

	objc_set_autosaved_contents_file_ur_l_ (an_item: POINTER; a_absolute_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setAutosavedContentsFileURL:$a_absolute_url];
			 ]"
		end

	objc_autosaved_contents_file_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item autosavedContentsFileURL];
			 ]"
		end

--	objc_can_close_document_with_delegate__should_close_selector__context_info_ (an_item: POINTER; a_delegate: POINTER; a_should_close_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item canCloseDocumentWithDelegate:$a_delegate shouldCloseSelector:$a_should_close_selector contextInfo:];
--			 ]"
--		end

	objc_close (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item close];
			 ]"
		end

	objc_run_page_layout_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item runPageLayout:$a_sender];
			 ]"
		end

--	objc_run_modal_page_layout_with_print_info__delegate__did_run_selector__context_info_ (an_item: POINTER; a_print_info: POINTER; a_delegate: POINTER; a_did_run_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item runModalPageLayoutWithPrintInfo:$a_print_info delegate:$a_delegate didRunSelector:$a_did_run_selector contextInfo:];
--			 ]"
--		end

	objc_prepare_page_layout_ (an_item: POINTER; a_page_layout: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item preparePageLayout:$a_page_layout];
			 ]"
		end

	objc_should_change_print_info_ (an_item: POINTER; a_new_print_info: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item shouldChangePrintInfo:$a_new_print_info];
			 ]"
		end

	objc_set_print_info_ (an_item: POINTER; a_print_info: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setPrintInfo:$a_print_info];
			 ]"
		end

	objc_print_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item printInfo];
			 ]"
		end

	objc_print_document_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item printDocument:$a_sender];
			 ]"
		end

--	objc_print_document_with_settings__show_print_panel__delegate__did_print_selector__context_info_ (an_item: POINTER; a_print_settings: POINTER; a_show_print_panel: BOOLEAN; a_delegate: POINTER; a_did_print_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item printDocumentWithSettings:$a_print_settings showPrintPanel:$a_show_print_panel delegate:$a_delegate didPrintSelector:$a_did_print_selector contextInfo:];
--			 ]"
--		end

--	objc_print_operation_with_settings__error_ (an_item: POINTER; a_print_settings: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDocument *)$an_item printOperationWithSettings:$a_print_settings error:];
--			 ]"
--		end

--	objc_run_modal_print_operation__delegate__did_run_selector__context_info_ (an_item: POINTER; a_print_operation: POINTER; a_delegate: POINTER; a_did_run_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item runModalPrintOperation:$a_print_operation delegate:$a_delegate didRunSelector:$a_did_run_selector contextInfo:];
--			 ]"
--		end

	objc_is_document_edited (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item isDocumentEdited];
			 ]"
		end

	objc_update_change_count_ (an_item: POINTER; a_change: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item updateChangeCount:$a_change];
			 ]"
		end

	objc_set_undo_manager_ (an_item: POINTER; a_undo_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setUndoManager:$a_undo_manager];
			 ]"
		end

	objc_undo_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item undoManager];
			 ]"
		end

	objc_set_has_undo_manager_ (an_item: POINTER; a_has_undo_manager: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setHasUndoManager:$a_has_undo_manager];
			 ]"
		end

	objc_has_undo_manager (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item hasUndoManager];
			 ]"
		end

--	objc_present_error__modal_for_window__delegate__did_present_selector__context_info_ (an_item: POINTER; a_error: POINTER; a_window: POINTER; a_delegate: POINTER; a_did_present_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item presentError:$a_error modalForWindow:$a_window delegate:$a_delegate didPresentSelector:$a_did_present_selector contextInfo:];
--			 ]"
--		end

	objc_present_error_ (an_item: POINTER; a_error: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item presentError:$a_error];
			 ]"
		end

	objc_will_present_error_ (an_item: POINTER; a_error: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item willPresentError:$a_error];
			 ]"
		end

	objc_make_window_controllers (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item makeWindowControllers];
			 ]"
		end

	objc_window_nib_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item windowNibName];
			 ]"
		end

	objc_window_controller_will_load_nib_ (an_item: POINTER; a_window_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item windowControllerWillLoadNib:$a_window_controller];
			 ]"
		end

	objc_window_controller_did_load_nib_ (an_item: POINTER; a_window_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item windowControllerDidLoadNib:$a_window_controller];
			 ]"
		end

	objc_set_window_ (an_item: POINTER; a_window: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setWindow:$a_window];
			 ]"
		end

	objc_add_window_controller_ (an_item: POINTER; a_window_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item addWindowController:$a_window_controller];
			 ]"
		end

	objc_remove_window_controller_ (an_item: POINTER; a_window_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item removeWindowController:$a_window_controller];
			 ]"
		end

	objc_show_windows (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item showWindows];
			 ]"
		end

	objc_window_controllers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item windowControllers];
			 ]"
		end

--	objc_should_close_window_controller__delegate__should_close_selector__context_info_ (an_item: POINTER; a_window_controller: POINTER; a_delegate: POINTER; a_should_close_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSDocument *)$an_item shouldCloseWindowController:$a_window_controller delegate:$a_delegate shouldCloseSelector:$a_should_close_selector contextInfo:];
--			 ]"
--		end

	objc_display_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item displayName];
			 ]"
		end

	objc_window_for_sheet (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item windowForSheet];
			 ]"
		end

	objc_writable_types_for_save_operation_ (an_item: POINTER; a_save_operation: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item writableTypesForSaveOperation:$a_save_operation];
			 ]"
		end

	objc_file_name_extension_for_type__save_operation_ (an_item: POINTER; a_type_name: POINTER; a_save_operation: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item fileNameExtensionForType:$a_type_name saveOperation:$a_save_operation];
			 ]"
		end

	objc_validate_user_interface_item_ (an_item: POINTER; an_item_arg: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDocument *)$an_item validateUserInterfaceItem:$an_item_arg];
			 ]"
		end

feature -- NSDocument

	set_file_type_ (a_type_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			objc_set_file_type_ (item, a_type_name__item)
		end

	file_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_file_ur_l_ (a_absolute_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_absolute_url__item: POINTER
		do
			if attached a_absolute_url as a_absolute_url_attached then
				a_absolute_url__item := a_absolute_url_attached.item
			end
			objc_set_file_ur_l_ (item, a_absolute_url__item)
		end

	file_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_file_modification_date_ (a_modification_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_modification_date__item: POINTER
		do
			if attached a_modification_date as a_modification_date_attached then
				a_modification_date__item := a_modification_date_attached.item
			end
			objc_set_file_modification_date_ (item, a_modification_date__item)
		end

	file_modification_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_modification_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_modification_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_modification_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	revert_document_to_saved_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_revert_document_to_saved_ (item, a_sender__item)
		end

--	revert_to_contents_of_ur_l__of_type__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_revert_to_contents_of_ur_l__of_type__error_ (item, a_absolute_url__item, a_type_name__item, a_out_error__item)
--		end

--	read_from_ur_l__of_type__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_read_from_ur_l__of_type__error_ (item, a_absolute_url__item, a_type_name__item, a_out_error__item)
--		end

--	read_from_file_wrapper__of_type__error_ (a_file_wrapper: detachable NS_FILE_WRAPPER; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_file_wrapper__item: POINTER
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_file_wrapper as a_file_wrapper_attached then
--				a_file_wrapper__item := a_file_wrapper_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_read_from_file_wrapper__of_type__error_ (item, a_file_wrapper__item, a_type_name__item, a_out_error__item)
--		end

--	read_from_data__of_type__error_ (a_data: detachable NS_DATA; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_data__item: POINTER
--			a_type_name__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_read_from_data__of_type__error_ (item, a_data__item, a_type_name__item, a_out_error__item)
--		end

--	write_to_ur_l__of_type__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_write_to_ur_l__of_type__error_ (item, a_absolute_url__item, a_type_name__item, a_out_error__item)
--		end

--	file_wrapper_of_type__error_ (a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_FILE_WRAPPER
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
--			result_pointer := objc_file_wrapper_of_type__error_ (item, a_type_name__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like file_wrapper_of_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like file_wrapper_of_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_of_type__error_ (a_type_name: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_DATA
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
--			result_pointer := objc_data_of_type__error_ (item, a_type_name__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_of_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_of_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	write_safely_to_ur_l__of_type__for_save_operation__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_write_safely_to_ur_l__of_type__for_save_operation__error_ (item, a_absolute_url__item, a_type_name__item, a_save_operation, a_out_error__item)
--		end

--	write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64; a_absolute_original_contents_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_absolute_url__item: POINTER
--			a_type_name__item: POINTER
--			a_absolute_original_contents_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_url as a_absolute_url_attached then
--				a_absolute_url__item := a_absolute_url_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_absolute_original_contents_url as a_absolute_original_contents_url_attached then
--				a_absolute_original_contents_url__item := a_absolute_original_contents_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (item, a_absolute_url__item, a_type_name__item, a_save_operation, a_absolute_original_contents_url__item, a_out_error__item)
--		end

--	file_attributes_to_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64; a_absolute_original_contents_url: detachable NS_URL; a_out_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_absolute_url__item: POINTER
--			a_type_name__item: POINTER
--			a_absolute_original_contents_url__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_url as a_absolute_url_attached then
--				a_absolute_url__item := a_absolute_url_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_absolute_original_contents_url as a_absolute_original_contents_url_attached then
--				a_absolute_original_contents_url__item := a_absolute_original_contents_url_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_file_attributes_to_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_ (item, a_absolute_url__item, a_type_name__item, a_save_operation, a_absolute_original_contents_url__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like file_attributes_to_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like file_attributes_to_write_to_ur_l__of_type__for_save_operation__original_contents_ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	keep_backup_file: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_keep_backup_file (item)
		end

	save_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_save_document_ (item, a_sender__item)
		end

	save_document_as_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_save_document_as_ (item, a_sender__item)
		end

	save_document_to_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_save_document_to_ (item, a_sender__item)
		end

--	save_document_with_delegate__did_save_selector__context_info_ (a_delegate: detachable NS_OBJECT; a_did_save_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_did_save_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_save_selector as a_did_save_selector_attached then
--				a_did_save_selector__item := a_did_save_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_save_document_with_delegate__did_save_selector__context_info_ (item, a_delegate__item, a_did_save_selector__item, a_context_info__item)
--		end

--	run_modal_save_panel_for_save_operation__delegate__did_save_selector__context_info_ (a_save_operation: NATURAL_64; a_delegate: detachable NS_OBJECT; a_did_save_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_did_save_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_save_selector as a_did_save_selector_attached then
--				a_did_save_selector__item := a_did_save_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_run_modal_save_panel_for_save_operation__delegate__did_save_selector__context_info_ (item, a_save_operation, a_delegate__item, a_did_save_selector__item, a_context_info__item)
--		end

	should_run_save_panel_with_accessory_view: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_run_save_panel_with_accessory_view (item)
		end

	prepare_save_panel_ (a_save_panel: detachable NS_SAVE_PANEL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_save_panel__item: POINTER
		do
			if attached a_save_panel as a_save_panel_attached then
				a_save_panel__item := a_save_panel_attached.item
			end
			Result := objc_prepare_save_panel_ (item, a_save_panel__item)
		end

	file_name_extension_was_hidden_in_last_run_save_panel: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_name_extension_was_hidden_in_last_run_save_panel (item)
		end

	file_type_from_last_run_save_panel: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_type_from_last_run_save_panel (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_type_from_last_run_save_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_type_from_last_run_save_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	save_to_ur_l__of_type__for_save_operation__delegate__did_save_selector__context_info_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64; a_delegate: detachable NS_OBJECT; a_did_save_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_absolute_url__item: POINTER
--			a_type_name__item: POINTER
--			a_delegate__item: POINTER
--			a_did_save_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_absolute_url as a_absolute_url_attached then
--				a_absolute_url__item := a_absolute_url_attached.item
--			end
--			if attached a_type_name as a_type_name_attached then
--				a_type_name__item := a_type_name_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_save_selector as a_did_save_selector_attached then
--				a_did_save_selector__item := a_did_save_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_save_to_ur_l__of_type__for_save_operation__delegate__did_save_selector__context_info_ (item, a_absolute_url__item, a_type_name__item, a_save_operation, a_delegate__item, a_did_save_selector__item, a_context_info__item)
--		end

--	save_to_ur_l__of_type__for_save_operation__error_ (a_absolute_url: detachable NS_URL; a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_save_to_ur_l__of_type__for_save_operation__error_ (item, a_absolute_url__item, a_type_name__item, a_save_operation, a_out_error__item)
--		end

	has_unautosaved_changes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_unautosaved_changes (item)
		end

--	autosave_document_with_delegate__did_autosave_selector__context_info_ (a_delegate: detachable NS_OBJECT; a_did_autosave_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_did_autosave_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_autosave_selector as a_did_autosave_selector_attached then
--				a_did_autosave_selector__item := a_did_autosave_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_autosave_document_with_delegate__did_autosave_selector__context_info_ (item, a_delegate__item, a_did_autosave_selector__item, a_context_info__item)
--		end

	autosaving_file_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_autosaving_file_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like autosaving_file_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like autosaving_file_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_autosaved_contents_file_ur_l_ (a_absolute_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_absolute_url__item: POINTER
		do
			if attached a_absolute_url as a_absolute_url_attached then
				a_absolute_url__item := a_absolute_url_attached.item
			end
			objc_set_autosaved_contents_file_ur_l_ (item, a_absolute_url__item)
		end

	autosaved_contents_file_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_autosaved_contents_file_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like autosaved_contents_file_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like autosaved_contents_file_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	can_close_document_with_delegate__should_close_selector__context_info_ (a_delegate: detachable NS_OBJECT; a_should_close_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_should_close_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_should_close_selector as a_should_close_selector_attached then
--				a_should_close_selector__item := a_should_close_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_can_close_document_with_delegate__should_close_selector__context_info_ (item, a_delegate__item, a_should_close_selector__item, a_context_info__item)
--		end

	close
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close (item)
		end

	run_page_layout_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_run_page_layout_ (item, a_sender__item)
		end

--	run_modal_page_layout_with_print_info__delegate__did_run_selector__context_info_ (a_print_info: detachable NS_PRINT_INFO; a_delegate: detachable NS_OBJECT; a_did_run_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_print_info__item: POINTER
--			a_delegate__item: POINTER
--			a_did_run_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_print_info as a_print_info_attached then
--				a_print_info__item := a_print_info_attached.item
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
--			objc_run_modal_page_layout_with_print_info__delegate__did_run_selector__context_info_ (item, a_print_info__item, a_delegate__item, a_did_run_selector__item, a_context_info__item)
--		end

	prepare_page_layout_ (a_page_layout: detachable NS_PAGE_LAYOUT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_page_layout__item: POINTER
		do
			if attached a_page_layout as a_page_layout_attached then
				a_page_layout__item := a_page_layout_attached.item
			end
			Result := objc_prepare_page_layout_ (item, a_page_layout__item)
		end

	should_change_print_info_ (a_new_print_info: detachable NS_PRINT_INFO): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_new_print_info__item: POINTER
		do
			if attached a_new_print_info as a_new_print_info_attached then
				a_new_print_info__item := a_new_print_info_attached.item
			end
			Result := objc_should_change_print_info_ (item, a_new_print_info__item)
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

	print_document_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_print_document_ (item, a_sender__item)
		end

--	print_document_with_settings__show_print_panel__delegate__did_print_selector__context_info_ (a_print_settings: detachable NS_DICTIONARY; a_show_print_panel: BOOLEAN; a_delegate: detachable NS_OBJECT; a_did_print_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_print_settings__item: POINTER
--			a_delegate__item: POINTER
--			a_did_print_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_print_settings as a_print_settings_attached then
--				a_print_settings__item := a_print_settings_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_print_selector as a_did_print_selector_attached then
--				a_did_print_selector__item := a_did_print_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_print_document_with_settings__show_print_panel__delegate__did_print_selector__context_info_ (item, a_print_settings__item, a_show_print_panel, a_delegate__item, a_did_print_selector__item, a_context_info__item)
--		end

--	print_operation_with_settings__error_ (a_print_settings: detachable NS_DICTIONARY; a_out_error: UNSUPPORTED_TYPE): detachable NS_PRINT_OPERATION
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_print_settings__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_print_settings as a_print_settings_attached then
--				a_print_settings__item := a_print_settings_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_print_operation_with_settings__error_ (item, a_print_settings__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like print_operation_with_settings__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like print_operation_with_settings__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	run_modal_print_operation__delegate__did_run_selector__context_info_ (a_print_operation: detachable NS_PRINT_OPERATION; a_delegate: detachable NS_OBJECT; a_did_run_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_print_operation__item: POINTER
--			a_delegate__item: POINTER
--			a_did_run_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_print_operation as a_print_operation_attached then
--				a_print_operation__item := a_print_operation_attached.item
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
--			objc_run_modal_print_operation__delegate__did_run_selector__context_info_ (item, a_print_operation__item, a_delegate__item, a_did_run_selector__item, a_context_info__item)
--		end

	is_document_edited: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_document_edited (item)
		end

	update_change_count_ (a_change: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_change_count_ (item, a_change)
		end

	set_undo_manager_ (a_undo_manager: detachable NS_UNDO_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_undo_manager__item: POINTER
		do
			if attached a_undo_manager as a_undo_manager_attached then
				a_undo_manager__item := a_undo_manager_attached.item
			end
			objc_set_undo_manager_ (item, a_undo_manager__item)
		end

	undo_manager: detachable NS_UNDO_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_undo_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_has_undo_manager_ (a_has_undo_manager: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_has_undo_manager_ (item, a_has_undo_manager)
		end

	has_undo_manager: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_undo_manager (item)
		end

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

	make_window_controllers
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_make_window_controllers (item)
		end

	window_nib_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_nib_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_nib_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_nib_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_controller_will_load_nib_ (a_window_controller: detachable NS_WINDOW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_window_controller__item: POINTER
		do
			if attached a_window_controller as a_window_controller_attached then
				a_window_controller__item := a_window_controller_attached.item
			end
			objc_window_controller_will_load_nib_ (item, a_window_controller__item)
		end

	window_controller_did_load_nib_ (a_window_controller: detachable NS_WINDOW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_window_controller__item: POINTER
		do
			if attached a_window_controller as a_window_controller_attached then
				a_window_controller__item := a_window_controller_attached.item
			end
			objc_window_controller_did_load_nib_ (item, a_window_controller__item)
		end

	set_window_ (a_window: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			objc_set_window_ (item, a_window__item)
		end

	add_window_controller_ (a_window_controller: detachable NS_WINDOW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_window_controller__item: POINTER
		do
			if attached a_window_controller as a_window_controller_attached then
				a_window_controller__item := a_window_controller_attached.item
			end
			objc_add_window_controller_ (item, a_window_controller__item)
		end

	remove_window_controller_ (a_window_controller: detachable NS_WINDOW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_window_controller__item: POINTER
		do
			if attached a_window_controller as a_window_controller_attached then
				a_window_controller__item := a_window_controller_attached.item
			end
			objc_remove_window_controller_ (item, a_window_controller__item)
		end

	show_windows
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_show_windows (item)
		end

	window_controllers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_controllers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_controllers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_controllers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	should_close_window_controller__delegate__should_close_selector__context_info_ (a_window_controller: detachable NS_WINDOW_CONTROLLER; a_delegate: detachable NS_OBJECT; a_should_close_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_window_controller__item: POINTER
--			a_delegate__item: POINTER
--			a_should_close_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_window_controller as a_window_controller_attached then
--				a_window_controller__item := a_window_controller_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_should_close_selector as a_should_close_selector_attached then
--				a_should_close_selector__item := a_should_close_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_should_close_window_controller__delegate__should_close_selector__context_info_ (item, a_window_controller__item, a_delegate__item, a_should_close_selector__item, a_context_info__item)
--		end

	display_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_display_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_for_sheet: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_for_sheet (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_for_sheet} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_for_sheet} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	writable_types_for_save_operation_ (a_save_operation: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_writable_types_for_save_operation_ (item, a_save_operation)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like writable_types_for_save_operation_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like writable_types_for_save_operation_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_name_extension_for_type__save_operation_ (a_type_name: detachable NS_STRING; a_save_operation: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			result_pointer := objc_file_name_extension_for_type__save_operation_ (item, a_type_name__item, a_save_operation)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_name_extension_for_type__save_operation_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_name_extension_for_type__save_operation_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

feature -- NSScripting

	last_component_of_file_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_last_component_of_file_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like last_component_of_file_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like last_component_of_file_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_last_component_of_file_name_ (a_str: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			objc_set_last_component_of_file_name_ (item, a_str__item)
		end

	handle_save_script_command_ (a_command: detachable NS_SCRIPT_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_save_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_save_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_save_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	handle_close_script_command_ (a_command: detachable NS_CLOSE_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_close_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_close_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_close_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	handle_print_script_command_ (a_command: detachable NS_SCRIPT_COMMAND): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command__item: POINTER
		do
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			result_pointer := objc_handle_print_script_command_ (item, a_command__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like handle_print_script_command_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like handle_print_script_command_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScripting Externals

	objc_last_component_of_file_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item lastComponentOfFileName];
			 ]"
		end

	objc_set_last_component_of_file_name_ (an_item: POINTER; a_str: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDocument *)$an_item setLastComponentOfFileName:$a_str];
			 ]"
		end

	objc_handle_save_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item handleSaveScriptCommand:$a_command];
			 ]"
		end

	objc_handle_close_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item handleCloseScriptCommand:$a_command];
			 ]"
		end

	objc_handle_print_script_command_ (an_item: POINTER; a_command: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDocument *)$an_item handlePrintScriptCommand:$a_command];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDocument"
		end

end
