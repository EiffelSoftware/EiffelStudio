note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WORKSPACE

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

feature -- NSWorkspace

	notification_center: detachable NS_NOTIFICATION_CENTER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_notification_center (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notification_center} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notification_center} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	open_file_ (a_full_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			Result := objc_open_file_ (item, a_full_path__item)
		end

	open_file__with_application_ (a_full_path: detachable NS_STRING; a_app_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
			a_app_name__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			if attached a_app_name as a_app_name_attached then
				a_app_name__item := a_app_name_attached.item
			end
			Result := objc_open_file__with_application_ (item, a_full_path__item, a_app_name__item)
		end

	open_file__with_application__and_deactivate_ (a_full_path: detachable NS_STRING; a_app_name: detachable NS_STRING; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
			a_app_name__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			if attached a_app_name as a_app_name_attached then
				a_app_name__item := a_app_name_attached.item
			end
			Result := objc_open_file__with_application__and_deactivate_ (item, a_full_path__item, a_app_name__item, a_flag)
		end

	open_file__from_image__at__in_view_ (a_full_path: detachable NS_STRING; an_image: detachable NS_IMAGE; a_point: NS_POINT; a_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
			an_image__item: POINTER
			a_view__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			if attached an_image as an_image_attached then
				an_image__item := an_image_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			Result := objc_open_file__from_image__at__in_view_ (item, a_full_path__item, an_image__item, a_point.item, a_view__item)
		end

	open_ur_l_ (a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_open_ur_l_ (item, a_url__item)
		end

	launch_application_ (a_app_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_app_name__item: POINTER
		do
			if attached a_app_name as a_app_name_attached then
				a_app_name__item := a_app_name_attached.item
			end
			Result := objc_launch_application_ (item, a_app_name__item)
		end

--	launch_application_at_ur_l__options__configuration__error_ (a_url: detachable NS_URL; a_options: NATURAL_64; a_configuration: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_RUNNING_APPLICATION
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_configuration__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_configuration as a_configuration_attached then
--				a_configuration__item := a_configuration_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_launch_application_at_ur_l__options__configuration__error_ (item, a_url__item, a_options, a_configuration__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like launch_application_at_ur_l__options__configuration__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like launch_application_at_ur_l__options__configuration__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	launch_application__show_icon__autolaunch_ (a_app_name: detachable NS_STRING; a_show_icon: BOOLEAN; a_autolaunch: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_app_name__item: POINTER
		do
			if attached a_app_name as a_app_name_attached then
				a_app_name__item := a_app_name_attached.item
			end
			Result := objc_launch_application__show_icon__autolaunch_ (item, a_app_name__item, a_show_icon, a_autolaunch)
		end

	full_path_for_application_ (a_app_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_app_name__item: POINTER
		do
			if attached a_app_name as a_app_name_attached then
				a_app_name__item := a_app_name_attached.item
			end
			result_pointer := objc_full_path_for_application_ (item, a_app_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like full_path_for_application_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like full_path_for_application_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	select_file__in_file_viewer_rooted_at_path_ (a_full_path: detachable NS_STRING; a_root_full_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
			a_root_full_path__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			if attached a_root_full_path as a_root_full_path_attached then
				a_root_full_path__item := a_root_full_path_attached.item
			end
			Result := objc_select_file__in_file_viewer_rooted_at_path_ (item, a_full_path__item, a_root_full_path__item)
		end

	activate_file_viewer_selecting_ur_ls_ (a_file_ur_ls: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_file_ur_ls__item: POINTER
		do
			if attached a_file_ur_ls as a_file_ur_ls_attached then
				a_file_ur_ls__item := a_file_ur_ls_attached.item
			end
			objc_activate_file_viewer_selecting_ur_ls_ (item, a_file_ur_ls__item)
		end

	show_search_results_for_query_string_ (a_query_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_query_string__item: POINTER
		do
			if attached a_query_string as a_query_string_attached then
				a_query_string__item := a_query_string_attached.item
			end
			Result := objc_show_search_results_for_query_string_ (item, a_query_string__item)
		end

	note_file_system_changed_ (a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_note_file_system_changed_ (item, a_path__item)
		end

--	get_info_for_file__application__type_ (a_full_path: detachable NS_STRING; a_app_name: UNSUPPORTED_TYPE; a_type: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_full_path__item: POINTER
--			a_app_name__item: POINTER
--			a_type__item: POINTER
--		do
--			if attached a_full_path as a_full_path_attached then
--				a_full_path__item := a_full_path_attached.item
--			end
--			if attached a_app_name as a_app_name_attached then
--				a_app_name__item := a_app_name_attached.item
--			end
--			if attached a_type as a_type_attached then
--				a_type__item := a_type_attached.item
--			end
--			Result := objc_get_info_for_file__application__type_ (item, a_full_path__item, a_app_name__item, a_type__item)
--		end

	is_file_package_at_path_ (a_full_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_full_path__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			Result := objc_is_file_package_at_path_ (item, a_full_path__item)
		end

	icon_for_file_ (a_full_path: detachable NS_STRING): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_full_path__item: POINTER
		do
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			result_pointer := objc_icon_for_file_ (item, a_full_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon_for_file_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon_for_file_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	icon_for_files_ (a_full_paths: detachable NS_ARRAY): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_full_paths__item: POINTER
		do
			if attached a_full_paths as a_full_paths_attached then
				a_full_paths__item := a_full_paths_attached.item
			end
			result_pointer := objc_icon_for_files_ (item, a_full_paths__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon_for_files_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon_for_files_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	icon_for_file_type_ (a_file_type: detachable NS_STRING): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_file_type__item: POINTER
		do
			if attached a_file_type as a_file_type_attached then
				a_file_type__item := a_file_type_attached.item
			end
			result_pointer := objc_icon_for_file_type_ (item, a_file_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon_for_file_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon_for_file_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_icon__for_file__options_ (a_image: detachable NS_IMAGE; a_full_path: detachable NS_STRING; a_options: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
			a_full_path__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_full_path as a_full_path_attached then
				a_full_path__item := a_full_path_attached.item
			end
			Result := objc_set_icon__for_file__options_ (item, a_image__item, a_full_path__item, a_options)
		end

	file_labels: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_labels (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_labels} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_labels} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_label_colors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_label_colors (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_label_colors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_label_colors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	recycle_ur_ls__completion_handler_ (a_ur_ls: detachable NS_ARRAY; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ur_ls__item: POINTER
--		do
--			if attached a_ur_ls as a_ur_ls_attached then
--				a_ur_ls__item := a_ur_ls_attached.item
--			end
--			objc_recycle_ur_ls__completion_handler_ (item, a_ur_ls__item, )
--		end

--	duplicate_ur_ls__completion_handler_ (a_ur_ls: detachable NS_ARRAY; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ur_ls__item: POINTER
--		do
--			if attached a_ur_ls as a_ur_ls_attached then
--				a_ur_ls__item := a_ur_ls_attached.item
--			end
--			objc_duplicate_ur_ls__completion_handler_ (item, a_ur_ls__item, )
--		end

--	get_file_system_info_for_path__is_removable__is_writable__is_unmountable__description__type_ (a_full_path: detachable NS_STRING; a_removable_flag: UNSUPPORTED_TYPE; a_writable_flag: UNSUPPORTED_TYPE; a_unmountable_flag: UNSUPPORTED_TYPE; a_description: UNSUPPORTED_TYPE; a_file_system_type: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_full_path__item: POINTER
--			a_removable_flag__item: POINTER
--			a_writable_flag__item: POINTER
--			a_unmountable_flag__item: POINTER
--			a_description__item: POINTER
--			a_file_system_type__item: POINTER
--		do
--			if attached a_full_path as a_full_path_attached then
--				a_full_path__item := a_full_path_attached.item
--			end
--			if attached a_removable_flag as a_removable_flag_attached then
--				a_removable_flag__item := a_removable_flag_attached.item
--			end
--			if attached a_writable_flag as a_writable_flag_attached then
--				a_writable_flag__item := a_writable_flag_attached.item
--			end
--			if attached a_unmountable_flag as a_unmountable_flag_attached then
--				a_unmountable_flag__item := a_unmountable_flag_attached.item
--			end
--			if attached a_description as a_description_attached then
--				a_description__item := a_description_attached.item
--			end
--			if attached a_file_system_type as a_file_system_type_attached then
--				a_file_system_type__item := a_file_system_type_attached.item
--			end
--			Result := objc_get_file_system_info_for_path__is_removable__is_writable__is_unmountable__description__type_ (item, a_full_path__item, a_removable_flag__item, a_writable_flag__item, a_unmountable_flag__item, a_description__item, a_file_system_type__item)
--		end

--	perform_file_operation__source__destination__files__tag_ (a_operation: detachable NS_STRING; a_source: detachable NS_STRING; a_destination: detachable NS_STRING; a_files: detachable NS_ARRAY; a_tag: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_operation__item: POINTER
--			a_source__item: POINTER
--			a_destination__item: POINTER
--			a_files__item: POINTER
--			a_tag__item: POINTER
--		do
--			if attached a_operation as a_operation_attached then
--				a_operation__item := a_operation_attached.item
--			end
--			if attached a_source as a_source_attached then
--				a_source__item := a_source_attached.item
--			end
--			if attached a_destination as a_destination_attached then
--				a_destination__item := a_destination_attached.item
--			end
--			if attached a_files as a_files_attached then
--				a_files__item := a_files_attached.item
--			end
--			if attached a_tag as a_tag_attached then
--				a_tag__item := a_tag_attached.item
--			end
--			Result := objc_perform_file_operation__source__destination__files__tag_ (item, a_operation__item, a_source__item, a_destination__item, a_files__item, a_tag__item)
--		end

	unmount_and_eject_device_at_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_unmount_and_eject_device_at_path_ (item, a_path__item)
		end

--	unmount_and_eject_device_at_ur_l__error_ (a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_unmount_and_eject_device_at_ur_l__error_ (item, a_url__item, a_error__item)
--		end

	extend_power_off_by_ (a_requested: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_extend_power_off_by_ (item, a_requested)
		end

	hide_other_applications
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_hide_other_applications (item)
		end

	mounted_local_volume_paths: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mounted_local_volume_paths (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mounted_local_volume_paths} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mounted_local_volume_paths} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mounted_removable_media: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mounted_removable_media (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mounted_removable_media} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mounted_removable_media} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_application_with_bundle_identifier_ (a_bundle_identifier: detachable NS_STRING): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_bundle_identifier__item: POINTER
		do
			if attached a_bundle_identifier as a_bundle_identifier_attached then
				a_bundle_identifier__item := a_bundle_identifier_attached.item
			end
			result_pointer := objc_url_for_application_with_bundle_identifier_ (item, a_bundle_identifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_application_with_bundle_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_application_with_bundle_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_application_to_open_ur_l_ (a_url: detachable NS_URL): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			result_pointer := objc_url_for_application_to_open_ur_l_ (item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_application_to_open_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_application_to_open_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	absolute_path_for_app_bundle_with_identifier_ (a_bundle_identifier: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_bundle_identifier__item: POINTER
		do
			if attached a_bundle_identifier as a_bundle_identifier_attached then
				a_bundle_identifier__item := a_bundle_identifier_attached.item
			end
			result_pointer := objc_absolute_path_for_app_bundle_with_identifier_ (item, a_bundle_identifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like absolute_path_for_app_bundle_with_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like absolute_path_for_app_bundle_with_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	launch_app_with_bundle_identifier__options__additional_event_param_descriptor__launch_identifier_ (a_bundle_identifier: detachable NS_STRING; a_options: NATURAL_64; a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_identifier: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_bundle_identifier__item: POINTER
--			a_descriptor__item: POINTER
--			a_identifier__item: POINTER
--		do
--			if attached a_bundle_identifier as a_bundle_identifier_attached then
--				a_bundle_identifier__item := a_bundle_identifier_attached.item
--			end
--			if attached a_descriptor as a_descriptor_attached then
--				a_descriptor__item := a_descriptor_attached.item
--			end
--			if attached a_identifier as a_identifier_attached then
--				a_identifier__item := a_identifier_attached.item
--			end
--			Result := objc_launch_app_with_bundle_identifier__options__additional_event_param_descriptor__launch_identifier_ (item, a_bundle_identifier__item, a_options, a_descriptor__item, a_identifier__item)
--		end

--	open_ur_ls__with_app_bundle_identifier__options__additional_event_param_descriptor__launch_identifiers_ (a_urls: detachable NS_ARRAY; a_bundle_identifier: detachable NS_STRING; a_options: NATURAL_64; a_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR; a_identifiers: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_urls__item: POINTER
--			a_bundle_identifier__item: POINTER
--			a_descriptor__item: POINTER
--			a_identifiers__item: POINTER
--		do
--			if attached a_urls as a_urls_attached then
--				a_urls__item := a_urls_attached.item
--			end
--			if attached a_bundle_identifier as a_bundle_identifier_attached then
--				a_bundle_identifier__item := a_bundle_identifier_attached.item
--			end
--			if attached a_descriptor as a_descriptor_attached then
--				a_descriptor__item := a_descriptor_attached.item
--			end
--			if attached a_identifiers as a_identifiers_attached then
--				a_identifiers__item := a_identifiers_attached.item
--			end
--			Result := objc_open_ur_ls__with_app_bundle_identifier__options__additional_event_param_descriptor__launch_identifiers_ (item, a_urls__item, a_bundle_identifier__item, a_options, a_descriptor__item, a_identifiers__item)
--		end

	launched_applications: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_launched_applications (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like launched_applications} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like launched_applications} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	active_application: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_active_application (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like active_application} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like active_application} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	type_of_file__error_ (a_absolute_file_path: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_absolute_file_path__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_absolute_file_path as a_absolute_file_path_attached then
--				a_absolute_file_path__item := a_absolute_file_path_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_type_of_file__error_ (item, a_absolute_file_path__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like type_of_file__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like type_of_file__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	localized_description_for_type_ (a_type_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			result_pointer := objc_localized_description_for_type_ (item, a_type_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_description_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_description_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	preferred_filename_extension_for_type_ (a_type_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type_name__item: POINTER
		do
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			result_pointer := objc_preferred_filename_extension_for_type_ (item, a_type_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like preferred_filename_extension_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like preferred_filename_extension_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	filename_extension__is_valid_for_type_ (a_filename_extension: detachable NS_STRING; a_type_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_filename_extension__item: POINTER
			a_type_name__item: POINTER
		do
			if attached a_filename_extension as a_filename_extension_attached then
				a_filename_extension__item := a_filename_extension_attached.item
			end
			if attached a_type_name as a_type_name_attached then
				a_type_name__item := a_type_name_attached.item
			end
			Result := objc_filename_extension__is_valid_for_type_ (item, a_filename_extension__item, a_type_name__item)
		end

	type__conforms_to_type_ (a_first_type_name: detachable NS_STRING; a_second_type_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_first_type_name__item: POINTER
			a_second_type_name__item: POINTER
		do
			if attached a_first_type_name as a_first_type_name_attached then
				a_first_type_name__item := a_first_type_name_attached.item
			end
			if attached a_second_type_name as a_second_type_name_attached then
				a_second_type_name__item := a_second_type_name_attached.item
			end
			Result := objc_type__conforms_to_type_ (item, a_first_type_name__item, a_second_type_name__item)
		end

feature {NONE} -- NSWorkspace Externals

	objc_notification_center (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item notificationCenter];
			 ]"
		end

	objc_open_file_ (an_item: POINTER; a_full_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item openFile:$a_full_path];
			 ]"
		end

	objc_open_file__with_application_ (an_item: POINTER; a_full_path: POINTER; a_app_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item openFile:$a_full_path withApplication:$a_app_name];
			 ]"
		end

	objc_open_file__with_application__and_deactivate_ (an_item: POINTER; a_full_path: POINTER; a_app_name: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item openFile:$a_full_path withApplication:$a_app_name andDeactivate:$a_flag];
			 ]"
		end

	objc_open_file__from_image__at__in_view_ (an_item: POINTER; a_full_path: POINTER; an_image: POINTER; a_point: POINTER; a_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item openFile:$a_full_path fromImage:$an_image at:*((NSPoint *)$a_point) inView:$a_view];
			 ]"
		end

	objc_open_ur_l_ (an_item: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item openURL:$a_url];
			 ]"
		end

	objc_launch_application_ (an_item: POINTER; a_app_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item launchApplication:$a_app_name];
			 ]"
		end

--	objc_launch_application_at_ur_l__options__configuration__error_ (an_item: POINTER; a_url: POINTER; a_options: NATURAL_64; a_configuration: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSWorkspace *)$an_item launchApplicationAtURL:$a_url options:$a_options configuration:$a_configuration error:];
--			 ]"
--		end

	objc_launch_application__show_icon__autolaunch_ (an_item: POINTER; a_app_name: POINTER; a_show_icon: BOOLEAN; a_autolaunch: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item launchApplication:$a_app_name showIcon:$a_show_icon autolaunch:$a_autolaunch];
			 ]"
		end

	objc_full_path_for_application_ (an_item: POINTER; a_app_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item fullPathForApplication:$a_app_name];
			 ]"
		end

	objc_select_file__in_file_viewer_rooted_at_path_ (an_item: POINTER; a_full_path: POINTER; a_root_full_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item selectFile:$a_full_path inFileViewerRootedAtPath:$a_root_full_path];
			 ]"
		end

	objc_activate_file_viewer_selecting_ur_ls_ (an_item: POINTER; a_file_ur_ls: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWorkspace *)$an_item activateFileViewerSelectingURLs:$a_file_ur_ls];
			 ]"
		end

	objc_show_search_results_for_query_string_ (an_item: POINTER; a_query_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item showSearchResultsForQueryString:$a_query_string];
			 ]"
		end

	objc_note_file_system_changed_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWorkspace *)$an_item noteFileSystemChanged:$a_path];
			 ]"
		end

--	objc_get_info_for_file__application__type_ (an_item: POINTER; a_full_path: POINTER; a_app_name: UNSUPPORTED_TYPE; a_type: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item getInfoForFile:$a_full_path application: type:];
--			 ]"
--		end

	objc_is_file_package_at_path_ (an_item: POINTER; a_full_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item isFilePackageAtPath:$a_full_path];
			 ]"
		end

	objc_icon_for_file_ (an_item: POINTER; a_full_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item iconForFile:$a_full_path];
			 ]"
		end

	objc_icon_for_files_ (an_item: POINTER; a_full_paths: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item iconForFiles:$a_full_paths];
			 ]"
		end

	objc_icon_for_file_type_ (an_item: POINTER; a_file_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item iconForFileType:$a_file_type];
			 ]"
		end

	objc_set_icon__for_file__options_ (an_item: POINTER; a_image: POINTER; a_full_path: POINTER; a_options: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item setIcon:$a_image forFile:$a_full_path options:$a_options];
			 ]"
		end

	objc_file_labels (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item fileLabels];
			 ]"
		end

	objc_file_label_colors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item fileLabelColors];
			 ]"
		end

--	objc_recycle_ur_ls__completion_handler_ (an_item: POINTER; a_ur_ls: POINTER; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSWorkspace *)$an_item recycleURLs:$a_ur_ls completionHandler:];
--			 ]"
--		end

--	objc_duplicate_ur_ls__completion_handler_ (an_item: POINTER; a_ur_ls: POINTER; a_handler: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSWorkspace *)$an_item duplicateURLs:$a_ur_ls completionHandler:];
--			 ]"
--		end

--	objc_get_file_system_info_for_path__is_removable__is_writable__is_unmountable__description__type_ (an_item: POINTER; a_full_path: POINTER; a_removable_flag: UNSUPPORTED_TYPE; a_writable_flag: UNSUPPORTED_TYPE; a_unmountable_flag: UNSUPPORTED_TYPE; a_description: UNSUPPORTED_TYPE; a_file_system_type: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item getFileSystemInfoForPath:$a_full_path isRemovable: isWritable: isUnmountable: description: type:];
--			 ]"
--		end

--	objc_perform_file_operation__source__destination__files__tag_ (an_item: POINTER; a_operation: POINTER; a_source: POINTER; a_destination: POINTER; a_files: POINTER; a_tag: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item performFileOperation:$a_operation source:$a_source destination:$a_destination files:$a_files tag:];
--			 ]"
--		end

	objc_unmount_and_eject_device_at_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item unmountAndEjectDeviceAtPath:$a_path];
			 ]"
		end

--	objc_unmount_and_eject_device_at_ur_l__error_ (an_item: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item unmountAndEjectDeviceAtURL:$a_url error:];
--			 ]"
--		end

	objc_extend_power_off_by_ (an_item: POINTER; a_requested: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item extendPowerOffBy:$a_requested];
			 ]"
		end

	objc_hide_other_applications (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWorkspace *)$an_item hideOtherApplications];
			 ]"
		end

	objc_mounted_local_volume_paths (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item mountedLocalVolumePaths];
			 ]"
		end

	objc_mounted_removable_media (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item mountedRemovableMedia];
			 ]"
		end

	objc_url_for_application_with_bundle_identifier_ (an_item: POINTER; a_bundle_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item URLForApplicationWithBundleIdentifier:$a_bundle_identifier];
			 ]"
		end

	objc_url_for_application_to_open_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item URLForApplicationToOpenURL:$a_url];
			 ]"
		end

	objc_absolute_path_for_app_bundle_with_identifier_ (an_item: POINTER; a_bundle_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item absolutePathForAppBundleWithIdentifier:$a_bundle_identifier];
			 ]"
		end

