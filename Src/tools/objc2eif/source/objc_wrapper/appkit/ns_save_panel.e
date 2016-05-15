note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL

inherit
	NS_PANEL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_rect__style_mask__backing__defer_,
	make_with_content_rect__style_mask__backing__defer__screen_,
	makeial_first_responder,
	make

feature -- NSSavePanel

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	directory_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_directory_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like directory_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like directory_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_directory_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_directory_ur_l_ (item, a_url__item)
		end

	allowed_file_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_allowed_file_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like allowed_file_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like allowed_file_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_allowed_file_types_ (a_types: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_types__item: POINTER
		do
			if attached a_types as a_types_attached then
				a_types__item := a_types_attached.item
			end
			objc_set_allowed_file_types_ (item, a_types__item)
		end

	allows_other_file_types: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_other_file_types (item)
		end

	set_allows_other_file_types_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_other_file_types_ (item, a_flag)
		end

	accessory_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessory_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessory_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessory_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_accessory_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_accessory_view_ (item, a_view__item)
		end

	is_expanded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_expanded (item)
		end

	can_create_directories: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_create_directories (item)
		end

	set_can_create_directories_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_create_directories_ (item, a_flag)
		end

	can_select_hidden_extension: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_select_hidden_extension (item)
		end

	set_can_select_hidden_extension_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_select_hidden_extension_ (item, a_flag)
		end

	is_extension_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_extension_hidden (item)
		end

	set_extension_hidden_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_extension_hidden_ (item, a_flag)
		end

	treats_file_packages_as_directories: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_treats_file_packages_as_directories (item)
		end

	set_treats_file_packages_as_directories_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_treats_file_packages_as_directories_ (item, a_flag)
		end

	prompt: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_prompt (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prompt} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prompt} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_prompt_ (a_prompt: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_prompt__item: POINTER
		do
			if attached a_prompt as a_prompt_attached then
				a_prompt__item := a_prompt_attached.item
			end
			objc_set_prompt_ (item, a_prompt__item)
		end

	name_field_label: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name_field_label (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name_field_label} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name_field_label} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_name_field_label_ (a_label: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_label__item: POINTER
		do
			if attached a_label as a_label_attached then
				a_label__item := a_label_attached.item
			end
			objc_set_name_field_label_ (item, a_label__item)
		end

	name_field_string_value: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name_field_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name_field_string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name_field_string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_name_field_string_value_ (a_value: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_name_field_string_value_ (item, a_value__item)
		end

	message: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_message (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like message} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like message} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_message_ (a_message: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_message__item: POINTER
		do
			if attached a_message as a_message_attached then
				a_message__item := a_message_attached.item
			end
			objc_set_message_ (item, a_message__item)
		end

	validate_visible_columns
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_validate_visible_columns (item)
		end

	shows_hidden_files: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_hidden_files (item)
		end

	set_shows_hidden_files_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_hidden_files_ (item, a_flag)
		end

	ok_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_ok_ (item, a_sender__item)
		end

	cancel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_cancel_ (item, a_sender__item)
		end

--	begin_sheet_modal_for_window__completion_handler_ (a_window: detachable NS_WINDOW; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_window__item: POINTER
--		do
--			if attached a_window as a_window_attached then
--				a_window__item := a_window_attached.item
--			end
--			objc_begin_sheet_modal_for_window__completion_handler_ (item, a_window__item, )
--		end

--	begin_with_completion_handler_ (a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_begin_with_completion_handler_ (item, )
--		end

	run_modal: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_run_modal (item)
		end

feature {NONE} -- NSSavePanel Externals

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item URL];
			 ]"
		end

	objc_directory_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item directoryURL];
			 ]"
		end

	objc_set_directory_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setDirectoryURL:$a_url];
			 ]"
		end

	objc_allowed_file_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item allowedFileTypes];
			 ]"
		end

	objc_set_allowed_file_types_ (an_item: POINTER; a_types: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setAllowedFileTypes:$a_types];
			 ]"
		end

	objc_allows_other_file_types (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item allowsOtherFileTypes];
			 ]"
		end

	objc_set_allows_other_file_types_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setAllowsOtherFileTypes:$a_flag];
			 ]"
		end

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item accessoryView];
			 ]"
		end

	objc_set_accessory_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setAccessoryView:$a_view];
			 ]"
		end

	objc_is_expanded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item isExpanded];
			 ]"
		end

	objc_can_create_directories (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item canCreateDirectories];
			 ]"
		end

	objc_set_can_create_directories_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setCanCreateDirectories:$a_flag];
			 ]"
		end

	objc_can_select_hidden_extension (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item canSelectHiddenExtension];
			 ]"
		end

	objc_set_can_select_hidden_extension_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setCanSelectHiddenExtension:$a_flag];
			 ]"
		end

	objc_is_extension_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item isExtensionHidden];
			 ]"
		end

	objc_set_extension_hidden_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setExtensionHidden:$a_flag];
			 ]"
		end

	objc_treats_file_packages_as_directories (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item treatsFilePackagesAsDirectories];
			 ]"
		end

	objc_set_treats_file_packages_as_directories_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setTreatsFilePackagesAsDirectories:$a_flag];
			 ]"
		end

	objc_prompt (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item prompt];
			 ]"
		end

	objc_set_prompt_ (an_item: POINTER; a_prompt: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setPrompt:$a_prompt];
			 ]"
		end

	objc_name_field_label (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item nameFieldLabel];
			 ]"
		end

	objc_set_name_field_label_ (an_item: POINTER; a_label: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setNameFieldLabel:$a_label];
			 ]"
		end

	objc_name_field_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item nameFieldStringValue];
			 ]"
		end

	objc_set_name_field_string_value_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setNameFieldStringValue:$a_value];
			 ]"
		end

	objc_message (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item message];
			 ]"
		end

	objc_set_message_ (an_item: POINTER; a_message: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setMessage:$a_message];
			 ]"
		end

	objc_validate_visible_columns (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item validateVisibleColumns];
			 ]"
		end

	objc_shows_hidden_files (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item showsHiddenFiles];
			 ]"
		end

	objc_set_shows_hidden_files_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setShowsHiddenFiles:$a_flag];
			 ]"
		end

	objc_ok_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item ok:$a_sender];
			 ]"
		end

	objc_cancel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item cancel:$a_sender];
			 ]"
		end