--	objc_launch_app_with_bundle_identifier__options__additional_event_param_descriptor__launch_identifier_ (an_item: POINTER; a_bundle_identifier: POINTER; a_options: NATURAL_64; a_descriptor: POINTER; a_identifier: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item launchAppWithBundleIdentifier:$a_bundle_identifier options:$a_options additionalEventParamDescriptor:$a_descriptor launchIdentifier:];
--			 ]"
--		end

--	objc_open_ur_ls__with_app_bundle_identifier__options__additional_event_param_descriptor__launch_identifiers_ (an_item: POINTER; a_urls: POINTER; a_bundle_identifier: POINTER; a_options: NATURAL_64; a_descriptor: POINTER; a_identifiers: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item openURLs:$a_urls withAppBundleIdentifier:$a_bundle_identifier options:$a_options additionalEventParamDescriptor:$a_descriptor launchIdentifiers:];
--			 ]"
--		end

	objc_launched_applications (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item launchedApplications];
			 ]"
		end

	objc_active_application (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item activeApplication];
			 ]"
		end

--	objc_type_of_file__error_ (an_item: POINTER; a_absolute_file_path: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSWorkspace *)$an_item typeOfFile:$a_absolute_file_path error:];
--			 ]"
--		end

	objc_localized_description_for_type_ (an_item: POINTER; a_type_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item localizedDescriptionForType:$a_type_name];
			 ]"
		end

	objc_preferred_filename_extension_for_type_ (an_item: POINTER; a_type_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item preferredFilenameExtensionForType:$a_type_name];
			 ]"
		end

	objc_filename_extension__is_valid_for_type_ (an_item: POINTER; a_filename_extension: POINTER; a_type_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item filenameExtension:$a_filename_extension isValidForType:$a_type_name];
			 ]"
		end

	objc_type__conforms_to_type_ (an_item: POINTER; a_first_type_name: POINTER; a_second_type_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWorkspace *)$an_item type:$a_first_type_name conformsToType:$a_second_type_name];
			 ]"
		end

feature -- NSDesktopImages

--	set_desktop_image_ur_l__for_screen__options__error_ (a_url: detachable NS_URL; a_screen: detachable NS_SCREEN; a_options: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_screen__item: POINTER
--			a_options__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_screen as a_screen_attached then
--				a_screen__item := a_screen_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_set_desktop_image_ur_l__for_screen__options__error_ (item, a_url__item, a_screen__item, a_options__item, a_error__item)
--		end

	desktop_image_url_for_screen_ (a_screen: detachable NS_SCREEN): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_screen__item: POINTER
		do
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			result_pointer := objc_desktop_image_url_for_screen_ (item, a_screen__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like desktop_image_url_for_screen_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like desktop_image_url_for_screen_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	desktop_image_options_for_screen_ (a_screen: detachable NS_SCREEN): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_screen__item: POINTER
		do
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			result_pointer := objc_desktop_image_options_for_screen_ (item, a_screen__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like desktop_image_options_for_screen_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like desktop_image_options_for_screen_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDesktopImages Externals

--	objc_set_desktop_image_ur_l__for_screen__options__error_ (an_item: POINTER; a_url: POINTER; a_screen: POINTER; a_options: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSWorkspace *)$an_item setDesktopImageURL:$a_url forScreen:$a_screen options:$a_options error:];
--			 ]"
--		end

	objc_desktop_image_url_for_screen_ (an_item: POINTER; a_screen: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item desktopImageURLForScreen:$a_screen];
			 ]"
		end

	objc_desktop_image_options_for_screen_ (an_item: POINTER; a_screen: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item desktopImageOptionsForScreen:$a_screen];
			 ]"
		end

feature -- NSWorkspaceRunningApplications

	running_applications: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_running_applications (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like running_applications} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like running_applications} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSWorkspaceRunningApplications Externals

	objc_running_applications (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWorkspace *)$an_item runningApplications];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSWorkspace"
		end

end