--	objc_begin_sheet_modal_for_window__completion_handler_ (an_item: POINTER; a_window: POINTER; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSSavePanel *)$an_item beginSheetModalForWindow:$a_window completionHandler:];
--			 ]"
--		end

--	objc_begin_with_completion_handler_ (an_item: POINTER; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSSavePanel *)$an_item beginWithCompletionHandler:];
--			 ]"
--		end

	objc_run_modal (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item runModal];
			 ]"
		end

feature -- NSDeprecated

	filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	directory: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_directory (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like directory} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like directory} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_directory_ (a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_set_directory_ (item, a_path__item)
		end

	required_file_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_required_file_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like required_file_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like required_file_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_required_file_type_ (a_type: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			objc_set_required_file_type_ (item, a_type__item)
		end

--	begin_sheet_for_directory__file__modal_for_window__modal_delegate__did_end_selector__context_info_ (a_path: detachable NS_STRING; a_name: detachable NS_STRING; a_doc_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_name__item: POINTER
--			a_doc_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_doc_window as a_doc_window_attached then
--				a_doc_window__item := a_doc_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_end_selector as a_did_end_selector_attached then
--				a_did_end_selector__item := a_did_end_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_begin_sheet_for_directory__file__modal_for_window__modal_delegate__did_end_selector__context_info_ (item, a_path__item, a_name__item, a_doc_window__item, a_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

	run_modal_for_directory__file_ (a_path: detachable NS_STRING; a_name: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
			a_name__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_run_modal_for_directory__file_ (item, a_path__item, a_name__item)
		end

feature {NONE} -- NSDeprecated Externals

	objc_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item filename];
			 ]"
		end

	objc_directory (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item directory];
			 ]"
		end

	objc_set_directory_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setDirectory:$a_path];
			 ]"
		end

	objc_required_file_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSavePanel *)$an_item requiredFileType];
			 ]"
		end

	objc_set_required_file_type_ (an_item: POINTER; a_type: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSavePanel *)$an_item setRequiredFileType:$a_type];
			 ]"
		end

--	objc_begin_sheet_for_directory__file__modal_for_window__modal_delegate__did_end_selector__context_info_ (an_item: POINTER; a_path: POINTER; a_name: POINTER; a_doc_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSSavePanel *)$an_item beginSheetForDirectory:$a_path file:$a_name modalForWindow:$a_doc_window modalDelegate:$a_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

	objc_run_modal_for_directory__file_ (an_item: POINTER; a_path: POINTER; a_name: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSavePanel *)$an_item runModalForDirectory:$a_path file:$a_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSavePanel"
		end

end
