indexing
	description: "Windows error messages in human-readable form."
	note: "Automatically generated from WinError.h"

class
	WEL_WINDOWS_ERROR_MESSAGES

feature -- Access

	error_messages: HASH_TABLE [STRING, INTEGER] is
			-- Error messages.
		once
			create Result.make (10000)
			Result.force (Error_success_text, Error_success_value)
			Result.force (Error_invalid_function_text, Error_invalid_function_value)
			Result.force (Error_file_not_found_text, Error_file_not_found_value)
			Result.force (Error_path_not_found_text, Error_path_not_found_value)
			Result.force (Error_too_many_open_files_text, Error_too_many_open_files_value)
			Result.force (Error_access_denied_text, Error_access_denied_value)
			Result.force (Error_invalid_handle_text, Error_invalid_handle_value)
			Result.force (Error_arena_trashed_text, Error_arena_trashed_value)
			Result.force (Error_not_enough_memory_text, Error_not_enough_memory_value)
			Result.force (Error_invalid_block_text, Error_invalid_block_value)
			Result.force (Error_bad_environment_text, Error_bad_environment_value)
			Result.force (Error_bad_format_text, Error_bad_format_value)
			Result.force (Error_invalid_access_text, Error_invalid_access_value)
			Result.force (Error_invalid_data_text, Error_invalid_data_value)
			Result.force (Error_outofmemory_text, Error_outofmemory_value)
			Result.force (Error_invalid_drive_text, Error_invalid_drive_value)
			Result.force (Error_current_directory_text, Error_current_directory_value)
			Result.force (Error_not_same_device_text, Error_not_same_device_value)
			Result.force (Error_no_more_files_text, Error_no_more_files_value)
			Result.force (Error_write_protect_text, Error_write_protect_value)
			Result.force (Error_bad_unit_text, Error_bad_unit_value)
			Result.force (Error_not_ready_text, Error_not_ready_value)
			Result.force (Error_bad_command_text, Error_bad_command_value)
			Result.force (Error_crc_text, Error_crc_value)
			Result.force (Error_bad_length_text, Error_bad_length_value)
			Result.force (Error_seek_text, Error_seek_value)
			Result.force (Error_not_dos_disk_text, Error_not_dos_disk_value)
			Result.force (Error_sector_not_found_text, Error_sector_not_found_value)
			Result.force (Error_out_of_paper_text, Error_out_of_paper_value)
			Result.force (Error_write_fault_text, Error_write_fault_value)
			Result.force (Error_read_fault_text, Error_read_fault_value)
			Result.force (Error_gen_failure_text, Error_gen_failure_value)
			Result.force (Error_sharing_violation_text, Error_sharing_violation_value)
			Result.force (Error_lock_violation_text, Error_lock_violation_value)
			Result.force (Error_wrong_disk_text, Error_wrong_disk_value)
			Result.force (Error_sharing_buffer_exceeded_text, Error_sharing_buffer_exceeded_value)
			Result.force (Error_handle_eof_text, Error_handle_eof_value)
			Result.force (Error_handle_disk_full_text, Error_handle_disk_full_value)
			Result.force (Error_not_supported_text, Error_not_supported_value)
			Result.force (Error_rem_not_list_text, Error_rem_not_list_value)
			Result.force (Error_dup_name_text, Error_dup_name_value)
			Result.force (Error_bad_netpath_text, Error_bad_netpath_value)
			Result.force (Error_network_busy_text, Error_network_busy_value)
			Result.force (Error_dev_not_exist_text, Error_dev_not_exist_value)
			Result.force (Error_too_many_cmds_text, Error_too_many_cmds_value)
			Result.force (Error_adap_hdw_err_text, Error_adap_hdw_err_value)
			Result.force (Error_bad_net_resp_text, Error_bad_net_resp_value)
			Result.force (Error_unexp_net_err_text, Error_unexp_net_err_value)
			Result.force (Error_bad_rem_adap_text, Error_bad_rem_adap_value)
			Result.force (Error_printq_full_text, Error_printq_full_value)
			Result.force (Error_no_spool_space_text, Error_no_spool_space_value)
			Result.force (Error_print_cancelled_text, Error_print_cancelled_value)
			Result.force (Error_netname_deleted_text, Error_netname_deleted_value)
			Result.force (Error_network_access_denied_text, Error_network_access_denied_value)
			Result.force (Error_bad_dev_type_text, Error_bad_dev_type_value)
			Result.force (Error_bad_net_name_text, Error_bad_net_name_value)
			Result.force (Error_too_many_names_text, Error_too_many_names_value)
			Result.force (Error_too_many_sess_text, Error_too_many_sess_value)
			Result.force (Error_sharing_paused_text, Error_sharing_paused_value)
			Result.force (Error_req_not_accep_text, Error_req_not_accep_value)
			Result.force (Error_redir_paused_text, Error_redir_paused_value)
			Result.force (Error_file_exists_text, Error_file_exists_value)
			Result.force (Error_cannot_make_text, Error_cannot_make_value)
			Result.force (Error_fail_i24_text, Error_fail_i24_value)
			Result.force (Error_out_of_structures_text, Error_out_of_structures_value)
			Result.force (Error_already_assigned_text, Error_already_assigned_value)
			Result.force (Error_invalid_password_text, Error_invalid_password_value)
			Result.force (Error_invalid_parameter_text, Error_invalid_parameter_value)
			Result.force (Error_net_write_fault_text, Error_net_write_fault_value)
			Result.force (Error_no_proc_slots_text, Error_no_proc_slots_value)
			Result.force (Error_too_many_semaphores_text, Error_too_many_semaphores_value)
			Result.force (Error_excl_sem_already_owned_text, Error_excl_sem_already_owned_value)
			Result.force (Error_sem_is_set_text, Error_sem_is_set_value)
			Result.force (Error_too_many_sem_requests_text, Error_too_many_sem_requests_value)
			Result.force (Error_invalid_at_interrupt_time_text, Error_invalid_at_interrupt_time_value)
			Result.force (Error_sem_owner_died_text, Error_sem_owner_died_value)
			Result.force (Error_sem_user_limit_text, Error_sem_user_limit_value)
			Result.force (Error_disk_change_text, Error_disk_change_value)
			Result.force (Error_drive_locked_text, Error_drive_locked_value)
			Result.force (Error_broken_pipe_text, Error_broken_pipe_value)
			Result.force (Error_open_failed_text, Error_open_failed_value)
			Result.force (Error_buffer_overflow_text, Error_buffer_overflow_value)
			Result.force (Error_disk_full_text, Error_disk_full_value)
			Result.force (Error_no_more_search_handles_text, Error_no_more_search_handles_value)
			Result.force (Error_invalid_target_handle_text, Error_invalid_target_handle_value)
			Result.force (Error_invalid_category_text, Error_invalid_category_value)
			Result.force (Error_invalid_verify_switch_text, Error_invalid_verify_switch_value)
			Result.force (Error_bad_driver_level_text, Error_bad_driver_level_value)
			Result.force (Error_call_not_implemented_text, Error_call_not_implemented_value)
			Result.force (Error_sem_timeout_text, Error_sem_timeout_value)
			Result.force (Error_insufficient_buffer_text, Error_insufficient_buffer_value)
			Result.force (Error_invalid_name_text, Error_invalid_name_value)
			Result.force (Error_invalid_level_text, Error_invalid_level_value)
			Result.force (Error_no_volume_label_text, Error_no_volume_label_value)
			Result.force (Error_mod_not_found_text, Error_mod_not_found_value)
			Result.force (Error_proc_not_found_text, Error_proc_not_found_value)
			Result.force (Error_wait_no_children_text, Error_wait_no_children_value)
			Result.force (Error_child_not_complete_text, Error_child_not_complete_value)
			Result.force (Error_direct_access_handle_text, Error_direct_access_handle_value)
			Result.force (Error_negative_seek_text, Error_negative_seek_value)
			Result.force (Error_seek_on_device_text, Error_seek_on_device_value)
			Result.force (Error_is_join_target_text, Error_is_join_target_value)
			Result.force (Error_is_joined_text, Error_is_joined_value)
			Result.force (Error_is_substed_text, Error_is_substed_value)
			Result.force (Error_not_joined_text, Error_not_joined_value)
			Result.force (Error_not_substed_text, Error_not_substed_value)
			Result.force (Error_join_to_join_text, Error_join_to_join_value)
			Result.force (Error_subst_to_subst_text, Error_subst_to_subst_value)
			Result.force (Error_join_to_subst_text, Error_join_to_subst_value)
			Result.force (Error_subst_to_join_text, Error_subst_to_join_value)
			Result.force (Error_busy_drive_text, Error_busy_drive_value)
			Result.force (Error_same_drive_text, Error_same_drive_value)
			Result.force (Error_dir_not_root_text, Error_dir_not_root_value)
			Result.force (Error_dir_not_empty_text, Error_dir_not_empty_value)
			Result.force (Error_is_subst_path_text, Error_is_subst_path_value)
			Result.force (Error_is_join_path_text, Error_is_join_path_value)
			Result.force (Error_path_busy_text, Error_path_busy_value)
			Result.force (Error_is_subst_target_text, Error_is_subst_target_value)
			Result.force (Error_system_trace_text, Error_system_trace_value)
			Result.force (Error_invalid_event_count_text, Error_invalid_event_count_value)
			Result.force (Error_too_many_muxwaiters_text, Error_too_many_muxwaiters_value)
			Result.force (Error_invalid_list_format_text, Error_invalid_list_format_value)
			Result.force (Error_label_too_long_text, Error_label_too_long_value)
			Result.force (Error_too_many_tcbs_text, Error_too_many_tcbs_value)
			Result.force (Error_signal_refused_text, Error_signal_refused_value)
			Result.force (Error_discarded_text, Error_discarded_value)
			Result.force (Error_not_locked_text, Error_not_locked_value)
			Result.force (Error_bad_threadid_addr_text, Error_bad_threadid_addr_value)
			Result.force (Error_bad_arguments_text, Error_bad_arguments_value)
			Result.force (Error_bad_pathname_text, Error_bad_pathname_value)
			Result.force (Error_signal_pending_text, Error_signal_pending_value)
			Result.force (Error_max_thrds_reached_text, Error_max_thrds_reached_value)
			Result.force (Error_lock_failed_text, Error_lock_failed_value)
			Result.force (Error_busy_text, Error_busy_value)
			Result.force (Error_cancel_violation_text, Error_cancel_violation_value)
			Result.force (Error_atomic_locks_not_supported_text, Error_atomic_locks_not_supported_value)
			Result.force (Error_invalid_segment_number_text, Error_invalid_segment_number_value)
			Result.force (Error_invalid_ordinal_text, Error_invalid_ordinal_value)
			Result.force (Error_already_exists_text, Error_already_exists_value)
			Result.force (Error_invalid_flag_number_text, Error_invalid_flag_number_value)
			Result.force (Error_sem_not_found_text, Error_sem_not_found_value)
			Result.force (Error_invalid_starting_codeseg_text, Error_invalid_starting_codeseg_value)
			Result.force (Error_invalid_stackseg_text, Error_invalid_stackseg_value)
			Result.force (Error_invalid_moduletype_text, Error_invalid_moduletype_value)
			Result.force (Error_invalid_exe_signature_text, Error_invalid_exe_signature_value)
			Result.force (Error_exe_marked_invalid_text, Error_exe_marked_invalid_value)
			Result.force (Error_bad_exe_format_text, Error_bad_exe_format_value)
			Result.force (Error_iterated_data_exceeds_64k_text, Error_iterated_data_exceeds_64k_value)
			Result.force (Error_invalid_minallocsize_text, Error_invalid_minallocsize_value)
			Result.force (Error_dynlink_from_invalid_ring_text, Error_dynlink_from_invalid_ring_value)
			Result.force (Error_iopl_not_enabled_text, Error_iopl_not_enabled_value)
			Result.force (Error_invalid_segdpl_text, Error_invalid_segdpl_value)
			Result.force (Error_autodataseg_exceeds_64k_text, Error_autodataseg_exceeds_64k_value)
			Result.force (Error_ring2seg_must_be_movable_text, Error_ring2seg_must_be_movable_value)
			Result.force (Error_reloc_chain_xeeds_seglim_text, Error_reloc_chain_xeeds_seglim_value)
			Result.force (Error_infloop_in_reloc_chain_text, Error_infloop_in_reloc_chain_value)
			Result.force (Error_envvar_not_found_text, Error_envvar_not_found_value)
			Result.force (Error_no_signal_sent_text, Error_no_signal_sent_value)
			Result.force (Error_filename_exced_range_text, Error_filename_exced_range_value)
			Result.force (Error_ring2_stack_in_use_text, Error_ring2_stack_in_use_value)
			Result.force (Error_meta_expansion_too_long_text, Error_meta_expansion_too_long_value)
			Result.force (Error_invalid_signal_number_text, Error_invalid_signal_number_value)
			Result.force (Error_thread_1_inactive_text, Error_thread_1_inactive_value)
			Result.force (Error_locked_text, Error_locked_value)
			Result.force (Error_too_many_modules_text, Error_too_many_modules_value)
			Result.force (Error_nesting_not_allowed_text, Error_nesting_not_allowed_value)
			Result.force (Error_exe_machine_type_mismatch_text, Error_exe_machine_type_mismatch_value)
			Result.force (Error_bad_pipe_text, Error_bad_pipe_value)
			Result.force (Error_pipe_busy_text, Error_pipe_busy_value)
			Result.force (Error_no_data_text, Error_no_data_value)
			Result.force (Error_pipe_not_connected_text, Error_pipe_not_connected_value)
			Result.force (Error_more_data_text, Error_more_data_value)
			Result.force (Error_vc_disconnected_text, Error_vc_disconnected_value)
			Result.force (Error_invalid_ea_name_text, Error_invalid_ea_name_value)
			Result.force (Error_ea_list_inconsistent_text, Error_ea_list_inconsistent_value)
			Result.force (Wait_timeout_text, Wait_timeout_value)
			Result.force (Error_no_more_items_text, Error_no_more_items_value)
			Result.force (Error_cannot_copy_text, Error_cannot_copy_value)
			Result.force (Error_directory_text, Error_directory_value)
			Result.force (Error_eas_didnt_fit_text, Error_eas_didnt_fit_value)
			Result.force (Error_ea_file_corrupt_text, Error_ea_file_corrupt_value)
			Result.force (Error_ea_table_full_text, Error_ea_table_full_value)
			Result.force (Error_invalid_ea_handle_text, Error_invalid_ea_handle_value)
			Result.force (Error_eas_not_supported_text, Error_eas_not_supported_value)
			Result.force (Error_not_owner_text, Error_not_owner_value)
			Result.force (Error_too_many_posts_text, Error_too_many_posts_value)
			Result.force (Error_partial_copy_text, Error_partial_copy_value)
			Result.force (Error_oplock_not_granted_text, Error_oplock_not_granted_value)
			Result.force (Error_invalid_oplock_protocol_text, Error_invalid_oplock_protocol_value)
			Result.force (Error_mr_mid_not_found_text, Error_mr_mid_not_found_value)
			Result.force (Error_invalid_address_text, Error_invalid_address_value)
			Result.force (Error_arithmetic_overflow_text, Error_arithmetic_overflow_value)
			Result.force (Error_pipe_connected_text, Error_pipe_connected_value)
			Result.force (Error_pipe_listening_text, Error_pipe_listening_value)
			Result.force (Error_ea_access_denied_text, Error_ea_access_denied_value)
			Result.force (Error_operation_aborted_text, Error_operation_aborted_value)
			Result.force (Error_io_incomplete_text, Error_io_incomplete_value)
			Result.force (Error_io_pending_text, Error_io_pending_value)
			Result.force (Error_noaccess_text, Error_noaccess_value)
			Result.force (Error_swaperror_text, Error_swaperror_value)
			Result.force (Error_stack_overflow_text, Error_stack_overflow_value)
			Result.force (Error_invalid_message_text, Error_invalid_message_value)
			Result.force (Error_can_not_complete_text, Error_can_not_complete_value)
			Result.force (Error_invalid_flags_text, Error_invalid_flags_value)
			Result.force (Error_unrecognized_volume_text, Error_unrecognized_volume_value)
			Result.force (Error_file_invalid_text, Error_file_invalid_value)
			Result.force (Error_fullscreen_mode_text, Error_fullscreen_mode_value)
			Result.force (Error_no_token_text, Error_no_token_value)
			Result.force (Error_baddb_text, Error_baddb_value)
			Result.force (Error_badkey_text, Error_badkey_value)
			Result.force (Error_cantopen_text, Error_cantopen_value)
			Result.force (Error_cantread_text, Error_cantread_value)
			Result.force (Error_cantwrite_text, Error_cantwrite_value)
			Result.force (Error_registry_recovered_text, Error_registry_recovered_value)
			Result.force (Error_registry_corrupt_text, Error_registry_corrupt_value)
			Result.force (Error_registry_io_failed_text, Error_registry_io_failed_value)
			Result.force (Error_not_registry_file_text, Error_not_registry_file_value)
			Result.force (Error_key_deleted_text, Error_key_deleted_value)
			Result.force (Error_no_log_space_text, Error_no_log_space_value)
			Result.force (Error_key_has_children_text, Error_key_has_children_value)
			Result.force (Error_child_must_be_volatile_text, Error_child_must_be_volatile_value)
			Result.force (Error_notify_enum_dir_text, Error_notify_enum_dir_value)
			Result.force (Error_dependent_services_running_text, Error_dependent_services_running_value)
			Result.force (Error_invalid_service_control_text, Error_invalid_service_control_value)
			Result.force (Error_service_request_timeout_text, Error_service_request_timeout_value)
			Result.force (Error_service_no_thread_text, Error_service_no_thread_value)
			Result.force (Error_service_database_locked_text, Error_service_database_locked_value)
			Result.force (Error_service_already_running_text, Error_service_already_running_value)
			Result.force (Error_invalid_service_account_text, Error_invalid_service_account_value)
			Result.force (Error_service_disabled_text, Error_service_disabled_value)
			Result.force (Error_circular_dependency_text, Error_circular_dependency_value)
			Result.force (Error_service_does_not_exist_text, Error_service_does_not_exist_value)
			Result.force (Error_service_cannot_accept_ctrl_text, Error_service_cannot_accept_ctrl_value)
			Result.force (Error_service_not_active_text, Error_service_not_active_value)
			Result.force (Error_failed_service_controller_connect_text, Error_failed_service_controller_connect_value)
			Result.force (Error_exception_in_service_text, Error_exception_in_service_value)
			Result.force (Error_database_does_not_exist_text, Error_database_does_not_exist_value)
			Result.force (Error_service_specific_error_text, Error_service_specific_error_value)
			Result.force (Error_process_aborted_text, Error_process_aborted_value)
			Result.force (Error_service_dependency_fail_text, Error_service_dependency_fail_value)
			Result.force (Error_service_logon_failed_text, Error_service_logon_failed_value)
			Result.force (Error_service_start_hang_text, Error_service_start_hang_value)
			Result.force (Error_invalid_service_lock_text, Error_invalid_service_lock_value)
			Result.force (Error_service_marked_for_delete_text, Error_service_marked_for_delete_value)
			Result.force (Error_service_exists_text, Error_service_exists_value)
			Result.force (Error_already_running_lkg_text, Error_already_running_lkg_value)
			Result.force (Error_service_dependency_deleted_text, Error_service_dependency_deleted_value)
			Result.force (Error_boot_already_accepted_text, Error_boot_already_accepted_value)
			Result.force (Error_service_never_started_text, Error_service_never_started_value)
			Result.force (Error_duplicate_service_name_text, Error_duplicate_service_name_value)
			Result.force (Error_different_service_account_text, Error_different_service_account_value)
			Result.force (Error_cannot_detect_driver_failure_text, Error_cannot_detect_driver_failure_value)
			Result.force (Error_cannot_detect_process_abort_text, Error_cannot_detect_process_abort_value)
			Result.force (Error_no_recovery_program_text, Error_no_recovery_program_value)
			Result.force (Error_service_not_in_exe_text, Error_service_not_in_exe_value)
			Result.force (Error_end_of_media_text, Error_end_of_media_value)
			Result.force (Error_filemark_detected_text, Error_filemark_detected_value)
			Result.force (Error_beginning_of_media_text, Error_beginning_of_media_value)
			Result.force (Error_setmark_detected_text, Error_setmark_detected_value)
			Result.force (Error_no_data_detected_text, Error_no_data_detected_value)
			Result.force (Error_partition_failure_text, Error_partition_failure_value)
			Result.force (Error_invalid_block_length_text, Error_invalid_block_length_value)
			Result.force (Error_device_not_partitioned_text, Error_device_not_partitioned_value)
			Result.force (Error_unable_to_lock_media_text, Error_unable_to_lock_media_value)
			Result.force (Error_unable_to_unload_media_text, Error_unable_to_unload_media_value)
			Result.force (Error_media_changed_text, Error_media_changed_value)
			Result.force (Error_bus_reset_text, Error_bus_reset_value)
			Result.force (Error_no_media_in_drive_text, Error_no_media_in_drive_value)
			Result.force (Error_no_unicode_translation_text, Error_no_unicode_translation_value)
			Result.force (Error_dll_init_failed_text, Error_dll_init_failed_value)
			Result.force (Error_shutdown_in_progress_text, Error_shutdown_in_progress_value)
			Result.force (Error_no_shutdown_in_progress_text, Error_no_shutdown_in_progress_value)
			Result.force (Error_io_device_text, Error_io_device_value)
			Result.force (Error_serial_no_device_text, Error_serial_no_device_value)
			Result.force (Error_irq_busy_text, Error_irq_busy_value)
			Result.force (Error_more_writes_text, Error_more_writes_value)
			Result.force (Error_counter_timeout_text, Error_counter_timeout_value)
			Result.force (Error_floppy_id_mark_not_found_text, Error_floppy_id_mark_not_found_value)
			Result.force (Error_floppy_wrong_cylinder_text, Error_floppy_wrong_cylinder_value)
			Result.force (Error_floppy_unknown_error_text, Error_floppy_unknown_error_value)
			Result.force (Error_floppy_bad_registers_text, Error_floppy_bad_registers_value)
			Result.force (Error_disk_recalibrate_failed_text, Error_disk_recalibrate_failed_value)
			Result.force (Error_disk_operation_failed_text, Error_disk_operation_failed_value)
			Result.force (Error_disk_reset_failed_text, Error_disk_reset_failed_value)
			Result.force (Error_eom_overflow_text, Error_eom_overflow_value)
			Result.force (Error_not_enough_server_memory_text, Error_not_enough_server_memory_value)
			Result.force (Error_possible_deadlock_text, Error_possible_deadlock_value)
			Result.force (Error_mapped_alignment_text, Error_mapped_alignment_value)
			Result.force (Error_set_power_state_vetoed_text, Error_set_power_state_vetoed_value)
			Result.force (Error_set_power_state_failed_text, Error_set_power_state_failed_value)
			Result.force (Error_too_many_links_text, Error_too_many_links_value)
			Result.force (Error_old_win_version_text, Error_old_win_version_value)
			Result.force (Error_app_wrong_os_text, Error_app_wrong_os_value)
			Result.force (Error_single_instance_app_text, Error_single_instance_app_value)
			Result.force (Error_rmode_app_text, Error_rmode_app_value)
			Result.force (Error_invalid_dll_text, Error_invalid_dll_value)
			Result.force (Error_no_association_text, Error_no_association_value)
			Result.force (Error_dde_fail_text, Error_dde_fail_value)
			Result.force (Error_dll_not_found_text, Error_dll_not_found_value)
			Result.force (Error_no_more_user_handles_text, Error_no_more_user_handles_value)
			Result.force (Error_message_sync_only_text, Error_message_sync_only_value)
			Result.force (Error_source_element_empty_text, Error_source_element_empty_value)
			Result.force (Error_destination_element_full_text, Error_destination_element_full_value)
			Result.force (Error_illegal_element_address_text, Error_illegal_element_address_value)
			Result.force (Error_magazine_not_present_text, Error_magazine_not_present_value)
			Result.force (Error_device_reinitialization_needed_text, Error_device_reinitialization_needed_value)
			Result.force (Error_device_requires_cleaning_text, Error_device_requires_cleaning_value)
			Result.force (Error_device_door_open_text, Error_device_door_open_value)
			Result.force (Error_device_not_connected_text, Error_device_not_connected_value)
			Result.force (Error_not_found_text, Error_not_found_value)
			Result.force (Error_no_match_text, Error_no_match_value)
			Result.force (Error_set_not_found_text, Error_set_not_found_value)
			Result.force (Error_point_not_found_text, Error_point_not_found_value)
			Result.force (Error_no_tracking_service_text, Error_no_tracking_service_value)
			Result.force (Error_no_volume_id_text, Error_no_volume_id_value)
			Result.force (Error_unable_to_remove_replaced_text, Error_unable_to_remove_replaced_value)
			Result.force (Error_unable_to_move_replacement_text, Error_unable_to_move_replacement_value)
			Result.force (Error_unable_to_move_replacement_2_text, Error_unable_to_move_replacement_2_value)
			Result.force (Error_journal_delete_in_progress_text, Error_journal_delete_in_progress_value)
			Result.force (Error_journal_not_active_text, Error_journal_not_active_value)
			Result.force (Error_potential_file_found_text, Error_potential_file_found_value)
			Result.force (Error_journal_entry_deleted_text, Error_journal_entry_deleted_value)
			Result.force (Error_bad_device_text, Error_bad_device_value)
			Result.force (Error_connection_unavail_text, Error_connection_unavail_value)
			Result.force (Error_device_already_remembered_text, Error_device_already_remembered_value)
			Result.force (Error_no_net_or_bad_path_text, Error_no_net_or_bad_path_value)
			Result.force (Error_bad_provider_text, Error_bad_provider_value)
			Result.force (Error_cannot_open_profile_text, Error_cannot_open_profile_value)
			Result.force (Error_bad_profile_text, Error_bad_profile_value)
			Result.force (Error_not_container_text, Error_not_container_value)
			Result.force (Error_extended_error_text, Error_extended_error_value)
			Result.force (Error_invalid_groupname_text, Error_invalid_groupname_value)
			Result.force (Error_invalid_computername_text, Error_invalid_computername_value)
			Result.force (Error_invalid_eventname_text, Error_invalid_eventname_value)
			Result.force (Error_invalid_domainname_text, Error_invalid_domainname_value)
			Result.force (Error_invalid_servicename_text, Error_invalid_servicename_value)
			Result.force (Error_invalid_netname_text, Error_invalid_netname_value)
			Result.force (Error_invalid_sharename_text, Error_invalid_sharename_value)
			Result.force (Error_invalid_passwordname_text, Error_invalid_passwordname_value)
			Result.force (Error_invalid_messagename_text, Error_invalid_messagename_value)
			Result.force (Error_invalid_messagedest_text, Error_invalid_messagedest_value)
			Result.force (Error_session_credential_conflict_text, Error_session_credential_conflict_value)
			Result.force (Error_remote_session_limit_exceeded_text, Error_remote_session_limit_exceeded_value)
			Result.force (Error_dup_domainname_text, Error_dup_domainname_value)
			Result.force (Error_no_network_text, Error_no_network_value)
			Result.force (Error_cancelled_text, Error_cancelled_value)
			Result.force (Error_user_mapped_file_text, Error_user_mapped_file_value)
			Result.force (Error_connection_refused_text, Error_connection_refused_value)
			Result.force (Error_graceful_disconnect_text, Error_graceful_disconnect_value)
			Result.force (Error_address_already_associated_text, Error_address_already_associated_value)
			Result.force (Error_address_not_associated_text, Error_address_not_associated_value)
			Result.force (Error_connection_invalid_text, Error_connection_invalid_value)
			Result.force (Error_connection_active_text, Error_connection_active_value)
			Result.force (Error_network_unreachable_text, Error_network_unreachable_value)
			Result.force (Error_host_unreachable_text, Error_host_unreachable_value)
			Result.force (Error_protocol_unreachable_text, Error_protocol_unreachable_value)
			Result.force (Error_port_unreachable_text, Error_port_unreachable_value)
			Result.force (Error_request_aborted_text, Error_request_aborted_value)
			Result.force (Error_connection_aborted_text, Error_connection_aborted_value)
			Result.force (Error_retry_text, Error_retry_value)
			Result.force (Error_connection_count_limit_text, Error_connection_count_limit_value)
			Result.force (Error_login_time_restriction_text, Error_login_time_restriction_value)
			Result.force (Error_login_wksta_restriction_text, Error_login_wksta_restriction_value)
			Result.force (Error_incorrect_address_text, Error_incorrect_address_value)
			Result.force (Error_already_registered_text, Error_already_registered_value)
			Result.force (Error_service_not_found_text, Error_service_not_found_value)
			Result.force (Error_not_authenticated_text, Error_not_authenticated_value)
			Result.force (Error_not_logged_on_text, Error_not_logged_on_value)
			Result.force (Error_continue_text, Error_continue_value)
			Result.force (Error_already_initialized_text, Error_already_initialized_value)
			Result.force (Error_no_more_devices_text, Error_no_more_devices_value)
			Result.force (Error_no_such_site_text, Error_no_such_site_value)
			Result.force (Error_domain_controller_exists_text, Error_domain_controller_exists_value)
			Result.force (Error_only_if_connected_text, Error_only_if_connected_value)
			Result.force (Error_override_nochanges_text, Error_override_nochanges_value)
			Result.force (Error_bad_user_profile_text, Error_bad_user_profile_value)
			Result.force (Error_not_supported_on_sbs_text, Error_not_supported_on_sbs_value)
			Result.force (Error_not_all_assigned_text, Error_not_all_assigned_value)
			Result.force (Error_some_not_mapped_text, Error_some_not_mapped_value)
			Result.force (Error_no_quotas_for_account_text, Error_no_quotas_for_account_value)
			Result.force (Error_local_user_session_key_text, Error_local_user_session_key_value)
			Result.force (Error_null_lm_password_text, Error_null_lm_password_value)
			Result.force (Error_unknown_revision_text, Error_unknown_revision_value)
			Result.force (Error_revision_mismatch_text, Error_revision_mismatch_value)
			Result.force (Error_invalid_owner_text, Error_invalid_owner_value)
			Result.force (Error_invalid_primary_group_text, Error_invalid_primary_group_value)
			Result.force (Error_no_impersonation_token_text, Error_no_impersonation_token_value)
			Result.force (Error_cant_disable_mandatory_text, Error_cant_disable_mandatory_value)
			Result.force (Error_no_logon_servers_text, Error_no_logon_servers_value)
			Result.force (Error_no_such_logon_session_text, Error_no_such_logon_session_value)
			Result.force (Error_no_such_privilege_text, Error_no_such_privilege_value)
			Result.force (Error_privilege_not_held_text, Error_privilege_not_held_value)
			Result.force (Error_invalid_account_name_text, Error_invalid_account_name_value)
			Result.force (Error_user_exists_text, Error_user_exists_value)
			Result.force (Error_no_such_user_text, Error_no_such_user_value)
			Result.force (Error_group_exists_text, Error_group_exists_value)
			Result.force (Error_no_such_group_text, Error_no_such_group_value)
			Result.force (Error_member_in_group_text, Error_member_in_group_value)
			Result.force (Error_member_not_in_group_text, Error_member_not_in_group_value)
			Result.force (Error_last_admin_text, Error_last_admin_value)
			Result.force (Error_wrong_password_text, Error_wrong_password_value)
			Result.force (Error_ill_formed_password_text, Error_ill_formed_password_value)
			Result.force (Error_password_restriction_text, Error_password_restriction_value)
			Result.force (Error_logon_failure_text, Error_logon_failure_value)
			Result.force (Error_account_restriction_text, Error_account_restriction_value)
			Result.force (Error_invalid_logon_hours_text, Error_invalid_logon_hours_value)
			Result.force (Error_invalid_workstation_text, Error_invalid_workstation_value)
			Result.force (Error_password_expired_text, Error_password_expired_value)
			Result.force (Error_account_disabled_text, Error_account_disabled_value)
			Result.force (Error_none_mapped_text, Error_none_mapped_value)
			Result.force (Error_too_many_luids_requested_text, Error_too_many_luids_requested_value)
			Result.force (Error_luids_exhausted_text, Error_luids_exhausted_value)
			Result.force (Error_invalid_sub_authority_text, Error_invalid_sub_authority_value)
			Result.force (Error_invalid_acl_text, Error_invalid_acl_value)
			Result.force (Error_invalid_sid_text, Error_invalid_sid_value)
			Result.force (Error_invalid_security_descr_text, Error_invalid_security_descr_value)
			Result.force (Error_bad_inheritance_acl_text, Error_bad_inheritance_acl_value)
			Result.force (Error_server_disabled_text, Error_server_disabled_value)
			Result.force (Error_server_not_disabled_text, Error_server_not_disabled_value)
			Result.force (Error_invalid_id_authority_text, Error_invalid_id_authority_value)
			Result.force (Error_allotted_space_exceeded_text, Error_allotted_space_exceeded_value)
			Result.force (Error_invalid_group_attributes_text, Error_invalid_group_attributes_value)
			Result.force (Error_bad_impersonation_level_text, Error_bad_impersonation_level_value)
			Result.force (Error_cant_open_anonymous_text, Error_cant_open_anonymous_value)
			Result.force (Error_bad_validation_class_text, Error_bad_validation_class_value)
			Result.force (Error_bad_token_type_text, Error_bad_token_type_value)
			Result.force (Error_no_security_on_object_text, Error_no_security_on_object_value)
			Result.force (Error_cant_access_domain_info_text, Error_cant_access_domain_info_value)
			Result.force (Error_invalid_server_state_text, Error_invalid_server_state_value)
			Result.force (Error_invalid_domain_state_text, Error_invalid_domain_state_value)
			Result.force (Error_invalid_domain_role_text, Error_invalid_domain_role_value)
			Result.force (Error_no_such_domain_text, Error_no_such_domain_value)
			Result.force (Error_domain_exists_text, Error_domain_exists_value)
			Result.force (Error_domain_limit_exceeded_text, Error_domain_limit_exceeded_value)
			Result.force (Error_internal_db_corruption_text, Error_internal_db_corruption_value)
			Result.force (Error_internal_error_text, Error_internal_error_value)
			Result.force (Error_generic_not_mapped_text, Error_generic_not_mapped_value)
			Result.force (Error_bad_descriptor_format_text, Error_bad_descriptor_format_value)
			Result.force (Error_not_logon_process_text, Error_not_logon_process_value)
			Result.force (Error_logon_session_exists_text, Error_logon_session_exists_value)
			Result.force (Error_no_such_package_text, Error_no_such_package_value)
			Result.force (Error_bad_logon_session_state_text, Error_bad_logon_session_state_value)
			Result.force (Error_logon_session_collision_text, Error_logon_session_collision_value)
			Result.force (Error_invalid_logon_type_text, Error_invalid_logon_type_value)
			Result.force (Error_cannot_impersonate_text, Error_cannot_impersonate_value)
			Result.force (Error_rxact_invalid_state_text, Error_rxact_invalid_state_value)
			Result.force (Error_rxact_commit_failure_text, Error_rxact_commit_failure_value)
			Result.force (Error_special_account_text, Error_special_account_value)
			Result.force (Error_special_group_text, Error_special_group_value)
			Result.force (Error_special_user_text, Error_special_user_value)
			Result.force (Error_members_primary_group_text, Error_members_primary_group_value)
			Result.force (Error_token_already_in_use_text, Error_token_already_in_use_value)
			Result.force (Error_no_such_alias_text, Error_no_such_alias_value)
			Result.force (Error_member_not_in_alias_text, Error_member_not_in_alias_value)
			Result.force (Error_member_in_alias_text, Error_member_in_alias_value)
			Result.force (Error_alias_exists_text, Error_alias_exists_value)
			Result.force (Error_logon_not_granted_text, Error_logon_not_granted_value)
			Result.force (Error_too_many_secrets_text, Error_too_many_secrets_value)
			Result.force (Error_secret_too_long_text, Error_secret_too_long_value)
			Result.force (Error_internal_db_error_text, Error_internal_db_error_value)
			Result.force (Error_too_many_context_ids_text, Error_too_many_context_ids_value)
			Result.force (Error_logon_type_not_granted_text, Error_logon_type_not_granted_value)
			Result.force (Error_nt_cross_encryption_required_text, Error_nt_cross_encryption_required_value)
			Result.force (Error_no_such_member_text, Error_no_such_member_value)
			Result.force (Error_invalid_member_text, Error_invalid_member_value)
			Result.force (Error_too_many_sids_text, Error_too_many_sids_value)
			Result.force (Error_lm_cross_encryption_required_text, Error_lm_cross_encryption_required_value)
			Result.force (Error_no_inheritance_text, Error_no_inheritance_value)
			Result.force (Error_file_corrupt_text, Error_file_corrupt_value)
			Result.force (Error_disk_corrupt_text, Error_disk_corrupt_value)
			Result.force (Error_no_user_session_key_text, Error_no_user_session_key_value)
			Result.force (Error_license_quota_exceeded_text, Error_license_quota_exceeded_value)
			Result.force (Error_wrong_target_name_text, Error_wrong_target_name_value)
			Result.force (Error_mutual_auth_failed_text, Error_mutual_auth_failed_value)
			Result.force (Error_time_skew_text, Error_time_skew_value)
			Result.force (Error_invalid_window_handle_text, Error_invalid_window_handle_value)
			Result.force (Error_invalid_menu_handle_text, Error_invalid_menu_handle_value)
			Result.force (Error_invalid_cursor_handle_text, Error_invalid_cursor_handle_value)
			Result.force (Error_invalid_accel_handle_text, Error_invalid_accel_handle_value)
			Result.force (Error_invalid_hook_handle_text, Error_invalid_hook_handle_value)
			Result.force (Error_invalid_dwp_handle_text, Error_invalid_dwp_handle_value)
			Result.force (Error_tlw_with_wschild_text, Error_tlw_with_wschild_value)
			Result.force (Error_cannot_find_wnd_class_text, Error_cannot_find_wnd_class_value)
			Result.force (Error_window_of_other_thread_text, Error_window_of_other_thread_value)
			Result.force (Error_hotkey_already_registered_text, Error_hotkey_already_registered_value)
			Result.force (Error_class_already_exists_text, Error_class_already_exists_value)
			Result.force (Error_class_does_not_exist_text, Error_class_does_not_exist_value)
			Result.force (Error_class_has_windows_text, Error_class_has_windows_value)
			Result.force (Error_invalid_index_text, Error_invalid_index_value)
			Result.force (Error_invalid_icon_handle_text, Error_invalid_icon_handle_value)
			Result.force (Error_private_dialog_index_text, Error_private_dialog_index_value)
			Result.force (Error_listbox_id_not_found_text, Error_listbox_id_not_found_value)
			Result.force (Error_no_wildcard_characters_text, Error_no_wildcard_characters_value)
			Result.force (Error_clipboard_not_open_text, Error_clipboard_not_open_value)
			Result.force (Error_hotkey_not_registered_text, Error_hotkey_not_registered_value)
			Result.force (Error_window_not_dialog_text, Error_window_not_dialog_value)
			Result.force (Error_control_id_not_found_text, Error_control_id_not_found_value)
			Result.force (Error_invalid_combobox_message_text, Error_invalid_combobox_message_value)
			Result.force (Error_window_not_combobox_text, Error_window_not_combobox_value)
			Result.force (Error_invalid_edit_height_text, Error_invalid_edit_height_value)
			Result.force (Error_dc_not_found_text, Error_dc_not_found_value)
			Result.force (Error_invalid_hook_filter_text, Error_invalid_hook_filter_value)
			Result.force (Error_invalid_filter_proc_text, Error_invalid_filter_proc_value)
			Result.force (Error_hook_needs_hmod_text, Error_hook_needs_hmod_value)
			Result.force (Error_global_only_hook_text, Error_global_only_hook_value)
			Result.force (Error_journal_hook_set_text, Error_journal_hook_set_value)
			Result.force (Error_hook_not_installed_text, Error_hook_not_installed_value)
			Result.force (Error_invalid_lb_message_text, Error_invalid_lb_message_value)
			Result.force (Error_setcount_on_bad_lb_text, Error_setcount_on_bad_lb_value)
			Result.force (Error_lb_without_tabstops_text, Error_lb_without_tabstops_value)
			Result.force (Error_destroy_object_of_other_thread_text, Error_destroy_object_of_other_thread_value)
			Result.force (Error_child_window_menu_text, Error_child_window_menu_value)
			Result.force (Error_no_system_menu_text, Error_no_system_menu_value)
			Result.force (Error_invalid_msgbox_style_text, Error_invalid_msgbox_style_value)
			Result.force (Error_invalid_spi_value_text, Error_invalid_spi_value_value)
			Result.force (Error_screen_already_locked_text, Error_screen_already_locked_value)
			Result.force (Error_hwnds_have_diff_parent_text, Error_hwnds_have_diff_parent_value)
			Result.force (Error_not_child_window_text, Error_not_child_window_value)
			Result.force (Error_invalid_gw_command_text, Error_invalid_gw_command_value)
			Result.force (Error_invalid_thread_id_text, Error_invalid_thread_id_value)
			Result.force (Error_non_mdichild_window_text, Error_non_mdichild_window_value)
			Result.force (Error_popup_already_active_text, Error_popup_already_active_value)
			Result.force (Error_no_scrollbars_text, Error_no_scrollbars_value)
			Result.force (Error_invalid_scrollbar_range_text, Error_invalid_scrollbar_range_value)
			Result.force (Error_invalid_showwin_command_text, Error_invalid_showwin_command_value)
			Result.force (Error_no_system_resources_text, Error_no_system_resources_value)
			Result.force (Error_nonpaged_system_resources_text, Error_nonpaged_system_resources_value)
			Result.force (Error_paged_system_resources_text, Error_paged_system_resources_value)
			Result.force (Error_working_set_quota_text, Error_working_set_quota_value)
			Result.force (Error_pagefile_quota_text, Error_pagefile_quota_value)
			Result.force (Error_commitment_limit_text, Error_commitment_limit_value)
			Result.force (Error_menu_item_not_found_text, Error_menu_item_not_found_value)
			Result.force (Error_invalid_keyboard_handle_text, Error_invalid_keyboard_handle_value)
			Result.force (Error_hook_type_not_allowed_text, Error_hook_type_not_allowed_value)
			Result.force (Error_requires_interactive_windowstation_text, Error_requires_interactive_windowstation_value)
			Result.force (Error_timeout_text, Error_timeout_value)
			Result.force (Error_invalid_monitor_handle_text, Error_invalid_monitor_handle_value)
			Result.force (Error_eventlog_file_corrupt_text, Error_eventlog_file_corrupt_value)
			Result.force (Error_eventlog_cant_start_text, Error_eventlog_cant_start_value)
			Result.force (Error_log_file_full_text, Error_log_file_full_value)
			Result.force (Error_eventlog_file_changed_text, Error_eventlog_file_changed_value)
			Result.force (Error_install_service_failure_text, Error_install_service_failure_value)
			Result.force (Error_install_userexit_text, Error_install_userexit_value)
			Result.force (Error_install_failure_text, Error_install_failure_value)
			Result.force (Error_install_suspend_text, Error_install_suspend_value)
			Result.force (Error_unknown_product_text, Error_unknown_product_value)
			Result.force (Error_unknown_feature_text, Error_unknown_feature_value)
			Result.force (Error_unknown_component_text, Error_unknown_component_value)
			Result.force (Error_unknown_property_text, Error_unknown_property_value)
			Result.force (Error_invalid_handle_state_text, Error_invalid_handle_state_value)
			Result.force (Error_bad_configuration_text, Error_bad_configuration_value)
			Result.force (Error_index_absent_text, Error_index_absent_value)
			Result.force (Error_install_source_absent_text, Error_install_source_absent_value)
			Result.force (Error_install_package_version_text, Error_install_package_version_value)
			Result.force (Error_product_uninstalled_text, Error_product_uninstalled_value)
			Result.force (Error_bad_query_syntax_text, Error_bad_query_syntax_value)
			Result.force (Error_invalid_field_text, Error_invalid_field_value)
			Result.force (Error_device_removed_text, Error_device_removed_value)
			Result.force (Error_install_already_running_text, Error_install_already_running_value)
			Result.force (Error_install_package_open_failed_text, Error_install_package_open_failed_value)
			Result.force (Error_install_package_invalid_text, Error_install_package_invalid_value)
			Result.force (Error_install_ui_failure_text, Error_install_ui_failure_value)
			Result.force (Error_install_log_failure_text, Error_install_log_failure_value)
			Result.force (Error_install_language_unsupported_text, Error_install_language_unsupported_value)
			Result.force (Error_install_transform_failure_text, Error_install_transform_failure_value)
			Result.force (Error_install_package_rejected_text, Error_install_package_rejected_value)
			Result.force (Error_function_not_called_text, Error_function_not_called_value)
			Result.force (Error_function_failed_text, Error_function_failed_value)
			Result.force (Error_invalid_table_text, Error_invalid_table_value)
			Result.force (Error_datatype_mismatch_text, Error_datatype_mismatch_value)
			Result.force (Error_unsupported_type_text, Error_unsupported_type_value)
			Result.force (Error_create_failed_text, Error_create_failed_value)
			Result.force (Error_install_temp_unwritable_text, Error_install_temp_unwritable_value)
			Result.force (Error_install_platform_unsupported_text, Error_install_platform_unsupported_value)
			Result.force (Error_install_notused_text, Error_install_notused_value)
			Result.force (Error_patch_package_open_failed_text, Error_patch_package_open_failed_value)
			Result.force (Error_patch_package_invalid_text, Error_patch_package_invalid_value)
			Result.force (Error_patch_package_unsupported_text, Error_patch_package_unsupported_value)
			Result.force (Error_product_version_text, Error_product_version_value)
			Result.force (Error_invalid_command_line_text, Error_invalid_command_line_value)
			Result.force (Error_install_remote_disallowed_text, Error_install_remote_disallowed_value)
			Result.force (Error_success_reboot_initiated_text, Error_success_reboot_initiated_value)
			Result.force (Error_patch_target_not_found_text, Error_patch_target_not_found_value)
			Result.force (Rpc_s_invalid_string_binding_text, Rpc_s_invalid_string_binding_value)
			Result.force (Rpc_s_wrong_kind_of_binding_text, Rpc_s_wrong_kind_of_binding_value)
			Result.force (Rpc_s_invalid_binding_text, Rpc_s_invalid_binding_value)
			Result.force (Rpc_s_protseq_not_supported_text, Rpc_s_protseq_not_supported_value)
			Result.force (Rpc_s_invalid_rpc_protseq_text, Rpc_s_invalid_rpc_protseq_value)
			Result.force (Rpc_s_invalid_string_uuid_text, Rpc_s_invalid_string_uuid_value)
			Result.force (Rpc_s_invalid_endpoint_format_text, Rpc_s_invalid_endpoint_format_value)
			Result.force (Rpc_s_invalid_net_addr_text, Rpc_s_invalid_net_addr_value)
			Result.force (Rpc_s_no_endpoint_found_text, Rpc_s_no_endpoint_found_value)
			Result.force (Rpc_s_invalid_timeout_text, Rpc_s_invalid_timeout_value)
			Result.force (Rpc_s_object_not_found_text, Rpc_s_object_not_found_value)
			Result.force (Rpc_s_already_registered_text, Rpc_s_already_registered_value)
			Result.force (Rpc_s_type_already_registered_text, Rpc_s_type_already_registered_value)
			Result.force (Rpc_s_already_listening_text, Rpc_s_already_listening_value)
			Result.force (Rpc_s_no_protseqs_registered_text, Rpc_s_no_protseqs_registered_value)
			Result.force (Rpc_s_not_listening_text, Rpc_s_not_listening_value)
			Result.force (Rpc_s_unknown_mgr_type_text, Rpc_s_unknown_mgr_type_value)
			Result.force (Rpc_s_unknown_if_text, Rpc_s_unknown_if_value)
			Result.force (Rpc_s_no_bindings_text, Rpc_s_no_bindings_value)
			Result.force (Rpc_s_no_protseqs_text, Rpc_s_no_protseqs_value)
			Result.force (Rpc_s_cant_create_endpoint_text, Rpc_s_cant_create_endpoint_value)
			Result.force (Rpc_s_out_of_resources_text, Rpc_s_out_of_resources_value)
			Result.force (Rpc_s_server_unavailable_text, Rpc_s_server_unavailable_value)
			Result.force (Rpc_s_server_too_busy_text, Rpc_s_server_too_busy_value)
			Result.force (Rpc_s_invalid_network_options_text, Rpc_s_invalid_network_options_value)
			Result.force (Rpc_s_no_call_active_text, Rpc_s_no_call_active_value)
			Result.force (Rpc_s_call_failed_text, Rpc_s_call_failed_value)
			Result.force (Rpc_s_call_failed_dne_text, Rpc_s_call_failed_dne_value)
			Result.force (Rpc_s_protocol_error_text, Rpc_s_protocol_error_value)
			Result.force (Rpc_s_unsupported_trans_syn_text, Rpc_s_unsupported_trans_syn_value)
			Result.force (Rpc_s_unsupported_type_text, Rpc_s_unsupported_type_value)
			Result.force (Rpc_s_invalid_tag_text, Rpc_s_invalid_tag_value)
			Result.force (Rpc_s_invalid_bound_text, Rpc_s_invalid_bound_value)
			Result.force (Rpc_s_no_entry_name_text, Rpc_s_no_entry_name_value)
			Result.force (Rpc_s_invalid_name_syntax_text, Rpc_s_invalid_name_syntax_value)
			Result.force (Rpc_s_unsupported_name_syntax_text, Rpc_s_unsupported_name_syntax_value)
			Result.force (Rpc_s_uuid_no_address_text, Rpc_s_uuid_no_address_value)
			Result.force (Rpc_s_duplicate_endpoint_text, Rpc_s_duplicate_endpoint_value)
			Result.force (Rpc_s_unknown_authn_type_text, Rpc_s_unknown_authn_type_value)
			Result.force (Rpc_s_max_calls_too_small_text, Rpc_s_max_calls_too_small_value)
			Result.force (Rpc_s_string_too_long_text, Rpc_s_string_too_long_value)
			Result.force (Rpc_s_protseq_not_found_text, Rpc_s_protseq_not_found_value)
			Result.force (Rpc_s_procnum_out_of_range_text, Rpc_s_procnum_out_of_range_value)
			Result.force (Rpc_s_binding_has_no_auth_text, Rpc_s_binding_has_no_auth_value)
			Result.force (Rpc_s_unknown_authn_service_text, Rpc_s_unknown_authn_service_value)
			Result.force (Rpc_s_unknown_authn_level_text, Rpc_s_unknown_authn_level_value)
			Result.force (Rpc_s_invalid_auth_identity_text, Rpc_s_invalid_auth_identity_value)
			Result.force (Rpc_s_unknown_authz_service_text, Rpc_s_unknown_authz_service_value)
			Result.force (Ept_s_invalid_entry_text, Ept_s_invalid_entry_value)
			Result.force (Ept_s_cant_perform_op_text, Ept_s_cant_perform_op_value)
			Result.force (Ept_s_not_registered_text, Ept_s_not_registered_value)
			Result.force (Rpc_s_nothing_to_export_text, Rpc_s_nothing_to_export_value)
			Result.force (Rpc_s_incomplete_name_text, Rpc_s_incomplete_name_value)
			Result.force (Rpc_s_invalid_vers_option_text, Rpc_s_invalid_vers_option_value)
			Result.force (Rpc_s_no_more_members_text, Rpc_s_no_more_members_value)
			Result.force (Rpc_s_not_all_objs_unexported_text, Rpc_s_not_all_objs_unexported_value)
			Result.force (Rpc_s_interface_not_found_text, Rpc_s_interface_not_found_value)
			Result.force (Rpc_s_entry_already_exists_text, Rpc_s_entry_already_exists_value)
			Result.force (Rpc_s_entry_not_found_text, Rpc_s_entry_not_found_value)
			Result.force (Rpc_s_name_service_unavailable_text, Rpc_s_name_service_unavailable_value)
			Result.force (Rpc_s_invalid_naf_id_text, Rpc_s_invalid_naf_id_value)
			Result.force (Rpc_s_cannot_support_text, Rpc_s_cannot_support_value)
			Result.force (Rpc_s_no_context_available_text, Rpc_s_no_context_available_value)
			Result.force (Rpc_s_internal_error_text, Rpc_s_internal_error_value)
			Result.force (Rpc_s_zero_divide_text, Rpc_s_zero_divide_value)
			Result.force (Rpc_s_address_error_text, Rpc_s_address_error_value)
			Result.force (Rpc_s_fp_div_zero_text, Rpc_s_fp_div_zero_value)
			Result.force (Rpc_s_fp_underflow_text, Rpc_s_fp_underflow_value)
			Result.force (Rpc_s_fp_overflow_text, Rpc_s_fp_overflow_value)
			Result.force (Rpc_x_no_more_entries_text, Rpc_x_no_more_entries_value)
			Result.force (Rpc_x_ss_char_trans_open_fail_text, Rpc_x_ss_char_trans_open_fail_value)
			Result.force (Rpc_x_ss_char_trans_short_file_text, Rpc_x_ss_char_trans_short_file_value)
			Result.force (Rpc_x_ss_in_null_context_text, Rpc_x_ss_in_null_context_value)
			Result.force (Rpc_x_ss_context_damaged_text, Rpc_x_ss_context_damaged_value)
			Result.force (Rpc_x_ss_handles_mismatch_text, Rpc_x_ss_handles_mismatch_value)
			Result.force (Rpc_x_ss_cannot_get_call_handle_text, Rpc_x_ss_cannot_get_call_handle_value)
			Result.force (Rpc_x_null_ref_pointer_text, Rpc_x_null_ref_pointer_value)
			Result.force (Rpc_x_enum_value_out_of_range_text, Rpc_x_enum_value_out_of_range_value)
			Result.force (Rpc_x_byte_count_too_small_text, Rpc_x_byte_count_too_small_value)
			Result.force (Rpc_x_bad_stub_data_text, Rpc_x_bad_stub_data_value)
			Result.force (Error_invalid_user_buffer_text, Error_invalid_user_buffer_value)
			Result.force (Error_unrecognized_media_text, Error_unrecognized_media_value)
			Result.force (Error_no_trust_lsa_secret_text, Error_no_trust_lsa_secret_value)
			Result.force (Error_no_trust_sam_account_text, Error_no_trust_sam_account_value)
			Result.force (Error_trusted_domain_failure_text, Error_trusted_domain_failure_value)
			Result.force (Error_trusted_relationship_failure_text, Error_trusted_relationship_failure_value)
			Result.force (Error_trust_failure_text, Error_trust_failure_value)
			Result.force (Rpc_s_call_in_progress_text, Rpc_s_call_in_progress_value)
			Result.force (Error_netlogon_not_started_text, Error_netlogon_not_started_value)
			Result.force (Error_account_expired_text, Error_account_expired_value)
			Result.force (Error_redirector_has_open_handles_text, Error_redirector_has_open_handles_value)
			Result.force (Error_printer_driver_already_installed_text, Error_printer_driver_already_installed_value)
			Result.force (Error_unknown_port_text, Error_unknown_port_value)
			Result.force (Error_unknown_printer_driver_text, Error_unknown_printer_driver_value)
			Result.force (Error_unknown_printprocessor_text, Error_unknown_printprocessor_value)
			Result.force (Error_invalid_separator_file_text, Error_invalid_separator_file_value)
			Result.force (Error_invalid_priority_text, Error_invalid_priority_value)
			Result.force (Error_invalid_printer_name_text, Error_invalid_printer_name_value)
			Result.force (Error_printer_already_exists_text, Error_printer_already_exists_value)
			Result.force (Error_invalid_printer_command_text, Error_invalid_printer_command_value)
			Result.force (Error_invalid_datatype_text, Error_invalid_datatype_value)
			Result.force (Error_invalid_environment_text, Error_invalid_environment_value)
			Result.force (Rpc_s_no_more_bindings_text, Rpc_s_no_more_bindings_value)
			Result.force (Error_nologon_interdomain_trust_account_text, Error_nologon_interdomain_trust_account_value)
			Result.force (Error_nologon_workstation_trust_account_text, Error_nologon_workstation_trust_account_value)
			Result.force (Error_nologon_server_trust_account_text, Error_nologon_server_trust_account_value)
			Result.force (Error_domain_trust_inconsistent_text, Error_domain_trust_inconsistent_value)
			Result.force (Error_server_has_open_handles_text, Error_server_has_open_handles_value)
			Result.force (Error_resource_data_not_found_text, Error_resource_data_not_found_value)
			Result.force (Error_resource_type_not_found_text, Error_resource_type_not_found_value)
			Result.force (Error_resource_name_not_found_text, Error_resource_name_not_found_value)
			Result.force (Error_resource_lang_not_found_text, Error_resource_lang_not_found_value)
			Result.force (Error_not_enough_quota_text, Error_not_enough_quota_value)
			Result.force (Rpc_s_no_interfaces_text, Rpc_s_no_interfaces_value)
			Result.force (Rpc_s_call_cancelled_text, Rpc_s_call_cancelled_value)
			Result.force (Rpc_s_binding_incomplete_text, Rpc_s_binding_incomplete_value)
			Result.force (Rpc_s_comm_failure_text, Rpc_s_comm_failure_value)
			Result.force (Rpc_s_unsupported_authn_level_text, Rpc_s_unsupported_authn_level_value)
			Result.force (Rpc_s_no_princ_name_text, Rpc_s_no_princ_name_value)
			Result.force (Rpc_s_not_rpc_error_text, Rpc_s_not_rpc_error_value)
			Result.force (Rpc_s_uuid_local_only_text, Rpc_s_uuid_local_only_value)
			Result.force (Rpc_s_sec_pkg_error_text, Rpc_s_sec_pkg_error_value)
			Result.force (Rpc_s_not_cancelled_text, Rpc_s_not_cancelled_value)
			Result.force (Rpc_x_invalid_es_action_text, Rpc_x_invalid_es_action_value)
			Result.force (Rpc_x_wrong_es_version_text, Rpc_x_wrong_es_version_value)
			Result.force (Rpc_x_wrong_stub_version_text, Rpc_x_wrong_stub_version_value)
			Result.force (Rpc_x_invalid_pipe_object_text, Rpc_x_invalid_pipe_object_value)
			Result.force (Rpc_x_wrong_pipe_order_text, Rpc_x_wrong_pipe_order_value)
			Result.force (Rpc_x_wrong_pipe_version_text, Rpc_x_wrong_pipe_version_value)
			Result.force (Rpc_s_group_member_not_found_text, Rpc_s_group_member_not_found_value)
			Result.force (Ept_s_cant_create_text, Ept_s_cant_create_value)
			Result.force (Rpc_s_invalid_object_text, Rpc_s_invalid_object_value)
			Result.force (Error_invalid_time_text, Error_invalid_time_value)
			Result.force (Error_invalid_form_name_text, Error_invalid_form_name_value)
			Result.force (Error_invalid_form_size_text, Error_invalid_form_size_value)
			Result.force (Error_already_waiting_text, Error_already_waiting_value)
			Result.force (Error_printer_deleted_text, Error_printer_deleted_value)
			Result.force (Error_invalid_printer_state_text, Error_invalid_printer_state_value)
			Result.force (Error_password_must_change_text, Error_password_must_change_value)
			Result.force (Error_domain_controller_not_found_text, Error_domain_controller_not_found_value)
			Result.force (Error_account_locked_out_text, Error_account_locked_out_value)
			Result.force (Or_invalid_oxid_text, Or_invalid_oxid_value)
			Result.force (Or_invalid_oid_text, Or_invalid_oid_value)
			Result.force (Or_invalid_set_text, Or_invalid_set_value)
			Result.force (Rpc_s_send_incomplete_text, Rpc_s_send_incomplete_value)
			Result.force (Rpc_s_invalid_async_handle_text, Rpc_s_invalid_async_handle_value)
			Result.force (Rpc_s_invalid_async_call_text, Rpc_s_invalid_async_call_value)
			Result.force (Rpc_x_pipe_closed_text, Rpc_x_pipe_closed_value)
			Result.force (Rpc_x_pipe_discipline_error_text, Rpc_x_pipe_discipline_error_value)
			Result.force (Rpc_x_pipe_empty_text, Rpc_x_pipe_empty_value)
			Result.force (Error_no_sitename_text, Error_no_sitename_value)
			Result.force (Error_cant_access_file_text, Error_cant_access_file_value)
			Result.force (Error_cant_resolve_filename_text, Error_cant_resolve_filename_value)
			Result.force (Rpc_s_entry_type_mismatch_text, Rpc_s_entry_type_mismatch_value)
			Result.force (Rpc_s_not_all_objs_exported_text, Rpc_s_not_all_objs_exported_value)
			Result.force (Rpc_s_interface_not_exported_text, Rpc_s_interface_not_exported_value)
			Result.force (Rpc_s_profile_not_added_text, Rpc_s_profile_not_added_value)
			Result.force (Rpc_s_prf_elt_not_added_text, Rpc_s_prf_elt_not_added_value)
			Result.force (Rpc_s_prf_elt_not_removed_text, Rpc_s_prf_elt_not_removed_value)
			Result.force (Rpc_s_grp_elt_not_added_text, Rpc_s_grp_elt_not_added_value)
			Result.force (Rpc_s_grp_elt_not_removed_text, Rpc_s_grp_elt_not_removed_value)
			Result.force (Error_no_browser_servers_found_text, Error_no_browser_servers_found_value)
			Result.force (Error_invalid_pixel_format_text, Error_invalid_pixel_format_value)
			Result.force (Error_bad_driver_text, Error_bad_driver_value)
			Result.force (Error_invalid_window_style_text, Error_invalid_window_style_value)
			Result.force (Error_metafile_not_supported_text, Error_metafile_not_supported_value)
			Result.force (Error_transform_not_supported_text, Error_transform_not_supported_value)
			Result.force (Error_clipping_not_supported_text, Error_clipping_not_supported_value)
			Result.force (Error_invalid_cmm_text, Error_invalid_cmm_value)
			Result.force (Error_invalid_profile_text, Error_invalid_profile_value)
			Result.force (Error_tag_not_found_text, Error_tag_not_found_value)
			Result.force (Error_tag_not_present_text, Error_tag_not_present_value)
			Result.force (Error_duplicate_tag_text, Error_duplicate_tag_value)
			Result.force (Error_profile_not_associated_with_device_text, Error_profile_not_associated_with_device_value)
			Result.force (Error_profile_not_found_text, Error_profile_not_found_value)
			Result.force (Error_invalid_colorspace_text, Error_invalid_colorspace_value)
			Result.force (Error_icm_not_enabled_text, Error_icm_not_enabled_value)
			Result.force (Error_deleting_icm_xform_text, Error_deleting_icm_xform_value)
			Result.force (Error_invalid_transform_text, Error_invalid_transform_value)
			Result.force (Error_colorspace_mismatch_text, Error_colorspace_mismatch_value)
			Result.force (Error_invalid_colorindex_text, Error_invalid_colorindex_value)
			Result.force (Error_connected_other_password_text, Error_connected_other_password_value)
			Result.force (Error_bad_username_text, Error_bad_username_value)
			Result.force (Error_not_connected_text, Error_not_connected_value)
			Result.force (Error_open_files_text, Error_open_files_value)
			Result.force (Error_active_connections_text, Error_active_connections_value)
			Result.force (Error_device_in_use_text, Error_device_in_use_value)
			Result.force (Error_unknown_print_monitor_text, Error_unknown_print_monitor_value)
			Result.force (Error_printer_driver_in_use_text, Error_printer_driver_in_use_value)
			Result.force (Error_spool_file_not_found_text, Error_spool_file_not_found_value)
			Result.force (Error_spl_no_startdoc_text, Error_spl_no_startdoc_value)
			Result.force (Error_spl_no_addjob_text, Error_spl_no_addjob_value)
			Result.force (Error_print_processor_already_installed_text, Error_print_processor_already_installed_value)
			Result.force (Error_print_monitor_already_installed_text, Error_print_monitor_already_installed_value)
			Result.force (Error_invalid_print_monitor_text, Error_invalid_print_monitor_value)
			Result.force (Error_print_monitor_in_use_text, Error_print_monitor_in_use_value)
			Result.force (Error_printer_has_jobs_queued_text, Error_printer_has_jobs_queued_value)
			Result.force (Error_success_reboot_required_text, Error_success_reboot_required_value)
			Result.force (Error_success_restart_required_text, Error_success_restart_required_value)
			Result.force (Error_printer_not_found_text, Error_printer_not_found_value)
			Result.force (Error_wins_internal_text, Error_wins_internal_value)
			Result.force (Error_can_not_del_local_wins_text, Error_can_not_del_local_wins_value)
			Result.force (Error_static_init_text, Error_static_init_value)
			Result.force (Error_inc_backup_text, Error_inc_backup_value)
			Result.force (Error_full_backup_text, Error_full_backup_value)
			Result.force (Error_rec_non_existent_text, Error_rec_non_existent_value)
			Result.force (Error_rpl_not_allowed_text, Error_rpl_not_allowed_value)
			Result.force (Error_dhcp_address_conflict_text, Error_dhcp_address_conflict_value)
			Result.force (Error_wmi_guid_not_found_text, Error_wmi_guid_not_found_value)
			Result.force (Error_wmi_instance_not_found_text, Error_wmi_instance_not_found_value)
			Result.force (Error_wmi_itemid_not_found_text, Error_wmi_itemid_not_found_value)
			Result.force (Error_wmi_try_again_text, Error_wmi_try_again_value)
			Result.force (Error_wmi_dp_not_found_text, Error_wmi_dp_not_found_value)
			Result.force (Error_wmi_unresolved_instance_ref_text, Error_wmi_unresolved_instance_ref_value)
			Result.force (Error_wmi_already_enabled_text, Error_wmi_already_enabled_value)
			Result.force (Error_wmi_guid_disconnected_text, Error_wmi_guid_disconnected_value)
			Result.force (Error_wmi_server_unavailable_text, Error_wmi_server_unavailable_value)
			Result.force (Error_wmi_dp_failed_text, Error_wmi_dp_failed_value)
			Result.force (Error_wmi_invalid_mof_text, Error_wmi_invalid_mof_value)
			Result.force (Error_wmi_invalid_reginfo_text, Error_wmi_invalid_reginfo_value)
			Result.force (Error_wmi_already_disabled_text, Error_wmi_already_disabled_value)
			Result.force (Error_wmi_read_only_text, Error_wmi_read_only_value)
			Result.force (Error_wmi_set_failure_text, Error_wmi_set_failure_value)
			Result.force (Error_invalid_media_text, Error_invalid_media_value)
			Result.force (Error_invalid_library_text, Error_invalid_library_value)
			Result.force (Error_invalid_media_pool_text, Error_invalid_media_pool_value)
			Result.force (Error_drive_media_mismatch_text, Error_drive_media_mismatch_value)
			Result.force (Error_media_offline_text, Error_media_offline_value)
			Result.force (Error_library_offline_text, Error_library_offline_value)
			Result.force (Error_empty_text, Error_empty_value)
			Result.force (Error_not_empty_text, Error_not_empty_value)
			Result.force (Error_media_unavailable_text, Error_media_unavailable_value)
			Result.force (Error_resource_disabled_text, Error_resource_disabled_value)
			Result.force (Error_invalid_cleaner_text, Error_invalid_cleaner_value)
			Result.force (Error_unable_to_clean_text, Error_unable_to_clean_value)
			Result.force (Error_object_not_found_text, Error_object_not_found_value)
			Result.force (Error_database_failure_text, Error_database_failure_value)
			Result.force (Error_database_full_text, Error_database_full_value)
			Result.force (Error_media_incompatible_text, Error_media_incompatible_value)
			Result.force (Error_resource_not_present_text, Error_resource_not_present_value)
			Result.force (Error_invalid_operation_text, Error_invalid_operation_value)
			Result.force (Error_media_not_available_text, Error_media_not_available_value)
			Result.force (Error_device_not_available_text, Error_device_not_available_value)
			Result.force (Error_request_refused_text, Error_request_refused_value)
			Result.force (Error_invalid_drive_object_text, Error_invalid_drive_object_value)
			Result.force (Error_library_full_text, Error_library_full_value)
			Result.force (Error_medium_not_accessible_text, Error_medium_not_accessible_value)
			Result.force (Error_unable_to_load_medium_text, Error_unable_to_load_medium_value)
			Result.force (Error_unable_to_inventory_drive_text, Error_unable_to_inventory_drive_value)
			Result.force (Error_unable_to_inventory_slot_text, Error_unable_to_inventory_slot_value)
			Result.force (Error_unable_to_inventory_transport_text, Error_unable_to_inventory_transport_value)
			Result.force (Error_transport_full_text, Error_transport_full_value)
			Result.force (Error_controlling_ieport_text, Error_controlling_ieport_value)
			Result.force (Error_unable_to_eject_mounted_media_text, Error_unable_to_eject_mounted_media_value)
			Result.force (Error_cleaner_slot_set_text, Error_cleaner_slot_set_value)
			Result.force (Error_cleaner_slot_not_set_text, Error_cleaner_slot_not_set_value)
			Result.force (Error_cleaner_cartridge_spent_text, Error_cleaner_cartridge_spent_value)
			Result.force (Error_unexpected_omid_text, Error_unexpected_omid_value)
			Result.force (Error_cant_delete_last_item_text, Error_cant_delete_last_item_value)
			Result.force (Error_message_exceeds_max_size_text, Error_message_exceeds_max_size_value)
			Result.force (Error_volume_contains_sys_files_text, Error_volume_contains_sys_files_value)
			Result.force (Error_indigenous_type_text, Error_indigenous_type_value)
			Result.force (Error_no_supporting_drives_text, Error_no_supporting_drives_value)
			Result.force (Error_file_offline_text, Error_file_offline_value)
			Result.force (Error_remote_storage_not_active_text, Error_remote_storage_not_active_value)
			Result.force (Error_remote_storage_media_error_text, Error_remote_storage_media_error_value)
			Result.force (Error_not_a_reparse_point_text, Error_not_a_reparse_point_value)
			Result.force (Error_reparse_attribute_conflict_text, Error_reparse_attribute_conflict_value)
			Result.force (Error_invalid_reparse_data_text, Error_invalid_reparse_data_value)
			Result.force (Error_reparse_tag_invalid_text, Error_reparse_tag_invalid_value)
			Result.force (Error_reparse_tag_mismatch_text, Error_reparse_tag_mismatch_value)
			Result.force (Error_volume_not_sis_enabled_text, Error_volume_not_sis_enabled_value)
			Result.force (Error_dependent_resource_exists_text, Error_dependent_resource_exists_value)
			Result.force (Error_dependency_not_found_text, Error_dependency_not_found_value)
			Result.force (Error_dependency_already_exists_text, Error_dependency_already_exists_value)
			Result.force (Error_resource_not_online_text, Error_resource_not_online_value)
			Result.force (Error_host_node_not_available_text, Error_host_node_not_available_value)
			Result.force (Error_resource_not_available_text, Error_resource_not_available_value)
			Result.force (Error_resource_not_found_text, Error_resource_not_found_value)
			Result.force (Error_shutdown_cluster_text, Error_shutdown_cluster_value)
			Result.force (Error_cant_evict_active_node_text, Error_cant_evict_active_node_value)
			Result.force (Error_object_already_exists_text, Error_object_already_exists_value)
			Result.force (Error_object_in_list_text, Error_object_in_list_value)
			Result.force (Error_group_not_available_text, Error_group_not_available_value)
			Result.force (Error_group_not_found_text, Error_group_not_found_value)
			Result.force (Error_group_not_online_text, Error_group_not_online_value)
			Result.force (Error_host_node_not_resource_owner_text, Error_host_node_not_resource_owner_value)
			Result.force (Error_host_node_not_group_owner_text, Error_host_node_not_group_owner_value)
			Result.force (Error_resmon_create_failed_text, Error_resmon_create_failed_value)
			Result.force (Error_resmon_online_failed_text, Error_resmon_online_failed_value)
			Result.force (Error_resource_online_text, Error_resource_online_value)
			Result.force (Error_quorum_resource_text, Error_quorum_resource_value)
			Result.force (Error_not_quorum_capable_text, Error_not_quorum_capable_value)
			Result.force (Error_cluster_shutting_down_text, Error_cluster_shutting_down_value)
			Result.force (Error_invalid_state_text, Error_invalid_state_value)
			Result.force (Error_resource_properties_stored_text, Error_resource_properties_stored_value)
			Result.force (Error_not_quorum_class_text, Error_not_quorum_class_value)
			Result.force (Error_core_resource_text, Error_core_resource_value)
			Result.force (Error_quorum_resource_online_failed_text, Error_quorum_resource_online_failed_value)
			Result.force (Error_quorumlog_open_failed_text, Error_quorumlog_open_failed_value)
			Result.force (Error_clusterlog_corrupt_text, Error_clusterlog_corrupt_value)
			Result.force (Error_clusterlog_record_exceeds_maxsize_text, Error_clusterlog_record_exceeds_maxsize_value)
			Result.force (Error_clusterlog_exceeds_maxsize_text, Error_clusterlog_exceeds_maxsize_value)
			Result.force (Error_clusterlog_chkpoint_not_found_text, Error_clusterlog_chkpoint_not_found_value)
			Result.force (Error_clusterlog_not_enough_space_text, Error_clusterlog_not_enough_space_value)
			Result.force (Error_quorum_owner_alive_text, Error_quorum_owner_alive_value)
			Result.force (Error_network_not_available_text, Error_network_not_available_value)
			Result.force (Error_node_not_available_text, Error_node_not_available_value)
			Result.force (Error_all_nodes_not_available_text, Error_all_nodes_not_available_value)
			Result.force (Error_resource_failed_text, Error_resource_failed_value)
			Result.force (Error_cluster_invalid_node_text, Error_cluster_invalid_node_value)
			Result.force (Error_cluster_node_exists_text, Error_cluster_node_exists_value)
			Result.force (Error_cluster_join_in_progress_text, Error_cluster_join_in_progress_value)
			Result.force (Error_cluster_node_not_found_text, Error_cluster_node_not_found_value)
			Result.force (Error_cluster_local_node_not_found_text, Error_cluster_local_node_not_found_value)
			Result.force (Error_cluster_network_exists_text, Error_cluster_network_exists_value)
			Result.force (Error_cluster_network_not_found_text, Error_cluster_network_not_found_value)
			Result.force (Error_cluster_netinterface_exists_text, Error_cluster_netinterface_exists_value)
			Result.force (Error_cluster_netinterface_not_found_text, Error_cluster_netinterface_not_found_value)
			Result.force (Error_cluster_invalid_request_text, Error_cluster_invalid_request_value)
			Result.force (Error_cluster_invalid_network_provider_text, Error_cluster_invalid_network_provider_value)
			Result.force (Error_cluster_node_down_text, Error_cluster_node_down_value)
			Result.force (Error_cluster_node_unreachable_text, Error_cluster_node_unreachable_value)
			Result.force (Error_cluster_node_not_member_text, Error_cluster_node_not_member_value)
			Result.force (Error_cluster_join_not_in_progress_text, Error_cluster_join_not_in_progress_value)
			Result.force (Error_cluster_invalid_network_text, Error_cluster_invalid_network_value)
			Result.force (Error_cluster_node_up_text, Error_cluster_node_up_value)
			Result.force (Error_cluster_ipaddr_in_use_text, Error_cluster_ipaddr_in_use_value)
			Result.force (Error_cluster_node_not_paused_text, Error_cluster_node_not_paused_value)
			Result.force (Error_cluster_no_security_context_text, Error_cluster_no_security_context_value)
			Result.force (Error_cluster_network_not_internal_text, Error_cluster_network_not_internal_value)
			Result.force (Error_cluster_node_already_up_text, Error_cluster_node_already_up_value)
			Result.force (Error_cluster_node_already_down_text, Error_cluster_node_already_down_value)
			Result.force (Error_cluster_network_already_online_text, Error_cluster_network_already_online_value)
			Result.force (Error_cluster_network_already_offline_text, Error_cluster_network_already_offline_value)
			Result.force (Error_cluster_node_already_member_text, Error_cluster_node_already_member_value)
			Result.force (Error_cluster_last_internal_network_text, Error_cluster_last_internal_network_value)
			Result.force (Error_cluster_network_has_dependents_text, Error_cluster_network_has_dependents_value)
			Result.force (Error_invalid_operation_on_quorum_text, Error_invalid_operation_on_quorum_value)
			Result.force (Error_dependency_not_allowed_text, Error_dependency_not_allowed_value)
			Result.force (Error_cluster_node_paused_text, Error_cluster_node_paused_value)
			Result.force (Error_node_cant_host_resource_text, Error_node_cant_host_resource_value)
			Result.force (Error_cluster_node_not_ready_text, Error_cluster_node_not_ready_value)
			Result.force (Error_cluster_node_shutting_down_text, Error_cluster_node_shutting_down_value)
			Result.force (Error_cluster_join_aborted_text, Error_cluster_join_aborted_value)
			Result.force (Error_cluster_incompatible_versions_text, Error_cluster_incompatible_versions_value)
			Result.force (Error_cluster_maxnum_of_resources_exceeded_text, Error_cluster_maxnum_of_resources_exceeded_value)
			Result.force (Error_cluster_system_config_changed_text, Error_cluster_system_config_changed_value)
			Result.force (Error_cluster_resource_type_not_found_text, Error_cluster_resource_type_not_found_value)
			Result.force (Error_cluster_restype_not_supported_text, Error_cluster_restype_not_supported_value)
			Result.force (Error_cluster_resname_not_found_text, Error_cluster_resname_not_found_value)
			Result.force (Error_cluster_no_rpc_packages_registered_text, Error_cluster_no_rpc_packages_registered_value)
			Result.force (Error_cluster_owner_not_in_preflist_text, Error_cluster_owner_not_in_preflist_value)
			Result.force (Error_cluster_database_seqmismatch_text, Error_cluster_database_seqmismatch_value)
			Result.force (Error_resmon_invalid_state_text, Error_resmon_invalid_state_value)
			Result.force (Error_cluster_gum_not_locker_text, Error_cluster_gum_not_locker_value)
			Result.force (Error_quorum_disk_not_found_text, Error_quorum_disk_not_found_value)
			Result.force (Error_database_backup_corrupt_text, Error_database_backup_corrupt_value)
			Result.force (Error_cluster_node_already_has_dfs_root_text, Error_cluster_node_already_has_dfs_root_value)
			Result.force (Error_resource_property_unchangeable_text, Error_resource_property_unchangeable_value)
			Result.force (Error_encryption_failed_text, Error_encryption_failed_value)
			Result.force (Error_decryption_failed_text, Error_decryption_failed_value)
			Result.force (Error_file_encrypted_text, Error_file_encrypted_value)
			Result.force (Error_no_recovery_policy_text, Error_no_recovery_policy_value)
			Result.force (Error_no_efs_text, Error_no_efs_value)
			Result.force (Error_wrong_efs_text, Error_wrong_efs_value)
			Result.force (Error_no_user_keys_text, Error_no_user_keys_value)
			Result.force (Error_file_not_encrypted_text, Error_file_not_encrypted_value)
			Result.force (Error_not_export_format_text, Error_not_export_format_value)
			Result.force (Error_file_read_only_text, Error_file_read_only_value)
			Result.force (Error_dir_efs_disallowed_text, Error_dir_efs_disallowed_value)
			Result.force (Error_efs_server_not_trusted_text, Error_efs_server_not_trusted_value)
			Result.force (Sched_e_service_not_localsystem_text, Sched_e_service_not_localsystem_value)
			Result.force (Error_ctx_winstation_name_invalid_text, Error_ctx_winstation_name_invalid_value)
			Result.force (Error_ctx_invalid_pd_text, Error_ctx_invalid_pd_value)
			Result.force (Error_ctx_pd_not_found_text, Error_ctx_pd_not_found_value)
			Result.force (Error_ctx_wd_not_found_text, Error_ctx_wd_not_found_value)
			Result.force (Error_ctx_cannot_make_eventlog_entry_text, Error_ctx_cannot_make_eventlog_entry_value)
			Result.force (Error_ctx_service_name_collision_text, Error_ctx_service_name_collision_value)
			Result.force (Error_ctx_close_pending_text, Error_ctx_close_pending_value)
			Result.force (Error_ctx_no_outbuf_text, Error_ctx_no_outbuf_value)
			Result.force (Error_ctx_modem_inf_not_found_text, Error_ctx_modem_inf_not_found_value)
			Result.force (Error_ctx_invalid_modemname_text, Error_ctx_invalid_modemname_value)
			Result.force (Error_ctx_modem_response_error_text, Error_ctx_modem_response_error_value)
			Result.force (Error_ctx_modem_response_timeout_text, Error_ctx_modem_response_timeout_value)
			Result.force (Error_ctx_modem_response_no_carrier_text, Error_ctx_modem_response_no_carrier_value)
			Result.force (Error_ctx_modem_response_no_dialtone_text, Error_ctx_modem_response_no_dialtone_value)
			Result.force (Error_ctx_modem_response_busy_text, Error_ctx_modem_response_busy_value)
			Result.force (Error_ctx_modem_response_voice_text, Error_ctx_modem_response_voice_value)
			Result.force (Error_ctx_td_error_text, Error_ctx_td_error_value)
			Result.force (Error_ctx_winstation_not_found_text, Error_ctx_winstation_not_found_value)
			Result.force (Error_ctx_winstation_already_exists_text, Error_ctx_winstation_already_exists_value)
			Result.force (Error_ctx_winstation_busy_text, Error_ctx_winstation_busy_value)
			Result.force (Error_ctx_bad_video_mode_text, Error_ctx_bad_video_mode_value)
			Result.force (Error_ctx_graphics_invalid_text, Error_ctx_graphics_invalid_value)
			Result.force (Error_ctx_logon_disabled_text, Error_ctx_logon_disabled_value)
			Result.force (Error_ctx_not_console_text, Error_ctx_not_console_value)
			Result.force (Error_ctx_client_query_timeout_text, Error_ctx_client_query_timeout_value)
			Result.force (Error_ctx_console_disconnect_text, Error_ctx_console_disconnect_value)
			Result.force (Error_ctx_console_connect_text, Error_ctx_console_connect_value)
			Result.force (Error_ctx_shadow_denied_text, Error_ctx_shadow_denied_value)
			Result.force (Error_ctx_winstation_access_denied_text, Error_ctx_winstation_access_denied_value)
			Result.force (Error_ctx_invalid_wd_text, Error_ctx_invalid_wd_value)
			Result.force (Error_ctx_shadow_invalid_text, Error_ctx_shadow_invalid_value)
			Result.force (Error_ctx_shadow_disabled_text, Error_ctx_shadow_disabled_value)
			Result.force (Error_ctx_client_license_in_use_text, Error_ctx_client_license_in_use_value)
			Result.force (Error_ctx_client_license_not_set_text, Error_ctx_client_license_not_set_value)
			Result.force (Error_ctx_license_not_available_text, Error_ctx_license_not_available_value)
			Result.force (Error_ctx_license_client_invalid_text, Error_ctx_license_client_invalid_value)
			Result.force (Error_ctx_license_expired_text, Error_ctx_license_expired_value)
			Result.force (Frs_err_invalid_api_sequence_text, Frs_err_invalid_api_sequence_value)
			Result.force (Frs_err_starting_service_text, Frs_err_starting_service_value)
			Result.force (Frs_err_stopping_service_text, Frs_err_stopping_service_value)
			Result.force (Frs_err_internal_api_text, Frs_err_internal_api_value)
			Result.force (Frs_err_internal_text, Frs_err_internal_value)
			Result.force (Frs_err_service_comm_text, Frs_err_service_comm_value)
			Result.force (Frs_err_insufficient_priv_text, Frs_err_insufficient_priv_value)
			Result.force (Frs_err_authentication_text, Frs_err_authentication_value)
			Result.force (Frs_err_parent_insufficient_priv_text, Frs_err_parent_insufficient_priv_value)
			Result.force (Frs_err_parent_authentication_text, Frs_err_parent_authentication_value)
			Result.force (Frs_err_child_to_parent_comm_text, Frs_err_child_to_parent_comm_value)
			Result.force (Frs_err_parent_to_child_comm_text, Frs_err_parent_to_child_comm_value)
			Result.force (Frs_err_sysvol_populate_text, Frs_err_sysvol_populate_value)
			Result.force (Frs_err_sysvol_populate_timeout_text, Frs_err_sysvol_populate_timeout_value)
			Result.force (Frs_err_sysvol_is_busy_text, Frs_err_sysvol_is_busy_value)
			Result.force (Frs_err_sysvol_demote_text, Frs_err_sysvol_demote_value)
			Result.force (Frs_err_invalid_service_parameter_text, Frs_err_invalid_service_parameter_value)
			Result.force (Error_ds_not_installed_text, Error_ds_not_installed_value)
			Result.force (Error_ds_membership_evaluated_locally_text, Error_ds_membership_evaluated_locally_value)
			Result.force (Error_ds_no_attribute_or_value_text, Error_ds_no_attribute_or_value_value)
			Result.force (Error_ds_invalid_attribute_syntax_text, Error_ds_invalid_attribute_syntax_value)
			Result.force (Error_ds_attribute_type_undefined_text, Error_ds_attribute_type_undefined_value)
			Result.force (Error_ds_attribute_or_value_exists_text, Error_ds_attribute_or_value_exists_value)
			Result.force (Error_ds_busy_text, Error_ds_busy_value)
			Result.force (Error_ds_unavailable_text, Error_ds_unavailable_value)
			Result.force (Error_ds_no_rids_allocated_text, Error_ds_no_rids_allocated_value)
			Result.force (Error_ds_no_more_rids_text, Error_ds_no_more_rids_value)
			Result.force (Error_ds_incorrect_role_owner_text, Error_ds_incorrect_role_owner_value)
			Result.force (Error_ds_ridmgr_init_error_text, Error_ds_ridmgr_init_error_value)
			Result.force (Error_ds_obj_class_violation_text, Error_ds_obj_class_violation_value)
			Result.force (Error_ds_cant_on_non_leaf_text, Error_ds_cant_on_non_leaf_value)
			Result.force (Error_ds_cant_on_rdn_text, Error_ds_cant_on_rdn_value)
			Result.force (Error_ds_cant_mod_obj_class_text, Error_ds_cant_mod_obj_class_value)
			Result.force (Error_ds_cross_dom_move_error_text, Error_ds_cross_dom_move_error_value)
			Result.force (Error_ds_gc_not_available_text, Error_ds_gc_not_available_value)
			Result.force (Error_shared_policy_text, Error_shared_policy_value)
			Result.force (Error_policy_object_not_found_text, Error_policy_object_not_found_value)
			Result.force (Error_policy_only_in_ds_text, Error_policy_only_in_ds_value)
			Result.force (Error_promotion_active_text, Error_promotion_active_value)
			Result.force (Error_no_promotion_active_text, Error_no_promotion_active_value)
			Result.force (Error_ds_operations_error_text, Error_ds_operations_error_value)
			Result.force (Error_ds_protocol_error_text, Error_ds_protocol_error_value)
			Result.force (Error_ds_timelimit_exceeded_text, Error_ds_timelimit_exceeded_value)
			Result.force (Error_ds_sizelimit_exceeded_text, Error_ds_sizelimit_exceeded_value)
			Result.force (Error_ds_admin_limit_exceeded_text, Error_ds_admin_limit_exceeded_value)
			Result.force (Error_ds_compare_false_text, Error_ds_compare_false_value)
			Result.force (Error_ds_compare_true_text, Error_ds_compare_true_value)
			Result.force (Error_ds_auth_method_not_supported_text, Error_ds_auth_method_not_supported_value)
			Result.force (Error_ds_strong_auth_required_text, Error_ds_strong_auth_required_value)
			Result.force (Error_ds_inappropriate_auth_text, Error_ds_inappropriate_auth_value)
			Result.force (Error_ds_auth_unknown_text, Error_ds_auth_unknown_value)
			Result.force (Error_ds_referral_text, Error_ds_referral_value)
			Result.force (Error_ds_unavailable_crit_extension_text, Error_ds_unavailable_crit_extension_value)
			Result.force (Error_ds_confidentiality_required_text, Error_ds_confidentiality_required_value)
			Result.force (Error_ds_inappropriate_matching_text, Error_ds_inappropriate_matching_value)
			Result.force (Error_ds_constraint_violation_text, Error_ds_constraint_violation_value)
			Result.force (Error_ds_no_such_object_text, Error_ds_no_such_object_value)
			Result.force (Error_ds_alias_problem_text, Error_ds_alias_problem_value)
			Result.force (Error_ds_invalid_dn_syntax_text, Error_ds_invalid_dn_syntax_value)
			Result.force (Error_ds_is_leaf_text, Error_ds_is_leaf_value)
			Result.force (Error_ds_alias_deref_problem_text, Error_ds_alias_deref_problem_value)
			Result.force (Error_ds_unwilling_to_perform_text, Error_ds_unwilling_to_perform_value)
			Result.force (Error_ds_loop_detect_text, Error_ds_loop_detect_value)
			Result.force (Error_ds_naming_violation_text, Error_ds_naming_violation_value)
			Result.force (Error_ds_object_results_too_large_text, Error_ds_object_results_too_large_value)
			Result.force (Error_ds_affects_multiple_dsas_text, Error_ds_affects_multiple_dsas_value)
			Result.force (Error_ds_server_down_text, Error_ds_server_down_value)
			Result.force (Error_ds_local_error_text, Error_ds_local_error_value)
			Result.force (Error_ds_encoding_error_text, Error_ds_encoding_error_value)
			Result.force (Error_ds_decoding_error_text, Error_ds_decoding_error_value)
			Result.force (Error_ds_filter_unknown_text, Error_ds_filter_unknown_value)
			Result.force (Error_ds_param_error_text, Error_ds_param_error_value)
			Result.force (Error_ds_not_supported_text, Error_ds_not_supported_value)
			Result.force (Error_ds_no_results_returned_text, Error_ds_no_results_returned_value)
			Result.force (Error_ds_control_not_found_text, Error_ds_control_not_found_value)
			Result.force (Error_ds_client_loop_text, Error_ds_client_loop_value)
			Result.force (Error_ds_referral_limit_exceeded_text, Error_ds_referral_limit_exceeded_value)
			Result.force (Error_ds_root_must_be_nc_text, Error_ds_root_must_be_nc_value)
			Result.force (Error_ds_add_replica_inhibited_text, Error_ds_add_replica_inhibited_value)
			Result.force (Error_ds_att_not_def_in_schema_text, Error_ds_att_not_def_in_schema_value)
			Result.force (Error_ds_max_obj_size_exceeded_text, Error_ds_max_obj_size_exceeded_value)
			Result.force (Error_ds_obj_string_name_exists_text, Error_ds_obj_string_name_exists_value)
			Result.force (Error_ds_no_rdn_defined_in_schema_text, Error_ds_no_rdn_defined_in_schema_value)
			Result.force (Error_ds_rdn_doesnt_match_schema_text, Error_ds_rdn_doesnt_match_schema_value)
			Result.force (Error_ds_no_requested_atts_found_text, Error_ds_no_requested_atts_found_value)
			Result.force (Error_ds_user_buffer_to_small_text, Error_ds_user_buffer_to_small_value)
			Result.force (Error_ds_att_is_not_on_obj_text, Error_ds_att_is_not_on_obj_value)
			Result.force (Error_ds_illegal_mod_operation_text, Error_ds_illegal_mod_operation_value)
			Result.force (Error_ds_obj_too_large_text, Error_ds_obj_too_large_value)
			Result.force (Error_ds_bad_instance_type_text, Error_ds_bad_instance_type_value)
			Result.force (Error_ds_masterdsa_required_text, Error_ds_masterdsa_required_value)
			Result.force (Error_ds_object_class_required_text, Error_ds_object_class_required_value)
			Result.force (Error_ds_missing_required_att_text, Error_ds_missing_required_att_value)
			Result.force (Error_ds_att_not_def_for_class_text, Error_ds_att_not_def_for_class_value)
			Result.force (Error_ds_att_already_exists_text, Error_ds_att_already_exists_value)
			Result.force (Error_ds_cant_add_att_values_text, Error_ds_cant_add_att_values_value)
			Result.force (Error_ds_single_value_constraint_text, Error_ds_single_value_constraint_value)
			Result.force (Error_ds_range_constraint_text, Error_ds_range_constraint_value)
			Result.force (Error_ds_att_val_already_exists_text, Error_ds_att_val_already_exists_value)
			Result.force (Error_ds_cant_rem_missing_att_text, Error_ds_cant_rem_missing_att_value)
			Result.force (Error_ds_cant_rem_missing_att_val_text, Error_ds_cant_rem_missing_att_val_value)
			Result.force (Error_ds_root_cant_be_subref_text, Error_ds_root_cant_be_subref_value)
			Result.force (Error_ds_no_chaining_text, Error_ds_no_chaining_value)
			Result.force (Error_ds_no_chained_eval_text, Error_ds_no_chained_eval_value)
			Result.force (Error_ds_no_parent_object_text, Error_ds_no_parent_object_value)
			Result.force (Error_ds_parent_is_an_alias_text, Error_ds_parent_is_an_alias_value)
			Result.force (Error_ds_cant_mix_master_and_reps_text, Error_ds_cant_mix_master_and_reps_value)
			Result.force (Error_ds_children_exist_text, Error_ds_children_exist_value)
			Result.force (Error_ds_obj_not_found_text, Error_ds_obj_not_found_value)
			Result.force (Error_ds_aliased_obj_missing_text, Error_ds_aliased_obj_missing_value)
			Result.force (Error_ds_bad_name_syntax_text, Error_ds_bad_name_syntax_value)
			Result.force (Error_ds_alias_points_to_alias_text, Error_ds_alias_points_to_alias_value)
			Result.force (Error_ds_cant_deref_alias_text, Error_ds_cant_deref_alias_value)
			Result.force (Error_ds_out_of_scope_text, Error_ds_out_of_scope_value)
			Result.force (Error_ds_cant_delete_dsa_obj_text, Error_ds_cant_delete_dsa_obj_value)
			Result.force (Error_ds_generic_error_text, Error_ds_generic_error_value)
			Result.force (Error_ds_dsa_must_be_int_master_text, Error_ds_dsa_must_be_int_master_value)
			Result.force (Error_ds_class_not_dsa_text, Error_ds_class_not_dsa_value)
			Result.force (Error_ds_insuff_access_rights_text, Error_ds_insuff_access_rights_value)
			Result.force (Error_ds_illegal_superior_text, Error_ds_illegal_superior_value)
			Result.force (Error_ds_attribute_owned_by_sam_text, Error_ds_attribute_owned_by_sam_value)
			Result.force (Error_ds_name_too_many_parts_text, Error_ds_name_too_many_parts_value)
			Result.force (Error_ds_name_too_long_text, Error_ds_name_too_long_value)
			Result.force (Error_ds_name_value_too_long_text, Error_ds_name_value_too_long_value)
			Result.force (Error_ds_name_unparseable_text, Error_ds_name_unparseable_value)
			Result.force (Error_ds_name_type_unknown_text, Error_ds_name_type_unknown_value)
			Result.force (Error_ds_not_an_object_text, Error_ds_not_an_object_value)
			Result.force (Error_ds_sec_desc_too_short_text, Error_ds_sec_desc_too_short_value)
			Result.force (Error_ds_sec_desc_invalid_text, Error_ds_sec_desc_invalid_value)
			Result.force (Error_ds_no_deleted_name_text, Error_ds_no_deleted_name_value)
			Result.force (Error_ds_subref_must_have_parent_text, Error_ds_subref_must_have_parent_value)
			Result.force (Error_ds_ncname_must_be_nc_text, Error_ds_ncname_must_be_nc_value)
			Result.force (Error_ds_cant_add_system_only_text, Error_ds_cant_add_system_only_value)
			Result.force (Error_ds_class_must_be_concrete_text, Error_ds_class_must_be_concrete_value)
			Result.force (Error_ds_invalid_dmd_text, Error_ds_invalid_dmd_value)
			Result.force (Error_ds_obj_guid_exists_text, Error_ds_obj_guid_exists_value)
			Result.force (Error_ds_not_on_backlink_text, Error_ds_not_on_backlink_value)
			Result.force (Error_ds_no_crossref_for_nc_text, Error_ds_no_crossref_for_nc_value)
			Result.force (Error_ds_shutting_down_text, Error_ds_shutting_down_value)
			Result.force (Error_ds_unknown_operation_text, Error_ds_unknown_operation_value)
			Result.force (Error_ds_invalid_role_owner_text, Error_ds_invalid_role_owner_value)
			Result.force (Error_ds_couldnt_contact_fsmo_text, Error_ds_couldnt_contact_fsmo_value)
			Result.force (Error_ds_cross_nc_dn_rename_text, Error_ds_cross_nc_dn_rename_value)
			Result.force (Error_ds_cant_mod_system_only_text, Error_ds_cant_mod_system_only_value)
			Result.force (Error_ds_replicator_only_text, Error_ds_replicator_only_value)
			Result.force (Error_ds_obj_class_not_defined_text, Error_ds_obj_class_not_defined_value)
			Result.force (Error_ds_obj_class_not_subclass_text, Error_ds_obj_class_not_subclass_value)
			Result.force (Error_ds_name_reference_invalid_text, Error_ds_name_reference_invalid_value)
			Result.force (Error_ds_cross_ref_exists_text, Error_ds_cross_ref_exists_value)
			Result.force (Error_ds_cant_del_master_crossref_text, Error_ds_cant_del_master_crossref_value)
			Result.force (Error_ds_subtree_notify_not_nc_head_text, Error_ds_subtree_notify_not_nc_head_value)
			Result.force (Error_ds_notify_filter_too_complex_text, Error_ds_notify_filter_too_complex_value)
			Result.force (Error_ds_dup_rdn_text, Error_ds_dup_rdn_value)
			Result.force (Error_ds_dup_oid_text, Error_ds_dup_oid_value)
			Result.force (Error_ds_dup_mapi_id_text, Error_ds_dup_mapi_id_value)
			Result.force (Error_ds_dup_schema_id_guid_text, Error_ds_dup_schema_id_guid_value)
			Result.force (Error_ds_dup_ldap_display_name_text, Error_ds_dup_ldap_display_name_value)
			Result.force (Error_ds_semantic_att_test_text, Error_ds_semantic_att_test_value)
			Result.force (Error_ds_syntax_mismatch_text, Error_ds_syntax_mismatch_value)
			Result.force (Error_ds_exists_in_must_have_text, Error_ds_exists_in_must_have_value)
			Result.force (Error_ds_exists_in_may_have_text, Error_ds_exists_in_may_have_value)
			Result.force (Error_ds_nonexistent_may_have_text, Error_ds_nonexistent_may_have_value)
			Result.force (Error_ds_nonexistent_must_have_text, Error_ds_nonexistent_must_have_value)
			Result.force (Error_ds_aux_cls_test_fail_text, Error_ds_aux_cls_test_fail_value)
			Result.force (Error_ds_nonexistent_poss_sup_text, Error_ds_nonexistent_poss_sup_value)
			Result.force (Error_ds_sub_cls_test_fail_text, Error_ds_sub_cls_test_fail_value)
			Result.force (Error_ds_bad_rdn_att_id_syntax_text, Error_ds_bad_rdn_att_id_syntax_value)
			Result.force (Error_ds_exists_in_aux_cls_text, Error_ds_exists_in_aux_cls_value)
			Result.force (Error_ds_exists_in_sub_cls_text, Error_ds_exists_in_sub_cls_value)
			Result.force (Error_ds_exists_in_poss_sup_text, Error_ds_exists_in_poss_sup_value)
			Result.force (Error_ds_recalcschema_failed_text, Error_ds_recalcschema_failed_value)
			Result.force (Error_ds_tree_delete_not_finished_text, Error_ds_tree_delete_not_finished_value)
			Result.force (Error_ds_cant_delete_text, Error_ds_cant_delete_value)
			Result.force (Error_ds_att_schema_req_id_text, Error_ds_att_schema_req_id_value)
			Result.force (Error_ds_bad_att_schema_syntax_text, Error_ds_bad_att_schema_syntax_value)
			Result.force (Error_ds_cant_cache_att_text, Error_ds_cant_cache_att_value)
			Result.force (Error_ds_cant_cache_class_text, Error_ds_cant_cache_class_value)
			Result.force (Error_ds_cant_remove_att_cache_text, Error_ds_cant_remove_att_cache_value)
			Result.force (Error_ds_cant_remove_class_cache_text, Error_ds_cant_remove_class_cache_value)
			Result.force (Error_ds_cant_retrieve_dn_text, Error_ds_cant_retrieve_dn_value)
			Result.force (Error_ds_missing_supref_text, Error_ds_missing_supref_value)
			Result.force (Error_ds_cant_retrieve_instance_text, Error_ds_cant_retrieve_instance_value)
			Result.force (Error_ds_code_inconsistency_text, Error_ds_code_inconsistency_value)
			Result.force (Error_ds_database_error_text, Error_ds_database_error_value)
			Result.force (Error_ds_governsid_missing_text, Error_ds_governsid_missing_value)
			Result.force (Error_ds_missing_expected_att_text, Error_ds_missing_expected_att_value)
			Result.force (Error_ds_ncname_missing_cr_ref_text, Error_ds_ncname_missing_cr_ref_value)
			Result.force (Error_ds_security_checking_error_text, Error_ds_security_checking_error_value)
			Result.force (Error_ds_schema_not_loaded_text, Error_ds_schema_not_loaded_value)
			Result.force (Error_ds_schema_alloc_failed_text, Error_ds_schema_alloc_failed_value)
			Result.force (Error_ds_att_schema_req_syntax_text, Error_ds_att_schema_req_syntax_value)
			Result.force (Error_ds_gcverify_error_text, Error_ds_gcverify_error_value)
			Result.force (Error_ds_dra_schema_mismatch_text, Error_ds_dra_schema_mismatch_value)
			Result.force (Error_ds_cant_find_dsa_obj_text, Error_ds_cant_find_dsa_obj_value)
			Result.force (Error_ds_cant_find_expected_nc_text, Error_ds_cant_find_expected_nc_value)
			Result.force (Error_ds_cant_find_nc_in_cache_text, Error_ds_cant_find_nc_in_cache_value)
			Result.force (Error_ds_cant_retrieve_child_text, Error_ds_cant_retrieve_child_value)
			Result.force (Error_ds_security_illegal_modify_text, Error_ds_security_illegal_modify_value)
			Result.force (Error_ds_cant_replace_hidden_rec_text, Error_ds_cant_replace_hidden_rec_value)
			Result.force (Error_ds_bad_hierarchy_file_text, Error_ds_bad_hierarchy_file_value)
			Result.force (Error_ds_build_hierarchy_table_failed_text, Error_ds_build_hierarchy_table_failed_value)
			Result.force (Error_ds_config_param_missing_text, Error_ds_config_param_missing_value)
			Result.force (Error_ds_counting_ab_indices_failed_text, Error_ds_counting_ab_indices_failed_value)
			Result.force (Error_ds_hierarchy_table_malloc_failed_text, Error_ds_hierarchy_table_malloc_failed_value)
			Result.force (Error_ds_internal_failure_text, Error_ds_internal_failure_value)
			Result.force (Error_ds_unknown_error_text, Error_ds_unknown_error_value)
			Result.force (Error_ds_root_requires_class_top_text, Error_ds_root_requires_class_top_value)
			Result.force (Error_ds_refusing_fsmo_roles_text, Error_ds_refusing_fsmo_roles_value)
			Result.force (Error_ds_missing_fsmo_settings_text, Error_ds_missing_fsmo_settings_value)
			Result.force (Error_ds_unable_to_surrender_roles_text, Error_ds_unable_to_surrender_roles_value)
			Result.force (Error_ds_dra_generic_text, Error_ds_dra_generic_value)
			Result.force (Error_ds_dra_invalid_parameter_text, Error_ds_dra_invalid_parameter_value)
			Result.force (Error_ds_dra_busy_text, Error_ds_dra_busy_value)
			Result.force (Error_ds_dra_bad_dn_text, Error_ds_dra_bad_dn_value)
			Result.force (Error_ds_dra_bad_nc_text, Error_ds_dra_bad_nc_value)
			Result.force (Error_ds_dra_dn_exists_text, Error_ds_dra_dn_exists_value)
			Result.force (Error_ds_dra_internal_error_text, Error_ds_dra_internal_error_value)
			Result.force (Error_ds_dra_inconsistent_dit_text, Error_ds_dra_inconsistent_dit_value)
			Result.force (Error_ds_dra_connection_failed_text, Error_ds_dra_connection_failed_value)
			Result.force (Error_ds_dra_bad_instance_type_text, Error_ds_dra_bad_instance_type_value)
			Result.force (Error_ds_dra_out_of_mem_text, Error_ds_dra_out_of_mem_value)
			Result.force (Error_ds_dra_mail_problem_text, Error_ds_dra_mail_problem_value)
			Result.force (Error_ds_dra_ref_already_exists_text, Error_ds_dra_ref_already_exists_value)
			Result.force (Error_ds_dra_ref_not_found_text, Error_ds_dra_ref_not_found_value)
			Result.force (Error_ds_dra_obj_is_rep_source_text, Error_ds_dra_obj_is_rep_source_value)
			Result.force (Error_ds_dra_db_error_text, Error_ds_dra_db_error_value)
			Result.force (Error_ds_dra_no_replica_text, Error_ds_dra_no_replica_value)
			Result.force (Error_ds_dra_access_denied_text, Error_ds_dra_access_denied_value)
			Result.force (Error_ds_dra_not_supported_text, Error_ds_dra_not_supported_value)
			Result.force (Error_ds_dra_rpc_cancelled_text, Error_ds_dra_rpc_cancelled_value)
			Result.force (Error_ds_dra_source_disabled_text, Error_ds_dra_source_disabled_value)
			Result.force (Error_ds_dra_sink_disabled_text, Error_ds_dra_sink_disabled_value)
			Result.force (Error_ds_dra_name_collision_text, Error_ds_dra_name_collision_value)
			Result.force (Error_ds_dra_source_reinstalled_text, Error_ds_dra_source_reinstalled_value)
			Result.force (Error_ds_dra_missing_parent_text, Error_ds_dra_missing_parent_value)
			Result.force (Error_ds_dra_preempted_text, Error_ds_dra_preempted_value)
			Result.force (Error_ds_dra_abandon_sync_text, Error_ds_dra_abandon_sync_value)
			Result.force (Error_ds_dra_shutdown_text, Error_ds_dra_shutdown_value)
			Result.force (Error_ds_dra_incompatible_partial_set_text, Error_ds_dra_incompatible_partial_set_value)
			Result.force (Error_ds_dra_source_is_partial_replica_text, Error_ds_dra_source_is_partial_replica_value)
			Result.force (Error_ds_dra_extn_connection_failed_text, Error_ds_dra_extn_connection_failed_value)
			Result.force (Error_ds_install_schema_mismatch_text, Error_ds_install_schema_mismatch_value)
			Result.force (Error_ds_dup_link_id_text, Error_ds_dup_link_id_value)
			Result.force (Error_ds_name_error_resolving_text, Error_ds_name_error_resolving_value)
			Result.force (Error_ds_name_error_not_found_text, Error_ds_name_error_not_found_value)
			Result.force (Error_ds_name_error_not_unique_text, Error_ds_name_error_not_unique_value)
			Result.force (Error_ds_name_error_no_mapping_text, Error_ds_name_error_no_mapping_value)
			Result.force (Error_ds_name_error_domain_only_text, Error_ds_name_error_domain_only_value)
			Result.force (Error_ds_name_error_no_syntactical_mapping_text, Error_ds_name_error_no_syntactical_mapping_value)
			Result.force (Error_ds_constructed_att_mod_text, Error_ds_constructed_att_mod_value)
			Result.force (Error_ds_wrong_om_obj_class_text, Error_ds_wrong_om_obj_class_value)
			Result.force (Error_ds_dra_repl_pending_text, Error_ds_dra_repl_pending_value)
			Result.force (Error_ds_ds_required_text, Error_ds_ds_required_value)
			Result.force (Error_ds_invalid_ldap_display_name_text, Error_ds_invalid_ldap_display_name_value)
			Result.force (Error_ds_non_base_search_text, Error_ds_non_base_search_value)
			Result.force (Error_ds_cant_retrieve_atts_text, Error_ds_cant_retrieve_atts_value)
			Result.force (Error_ds_backlink_without_link_text, Error_ds_backlink_without_link_value)
			Result.force (Error_ds_epoch_mismatch_text, Error_ds_epoch_mismatch_value)
			Result.force (Error_ds_src_name_mismatch_text, Error_ds_src_name_mismatch_value)
			Result.force (Error_ds_src_and_dst_nc_identical_text, Error_ds_src_and_dst_nc_identical_value)
			Result.force (Error_ds_dst_nc_mismatch_text, Error_ds_dst_nc_mismatch_value)
			Result.force (Error_ds_not_authoritive_for_dst_nc_text, Error_ds_not_authoritive_for_dst_nc_value)
			Result.force (Error_ds_src_guid_mismatch_text, Error_ds_src_guid_mismatch_value)
			Result.force (Error_ds_cant_move_deleted_object_text, Error_ds_cant_move_deleted_object_value)
			Result.force (Error_ds_pdc_operation_in_progress_text, Error_ds_pdc_operation_in_progress_value)
			Result.force (Error_ds_cross_domain_cleanup_reqd_text, Error_ds_cross_domain_cleanup_reqd_value)
			Result.force (Error_ds_illegal_xdom_move_operation_text, Error_ds_illegal_xdom_move_operation_value)
			Result.force (Error_ds_cant_with_acct_group_membershps_text, Error_ds_cant_with_acct_group_membershps_value)
			Result.force (Error_ds_nc_must_have_nc_parent_text, Error_ds_nc_must_have_nc_parent_value)
			Result.force (Error_ds_cr_impossible_to_validate_text, Error_ds_cr_impossible_to_validate_value)
			Result.force (Error_ds_dst_domain_not_native_text, Error_ds_dst_domain_not_native_value)
			Result.force (Error_ds_missing_infrastructure_container_text, Error_ds_missing_infrastructure_container_value)
			Result.force (Error_ds_cant_move_account_group_text, Error_ds_cant_move_account_group_value)
			Result.force (Error_ds_cant_move_resource_group_text, Error_ds_cant_move_resource_group_value)
			Result.force (Error_ds_invalid_search_flag_text, Error_ds_invalid_search_flag_value)
			Result.force (Error_ds_no_tree_delete_above_nc_text, Error_ds_no_tree_delete_above_nc_value)
			Result.force (Error_ds_couldnt_lock_tree_for_delete_text, Error_ds_couldnt_lock_tree_for_delete_value)
			Result.force (Error_ds_couldnt_identify_objects_for_tree_delete_text, Error_ds_couldnt_identify_objects_for_tree_delete_value)
			Result.force (Error_ds_sam_init_failure_text, Error_ds_sam_init_failure_value)
			Result.force (Error_ds_sensitive_group_violation_text, Error_ds_sensitive_group_violation_value)
			Result.force (Error_ds_cant_mod_primarygroupid_text, Error_ds_cant_mod_primarygroupid_value)
			Result.force (Error_ds_illegal_base_schema_mod_text, Error_ds_illegal_base_schema_mod_value)
			Result.force (Error_ds_nonsafe_schema_change_text, Error_ds_nonsafe_schema_change_value)
			Result.force (Error_ds_schema_update_disallowed_text, Error_ds_schema_update_disallowed_value)
			Result.force (Error_ds_cant_create_under_schema_text, Error_ds_cant_create_under_schema_value)
			Result.force (Error_ds_install_no_src_sch_version_text, Error_ds_install_no_src_sch_version_value)
			Result.force (Error_ds_install_no_sch_version_in_inifile_text, Error_ds_install_no_sch_version_in_inifile_value)
			Result.force (Error_ds_invalid_group_type_text, Error_ds_invalid_group_type_value)
			Result.force (Error_ds_no_nest_globalgroup_in_mixeddomain_text, Error_ds_no_nest_globalgroup_in_mixeddomain_value)
			Result.force (Error_ds_no_nest_localgroup_in_mixeddomain_text, Error_ds_no_nest_localgroup_in_mixeddomain_value)
			Result.force (Error_ds_global_cant_have_local_member_text, Error_ds_global_cant_have_local_member_value)
			Result.force (Error_ds_global_cant_have_universal_member_text, Error_ds_global_cant_have_universal_member_value)
			Result.force (Error_ds_universal_cant_have_local_member_text, Error_ds_universal_cant_have_local_member_value)
			Result.force (Error_ds_global_cant_have_crossdomain_member_text, Error_ds_global_cant_have_crossdomain_member_value)
			Result.force (Error_ds_local_cant_have_crossdomain_local_member_text, Error_ds_local_cant_have_crossdomain_local_member_value)
			Result.force (Error_ds_have_primary_members_text, Error_ds_have_primary_members_value)
			Result.force (Error_ds_string_sd_conversion_failed_text, Error_ds_string_sd_conversion_failed_value)
			Result.force (Error_ds_naming_master_gc_text, Error_ds_naming_master_gc_value)
			Result.force (Error_ds_dns_lookup_failure_text, Error_ds_dns_lookup_failure_value)
			Result.force (Error_ds_couldnt_update_spns_text, Error_ds_couldnt_update_spns_value)
			Result.force (Error_ds_cant_retrieve_sd_text, Error_ds_cant_retrieve_sd_value)
			Result.force (Error_ds_key_not_unique_text, Error_ds_key_not_unique_value)
			Result.force (Error_ds_wrong_linked_att_syntax_text, Error_ds_wrong_linked_att_syntax_value)
			Result.force (Error_ds_sam_need_bootkey_password_text, Error_ds_sam_need_bootkey_password_value)
			Result.force (Error_ds_sam_need_bootkey_floppy_text, Error_ds_sam_need_bootkey_floppy_value)
			Result.force (Error_ds_cant_start_text, Error_ds_cant_start_value)
			Result.force (Error_ds_init_failure_text, Error_ds_init_failure_value)
			Result.force (Error_ds_no_pkt_privacy_on_connection_text, Error_ds_no_pkt_privacy_on_connection_value)
			Result.force (Error_ds_source_domain_in_forest_text, Error_ds_source_domain_in_forest_value)
			Result.force (Error_ds_destination_domain_not_in_forest_text, Error_ds_destination_domain_not_in_forest_value)
			Result.force (Error_ds_destination_auditing_not_enabled_text, Error_ds_destination_auditing_not_enabled_value)
			Result.force (Error_ds_cant_find_dc_for_src_domain_text, Error_ds_cant_find_dc_for_src_domain_value)
			Result.force (Error_ds_src_obj_not_group_or_user_text, Error_ds_src_obj_not_group_or_user_value)
			Result.force (Error_ds_src_sid_exists_in_forest_text, Error_ds_src_sid_exists_in_forest_value)
			Result.force (Error_ds_src_and_dst_object_class_mismatch_text, Error_ds_src_and_dst_object_class_mismatch_value)
			Result.force (Error_sam_init_failure_text, Error_sam_init_failure_value)
			Result.force (Error_ds_dra_schema_info_ship_text, Error_ds_dra_schema_info_ship_value)
			Result.force (Error_ds_dra_schema_conflict_text, Error_ds_dra_schema_conflict_value)
			Result.force (Error_ds_dra_earlier_schema_conflict_text, Error_ds_dra_earlier_schema_conflict_value)
			Result.force (Error_ds_dra_obj_nc_mismatch_text, Error_ds_dra_obj_nc_mismatch_value)
			Result.force (Error_ds_nc_still_has_dsas_text, Error_ds_nc_still_has_dsas_value)
			Result.force (Error_ds_gc_required_text, Error_ds_gc_required_value)
			Result.force (Error_ds_local_member_of_local_only_text, Error_ds_local_member_of_local_only_value)
			Result.force (Error_ds_no_fpo_in_universal_groups_text, Error_ds_no_fpo_in_universal_groups_value)
			Result.force (Error_ds_cant_add_to_gc_text, Error_ds_cant_add_to_gc_value)
			Result.force (Error_ds_no_checkpoint_with_pdc_text, Error_ds_no_checkpoint_with_pdc_value)
			Result.force (Error_ds_source_auditing_not_enabled_text, Error_ds_source_auditing_not_enabled_value)
			Result.force (Error_ds_cant_create_in_nondomain_nc_text, Error_ds_cant_create_in_nondomain_nc_value)
			Result.force (Error_ds_invalid_name_for_spn_text, Error_ds_invalid_name_for_spn_value)
			Result.force (Error_ds_filter_uses_contructed_attrs_text, Error_ds_filter_uses_contructed_attrs_value)
			Result.force (Error_ds_unicodepwd_not_in_quotes_text, Error_ds_unicodepwd_not_in_quotes_value)
			Result.force (Error_ds_machine_account_quota_exceeded_text, Error_ds_machine_account_quota_exceeded_value)
			Result.force (Error_ds_must_be_run_on_dst_dc_text, Error_ds_must_be_run_on_dst_dc_value)
			Result.force (Error_ds_src_dc_must_be_sp4_or_greater_text, Error_ds_src_dc_must_be_sp4_or_greater_value)
			Result.force (Error_ds_cant_tree_delete_critical_obj_text, Error_ds_cant_tree_delete_critical_obj_value)
			Result.force (Dns_error_rcode_format_error_text, Dns_error_rcode_format_error_value)
			Result.force (Dns_error_rcode_server_failure_text, Dns_error_rcode_server_failure_value)
			Result.force (Dns_error_rcode_name_error_text, Dns_error_rcode_name_error_value)
			Result.force (Dns_error_rcode_not_implemented_text, Dns_error_rcode_not_implemented_value)
			Result.force (Dns_error_rcode_refused_text, Dns_error_rcode_refused_value)
			Result.force (Dns_error_rcode_yxdomain_text, Dns_error_rcode_yxdomain_value)
			Result.force (Dns_error_rcode_yxrrset_text, Dns_error_rcode_yxrrset_value)
			Result.force (Dns_error_rcode_nxrrset_text, Dns_error_rcode_nxrrset_value)
			Result.force (Dns_error_rcode_notauth_text, Dns_error_rcode_notauth_value)
			Result.force (Dns_error_rcode_notzone_text, Dns_error_rcode_notzone_value)
			Result.force (Dns_error_rcode_badsig_text, Dns_error_rcode_badsig_value)
			Result.force (Dns_error_rcode_badkey_text, Dns_error_rcode_badkey_value)
			Result.force (Dns_error_rcode_badtime_text, Dns_error_rcode_badtime_value)
			Result.force (Dns_info_no_records_text, Dns_info_no_records_value)
			Result.force (Dns_error_bad_packet_text, Dns_error_bad_packet_value)
			Result.force (Dns_error_no_packet_text, Dns_error_no_packet_value)
			Result.force (Dns_error_rcode_text, Dns_error_rcode_value)
			Result.force (Dns_error_unsecure_packet_text, Dns_error_unsecure_packet_value)
			Result.force (Dns_error_invalid_type_text, Dns_error_invalid_type_value)
			Result.force (Dns_error_invalid_ip_address_text, Dns_error_invalid_ip_address_value)
			Result.force (Dns_error_invalid_property_text, Dns_error_invalid_property_value)
			Result.force (Dns_error_try_again_later_text, Dns_error_try_again_later_value)
			Result.force (Dns_error_not_unique_text, Dns_error_not_unique_value)
			Result.force (Dns_error_non_rfc_name_text, Dns_error_non_rfc_name_value)
			Result.force (Dns_status_fqdn_text, Dns_status_fqdn_value)
			Result.force (Dns_status_dotted_name_text, Dns_status_dotted_name_value)
			Result.force (Dns_status_single_part_name_text, Dns_status_single_part_name_value)
			Result.force (Dns_error_invalid_name_char_text, Dns_error_invalid_name_char_value)
			Result.force (Dns_error_numeric_name_text, Dns_error_numeric_name_value)
			Result.force (Dns_error_zone_does_not_exist_text, Dns_error_zone_does_not_exist_value)
			Result.force (Dns_error_no_zone_info_text, Dns_error_no_zone_info_value)
			Result.force (Dns_error_invalid_zone_operation_text, Dns_error_invalid_zone_operation_value)
			Result.force (Dns_error_zone_configuration_error_text, Dns_error_zone_configuration_error_value)
			Result.force (Dns_error_zone_has_no_soa_record_text, Dns_error_zone_has_no_soa_record_value)
			Result.force (Dns_error_zone_has_no_ns_records_text, Dns_error_zone_has_no_ns_records_value)
			Result.force (Dns_error_zone_locked_text, Dns_error_zone_locked_value)
			Result.force (Dns_error_zone_creation_failed_text, Dns_error_zone_creation_failed_value)
			Result.force (Dns_error_zone_already_exists_text, Dns_error_zone_already_exists_value)
			Result.force (Dns_error_autozone_already_exists_text, Dns_error_autozone_already_exists_value)
			Result.force (Dns_error_invalid_zone_type_text, Dns_error_invalid_zone_type_value)
			Result.force (Dns_error_secondary_requires_master_ip_text, Dns_error_secondary_requires_master_ip_value)
			Result.force (Dns_error_zone_not_secondary_text, Dns_error_zone_not_secondary_value)
			Result.force (Dns_error_need_secondary_addresses_text, Dns_error_need_secondary_addresses_value)
			Result.force (Dns_error_wins_init_failed_text, Dns_error_wins_init_failed_value)
			Result.force (Dns_error_need_wins_servers_text, Dns_error_need_wins_servers_value)
			Result.force (Dns_error_nbstat_init_failed_text, Dns_error_nbstat_init_failed_value)
			Result.force (Dns_error_soa_delete_invalid_text, Dns_error_soa_delete_invalid_value)
			Result.force (Dns_error_primary_requires_datafile_text, Dns_error_primary_requires_datafile_value)
			Result.force (Dns_error_invalid_datafile_name_text, Dns_error_invalid_datafile_name_value)
			Result.force (Dns_error_datafile_open_failure_text, Dns_error_datafile_open_failure_value)
			Result.force (Dns_error_file_writeback_failed_text, Dns_error_file_writeback_failed_value)
			Result.force (Dns_error_datafile_parsing_text, Dns_error_datafile_parsing_value)
			Result.force (Dns_error_record_does_not_exist_text, Dns_error_record_does_not_exist_value)
			Result.force (Dns_error_record_format_text, Dns_error_record_format_value)
			Result.force (Dns_error_node_creation_failed_text, Dns_error_node_creation_failed_value)
			Result.force (Dns_error_unknown_record_type_text, Dns_error_unknown_record_type_value)
			Result.force (Dns_error_record_timed_out_text, Dns_error_record_timed_out_value)
			Result.force (Dns_error_name_not_in_zone_text, Dns_error_name_not_in_zone_value)
			Result.force (Dns_error_cname_loop_text, Dns_error_cname_loop_value)
			Result.force (Dns_error_node_is_cname_text, Dns_error_node_is_cname_value)
			Result.force (Dns_error_cname_collision_text, Dns_error_cname_collision_value)
			Result.force (Dns_error_record_only_at_zone_root_text, Dns_error_record_only_at_zone_root_value)
			Result.force (Dns_error_record_already_exists_text, Dns_error_record_already_exists_value)
			Result.force (Dns_error_secondary_data_text, Dns_error_secondary_data_value)
			Result.force (Dns_error_no_create_cache_data_text, Dns_error_no_create_cache_data_value)
			Result.force (Dns_error_name_does_not_exist_text, Dns_error_name_does_not_exist_value)
			Result.force (Dns_warning_ptr_create_failed_text, Dns_warning_ptr_create_failed_value)
			Result.force (Dns_warning_domain_undeleted_text, Dns_warning_domain_undeleted_value)
			Result.force (Dns_error_ds_unavailable_text, Dns_error_ds_unavailable_value)
			Result.force (Dns_error_ds_zone_already_exists_text, Dns_error_ds_zone_already_exists_value)
			Result.force (Dns_error_no_bootfile_if_ds_zone_text, Dns_error_no_bootfile_if_ds_zone_value)
			Result.force (Dns_info_axfr_complete_text, Dns_info_axfr_complete_value)
			Result.force (Dns_error_axfr_text, Dns_error_axfr_value)
			Result.force (Dns_info_added_local_wins_text, Dns_info_added_local_wins_value)
			Result.force (Dns_status_continue_needed_text, Dns_status_continue_needed_value)
			Result.force (Dns_error_no_tcpip_text, Dns_error_no_tcpip_value)
			Result.force (Dns_error_no_dns_servers_text, Dns_error_no_dns_servers_value)
			Result.force (Wsaeintr_text, Wsaeintr_value)
			Result.force (Wsaebadf_text, Wsaebadf_value)
			Result.force (Wsaeacces_text, Wsaeacces_value)
			Result.force (Wsaefault_text, Wsaefault_value)
			Result.force (Wsaeinval_text, Wsaeinval_value)
			Result.force (Wsaemfile_text, Wsaemfile_value)
			Result.force (Wsaewouldblock_text, Wsaewouldblock_value)
			Result.force (Wsaeinprogress_text, Wsaeinprogress_value)
			Result.force (Wsaealready_text, Wsaealready_value)
			Result.force (Wsaenotsock_text, Wsaenotsock_value)
			Result.force (Wsaedestaddrreq_text, Wsaedestaddrreq_value)
			Result.force (Wsaemsgsize_text, Wsaemsgsize_value)
			Result.force (Wsaeprototype_text, Wsaeprototype_value)
			Result.force (Wsaenoprotoopt_text, Wsaenoprotoopt_value)
			Result.force (Wsaeprotonosupport_text, Wsaeprotonosupport_value)
			Result.force (Wsaesocktnosupport_text, Wsaesocktnosupport_value)
			Result.force (Wsaeopnotsupp_text, Wsaeopnotsupp_value)
			Result.force (Wsaepfnosupport_text, Wsaepfnosupport_value)
			Result.force (Wsaeafnosupport_text, Wsaeafnosupport_value)
			Result.force (Wsaeaddrinuse_text, Wsaeaddrinuse_value)
			Result.force (Wsaeaddrnotavail_text, Wsaeaddrnotavail_value)
			Result.force (Wsaenetdown_text, Wsaenetdown_value)
			Result.force (Wsaenetunreach_text, Wsaenetunreach_value)
			Result.force (Wsaenetreset_text, Wsaenetreset_value)
			Result.force (Wsaeconnaborted_text, Wsaeconnaborted_value)
			Result.force (Wsaeconnreset_text, Wsaeconnreset_value)
			Result.force (Wsaenobufs_text, Wsaenobufs_value)
			Result.force (Wsaeisconn_text, Wsaeisconn_value)
			Result.force (Wsaenotconn_text, Wsaenotconn_value)
			Result.force (Wsaeshutdown_text, Wsaeshutdown_value)
			Result.force (Wsaetoomanyrefs_text, Wsaetoomanyrefs_value)
			Result.force (Wsaetimedout_text, Wsaetimedout_value)
			Result.force (Wsaeconnrefused_text, Wsaeconnrefused_value)
			Result.force (Wsaeloop_text, Wsaeloop_value)
			Result.force (Wsaenametoolong_text, Wsaenametoolong_value)
			Result.force (Wsaehostdown_text, Wsaehostdown_value)
			Result.force (Wsaehostunreach_text, Wsaehostunreach_value)
			Result.force (Wsaenotempty_text, Wsaenotempty_value)
			Result.force (Wsaeproclim_text, Wsaeproclim_value)
			Result.force (Wsaeusers_text, Wsaeusers_value)
			Result.force (Wsaedquot_text, Wsaedquot_value)
			Result.force (Wsaestale_text, Wsaestale_value)
			Result.force (Wsaeremote_text, Wsaeremote_value)
			Result.force (Wsasysnotready_text, Wsasysnotready_value)
			Result.force (Wsavernotsupported_text, Wsavernotsupported_value)
			Result.force (Wsanotinitialised_text, Wsanotinitialised_value)
			Result.force (Wsaediscon_text, Wsaediscon_value)
			Result.force (Wsaenomore_text, Wsaenomore_value)
			Result.force (Wsaecancelled_text, Wsaecancelled_value)
			Result.force (Wsaeinvalidproctable_text, Wsaeinvalidproctable_value)
			Result.force (Wsaeinvalidprovider_text, Wsaeinvalidprovider_value)
			Result.force (Wsaeproviderfailedinit_text, Wsaeproviderfailedinit_value)
			Result.force (Wsasyscallfailure_text, Wsasyscallfailure_value)
			Result.force (Wsaservice_not_found_text, Wsaservice_not_found_value)
			Result.force (Wsatype_not_found_text, Wsatype_not_found_value)
			Result.force (Wsa_e_no_more_text, Wsa_e_no_more_value)
			Result.force (Wsa_e_cancelled_text, Wsa_e_cancelled_value)
			Result.force (Wsaerefused_text, Wsaerefused_value)
			Result.force (Wsahost_not_found_text, Wsahost_not_found_value)
			Result.force (Wsatry_again_text, Wsatry_again_value)
			Result.force (Wsano_recovery_text, Wsano_recovery_value)
			Result.force (Wsano_data_text, Wsano_data_value)
			Result.force (Wsa_qos_receivers_text, Wsa_qos_receivers_value)
			Result.force (Wsa_qos_senders_text, Wsa_qos_senders_value)
			Result.force (Wsa_qos_no_senders_text, Wsa_qos_no_senders_value)
			Result.force (Wsa_qos_no_receivers_text, Wsa_qos_no_receivers_value)
			Result.force (Wsa_qos_request_confirmed_text, Wsa_qos_request_confirmed_value)
			Result.force (Wsa_qos_admission_failure_text, Wsa_qos_admission_failure_value)
			Result.force (Wsa_qos_policy_failure_text, Wsa_qos_policy_failure_value)
			Result.force (Wsa_qos_bad_style_text, Wsa_qos_bad_style_value)
			Result.force (Wsa_qos_bad_object_text, Wsa_qos_bad_object_value)
			Result.force (Wsa_qos_traffic_ctrl_error_text, Wsa_qos_traffic_ctrl_error_value)
			Result.force (Wsa_qos_generic_error_text, Wsa_qos_generic_error_value)
			Result.force (Wsa_qos_eservicetype_text, Wsa_qos_eservicetype_value)
			Result.force (Wsa_qos_eflowspec_text, Wsa_qos_eflowspec_value)
			Result.force (Wsa_qos_eprovspecbuf_text, Wsa_qos_eprovspecbuf_value)
			Result.force (Wsa_qos_efilterstyle_text, Wsa_qos_efilterstyle_value)
			Result.force (Wsa_qos_efiltertype_text, Wsa_qos_efiltertype_value)
			Result.force (Wsa_qos_efiltercount_text, Wsa_qos_efiltercount_value)
			Result.force (Wsa_qos_eobjlength_text, Wsa_qos_eobjlength_value)
			Result.force (Wsa_qos_eflowcount_text, Wsa_qos_eflowcount_value)
			Result.force (Wsa_qos_eunkownpsobj_text, Wsa_qos_eunkownpsobj_value)
			Result.force (Wsa_qos_epolicyobj_text, Wsa_qos_epolicyobj_value)
			Result.force (Wsa_qos_eflowdesc_text, Wsa_qos_eflowdesc_value)
			Result.force (Wsa_qos_epsflowspec_text, Wsa_qos_epsflowspec_value)
			Result.force (Wsa_qos_epsfilterspec_text, Wsa_qos_epsfilterspec_value)
			Result.force (Wsa_qos_esdmodeobj_text, Wsa_qos_esdmodeobj_value)
			Result.force (Wsa_qos_eshaperateobj_text, Wsa_qos_eshaperateobj_value)
			Result.force (Wsa_qos_reserved_petype_text, Wsa_qos_reserved_petype_value)

		end

	Error_success_text: STRING is
			"The operation completed successfully."

	Error_success_value: INTEGER is 0

	Error_invalid_function_text: STRING is
			"Incorrect function."

	Error_invalid_function_value: INTEGER is 1

	Error_file_not_found_text: STRING is
			"The system cannot find the file specified."

	Error_file_not_found_value: INTEGER is 2

	Error_path_not_found_text: STRING is
			"The system cannot find the path specified."

	Error_path_not_found_value: INTEGER is 3

	Error_too_many_open_files_text: STRING is
			"The system cannot open the file."

	Error_too_many_open_files_value: INTEGER is 4

	Error_access_denied_text: STRING is
			"Access is denied."

	Error_access_denied_value: INTEGER is 5

	Error_invalid_handle_text: STRING is
			"The handle is invalid."

	Error_invalid_handle_value: INTEGER is 6

	Error_arena_trashed_text: STRING is
			"The storage control blocks were destroyed."

	Error_arena_trashed_value: INTEGER is 7

	Error_not_enough_memory_text: STRING is
			"Not enough storage is available to process this command."

	Error_not_enough_memory_value: INTEGER is 8

	Error_invalid_block_text: STRING is
			"The storage control block address is invalid."

	Error_invalid_block_value: INTEGER is 9

	Error_bad_environment_text: STRING is
			"The environment is incorrect."

	Error_bad_environment_value: INTEGER is 10

	Error_bad_format_text: STRING is
			"An attempt was made to load a program with an incorrect format."

	Error_bad_format_value: INTEGER is 11

	Error_invalid_access_text: STRING is
			"The access code is invalid."

	Error_invalid_access_value: INTEGER is 12

	Error_invalid_data_text: STRING is
			"The data is invalid."

	Error_invalid_data_value: INTEGER is 13

	Error_outofmemory_text: STRING is
			"Not enough storage is available to complete this operation."

	Error_outofmemory_value: INTEGER is 14

	Error_invalid_drive_text: STRING is
			"The system cannot find the drive specified."

	Error_invalid_drive_value: INTEGER is 15

	Error_current_directory_text: STRING is
			"The directory cannot be removed."

	Error_current_directory_value: INTEGER is 16

	Error_not_same_device_text: STRING is
			"The system cannot move the file to a different disk drive."

	Error_not_same_device_value: INTEGER is 17

	Error_no_more_files_text: STRING is
			"There are no more files."

	Error_no_more_files_value: INTEGER is 18

	Error_write_protect_text: STRING is
			"The media is write protected."

	Error_write_protect_value: INTEGER is 19

	Error_bad_unit_text: STRING is
			"The system cannot find the device specified."

	Error_bad_unit_value: INTEGER is 20

	Error_not_ready_text: STRING is
			"The device is not ready."

	Error_not_ready_value: INTEGER is 21

	Error_bad_command_text: STRING is
			"The device does not recognize the command."

	Error_bad_command_value: INTEGER is 22

	Error_crc_text: STRING is
			"Data error (cyclic redundancy check)."

	Error_crc_value: INTEGER is 23

	Error_bad_length_text: STRING is
			"The program issued a command but the command length is incorrect."

	Error_bad_length_value: INTEGER is 24

	Error_seek_text: STRING is
			"The drive cannot locate a specific area or track on the disk."

	Error_seek_value: INTEGER is 25

	Error_not_dos_disk_text: STRING is
			"The specified disk or diskette cannot be accessed."

	Error_not_dos_disk_value: INTEGER is 26

	Error_sector_not_found_text: STRING is
			"The drive cannot find the sector requested."

	Error_sector_not_found_value: INTEGER is 27

	Error_out_of_paper_text: STRING is
			"The printer is out of paper."

	Error_out_of_paper_value: INTEGER is 28

	Error_write_fault_text: STRING is
			"The system cannot write to the specified device."

	Error_write_fault_value: INTEGER is 29

	Error_read_fault_text: STRING is
			"The system cannot read from the specified device."

	Error_read_fault_value: INTEGER is 30

	Error_gen_failure_text: STRING is
			"A device attached to the system is not functioning."

	Error_gen_failure_value: INTEGER is 31

	Error_sharing_violation_text: STRING is
			"The process cannot access the file because it is being used by another process."

	Error_sharing_violation_value: INTEGER is 32

	Error_lock_violation_text: STRING is
			"The process cannot access the file because another process has locked a portion of the file."

	Error_lock_violation_value: INTEGER is 33

	Error_wrong_disk_text: STRING is
			"The wrong diskette is in the drive.  Insert %%2 (Volume Serial Number: %%3)  into drive %%1."

	Error_wrong_disk_value: INTEGER is 34

	Error_sharing_buffer_exceeded_text: STRING is
			"Too many files opened for sharing."

	Error_sharing_buffer_exceeded_value: INTEGER is 36

	Error_handle_eof_text: STRING is
			"Reached the end of the file."

	Error_handle_eof_value: INTEGER is 38

	Error_handle_disk_full_text: STRING is
			"The disk is full."

	Error_handle_disk_full_value: INTEGER is 39

	Error_not_supported_text: STRING is
			"The network request is not supported."

	Error_not_supported_value: INTEGER is 50

	Error_rem_not_list_text: STRING is
			"The remote computer is not available."

	Error_rem_not_list_value: INTEGER is 51

	Error_dup_name_text: STRING is
			"A duplicate name exists on the network."

	Error_dup_name_value: INTEGER is 52

	Error_bad_netpath_text: STRING is
			"The network path was not found."

	Error_bad_netpath_value: INTEGER is 53

	Error_network_busy_text: STRING is
			"The network is busy."

	Error_network_busy_value: INTEGER is 54

	Error_dev_not_exist_text: STRING is
			"The specified network resource or device is no longer available."

	Error_dev_not_exist_value: INTEGER is 55

	Error_too_many_cmds_text: STRING is
			"The network BIOS command limit has been reached."

	Error_too_many_cmds_value: INTEGER is 56

	Error_adap_hdw_err_text: STRING is
			"A network adapter hardware error occurred."

	Error_adap_hdw_err_value: INTEGER is 57

	Error_bad_net_resp_text: STRING is
			"The specified server cannot perform the requested operation."

	Error_bad_net_resp_value: INTEGER is 58

	Error_unexp_net_err_text: STRING is
			"An unexpected network error occurred."

	Error_unexp_net_err_value: INTEGER is 59

	Error_bad_rem_adap_text: STRING is
			"The remote adapter is not compatible."

	Error_bad_rem_adap_value: INTEGER is 60

	Error_printq_full_text: STRING is
			"The printer queue is full."

	Error_printq_full_value: INTEGER is 61

	Error_no_spool_space_text: STRING is
			"Space to store the file waiting to be printed is not available on the server."

	Error_no_spool_space_value: INTEGER is 62

	Error_print_cancelled_text: STRING is
			"Your file waiting to be printed was deleted."

	Error_print_cancelled_value: INTEGER is 63

	Error_netname_deleted_text: STRING is
			"The specified network name is no longer available."

	Error_netname_deleted_value: INTEGER is 64

	Error_network_access_denied_text: STRING is
			"Network access is denied."

	Error_network_access_denied_value: INTEGER is 65

	Error_bad_dev_type_text: STRING is
			"The network resource type is not correct."

	Error_bad_dev_type_value: INTEGER is 66

	Error_bad_net_name_text: STRING is
			"The network name cannot be found."

	Error_bad_net_name_value: INTEGER is 67

	Error_too_many_names_text: STRING is
			"The name limit for the local computer network adapter card was exceeded."

	Error_too_many_names_value: INTEGER is 68

	Error_too_many_sess_text: STRING is
			"The network BIOS session limit was exceeded."

	Error_too_many_sess_value: INTEGER is 69

	Error_sharing_paused_text: STRING is
			"The remote server has been paused or is in the process of being started."

	Error_sharing_paused_value: INTEGER is 70

	Error_req_not_accep_text: STRING is
			"No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept."

	Error_req_not_accep_value: INTEGER is 71

	Error_redir_paused_text: STRING is
			"The specified printer or disk device has been paused."

	Error_redir_paused_value: INTEGER is 72

	Error_file_exists_text: STRING is
			"The file exists."

	Error_file_exists_value: INTEGER is 80

	Error_cannot_make_text: STRING is
			"The directory or file cannot be created."

	Error_cannot_make_value: INTEGER is 82

	Error_fail_i24_text: STRING is
			"Fail on INT 24."

	Error_fail_i24_value: INTEGER is 83

	Error_out_of_structures_text: STRING is
			"Storage to process this request is not available."

	Error_out_of_structures_value: INTEGER is 84

	Error_already_assigned_text: STRING is
			"The local device name is already in use."

	Error_already_assigned_value: INTEGER is 85

	Error_invalid_password_text: STRING is
			"The specified network password is not correct."

	Error_invalid_password_value: INTEGER is 86

	Error_invalid_parameter_text: STRING is
			"The parameter is incorrect."

	Error_invalid_parameter_value: INTEGER is 87

	Error_net_write_fault_text: STRING is
			"A write fault occurred on the network."

	Error_net_write_fault_value: INTEGER is 88

	Error_no_proc_slots_text: STRING is
			"The system cannot start another process at this time."

	Error_no_proc_slots_value: INTEGER is 89

	Error_too_many_semaphores_text: STRING is
			"Cannot create another system semaphore."

	Error_too_many_semaphores_value: INTEGER is 100

	Error_excl_sem_already_owned_text: STRING is
			"The exclusive semaphore is owned by another process."

	Error_excl_sem_already_owned_value: INTEGER is 101

	Error_sem_is_set_text: STRING is
			"The semaphore is set and cannot be closed."

	Error_sem_is_set_value: INTEGER is 102

	Error_too_many_sem_requests_text: STRING is
			"The semaphore cannot be set again."

	Error_too_many_sem_requests_value: INTEGER is 103

	Error_invalid_at_interrupt_time_text: STRING is
			"Cannot request exclusive semaphores at interrupt time."

	Error_invalid_at_interrupt_time_value: INTEGER is 104

	Error_sem_owner_died_text: STRING is
			"The previous ownership of this semaphore has ended."

	Error_sem_owner_died_value: INTEGER is 105

	Error_sem_user_limit_text: STRING is
			"Insert the diskette for drive %%1."

	Error_sem_user_limit_value: INTEGER is 106

	Error_disk_change_text: STRING is
			"The program stopped because an alternate diskette was not inserted."

	Error_disk_change_value: INTEGER is 107

	Error_drive_locked_text: STRING is
			"The disk is in use or locked by  another process."

	Error_drive_locked_value: INTEGER is 108

	Error_broken_pipe_text: STRING is
			"The pipe has been ended."

	Error_broken_pipe_value: INTEGER is 109

	Error_open_failed_text: STRING is
			"The system cannot open the  device or file specified."

	Error_open_failed_value: INTEGER is 110

	Error_buffer_overflow_text: STRING is
			"The file name is too long."

	Error_buffer_overflow_value: INTEGER is 111

	Error_disk_full_text: STRING is
			"There is not enough space on the disk."

	Error_disk_full_value: INTEGER is 112

	Error_no_more_search_handles_text: STRING is
			"No more internal file identifiers available."

	Error_no_more_search_handles_value: INTEGER is 113

	Error_invalid_target_handle_text: STRING is
			"The target internal file identifier is incorrect."

	Error_invalid_target_handle_value: INTEGER is 114

	Error_invalid_category_text: STRING is
			"The IOCTL call made by the application program is not correct."

	Error_invalid_category_value: INTEGER is 117

	Error_invalid_verify_switch_text: STRING is
			"The verify-on-write switch parameter value is not correct."

	Error_invalid_verify_switch_value: INTEGER is 118

	Error_bad_driver_level_text: STRING is
			"The system does not support the command requested."

	Error_bad_driver_level_value: INTEGER is 119

	Error_call_not_implemented_text: STRING is
			"This function is not supported on this system."

	Error_call_not_implemented_value: INTEGER is 120

	Error_sem_timeout_text: STRING is
			"The semaphore timeout period has expired."

	Error_sem_timeout_value: INTEGER is 121

	Error_insufficient_buffer_text: STRING is
			"The data area passed to a system call is too small."

	Error_insufficient_buffer_value: INTEGER is 122

	Error_invalid_name_text: STRING is
			"The filename, directory name, or volume label syntax is incorrect."

	Error_invalid_name_value: INTEGER is 123

	Error_invalid_level_text: STRING is
			"The system call level is not correct."

	Error_invalid_level_value: INTEGER is 124

	Error_no_volume_label_text: STRING is
			"The disk has no volume label."

	Error_no_volume_label_value: INTEGER is 125

	Error_mod_not_found_text: STRING is
			"The specified module could not be found."

	Error_mod_not_found_value: INTEGER is 126

	Error_proc_not_found_text: STRING is
			"The specified procedure could not be found."

	Error_proc_not_found_value: INTEGER is 127

	Error_wait_no_children_text: STRING is
			"There are no child processes to wait for."

	Error_wait_no_children_value: INTEGER is 128

	Error_child_not_complete_text: STRING is
			"The %%1 application cannot be run in Win32 mode."

	Error_child_not_complete_value: INTEGER is 129

	Error_direct_access_handle_text: STRING is
			"Attempt to use a file handle to an open disk partition for an operation other than raw disk I/O."

	Error_direct_access_handle_value: INTEGER is 130

	Error_negative_seek_text: STRING is
			"An attempt was made to move the file pointer before the beginning of the file."

	Error_negative_seek_value: INTEGER is 131

	Error_seek_on_device_text: STRING is
			"The file pointer cannot be set on the specified device or file."

	Error_seek_on_device_value: INTEGER is 132

	Error_is_join_target_text: STRING is
			"A JOIN or SUBST command cannot be used for a drive that contains previously joined drives."

	Error_is_join_target_value: INTEGER is 133

	Error_is_joined_text: STRING is
			"An attempt was made to use a JOIN or SUBST command on a drive that has already been joined."

	Error_is_joined_value: INTEGER is 134

	Error_is_substed_text: STRING is
			"An attempt was made to use a JOIN or SUBST command on a drive that has already been substituted."

	Error_is_substed_value: INTEGER is 135

	Error_not_joined_text: STRING is
			"The system tried to delete the JOIN of a drive that is not joined."

	Error_not_joined_value: INTEGER is 136

	Error_not_substed_text: STRING is
			"The system tried to delete the substitution of a drive that is not substituted."

	Error_not_substed_value: INTEGER is 137

	Error_join_to_join_text: STRING is
			"The system tried to join a drive to a directory on a joined drive."

	Error_join_to_join_value: INTEGER is 138

	Error_subst_to_subst_text: STRING is
			"The system tried to substitute a drive to a directory on a substituted drive."

	Error_subst_to_subst_value: INTEGER is 139

	Error_join_to_subst_text: STRING is
			"The system tried to join a drive to a directory on a substituted drive."

	Error_join_to_subst_value: INTEGER is 140

	Error_subst_to_join_text: STRING is
			"The system tried to SUBST a drive to a directory on a joined drive."

	Error_subst_to_join_value: INTEGER is 141

	Error_busy_drive_text: STRING is
			"The system cannot perform a JOIN or SUBST at this time."

	Error_busy_drive_value: INTEGER is 142

	Error_same_drive_text: STRING is
			"The system cannot join or substitute a drive to or for a directory on the same drive."

	Error_same_drive_value: INTEGER is 143

	Error_dir_not_root_text: STRING is
			"The directory is not a subdirectory of the root directory."

	Error_dir_not_root_value: INTEGER is 144

	Error_dir_not_empty_text: STRING is
			"The directory is not empty."

	Error_dir_not_empty_value: INTEGER is 145

	Error_is_subst_path_text: STRING is
			"The path specified is being used in a substitute."

	Error_is_subst_path_value: INTEGER is 146

	Error_is_join_path_text: STRING is
			"Not enough resources are available to process this command."

	Error_is_join_path_value: INTEGER is 147

	Error_path_busy_text: STRING is
			"The path specified cannot be used at this time."

	Error_path_busy_value: INTEGER is 148

	Error_is_subst_target_text: STRING is
			"An attempt was made to join or substitute a drive for which a directory on the drive is the target of a previous substitute."

	Error_is_subst_target_value: INTEGER is 149

	Error_system_trace_text: STRING is
			"System trace information was not specified in your CONFIG.SYS file, or tracing is disallowed."

	Error_system_trace_value: INTEGER is 150

	Error_invalid_event_count_text: STRING is
			"The number of specified semaphore events for DosMuxSemWait is not correct."

	Error_invalid_event_count_value: INTEGER is 151

	Error_too_many_muxwaiters_text: STRING is
			"DosMuxSemWait did not execute; too many semaphores are already set."

	Error_too_many_muxwaiters_value: INTEGER is 152

	Error_invalid_list_format_text: STRING is
			"The DosMuxSemWait list is not correct."

	Error_invalid_list_format_value: INTEGER is 153

	Error_label_too_long_text: STRING is
			"The volume label you entered exceeds the label character  limit of the target file system."

	Error_label_too_long_value: INTEGER is 154

	Error_too_many_tcbs_text: STRING is
			"Cannot create another thread."

	Error_too_many_tcbs_value: INTEGER is 155

	Error_signal_refused_text: STRING is
			"The recipient process has refused the signal."

	Error_signal_refused_value: INTEGER is 156

	Error_discarded_text: STRING is
			"The segment is already discarded and cannot be locked."

	Error_discarded_value: INTEGER is 157

	Error_not_locked_text: STRING is
			"The segment is already unlocked."

	Error_not_locked_value: INTEGER is 158

	Error_bad_threadid_addr_text: STRING is
			"The address for the thread ID is not correct."

	Error_bad_threadid_addr_value: INTEGER is 159

	Error_bad_arguments_text: STRING is
			"The argument string passed to DosExecPgm is not correct."

	Error_bad_arguments_value: INTEGER is 160

	Error_bad_pathname_text: STRING is
			"The specified path is invalid."

	Error_bad_pathname_value: INTEGER is 161

	Error_signal_pending_text: STRING is
			"A signal is already pending."

	Error_signal_pending_value: INTEGER is 162

	Error_max_thrds_reached_text: STRING is
			"No more threads can be created in the system."

	Error_max_thrds_reached_value: INTEGER is 164

	Error_lock_failed_text: STRING is
			"Unable to lock a region of a file."

	Error_lock_failed_value: INTEGER is 167

	Error_busy_text: STRING is
			"The requested resource is in use."

	Error_busy_value: INTEGER is 170

	Error_cancel_violation_text: STRING is
			"A lock request was not outstanding for the supplied cancel region."

	Error_cancel_violation_value: INTEGER is 173

	Error_atomic_locks_not_supported_text: STRING is
			"The file system does not support atomic changes to the lock type."

	Error_atomic_locks_not_supported_value: INTEGER is 174

	Error_invalid_segment_number_text: STRING is
			"The system detected a segment number that was not correct."

	Error_invalid_segment_number_value: INTEGER is 180

	Error_invalid_ordinal_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_ordinal_value: INTEGER is 182

	Error_already_exists_text: STRING is
			"Cannot create a file when that file already exists."

	Error_already_exists_value: INTEGER is 183

	Error_invalid_flag_number_text: STRING is
			"The flag passed is not correct."

	Error_invalid_flag_number_value: INTEGER is 186

	Error_sem_not_found_text: STRING is
			"The specified system semaphore name was not found."

	Error_sem_not_found_value: INTEGER is 187

	Error_invalid_starting_codeseg_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_starting_codeseg_value: INTEGER is 188

	Error_invalid_stackseg_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_stackseg_value: INTEGER is 189

	Error_invalid_moduletype_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_moduletype_value: INTEGER is 190

	Error_invalid_exe_signature_text: STRING is
			"Cannot run %%1 in Win32 mode."

	Error_invalid_exe_signature_value: INTEGER is 191

	Error_exe_marked_invalid_text: STRING is
			"The operating system cannot run %%1."

	Error_exe_marked_invalid_value: INTEGER is 192

	Error_bad_exe_format_text: STRING is
			"%%1 is not a valid Win32 application."

	Error_bad_exe_format_value: INTEGER is 193

	Error_iterated_data_exceeds_64k_text: STRING is
			"The operating system cannot run %%1."

	Error_iterated_data_exceeds_64k_value: INTEGER is 194

	Error_invalid_minallocsize_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_minallocsize_value: INTEGER is 195

	Error_dynlink_from_invalid_ring_text: STRING is
			"The operating system cannot run this application program."

	Error_dynlink_from_invalid_ring_value: INTEGER is 196

	Error_iopl_not_enabled_text: STRING is
			"The operating system is not presently configured to run this application."

	Error_iopl_not_enabled_value: INTEGER is 197

	Error_invalid_segdpl_text: STRING is
			"The operating system cannot run %%1."

	Error_invalid_segdpl_value: INTEGER is 198

	Error_autodataseg_exceeds_64k_text: STRING is
			"The operating system cannot run this application program."

	Error_autodataseg_exceeds_64k_value: INTEGER is 199

	Error_ring2seg_must_be_movable_text: STRING is
			"The code segment cannot be greater than or equal to 64K."

	Error_ring2seg_must_be_movable_value: INTEGER is 200

	Error_reloc_chain_xeeds_seglim_text: STRING is
			"The operating system cannot run %%1."

	Error_reloc_chain_xeeds_seglim_value: INTEGER is 201

	Error_infloop_in_reloc_chain_text: STRING is
			"The operating system cannot run %%1."

	Error_infloop_in_reloc_chain_value: INTEGER is 202

	Error_envvar_not_found_text: STRING is
			"The system could not find the environment  option that was entered."

	Error_envvar_not_found_value: INTEGER is 203

	Error_no_signal_sent_text: STRING is
			"No process in the command subtree has a  signal handler."

	Error_no_signal_sent_value: INTEGER is 205

	Error_filename_exced_range_text: STRING is
			"The filename or extension is too long."

	Error_filename_exced_range_value: INTEGER is 206

	Error_ring2_stack_in_use_text: STRING is
			"The ring 2 stack is in use."

	Error_ring2_stack_in_use_value: INTEGER is 207

	Error_meta_expansion_too_long_text: STRING is
			"The global filename characters, * or ?, are entered incorrectly or too many global filename characters are specified."

	Error_meta_expansion_too_long_value: INTEGER is 208

	Error_invalid_signal_number_text: STRING is
			"The signal being posted is not correct."

	Error_invalid_signal_number_value: INTEGER is 209

	Error_thread_1_inactive_text: STRING is
			"The signal handler cannot be set."

	Error_thread_1_inactive_value: INTEGER is 210

	Error_locked_text: STRING is
			"The segment is locked and cannot be reallocated."

	Error_locked_value: INTEGER is 212

	Error_too_many_modules_text: STRING is
			"Too many dynamic-link modules are attached to this program or dynamic-link module."

	Error_too_many_modules_value: INTEGER is 214

	Error_nesting_not_allowed_text: STRING is
			"Cannot nest calls to LoadModule."

	Error_nesting_not_allowed_value: INTEGER is 215

	Error_exe_machine_type_mismatch_text: STRING is
			"The image file %%1 is valid, but is for a machine type other than the current machine."

	Error_exe_machine_type_mismatch_value: INTEGER is 216

	Error_bad_pipe_text: STRING is
			"The pipe state is invalid."

	Error_bad_pipe_value: INTEGER is 230

	Error_pipe_busy_text: STRING is
			"All pipe instances are busy."

	Error_pipe_busy_value: INTEGER is 231

	Error_no_data_text: STRING is
			"The pipe is being closed."

	Error_no_data_value: INTEGER is 232

	Error_pipe_not_connected_text: STRING is
			"No process is on the other end of the pipe."

	Error_pipe_not_connected_value: INTEGER is 233

	Error_more_data_text: STRING is
			"More data is available."

	Error_more_data_value: INTEGER is 234

	Error_vc_disconnected_text: STRING is
			"The session was canceled."

	Error_vc_disconnected_value: INTEGER is 240

	Error_invalid_ea_name_text: STRING is
			"The specified extended attribute name was invalid."

	Error_invalid_ea_name_value: INTEGER is 254

	Error_ea_list_inconsistent_text: STRING is
			"The extended attributes are inconsistent."

	Error_ea_list_inconsistent_value: INTEGER is 255

	Wait_timeout_text: STRING is
			"The wait operation timed out."

	Wait_timeout_value: INTEGER is 258

	Error_no_more_items_text: STRING is
			"No more data is available."

	Error_no_more_items_value: INTEGER is 259

	Error_cannot_copy_text: STRING is
			"The copy functions cannot be used."

	Error_cannot_copy_value: INTEGER is 266

	Error_directory_text: STRING is
			"The directory name is invalid."

	Error_directory_value: INTEGER is 267

	Error_eas_didnt_fit_text: STRING is
			"The extended attributes did not fit in the buffer."

	Error_eas_didnt_fit_value: INTEGER is 275

	Error_ea_file_corrupt_text: STRING is
			"The extended attribute file on the mounted file system is corrupt."

	Error_ea_file_corrupt_value: INTEGER is 276

	Error_ea_table_full_text: STRING is
			"The extended attribute table file is full."

	Error_ea_table_full_value: INTEGER is 277

	Error_invalid_ea_handle_text: STRING is
			"The specified extended attribute handle is invalid."

	Error_invalid_ea_handle_value: INTEGER is 278

	Error_eas_not_supported_text: STRING is
			"The mounted file system does not support extended attributes."

	Error_eas_not_supported_value: INTEGER is 282

	Error_not_owner_text: STRING is
			"Attempt to release mutex not owned by caller."

	Error_not_owner_value: INTEGER is 288

	Error_too_many_posts_text: STRING is
			"Too many posts were made to a semaphore."

	Error_too_many_posts_value: INTEGER is 298

	Error_partial_copy_text: STRING is
			"Only part of a ReadProcessMemory or WriteProcessMemory request was completed."

	Error_partial_copy_value: INTEGER is 299

	Error_oplock_not_granted_text: STRING is
			"The oplock request is denied."

	Error_oplock_not_granted_value: INTEGER is 300

	Error_invalid_oplock_protocol_text: STRING is
			"An invalid oplock acknowledgment was received by the system."

	Error_invalid_oplock_protocol_value: INTEGER is 301

	Error_mr_mid_not_found_text: STRING is
			"The system cannot find message text for message number 0x%%1 in the message file for %%2."

	Error_mr_mid_not_found_value: INTEGER is 317

	Error_invalid_address_text: STRING is
			"Attempt to access invalid address."

	Error_invalid_address_value: INTEGER is 487

	Error_arithmetic_overflow_text: STRING is
			"Arithmetic result exceeded 32 bits."

	Error_arithmetic_overflow_value: INTEGER is 534

	Error_pipe_connected_text: STRING is
			"There is a process on other end of the pipe."

	Error_pipe_connected_value: INTEGER is 535

	Error_pipe_listening_text: STRING is
			"Waiting for a process to open the other end of the pipe."

	Error_pipe_listening_value: INTEGER is 536

	Error_ea_access_denied_text: STRING is
			"Access to the extended attribute was denied."

	Error_ea_access_denied_value: INTEGER is 994

	Error_operation_aborted_text: STRING is
			"The I/O operation has been aborted because of either a thread exit or an application request."

	Error_operation_aborted_value: INTEGER is 995

	Error_io_incomplete_text: STRING is
			"Overlapped I/O event is not in a signaled state."

	Error_io_incomplete_value: INTEGER is 996

	Error_io_pending_text: STRING is
			"Overlapped I/O operation is in progress."

	Error_io_pending_value: INTEGER is 997

	Error_noaccess_text: STRING is
			"Invalid access to memory location."

	Error_noaccess_value: INTEGER is 998

	Error_swaperror_text: STRING is
			"Error performing in page operation."

	Error_swaperror_value: INTEGER is 999

	Error_stack_overflow_text: STRING is
			"Recursion too deep; the stack overflowed."

	Error_stack_overflow_value: INTEGER is 1001

	Error_invalid_message_text: STRING is
			"The window cannot act on the sent message."

	Error_invalid_message_value: INTEGER is 1002

	Error_can_not_complete_text: STRING is
			"Cannot complete this function."

	Error_can_not_complete_value: INTEGER is 1003

	Error_invalid_flags_text: STRING is
			"Invalid flags."

	Error_invalid_flags_value: INTEGER is 1004

	Error_unrecognized_volume_text: STRING is
			"The volume does not contain a recognized file system.  Please make sure that all required file system drivers are loaded and that the volume is not corrupted."

	Error_unrecognized_volume_value: INTEGER is 1005

	Error_file_invalid_text: STRING is
			"The volume for a file has been externally altered so that the opened file is no longer valid."

	Error_file_invalid_value: INTEGER is 1006

	Error_fullscreen_mode_text: STRING is
			"The requested operation cannot be performed in full-screen mode."

	Error_fullscreen_mode_value: INTEGER is 1007

	Error_no_token_text: STRING is
			"An attempt was made to reference a token that does not exist."

	Error_no_token_value: INTEGER is 1008

	Error_baddb_text: STRING is
			"The configuration registry database is corrupt."

	Error_baddb_value: INTEGER is 1009

	Error_badkey_text: STRING is
			"The configuration registry key is invalid."

	Error_badkey_value: INTEGER is 1010

	Error_cantopen_text: STRING is
			"The configuration registry key could not be opened."

	Error_cantopen_value: INTEGER is 1011

	Error_cantread_text: STRING is
			"The configuration registry key could not be read."

	Error_cantread_value: INTEGER is 1012

	Error_cantwrite_text: STRING is
			"The configuration registry key could not be written."

	Error_cantwrite_value: INTEGER is 1013

	Error_registry_recovered_text: STRING is
			"One of the files in the registry database had to be recovered by use of a log or alternate copy. The recovery was successful."

	Error_registry_recovered_value: INTEGER is 1014

	Error_registry_corrupt_text: STRING is
			"The registry is corrupted. The structure of one of the files containing registry data is corrupted, or the system's memory image of the file is corrupted, or the file could not be recovered because the alternate copy or log was absent or corrupted."

	Error_registry_corrupt_value: INTEGER is 1015

	Error_registry_io_failed_text: STRING is
			"An I/O operation initiated by the registry failed unrecoverably. The registry could not read in, or write out, or flush, one of the files that contain the system's image of the registry."

	Error_registry_io_failed_value: INTEGER is 1016

	Error_not_registry_file_text: STRING is
			"The system has attempted to load or restore a file into the registry, but the specified file is not in a registry file format."

	Error_not_registry_file_value: INTEGER is 1017

	Error_key_deleted_text: STRING is
			"Illegal operation attempted on a registry key that has been marked for deletion."

	Error_key_deleted_value: INTEGER is 1018

	Error_no_log_space_text: STRING is
			"System could not allocate the required space in a registry log."

	Error_no_log_space_value: INTEGER is 1019

	Error_key_has_children_text: STRING is
			"Cannot create a symbolic link in a registry key that already has subkeys or values."

	Error_key_has_children_value: INTEGER is 1020

	Error_child_must_be_volatile_text: STRING is
			"Cannot create a stable subkey under a volatile parent key."

	Error_child_must_be_volatile_value: INTEGER is 1021

	Error_notify_enum_dir_text: STRING is
			"A notify change request is being completed and the information is not being returned in the caller's buffer. The caller now needs to enumerate the files to find the changes."

	Error_notify_enum_dir_value: INTEGER is 1022

	Error_dependent_services_running_text: STRING is
			"A stop control has been sent to a service that other running services are dependent on."

	Error_dependent_services_running_value: INTEGER is 1051

	Error_invalid_service_control_text: STRING is
			"The requested control is not valid for this service."

	Error_invalid_service_control_value: INTEGER is 1052

	Error_service_request_timeout_text: STRING is
			"The service did not respond to the start or control request in a timely fashion."

	Error_service_request_timeout_value: INTEGER is 1053

	Error_service_no_thread_text: STRING is
			"A thread could not be created for the service."

	Error_service_no_thread_value: INTEGER is 1054

	Error_service_database_locked_text: STRING is
			"The service database is locked."

	Error_service_database_locked_value: INTEGER is 1055

	Error_service_already_running_text: STRING is
			"An instance of the service is already running."

	Error_service_already_running_value: INTEGER is 1056

	Error_invalid_service_account_text: STRING is
			"The account name is invalid or does not exist, or the password is invalid for the account name specified."

	Error_invalid_service_account_value: INTEGER is 1057

	Error_service_disabled_text: STRING is
			"The service cannot be started, either because it is disabled or because it has no enabled devices associated with it."

	Error_service_disabled_value: INTEGER is 1058

	Error_circular_dependency_text: STRING is
			"Circular service dependency was specified."

	Error_circular_dependency_value: INTEGER is 1059

	Error_service_does_not_exist_text: STRING is
			"The specified service does not exist as an installed service."

	Error_service_does_not_exist_value: INTEGER is 1060

	Error_service_cannot_accept_ctrl_text: STRING is
			"The service cannot accept control messages at this time."

	Error_service_cannot_accept_ctrl_value: INTEGER is 1061

	Error_service_not_active_text: STRING is
			"The service has not been started."

	Error_service_not_active_value: INTEGER is 1062

	Error_failed_service_controller_connect_text: STRING is
			"The service process could not connect to the service controller."

	Error_failed_service_controller_connect_value: INTEGER is 1063

	Error_exception_in_service_text: STRING is
			"An exception occurred in the service when handling the control request."

	Error_exception_in_service_value: INTEGER is 1064

	Error_database_does_not_exist_text: STRING is
			"The database specified does not exist."

	Error_database_does_not_exist_value: INTEGER is 1065

	Error_service_specific_error_text: STRING is
			"The service has returned a service-specific error code."

	Error_service_specific_error_value: INTEGER is 1066

	Error_process_aborted_text: STRING is
			"The process terminated unexpectedly."

	Error_process_aborted_value: INTEGER is 1067

	Error_service_dependency_fail_text: STRING is
			"The dependency service or group failed to start."

	Error_service_dependency_fail_value: INTEGER is 1068

	Error_service_logon_failed_text: STRING is
			"The service did not start due to a logon failure."

	Error_service_logon_failed_value: INTEGER is 1069

	Error_service_start_hang_text: STRING is
			"After starting, the service hung in a start-pending state."

	Error_service_start_hang_value: INTEGER is 1070

	Error_invalid_service_lock_text: STRING is
			"The specified service database lock is invalid."

	Error_invalid_service_lock_value: INTEGER is 1071

	Error_service_marked_for_delete_text: STRING is
			"The specified service has been marked for deletion."

	Error_service_marked_for_delete_value: INTEGER is 1072

	Error_service_exists_text: STRING is
			"The specified service already exists."

	Error_service_exists_value: INTEGER is 1073

	Error_already_running_lkg_text: STRING is
			"The system is currently running with the last-known-good configuration."

	Error_already_running_lkg_value: INTEGER is 1074

	Error_service_dependency_deleted_text: STRING is
			"The dependency service does not exist or has been marked for deletion."

	Error_service_dependency_deleted_value: INTEGER is 1075

	Error_boot_already_accepted_text: STRING is
			"The current boot has already been accepted for use as the last-known-good control set."

	Error_boot_already_accepted_value: INTEGER is 1076

	Error_service_never_started_text: STRING is
			"No attempts to start the service have been made since the last boot."

	Error_service_never_started_value: INTEGER is 1077

	Error_duplicate_service_name_text: STRING is
			"The name is already in use as either a service name or a service display name."

	Error_duplicate_service_name_value: INTEGER is 1078

	Error_different_service_account_text: STRING is
			"The account specified for this service is different from the account specified for other services running in the same process."

	Error_different_service_account_value: INTEGER is 1079

	Error_cannot_detect_driver_failure_text: STRING is
			"Failure actions can only be set for Win32 services, not for drivers."

	Error_cannot_detect_driver_failure_value: INTEGER is 1080

	Error_cannot_detect_process_abort_text: STRING is
			"This service runs in the same process as the service control manager.  Therefore, the service control manager cannot take action if this service's process terminates unexpectedly."

	Error_cannot_detect_process_abort_value: INTEGER is 1081

	Error_no_recovery_program_text: STRING is
			"No recovery program has been configured for this service."

	Error_no_recovery_program_value: INTEGER is 1082

	Error_service_not_in_exe_text: STRING is
			"The executable program that this service is configured to run in does not implement the service."

	Error_service_not_in_exe_value: INTEGER is 1083

	Error_end_of_media_text: STRING is
			"The physical end of the tape has been reached."

	Error_end_of_media_value: INTEGER is 1100

	Error_filemark_detected_text: STRING is
			"A tape access reached a filemark."

	Error_filemark_detected_value: INTEGER is 1101

	Error_beginning_of_media_text: STRING is
			"The beginning of the tape or a partition was encountered."

	Error_beginning_of_media_value: INTEGER is 1102

	Error_setmark_detected_text: STRING is
			"A tape access reached the end of a set of files."

	Error_setmark_detected_value: INTEGER is 1103

	Error_no_data_detected_text: STRING is
			"No more data is on the tape."

	Error_no_data_detected_value: INTEGER is 1104

	Error_partition_failure_text: STRING is
			"Tape could not be partitioned."

	Error_partition_failure_value: INTEGER is 1105

	Error_invalid_block_length_text: STRING is
			"When accessing a new tape of a multivolume partition, the current block size is incorrect."

	Error_invalid_block_length_value: INTEGER is 1106

	Error_device_not_partitioned_text: STRING is
			"Tape partition information could not be found when loading a tape."

	Error_device_not_partitioned_value: INTEGER is 1107

	Error_unable_to_lock_media_text: STRING is
			"Unable to lock the media eject mechanism."

	Error_unable_to_lock_media_value: INTEGER is 1108

	Error_unable_to_unload_media_text: STRING is
			"Unable to unload the media."

	Error_unable_to_unload_media_value: INTEGER is 1109

	Error_media_changed_text: STRING is
			"The media in the drive may have changed."

	Error_media_changed_value: INTEGER is 1110

	Error_bus_reset_text: STRING is
			"The I/O bus was reset."

	Error_bus_reset_value: INTEGER is 1111

	Error_no_media_in_drive_text: STRING is
			"No media in drive."

	Error_no_media_in_drive_value: INTEGER is 1112

	Error_no_unicode_translation_text: STRING is
			"No mapping for the Unicode character exists in the target multi-byte code page."

	Error_no_unicode_translation_value: INTEGER is 1113

	Error_dll_init_failed_text: STRING is
			"A dynamic link library (DLL) initialization routine failed."

	Error_dll_init_failed_value: INTEGER is 1114

	Error_shutdown_in_progress_text: STRING is
			"A system shutdown is in progress."

	Error_shutdown_in_progress_value: INTEGER is 1115

	Error_no_shutdown_in_progress_text: STRING is
			"Unable to abort the system shutdown because no shutdown was in progress."

	Error_no_shutdown_in_progress_value: INTEGER is 1116

	Error_io_device_text: STRING is
			"The request could not be performed because of an I/O device error."

	Error_io_device_value: INTEGER is 1117

	Error_serial_no_device_text: STRING is
			"No serial device was successfully initialized. The serial driver will unload."

	Error_serial_no_device_value: INTEGER is 1118

	Error_irq_busy_text: STRING is
			"Unable to open a device that was sharing an interrupt request (IRQ) with other devices. At least one other device that uses that IRQ was already opened."

	Error_irq_busy_value: INTEGER is 1119

	Error_more_writes_text: STRING is
			"A serial I/O operation was completed by another write to the serial port.  (The IOCTL_SERIAL_XOFF_COUNTER reached zero.)"

	Error_more_writes_value: INTEGER is 1120

	Error_counter_timeout_text: STRING is
			"A serial I/O operation completed because the timeout period expired.  (The IOCTL_SERIAL_XOFF_COUNTER did not reach zero.)"

	Error_counter_timeout_value: INTEGER is 1121

	Error_floppy_id_mark_not_found_text: STRING is
			"No ID address mark was found on the floppy disk."

	Error_floppy_id_mark_not_found_value: INTEGER is 1122

	Error_floppy_wrong_cylinder_text: STRING is
			"Mismatch between the floppy disk sector ID field and the floppy disk controller track address."

	Error_floppy_wrong_cylinder_value: INTEGER is 1123

	Error_floppy_unknown_error_text: STRING is
			"The floppy disk controller reported an error that is not recognized by the floppy disk driver."

	Error_floppy_unknown_error_value: INTEGER is 1124

	Error_floppy_bad_registers_text: STRING is
			"The floppy disk controller returned inconsistent results in its registers."

	Error_floppy_bad_registers_value: INTEGER is 1125

	Error_disk_recalibrate_failed_text: STRING is
			"While accessing the hard disk, a recalibrate operation failed, even after retries."

	Error_disk_recalibrate_failed_value: INTEGER is 1126

	Error_disk_operation_failed_text: STRING is
			"While accessing the hard disk, a disk operation failed even after retries."

	Error_disk_operation_failed_value: INTEGER is 1127

	Error_disk_reset_failed_text: STRING is
			"While accessing the hard disk, a disk controller reset was needed, but even that failed."

	Error_disk_reset_failed_value: INTEGER is 1128

	Error_eom_overflow_text: STRING is
			"Physical end of tape encountered."

	Error_eom_overflow_value: INTEGER is 1129

	Error_not_enough_server_memory_text: STRING is
			"Not enough server storage is available to process this command."

	Error_not_enough_server_memory_value: INTEGER is 1130

	Error_possible_deadlock_text: STRING is
			"A potential deadlock condition has been detected."

	Error_possible_deadlock_value: INTEGER is 1131

	Error_mapped_alignment_text: STRING is
			"The base address or the file offset specified does not have the proper alignment."

	Error_mapped_alignment_value: INTEGER is 1132

	Error_set_power_state_vetoed_text: STRING is
			"An attempt to change the system power state was vetoed by another application or driver."

	Error_set_power_state_vetoed_value: INTEGER is 1140

	Error_set_power_state_failed_text: STRING is
			"The system BIOS failed an attempt to change the system power state."

	Error_set_power_state_failed_value: INTEGER is 1141

	Error_too_many_links_text: STRING is
			"An attempt was made to create more links on a file than the file system supports."

	Error_too_many_links_value: INTEGER is 1142

	Error_old_win_version_text: STRING is
			"The specified program requires a newer version of Windows."

	Error_old_win_version_value: INTEGER is 1150

	Error_app_wrong_os_text: STRING is
			"The specified program is not a Windows or MS-DOS program."

	Error_app_wrong_os_value: INTEGER is 1151

	Error_single_instance_app_text: STRING is
			"Cannot start more than one instance of the specified program."

	Error_single_instance_app_value: INTEGER is 1152

	Error_rmode_app_text: STRING is
			"The specified program was written for an earlier version of Windows."

	Error_rmode_app_value: INTEGER is 1153

	Error_invalid_dll_text: STRING is
			"One of the library files needed to run this application is damaged."

	Error_invalid_dll_value: INTEGER is 1154

	Error_no_association_text: STRING is
			"No application is associated with the specified file for this operation."

	Error_no_association_value: INTEGER is 1155

	Error_dde_fail_text: STRING is
			"An error occurred in sending the command to the application."

	Error_dde_fail_value: INTEGER is 1156

	Error_dll_not_found_text: STRING is
			"One of the library files needed to run this application cannot be found."

	Error_dll_not_found_value: INTEGER is 1157

	Error_no_more_user_handles_text: STRING is
			"The current process has used all of its system allowance of handles for Window Manager objects."

	Error_no_more_user_handles_value: INTEGER is 1158

	Error_message_sync_only_text: STRING is
			"The message can be used only with synchronous operations."

	Error_message_sync_only_value: INTEGER is 1159

	Error_source_element_empty_text: STRING is
			"The indicated source element has no media."

	Error_source_element_empty_value: INTEGER is 1160

	Error_destination_element_full_text: STRING is
			"The indicated destination element already contains media."

	Error_destination_element_full_value: INTEGER is 1161

	Error_illegal_element_address_text: STRING is
			"The indicated element does not exist."

	Error_illegal_element_address_value: INTEGER is 1162

	Error_magazine_not_present_text: STRING is
			"The indicated element is part of a magazine that is not present."

	Error_magazine_not_present_value: INTEGER is 1163

	Error_device_reinitialization_needed_text: STRING is
			"The indicated device requires reinitialization due to hardware errors."

	Error_device_reinitialization_needed_value: INTEGER is 1164

	Error_device_requires_cleaning_text: STRING is
			"The device has indicated that cleaning is required before further operations are attempted."

	Error_device_requires_cleaning_value: INTEGER is 1165

	Error_device_door_open_text: STRING is
			"The device has indicated that its door is open."

	Error_device_door_open_value: INTEGER is 1166

	Error_device_not_connected_text: STRING is
			"The device is not connected."

	Error_device_not_connected_value: INTEGER is 1167

	Error_not_found_text: STRING is
			"Element not found."

	Error_not_found_value: INTEGER is 1168

	Error_no_match_text: STRING is
			"There was no match for the specified key in the index."

	Error_no_match_value: INTEGER is 1169

	Error_set_not_found_text: STRING is
			"The property set specified does not exist on the object."

	Error_set_not_found_value: INTEGER is 1170

	Error_point_not_found_text: STRING is
			"The point passed to GetMouseMovePoints is not in the buffer."

	Error_point_not_found_value: INTEGER is 1171

	Error_no_tracking_service_text: STRING is
			"The tracking (workstation) service is not running."

	Error_no_tracking_service_value: INTEGER is 1172

	Error_no_volume_id_text: STRING is
			"The Volume ID could not be found."

	Error_no_volume_id_value: INTEGER is 1173

	Error_unable_to_remove_replaced_text: STRING is
			"Unable to remove the file to be replaced."

	Error_unable_to_remove_replaced_value: INTEGER is 1175

	Error_unable_to_move_replacement_text: STRING is
			"Unable to move the replacement file to the file to be replaced. The file to be replaced has retained its original name."

	Error_unable_to_move_replacement_value: INTEGER is 1176

	Error_unable_to_move_replacement_2_text: STRING is
			"Unable to move the replacement file to the file to be replaced. The file to be replaced has been renamed using the backup name."

	Error_unable_to_move_replacement_2_value: INTEGER is 1177

	Error_journal_delete_in_progress_text: STRING is
			"The volume change journal is being deleted."

	Error_journal_delete_in_progress_value: INTEGER is 1178

	Error_journal_not_active_text: STRING is
			"The volume change journal service is not active."

	Error_journal_not_active_value: INTEGER is 1179

	Error_potential_file_found_text: STRING is
			"A file was found, but it may not be the correct file."

	Error_potential_file_found_value: INTEGER is 1180

	Error_journal_entry_deleted_text: STRING is
			"The journal entry has been deleted from the journal."

	Error_journal_entry_deleted_value: INTEGER is 1181

	Error_bad_device_text: STRING is
			"The specified device name is invalid."

	Error_bad_device_value: INTEGER is 1200

	Error_connection_unavail_text: STRING is
			"The device is not currently connected but it is a remembered connection."

	Error_connection_unavail_value: INTEGER is 1201

	Error_device_already_remembered_text: STRING is
			"An attempt was made to remember a device that had previously been remembered."

	Error_device_already_remembered_value: INTEGER is 1202

	Error_no_net_or_bad_path_text: STRING is
			"No network provider accepted the given network path."

	Error_no_net_or_bad_path_value: INTEGER is 1203

	Error_bad_provider_text: STRING is
			"The specified network provider name is invalid."

	Error_bad_provider_value: INTEGER is 1204

	Error_cannot_open_profile_text: STRING is
			"Unable to open the network connection profile."

	Error_cannot_open_profile_value: INTEGER is 1205

	Error_bad_profile_text: STRING is
			"The network connection profile is corrupted."

	Error_bad_profile_value: INTEGER is 1206

	Error_not_container_text: STRING is
			"Cannot enumerate a noncontainer."

	Error_not_container_value: INTEGER is 1207

	Error_extended_error_text: STRING is
			"An extended error has occurred."

	Error_extended_error_value: INTEGER is 1208

	Error_invalid_groupname_text: STRING is
			"The format of the specified group name is invalid."

	Error_invalid_groupname_value: INTEGER is 1209

	Error_invalid_computername_text: STRING is
			"The format of the specified computer name is invalid."

	Error_invalid_computername_value: INTEGER is 1210

	Error_invalid_eventname_text: STRING is
			"The format of the specified event name is invalid."

	Error_invalid_eventname_value: INTEGER is 1211

	Error_invalid_domainname_text: STRING is
			"The format of the specified domain name is invalid."

	Error_invalid_domainname_value: INTEGER is 1212

	Error_invalid_servicename_text: STRING is
			"The format of the specified service name is invalid."

	Error_invalid_servicename_value: INTEGER is 1213

	Error_invalid_netname_text: STRING is
			"The format of the specified network name is invalid."

	Error_invalid_netname_value: INTEGER is 1214

	Error_invalid_sharename_text: STRING is
			"The format of the specified share name is invalid."

	Error_invalid_sharename_value: INTEGER is 1215

	Error_invalid_passwordname_text: STRING is
			"The format of the specified password is invalid."

	Error_invalid_passwordname_value: INTEGER is 1216

	Error_invalid_messagename_text: STRING is
			"The format of the specified message name is invalid."

	Error_invalid_messagename_value: INTEGER is 1217

	Error_invalid_messagedest_text: STRING is
			"The format of the specified message destination is invalid."

	Error_invalid_messagedest_value: INTEGER is 1218

	Error_session_credential_conflict_text: STRING is
			"The credentials supplied conflict with an existing set of credentials."

	Error_session_credential_conflict_value: INTEGER is 1219

	Error_remote_session_limit_exceeded_text: STRING is
			"An attempt was made to establish a session to a network server, but there are already too many sessions established to that server."

	Error_remote_session_limit_exceeded_value: INTEGER is 1220

	Error_dup_domainname_text: STRING is
			"The workgroup or domain name is already in use by another computer on the network."

	Error_dup_domainname_value: INTEGER is 1221

	Error_no_network_text: STRING is
			"The network is not present or not started."

	Error_no_network_value: INTEGER is 1222

	Error_cancelled_text: STRING is
			"The operation was canceled by the user."

	Error_cancelled_value: INTEGER is 1223

	Error_user_mapped_file_text: STRING is
			"The requested operation cannot be performed on a file with a user-mapped section open."

	Error_user_mapped_file_value: INTEGER is 1224

	Error_connection_refused_text: STRING is
			"The remote system refused the network connection."

	Error_connection_refused_value: INTEGER is 1225

	Error_graceful_disconnect_text: STRING is
			"The network connection was gracefully closed."

	Error_graceful_disconnect_value: INTEGER is 1226

	Error_address_already_associated_text: STRING is
			"The network transport endpoint already has an address associated with it."

	Error_address_already_associated_value: INTEGER is 1227

	Error_address_not_associated_text: STRING is
			"An address has not yet been associated with the network endpoint."

	Error_address_not_associated_value: INTEGER is 1228

	Error_connection_invalid_text: STRING is
			"An operation was attempted on a nonexistent network connection."

	Error_connection_invalid_value: INTEGER is 1229

	Error_connection_active_text: STRING is
			"An invalid operation was attempted on an active network connection."

	Error_connection_active_value: INTEGER is 1230

	Error_network_unreachable_text: STRING is
			"The network location cannot be reached. For information about network troubleshooting, see Windows Help."

	Error_network_unreachable_value: INTEGER is 1231

	Error_host_unreachable_text: STRING is
			"The network location cannot be reached. For information about network troubleshooting, see Windows Help."

	Error_host_unreachable_value: INTEGER is 1232

	Error_protocol_unreachable_text: STRING is
			"The network location cannot be reached. For information about network troubleshooting, see Windows Help."

	Error_protocol_unreachable_value: INTEGER is 1233

	Error_port_unreachable_text: STRING is
			"No service is operating at the destination network endpoint on the remote system."

	Error_port_unreachable_value: INTEGER is 1234

	Error_request_aborted_text: STRING is
			"The request was aborted."

	Error_request_aborted_value: INTEGER is 1235

	Error_connection_aborted_text: STRING is
			"The network connection was aborted by the local system."

	Error_connection_aborted_value: INTEGER is 1236

	Error_retry_text: STRING is
			"The operation could not be completed. A retry should be performed."

	Error_retry_value: INTEGER is 1237

	Error_connection_count_limit_text: STRING is
			"A connection to the server could not be made because the limit on the number of concurrent connections for this account has been reached."

	Error_connection_count_limit_value: INTEGER is 1238

	Error_login_time_restriction_text: STRING is
			"Attempting to log in during an unauthorized time of day for this account."

	Error_login_time_restriction_value: INTEGER is 1239

	Error_login_wksta_restriction_text: STRING is
			"The account is not authorized to log in from this station."

	Error_login_wksta_restriction_value: INTEGER is 1240

	Error_incorrect_address_text: STRING is
			"The network address could not be used for the operation requested."

	Error_incorrect_address_value: INTEGER is 1241

	Error_already_registered_text: STRING is
			"The service is already registered."

	Error_already_registered_value: INTEGER is 1242

	Error_service_not_found_text: STRING is
			"The specified service does not exist."

	Error_service_not_found_value: INTEGER is 1243

	Error_not_authenticated_text: STRING is
			"The operation being requested was not performed because the user has not been authenticated."

	Error_not_authenticated_value: INTEGER is 1244

	Error_not_logged_on_text: STRING is
			"The operation being requested was not performed because the user has not logged on to the network.  The specified service does not exist."

	Error_not_logged_on_value: INTEGER is 1245

	Error_continue_text: STRING is
			"Continue with work in progress."

	Error_continue_value: INTEGER is 1246

	Error_already_initialized_text: STRING is
			"An attempt was made to perform an initialization operation when initialization has already been completed."

	Error_already_initialized_value: INTEGER is 1247

	Error_no_more_devices_text: STRING is
			"No more local devices."

	Error_no_more_devices_value: INTEGER is 1248

	Error_no_such_site_text: STRING is
			"The specified site does not exist."

	Error_no_such_site_value: INTEGER is 1249

	Error_domain_controller_exists_text: STRING is
			"A domain controller with the specified name already exists."

	Error_domain_controller_exists_value: INTEGER is 1250

	Error_only_if_connected_text: STRING is
			"This operation is supported only when you are connected to the server."

	Error_only_if_connected_value: INTEGER is 1251

	Error_override_nochanges_text: STRING is
			"The group policy framework should call the extension even if there are no changes."

	Error_override_nochanges_value: INTEGER is 1252

	Error_bad_user_profile_text: STRING is
			"The specified user does not have a valid profile."

	Error_bad_user_profile_value: INTEGER is 1253

	Error_not_supported_on_sbs_text: STRING is
			"This operation is not supported on a Microsoft Small Business Server"

	Error_not_supported_on_sbs_value: INTEGER is 1254

	Error_not_all_assigned_text: STRING is
			"Not all privileges referenced are assigned to the caller."

	Error_not_all_assigned_value: INTEGER is 1300

	Error_some_not_mapped_text: STRING is
			"Some mapping between account names and security IDs was not done."

	Error_some_not_mapped_value: INTEGER is 1301

	Error_no_quotas_for_account_text: STRING is
			"No system quota limits are specifically set for this account."

	Error_no_quotas_for_account_value: INTEGER is 1302

	Error_local_user_session_key_text: STRING is
			"No encryption key is available. A well-known encryption key was returned."

	Error_local_user_session_key_value: INTEGER is 1303

	Error_null_lm_password_text: STRING is
			"The password is too complex to be converted to a LAN Manager password. The LAN Manager password returned is a NULL string."

	Error_null_lm_password_value: INTEGER is 1304

	Error_unknown_revision_text: STRING is
			"The revision level is unknown."

	Error_unknown_revision_value: INTEGER is 1305

	Error_revision_mismatch_text: STRING is
			"Indicates two revision levels are incompatible."

	Error_revision_mismatch_value: INTEGER is 1306

	Error_invalid_owner_text: STRING is
			"This security ID may not be assigned as the owner of this object."

	Error_invalid_owner_value: INTEGER is 1307

	Error_invalid_primary_group_text: STRING is
			"This security ID may not be assigned as the primary group of an object."

	Error_invalid_primary_group_value: INTEGER is 1308

	Error_no_impersonation_token_text: STRING is
			"An attempt has been made to operate on an impersonation token by a thread that is not currently impersonating a client."

	Error_no_impersonation_token_value: INTEGER is 1309

	Error_cant_disable_mandatory_text: STRING is
			"The group may not be disabled."

	Error_cant_disable_mandatory_value: INTEGER is 1310

	Error_no_logon_servers_text: STRING is
			"There are currently no logon servers available to service the logon request."

	Error_no_logon_servers_value: INTEGER is 1311

	Error_no_such_logon_session_text: STRING is
			"A specified logon session does not exist. It may already have been terminated."

	Error_no_such_logon_session_value: INTEGER is 1312

	Error_no_such_privilege_text: STRING is
			"A specified privilege does not exist."

	Error_no_such_privilege_value: INTEGER is 1313

	Error_privilege_not_held_text: STRING is
			"A required privilege is not held by the client."

	Error_privilege_not_held_value: INTEGER is 1314

	Error_invalid_account_name_text: STRING is
			"The name provided is not a properly formed account name."

	Error_invalid_account_name_value: INTEGER is 1315

	Error_user_exists_text: STRING is
			"The specified user already exists."

	Error_user_exists_value: INTEGER is 1316

	Error_no_such_user_text: STRING is
			"The specified user does not exist."

	Error_no_such_user_value: INTEGER is 1317

	Error_group_exists_text: STRING is
			"The specified group already exists."

	Error_group_exists_value: INTEGER is 1318

	Error_no_such_group_text: STRING is
			"The specified group does not exist."

	Error_no_such_group_value: INTEGER is 1319

	Error_member_in_group_text: STRING is
			"Either the specified user account is already a member of the specified group, or the specified group cannot be deleted because it contains a member."

	Error_member_in_group_value: INTEGER is 1320

	Error_member_not_in_group_text: STRING is
			"The specified user account is not a member of the specified group account."

	Error_member_not_in_group_value: INTEGER is 1321

	Error_last_admin_text: STRING is
			"The last remaining administration account cannot be disabled or deleted."

	Error_last_admin_value: INTEGER is 1322

	Error_wrong_password_text: STRING is
			"Unable to update the password. The value provided as the current password is incorrect."

	Error_wrong_password_value: INTEGER is 1323

	Error_ill_formed_password_text: STRING is
			"Unable to update the password. The value provided for the new password contains values that are not allowed in passwords."

	Error_ill_formed_password_value: INTEGER is 1324

	Error_password_restriction_text: STRING is
			"Unable to update the password. The value provided for the new password does not meet the length, complexity, or history requirement of the domain."

	Error_password_restriction_value: INTEGER is 1325

	Error_logon_failure_text: STRING is
			"Logon failure: unknown user name or bad password."

	Error_logon_failure_value: INTEGER is 1326

	Error_account_restriction_text: STRING is
			"Logon failure: user account restriction."

	Error_account_restriction_value: INTEGER is 1327

	Error_invalid_logon_hours_text: STRING is
			"Logon failure: account logon time restriction violation."

	Error_invalid_logon_hours_value: INTEGER is 1328

	Error_invalid_workstation_text: STRING is
			"Logon failure: user not allowed to log on to this computer."

	Error_invalid_workstation_value: INTEGER is 1329

	Error_password_expired_text: STRING is
			"Logon failure: the specified account password has expired."

	Error_password_expired_value: INTEGER is 1330

	Error_account_disabled_text: STRING is
			"Logon failure: account currently disabled."

	Error_account_disabled_value: INTEGER is 1331

	Error_none_mapped_text: STRING is
			"No mapping between account names and security IDs was done."

	Error_none_mapped_value: INTEGER is 1332

	Error_too_many_luids_requested_text: STRING is
			"Too many local user identifiers (LUIDs) were requested at one time."

	Error_too_many_luids_requested_value: INTEGER is 1333

	Error_luids_exhausted_text: STRING is
			"No more local user identifiers (LUIDs) are available."

	Error_luids_exhausted_value: INTEGER is 1334

	Error_invalid_sub_authority_text: STRING is
			"The subauthority part of a security ID is invalid for this particular use."

	Error_invalid_sub_authority_value: INTEGER is 1335

	Error_invalid_acl_text: STRING is
			"The access control list (ACL) structure is invalid."

	Error_invalid_acl_value: INTEGER is 1336

	Error_invalid_sid_text: STRING is
			"The security ID structure is invalid."

	Error_invalid_sid_value: INTEGER is 1337

	Error_invalid_security_descr_text: STRING is
			"The security descriptor structure is invalid."

	Error_invalid_security_descr_value: INTEGER is 1338

	Error_bad_inheritance_acl_text: STRING is
			"The inherited access control list (ACL) or access control entry (ACE) could not be built."

	Error_bad_inheritance_acl_value: INTEGER is 1340

	Error_server_disabled_text: STRING is
			"The server is currently disabled."

	Error_server_disabled_value: INTEGER is 1341

	Error_server_not_disabled_text: STRING is
			"The server is currently enabled."

	Error_server_not_disabled_value: INTEGER is 1342

	Error_invalid_id_authority_text: STRING is
			"The value provided was an invalid value for an identifier authority."

	Error_invalid_id_authority_value: INTEGER is 1343

	Error_allotted_space_exceeded_text: STRING is
			"No more memory is available for security information updates."

	Error_allotted_space_exceeded_value: INTEGER is 1344

	Error_invalid_group_attributes_text: STRING is
			"The specified attributes are invalid, or incompatible with the attributes for the group as a whole."

	Error_invalid_group_attributes_value: INTEGER is 1345

	Error_bad_impersonation_level_text: STRING is
			"Either a required impersonation level was not provided, or the provided impersonation level is invalid."

	Error_bad_impersonation_level_value: INTEGER is 1346

	Error_cant_open_anonymous_text: STRING is
			"Cannot open an anonymous level security token."

	Error_cant_open_anonymous_value: INTEGER is 1347

	Error_bad_validation_class_text: STRING is
			"The validation information class requested was invalid."

	Error_bad_validation_class_value: INTEGER is 1348

	Error_bad_token_type_text: STRING is
			"The type of the token is inappropriate for its attempted use."

	Error_bad_token_type_value: INTEGER is 1349

	Error_no_security_on_object_text: STRING is
			"Unable to perform a security operation on an object that has no associated security."

	Error_no_security_on_object_value: INTEGER is 1350

	Error_cant_access_domain_info_text: STRING is
			"Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied."

	Error_cant_access_domain_info_value: INTEGER is 1351

	Error_invalid_server_state_text: STRING is
			"The security account manager (SAM) or local security authority (LSA) server was in the wrong state to perform the security operation."

	Error_invalid_server_state_value: INTEGER is 1352

	Error_invalid_domain_state_text: STRING is
			"The domain was in the wrong state to perform the security operation."

	Error_invalid_domain_state_value: INTEGER is 1353

	Error_invalid_domain_role_text: STRING is
			"This operation is only allowed for the Primary Domain Controller of the domain."

	Error_invalid_domain_role_value: INTEGER is 1354

	Error_no_such_domain_text: STRING is
			"The specified domain either does not exist or could not be contacted."

	Error_no_such_domain_value: INTEGER is 1355

	Error_domain_exists_text: STRING is
			"The specified domain already exists."

	Error_domain_exists_value: INTEGER is 1356

	Error_domain_limit_exceeded_text: STRING is
			"An attempt was made to exceed the limit on the number of domains per server."

	Error_domain_limit_exceeded_value: INTEGER is 1357

	Error_internal_db_corruption_text: STRING is
			"Unable to complete the requested operation because of either a catastrophic media failure or a data structure corruption on the disk."

	Error_internal_db_corruption_value: INTEGER is 1358

	Error_internal_error_text: STRING is
			"An internal error occurred."

	Error_internal_error_value: INTEGER is 1359

	Error_generic_not_mapped_text: STRING is
			"Generic access types were contained in an access mask which should already be mapped to nongeneric types."

	Error_generic_not_mapped_value: INTEGER is 1360

	Error_bad_descriptor_format_text: STRING is
			"A security descriptor is not in the right format (absolute or self-relative)."

	Error_bad_descriptor_format_value: INTEGER is 1361

	Error_not_logon_process_text: STRING is
			"The requested action is restricted for use by logon processes only. The calling process has not registered as a logon process."

	Error_not_logon_process_value: INTEGER is 1362

	Error_logon_session_exists_text: STRING is
			"Cannot start a new logon session with an ID that is already in use."

	Error_logon_session_exists_value: INTEGER is 1363

	Error_no_such_package_text: STRING is
			"A specified authentication package is unknown."

	Error_no_such_package_value: INTEGER is 1364

	Error_bad_logon_session_state_text: STRING is
			"The logon session is not in a state that is consistent with the requested operation."

	Error_bad_logon_session_state_value: INTEGER is 1365

	Error_logon_session_collision_text: STRING is
			"The logon session ID is already in use."

	Error_logon_session_collision_value: INTEGER is 1366

	Error_invalid_logon_type_text: STRING is
			"A logon request contained an invalid logon type value."

	Error_invalid_logon_type_value: INTEGER is 1367

	Error_cannot_impersonate_text: STRING is
			"Unable to impersonate using a named pipe until data has been read from that pipe."

	Error_cannot_impersonate_value: INTEGER is 1368

	Error_rxact_invalid_state_text: STRING is
			"The transaction state of a registry subtree is incompatible with the requested operation."

	Error_rxact_invalid_state_value: INTEGER is 1369

	Error_rxact_commit_failure_text: STRING is
			"An internal security database corruption has been encountered."

	Error_rxact_commit_failure_value: INTEGER is 1370

	Error_special_account_text: STRING is
			"Cannot perform this operation on built-in accounts."

	Error_special_account_value: INTEGER is 1371

	Error_special_group_text: STRING is
			"Cannot perform this operation on this built-in special group."

	Error_special_group_value: INTEGER is 1372

	Error_special_user_text: STRING is
			"Cannot perform this operation on this built-in special user."

	Error_special_user_value: INTEGER is 1373

	Error_members_primary_group_text: STRING is
			"The user cannot be removed from a group because the group is currently the user's primary group."

	Error_members_primary_group_value: INTEGER is 1374

	Error_token_already_in_use_text: STRING is
			"The token is already in use as a primary token."

	Error_token_already_in_use_value: INTEGER is 1375

	Error_no_such_alias_text: STRING is
			"The specified local group does not exist."

	Error_no_such_alias_value: INTEGER is 1376

	Error_member_not_in_alias_text: STRING is
			"The specified account name is not a member of the local group."

	Error_member_not_in_alias_value: INTEGER is 1377

	Error_member_in_alias_text: STRING is
			"The specified account name is already a member of the local group."

	Error_member_in_alias_value: INTEGER is 1378

	Error_alias_exists_text: STRING is
			"The specified local group already exists."

	Error_alias_exists_value: INTEGER is 1379

	Error_logon_not_granted_text: STRING is
			"Logon failure: the user has not been granted the requested logon type at this computer."

	Error_logon_not_granted_value: INTEGER is 1380

	Error_too_many_secrets_text: STRING is
			"The maximum number of secrets that may be stored in a single system has been exceeded."

	Error_too_many_secrets_value: INTEGER is 1381

	Error_secret_too_long_text: STRING is
			"The length of a secret exceeds the maximum length allowed."

	Error_secret_too_long_value: INTEGER is 1382

	Error_internal_db_error_text: STRING is
			"The local security authority database contains an internal inconsistency."

	Error_internal_db_error_value: INTEGER is 1383

	Error_too_many_context_ids_text: STRING is
			"During a logon attempt, the user's security context accumulated too many security IDs."

	Error_too_many_context_ids_value: INTEGER is 1384

	Error_logon_type_not_granted_text: STRING is
			"Logon failure: the user has not been granted the requested logon type at this computer."

	Error_logon_type_not_granted_value: INTEGER is 1385

	Error_nt_cross_encryption_required_text: STRING is
			"A cross-encrypted password is necessary to change a user password."

	Error_nt_cross_encryption_required_value: INTEGER is 1386

	Error_no_such_member_text: STRING is
			"A member could not be added to or removed from the local group because the member does not exist."

	Error_no_such_member_value: INTEGER is 1387

	Error_invalid_member_text: STRING is
			"A new member could not be added to a local group because the member has the wrong account type."

	Error_invalid_member_value: INTEGER is 1388

	Error_too_many_sids_text: STRING is
			"Too many security IDs have been specified."

	Error_too_many_sids_value: INTEGER is 1389

	Error_lm_cross_encryption_required_text: STRING is
			"A cross-encrypted password is necessary to change this user password."

	Error_lm_cross_encryption_required_value: INTEGER is 1390

	Error_no_inheritance_text: STRING is
			"Indicates an ACL contains no inheritable components."

	Error_no_inheritance_value: INTEGER is 1391

	Error_file_corrupt_text: STRING is
			"The file or directory is corrupted and unreadable."

	Error_file_corrupt_value: INTEGER is 1392

	Error_disk_corrupt_text: STRING is
			"The disk structure is corrupted and unreadable."

	Error_disk_corrupt_value: INTEGER is 1393

	Error_no_user_session_key_text: STRING is
			"There is no user session key for the specified logon session."

	Error_no_user_session_key_value: INTEGER is 1394

	Error_license_quota_exceeded_text: STRING is
			"The service being accessed is licensed for a particular number of connections.  No more connections can be made to the service at this time because there are already as many connections as the service can accept."

	Error_license_quota_exceeded_value: INTEGER is 1395

	Error_wrong_target_name_text: STRING is
			"Logon Failure: The target account name is incorrect."

	Error_wrong_target_name_value: INTEGER is 1396

	Error_mutual_auth_failed_text: STRING is
			"Mutual Authentication failed. The server's password is out of date at the domain controller."

	Error_mutual_auth_failed_value: INTEGER is 1397

	Error_time_skew_text: STRING is
			"There is a time difference between the client and server."

	Error_time_skew_value: INTEGER is 1398

	Error_invalid_window_handle_text: STRING is
			"Invalid window handle."

	Error_invalid_window_handle_value: INTEGER is 1400

	Error_invalid_menu_handle_text: STRING is
			"Invalid menu handle."

	Error_invalid_menu_handle_value: INTEGER is 1401

	Error_invalid_cursor_handle_text: STRING is
			"Invalid cursor handle."

	Error_invalid_cursor_handle_value: INTEGER is 1402

	Error_invalid_accel_handle_text: STRING is
			"Invalid accelerator table handle."

	Error_invalid_accel_handle_value: INTEGER is 1403

	Error_invalid_hook_handle_text: STRING is
			"Invalid hook handle."

	Error_invalid_hook_handle_value: INTEGER is 1404

	Error_invalid_dwp_handle_text: STRING is
			"Invalid handle to a multiple-window position structure."

	Error_invalid_dwp_handle_value: INTEGER is 1405

	Error_tlw_with_wschild_text: STRING is
			"Cannot create a top-level child window."

	Error_tlw_with_wschild_value: INTEGER is 1406

	Error_cannot_find_wnd_class_text: STRING is
			"Cannot find window class."

	Error_cannot_find_wnd_class_value: INTEGER is 1407

	Error_window_of_other_thread_text: STRING is
			"Invalid window; it belongs to other thread."

	Error_window_of_other_thread_value: INTEGER is 1408

	Error_hotkey_already_registered_text: STRING is
			"Hot key is already registered."

	Error_hotkey_already_registered_value: INTEGER is 1409

	Error_class_already_exists_text: STRING is
			"Class already exists."

	Error_class_already_exists_value: INTEGER is 1410

	Error_class_does_not_exist_text: STRING is
			"Class does not exist."

	Error_class_does_not_exist_value: INTEGER is 1411

	Error_class_has_windows_text: STRING is
			"Class still has open windows."

	Error_class_has_windows_value: INTEGER is 1412

	Error_invalid_index_text: STRING is
			"Invalid index."

	Error_invalid_index_value: INTEGER is 1413

	Error_invalid_icon_handle_text: STRING is
			"Invalid icon handle."

	Error_invalid_icon_handle_value: INTEGER is 1414

	Error_private_dialog_index_text: STRING is
			"Using private DIALOG window words."

	Error_private_dialog_index_value: INTEGER is 1415

	Error_listbox_id_not_found_text: STRING is
			"The list box identifier was not found."

	Error_listbox_id_not_found_value: INTEGER is 1416

	Error_no_wildcard_characters_text: STRING is
			"No wildcards were found."

	Error_no_wildcard_characters_value: INTEGER is 1417

	Error_clipboard_not_open_text: STRING is
			"Thread does not have a clipboard open."

	Error_clipboard_not_open_value: INTEGER is 1418

	Error_hotkey_not_registered_text: STRING is
			"Hot key is not registered."

	Error_hotkey_not_registered_value: INTEGER is 1419

	Error_window_not_dialog_text: STRING is
			"The window is not a valid dialog window."

	Error_window_not_dialog_value: INTEGER is 1420

	Error_control_id_not_found_text: STRING is
			"Control ID not found."

	Error_control_id_not_found_value: INTEGER is 1421

	Error_invalid_combobox_message_text: STRING is
			"Invalid message for a combo box because it does not have an edit control."

	Error_invalid_combobox_message_value: INTEGER is 1422

	Error_window_not_combobox_text: STRING is
			"The window is not a combo box."

	Error_window_not_combobox_value: INTEGER is 1423

	Error_invalid_edit_height_text: STRING is
			"Height must be less than 256."

	Error_invalid_edit_height_value: INTEGER is 1424

	Error_dc_not_found_text: STRING is
			"Invalid device context (DC) handle."

	Error_dc_not_found_value: INTEGER is 1425

	Error_invalid_hook_filter_text: STRING is
			"Invalid hook procedure type."

	Error_invalid_hook_filter_value: INTEGER is 1426

	Error_invalid_filter_proc_text: STRING is
			"Invalid hook procedure."

	Error_invalid_filter_proc_value: INTEGER is 1427

	Error_hook_needs_hmod_text: STRING is
			"Cannot set nonlocal hook without a module handle."

	Error_hook_needs_hmod_value: INTEGER is 1428

	Error_global_only_hook_text: STRING is
			"This hook procedure can only be set globally."

	Error_global_only_hook_value: INTEGER is 1429

	Error_journal_hook_set_text: STRING is
			"The journal hook procedure is already installed."

	Error_journal_hook_set_value: INTEGER is 1430

	Error_hook_not_installed_text: STRING is
			"The hook procedure is not installed."

	Error_hook_not_installed_value: INTEGER is 1431

	Error_invalid_lb_message_text: STRING is
			"Invalid message for single-selection list box."

	Error_invalid_lb_message_value: INTEGER is 1432

	Error_setcount_on_bad_lb_text: STRING is
			"LB_SETCOUNT sent to non-lazy list box."

	Error_setcount_on_bad_lb_value: INTEGER is 1433

	Error_lb_without_tabstops_text: STRING is
			"This list box does not support tab stops."

	Error_lb_without_tabstops_value: INTEGER is 1434

	Error_destroy_object_of_other_thread_text: STRING is
			"Cannot destroy object created by another thread."

	Error_destroy_object_of_other_thread_value: INTEGER is 1435

	Error_child_window_menu_text: STRING is
			"Child windows cannot have menus."

	Error_child_window_menu_value: INTEGER is 1436

	Error_no_system_menu_text: STRING is
			"The window does not have a system menu."

	Error_no_system_menu_value: INTEGER is 1437

	Error_invalid_msgbox_style_text: STRING is
			"Invalid message box style."

	Error_invalid_msgbox_style_value: INTEGER is 1438

	Error_invalid_spi_value_text: STRING is
			"Invalid system-wide (SPI_*) parameter."

	Error_invalid_spi_value_value: INTEGER is 1439

	Error_screen_already_locked_text: STRING is
			"Screen already locked."

	Error_screen_already_locked_value: INTEGER is 1440

	Error_hwnds_have_diff_parent_text: STRING is
			"All handles to windows in a multiple-window position structure must have the same parent."

	Error_hwnds_have_diff_parent_value: INTEGER is 1441

	Error_not_child_window_text: STRING is
			"The window is not a child window."

	Error_not_child_window_value: INTEGER is 1442

	Error_invalid_gw_command_text: STRING is
			"Invalid GW_* command."

	Error_invalid_gw_command_value: INTEGER is 1443

	Error_invalid_thread_id_text: STRING is
			"Invalid thread identifier."

	Error_invalid_thread_id_value: INTEGER is 1444

	Error_non_mdichild_window_text: STRING is
			"Cannot process a message from a window that is not a multiple document interface (MDI) window."

	Error_non_mdichild_window_value: INTEGER is 1445

	Error_popup_already_active_text: STRING is
			"Popup menu already active."

	Error_popup_already_active_value: INTEGER is 1446

	Error_no_scrollbars_text: STRING is
			"The window does not have scroll bars."

	Error_no_scrollbars_value: INTEGER is 1447

	Error_invalid_scrollbar_range_text: STRING is
			"Scroll bar range cannot be greater than MAXLONG."

	Error_invalid_scrollbar_range_value: INTEGER is 1448

	Error_invalid_showwin_command_text: STRING is
			"Cannot show or remove the window in the way specified."

	Error_invalid_showwin_command_value: INTEGER is 1449

	Error_no_system_resources_text: STRING is
			"Insufficient system resources exist to complete the requested service."

	Error_no_system_resources_value: INTEGER is 1450

	Error_nonpaged_system_resources_text: STRING is
			"Insufficient system resources exist to complete the requested service."

	Error_nonpaged_system_resources_value: INTEGER is 1451

	Error_paged_system_resources_text: STRING is
			"Insufficient system resources exist to complete the requested service."

	Error_paged_system_resources_value: INTEGER is 1452

	Error_working_set_quota_text: STRING is
			"Insufficient quota to complete the requested service."

	Error_working_set_quota_value: INTEGER is 1453

	Error_pagefile_quota_text: STRING is
			"Insufficient quota to complete the requested service."

	Error_pagefile_quota_value: INTEGER is 1454

	Error_commitment_limit_text: STRING is
			"The paging file is too small for this operation to complete."

	Error_commitment_limit_value: INTEGER is 1455

	Error_menu_item_not_found_text: STRING is
			"A menu item was not found."

	Error_menu_item_not_found_value: INTEGER is 1456

	Error_invalid_keyboard_handle_text: STRING is
			"Invalid keyboard layout handle."

	Error_invalid_keyboard_handle_value: INTEGER is 1457

	Error_hook_type_not_allowed_text: STRING is
			"Hook type not allowed."

	Error_hook_type_not_allowed_value: INTEGER is 1458

	Error_requires_interactive_windowstation_text: STRING is
			"This operation requires an interactive window station."

	Error_requires_interactive_windowstation_value: INTEGER is 1459

	Error_timeout_text: STRING is
			"This operation returned because the timeout period expired."

	Error_timeout_value: INTEGER is 1460

	Error_invalid_monitor_handle_text: STRING is
			"Invalid monitor handle."

	Error_invalid_monitor_handle_value: INTEGER is 1461

	Error_eventlog_file_corrupt_text: STRING is
			"The event log file is corrupted."

	Error_eventlog_file_corrupt_value: INTEGER is 1500

	Error_eventlog_cant_start_text: STRING is
			"No event log file could be opened, so the event logging service did not start."

	Error_eventlog_cant_start_value: INTEGER is 1501

	Error_log_file_full_text: STRING is
			"The event log file is full."

	Error_log_file_full_value: INTEGER is 1502

	Error_eventlog_file_changed_text: STRING is
			"The event log file has changed between read operations."

	Error_eventlog_file_changed_value: INTEGER is 1503

	Error_install_service_failure_text: STRING is
			"The Windows Installer service could not be accessed.  Contact your support personnel to verify that the Windows Installer service is properly registered."

	Error_install_service_failure_value: INTEGER is 1601

	Error_install_userexit_text: STRING is
			"User cancelled installation."

	Error_install_userexit_value: INTEGER is 1602

	Error_install_failure_text: STRING is
			"Fatal error during installation."

	Error_install_failure_value: INTEGER is 1603

	Error_install_suspend_text: STRING is
			"Installation suspended, incomplete."

	Error_install_suspend_value: INTEGER is 1604

	Error_unknown_product_text: STRING is
			"This action is only valid for products that are currently installed."

	Error_unknown_product_value: INTEGER is 1605

	Error_unknown_feature_text: STRING is
			"Feature ID not registered."

	Error_unknown_feature_value: INTEGER is 1606

	Error_unknown_component_text: STRING is
			"Component ID not registered."

	Error_unknown_component_value: INTEGER is 1607

	Error_unknown_property_text: STRING is
			"Unknown property."

	Error_unknown_property_value: INTEGER is 1608

	Error_invalid_handle_state_text: STRING is
			"Handle is in an invalid state."

	Error_invalid_handle_state_value: INTEGER is 1609

	Error_bad_configuration_text: STRING is
			"The configuration data for this product is corrupt.  Contact your support personnel."

	Error_bad_configuration_value: INTEGER is 1610

	Error_index_absent_text: STRING is
			"Component qualifier not present."

	Error_index_absent_value: INTEGER is 1611

	Error_install_source_absent_text: STRING is
			"The installation source for this product is not available.  Verify that the source exists and that you can access it."

	Error_install_source_absent_value: INTEGER is 1612

	Error_install_package_version_text: STRING is
			"This installation package cannot be installed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service."

	Error_install_package_version_value: INTEGER is 1613

	Error_product_uninstalled_text: STRING is
			"Product is uninstalled."

	Error_product_uninstalled_value: INTEGER is 1614

	Error_bad_query_syntax_text: STRING is
			"SQL query syntax invalid or unsupported."

	Error_bad_query_syntax_value: INTEGER is 1615

	Error_invalid_field_text: STRING is
			"Record field does not exist."

	Error_invalid_field_value: INTEGER is 1616

	Error_device_removed_text: STRING is
			"The device has been removed."

	Error_device_removed_value: INTEGER is 1617

	Error_install_already_running_text: STRING is
			"Another installation is already in progress.  Complete that installation before proceeding with this install."

	Error_install_already_running_value: INTEGER is 1618

	Error_install_package_open_failed_text: STRING is
			"This installation package could not be opened.  Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package."

	Error_install_package_open_failed_value: INTEGER is 1619

	Error_install_package_invalid_text: STRING is
			"This installation package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer package."

	Error_install_package_invalid_value: INTEGER is 1620

	Error_install_ui_failure_text: STRING is
			"There was an error starting the Windows Installer service user interface.  Contact your support personnel."

	Error_install_ui_failure_value: INTEGER is 1621

	Error_install_log_failure_text: STRING is
			"Error opening installation log file. Verify that the specified log file location exists and that you can write to it."

	Error_install_log_failure_value: INTEGER is 1622

	Error_install_language_unsupported_text: STRING is
			"The language of this installation package is not supported by your system."

	Error_install_language_unsupported_value: INTEGER is 1623

	Error_install_transform_failure_text: STRING is
			"Error applying transforms.  Verify that the specified transform paths are valid."

	Error_install_transform_failure_value: INTEGER is 1624

	Error_install_package_rejected_text: STRING is
			"This installation is forbidden by system policy.  Contact your system administrator."

	Error_install_package_rejected_value: INTEGER is 1625

	Error_function_not_called_text: STRING is
			"Function could not be executed."

	Error_function_not_called_value: INTEGER is 1626

	Error_function_failed_text: STRING is
			"Function failed during execution."

	Error_function_failed_value: INTEGER is 1627

	Error_invalid_table_text: STRING is
			"Invalid or unknown table specified."

	Error_invalid_table_value: INTEGER is 1628

	Error_datatype_mismatch_text: STRING is
			"Data supplied is of wrong type."

	Error_datatype_mismatch_value: INTEGER is 1629

	Error_unsupported_type_text: STRING is
			"Data of this type is not supported."

	Error_unsupported_type_value: INTEGER is 1630

	Error_create_failed_text: STRING is
			"The Windows Installer service failed to start.  Contact your support personnel."

	Error_create_failed_value: INTEGER is 1631

	Error_install_temp_unwritable_text: STRING is
			"The temp folder is either full or inaccessible.  Verify that the temp folder exists and that you can write to it."

	Error_install_temp_unwritable_value: INTEGER is 1632

	Error_install_platform_unsupported_text: STRING is
			"This installation package is not supported by this processor type. Contact your product vendor."

	Error_install_platform_unsupported_value: INTEGER is 1633

	Error_install_notused_text: STRING is
			"Component not used on this computer."

	Error_install_notused_value: INTEGER is 1634

	Error_patch_package_open_failed_text: STRING is
			"This patch package could not be opened.  Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package."

	Error_patch_package_open_failed_value: INTEGER is 1635

	Error_patch_package_invalid_text: STRING is
			"This patch package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer patch package."

	Error_patch_package_invalid_value: INTEGER is 1636

	Error_patch_package_unsupported_text: STRING is
			"This patch package cannot be processed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service."

	Error_patch_package_unsupported_value: INTEGER is 1637

	Error_product_version_text: STRING is
			"Another version of this product is already installed.  Installation of this version cannot continue.  To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel."

	Error_product_version_value: INTEGER is 1638

	Error_invalid_command_line_text: STRING is
			"Invalid command line argument.  Consult the Windows Installer SDK for detailed command line help."

	Error_invalid_command_line_value: INTEGER is 1639

	Error_install_remote_disallowed_text: STRING is
			"Only administrators have permission to add, remove, or configure server software during a Terminal services remote session. If you want to install or configure software on the server, contact your network administrator."

	Error_install_remote_disallowed_value: INTEGER is 1640

	Error_success_reboot_initiated_text: STRING is
			"The requested operation completed successfully.  The system will be restarted so the changes can take effect."

	Error_success_reboot_initiated_value: INTEGER is 1641

	Error_patch_target_not_found_text: STRING is
			"The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch."

	Error_patch_target_not_found_value: INTEGER is 1642

	Rpc_s_invalid_string_binding_text: STRING is
			"The string binding is invalid."

	Rpc_s_invalid_string_binding_value: INTEGER is 1700

	Rpc_s_wrong_kind_of_binding_text: STRING is
			"The binding handle is not the correct type."

	Rpc_s_wrong_kind_of_binding_value: INTEGER is 1701

	Rpc_s_invalid_binding_text: STRING is
			"The binding handle is invalid."

	Rpc_s_invalid_binding_value: INTEGER is 1702

	Rpc_s_protseq_not_supported_text: STRING is
			"The RPC protocol sequence is not supported."

	Rpc_s_protseq_not_supported_value: INTEGER is 1703

	Rpc_s_invalid_rpc_protseq_text: STRING is
			"The RPC protocol sequence is invalid."

	Rpc_s_invalid_rpc_protseq_value: INTEGER is 1704

	Rpc_s_invalid_string_uuid_text: STRING is
			"The string universal unique identifier (UUID) is invalid."

	Rpc_s_invalid_string_uuid_value: INTEGER is 1705

	Rpc_s_invalid_endpoint_format_text: STRING is
			"The endpoint format is invalid."

	Rpc_s_invalid_endpoint_format_value: INTEGER is 1706

	Rpc_s_invalid_net_addr_text: STRING is
			"The network address is invalid."

	Rpc_s_invalid_net_addr_value: INTEGER is 1707

	Rpc_s_no_endpoint_found_text: STRING is
			"No endpoint was found."

	Rpc_s_no_endpoint_found_value: INTEGER is 1708

	Rpc_s_invalid_timeout_text: STRING is
			"The timeout value is invalid."

	Rpc_s_invalid_timeout_value: INTEGER is 1709

	Rpc_s_object_not_found_text: STRING is
			"The object universal unique identifier (UUID) was not found."

	Rpc_s_object_not_found_value: INTEGER is 1710

	Rpc_s_already_registered_text: STRING is
			"The object universal unique identifier (UUID) has already been registered."

	Rpc_s_already_registered_value: INTEGER is 1711

	Rpc_s_type_already_registered_text: STRING is
			"The type universal unique identifier (UUID) has already been registered."

	Rpc_s_type_already_registered_value: INTEGER is 1712

	Rpc_s_already_listening_text: STRING is
			"The RPC server is already listening."

	Rpc_s_already_listening_value: INTEGER is 1713

	Rpc_s_no_protseqs_registered_text: STRING is
			"No protocol sequences have been registered."

	Rpc_s_no_protseqs_registered_value: INTEGER is 1714

	Rpc_s_not_listening_text: STRING is
			"The RPC server is not listening."

	Rpc_s_not_listening_value: INTEGER is 1715

	Rpc_s_unknown_mgr_type_text: STRING is
			"The manager type is unknown."

	Rpc_s_unknown_mgr_type_value: INTEGER is 1716

	Rpc_s_unknown_if_text: STRING is
			"The interface is unknown."

	Rpc_s_unknown_if_value: INTEGER is 1717

	Rpc_s_no_bindings_text: STRING is
			"There are no bindings."

	Rpc_s_no_bindings_value: INTEGER is 1718

	Rpc_s_no_protseqs_text: STRING is
			"There are no protocol sequences."

	Rpc_s_no_protseqs_value: INTEGER is 1719

	Rpc_s_cant_create_endpoint_text: STRING is
			"The endpoint cannot be created."

	Rpc_s_cant_create_endpoint_value: INTEGER is 1720

	Rpc_s_out_of_resources_text: STRING is
			"Not enough resources are available to complete this operation."

	Rpc_s_out_of_resources_value: INTEGER is 1721

	Rpc_s_server_unavailable_text: STRING is
			"The RPC server is unavailable."

	Rpc_s_server_unavailable_value: INTEGER is 1722

	Rpc_s_server_too_busy_text: STRING is
			"The RPC server is too busy to complete this operation."

	Rpc_s_server_too_busy_value: INTEGER is 1723

	Rpc_s_invalid_network_options_text: STRING is
			"The network options are invalid."

	Rpc_s_invalid_network_options_value: INTEGER is 1724

	Rpc_s_no_call_active_text: STRING is
			"There are no remote procedure calls active on this thread."

	Rpc_s_no_call_active_value: INTEGER is 1725

	Rpc_s_call_failed_text: STRING is
			"The remote procedure call failed."

	Rpc_s_call_failed_value: INTEGER is 1726

	Rpc_s_call_failed_dne_text: STRING is
			"The remote procedure call failed and did not execute."

	Rpc_s_call_failed_dne_value: INTEGER is 1727

	Rpc_s_protocol_error_text: STRING is
			"A remote procedure call (RPC) protocol error occurred."

	Rpc_s_protocol_error_value: INTEGER is 1728

	Rpc_s_unsupported_trans_syn_text: STRING is
			"The transfer syntax is not supported by the RPC server."

	Rpc_s_unsupported_trans_syn_value: INTEGER is 1730

	Rpc_s_unsupported_type_text: STRING is
			"The universal unique identifier (UUID) type is not supported."

	Rpc_s_unsupported_type_value: INTEGER is 1732

	Rpc_s_invalid_tag_text: STRING is
			"The tag is invalid."

	Rpc_s_invalid_tag_value: INTEGER is 1733

	Rpc_s_invalid_bound_text: STRING is
			"The array bounds are invalid."

	Rpc_s_invalid_bound_value: INTEGER is 1734

	Rpc_s_no_entry_name_text: STRING is
			"The binding does not contain an entry name."

	Rpc_s_no_entry_name_value: INTEGER is 1735

	Rpc_s_invalid_name_syntax_text: STRING is
			"The name syntax is invalid."

	Rpc_s_invalid_name_syntax_value: INTEGER is 1736

	Rpc_s_unsupported_name_syntax_text: STRING is
			"The name syntax is not supported."

	Rpc_s_unsupported_name_syntax_value: INTEGER is 1737

	Rpc_s_uuid_no_address_text: STRING is
			"No network address is available to use to construct a universal unique identifier (UUID)."

	Rpc_s_uuid_no_address_value: INTEGER is 1739

	Rpc_s_duplicate_endpoint_text: STRING is
			"The endpoint is a duplicate."

	Rpc_s_duplicate_endpoint_value: INTEGER is 1740

	Rpc_s_unknown_authn_type_text: STRING is
			"The authentication type is unknown."

	Rpc_s_unknown_authn_type_value: INTEGER is 1741

	Rpc_s_max_calls_too_small_text: STRING is
			"The maximum number of calls is too small."

	Rpc_s_max_calls_too_small_value: INTEGER is 1742

	Rpc_s_string_too_long_text: STRING is
			"The string is too long."

	Rpc_s_string_too_long_value: INTEGER is 1743

	Rpc_s_protseq_not_found_text: STRING is
			"The RPC protocol sequence was not found."

	Rpc_s_protseq_not_found_value: INTEGER is 1744

	Rpc_s_procnum_out_of_range_text: STRING is
			"The procedure number is out of range."

	Rpc_s_procnum_out_of_range_value: INTEGER is 1745

	Rpc_s_binding_has_no_auth_text: STRING is
			"The binding does not contain any authentication information."

	Rpc_s_binding_has_no_auth_value: INTEGER is 1746

	Rpc_s_unknown_authn_service_text: STRING is
			"The authentication service is unknown."

	Rpc_s_unknown_authn_service_value: INTEGER is 1747

	Rpc_s_unknown_authn_level_text: STRING is
			"The authentication level is unknown."

	Rpc_s_unknown_authn_level_value: INTEGER is 1748

	Rpc_s_invalid_auth_identity_text: STRING is
			"The security context is invalid."

	Rpc_s_invalid_auth_identity_value: INTEGER is 1749

	Rpc_s_unknown_authz_service_text: STRING is
			"The authorization service is unknown."

	Rpc_s_unknown_authz_service_value: INTEGER is 1750

	Ept_s_invalid_entry_text: STRING is
			"The entry is invalid."

	Ept_s_invalid_entry_value: INTEGER is 1751

	Ept_s_cant_perform_op_text: STRING is
			"The server endpoint cannot perform the operation."

	Ept_s_cant_perform_op_value: INTEGER is 1752

	Ept_s_not_registered_text: STRING is
			"There are no more endpoints available from the endpoint mapper."

	Ept_s_not_registered_value: INTEGER is 1753

	Rpc_s_nothing_to_export_text: STRING is
			"No interfaces have been exported."

	Rpc_s_nothing_to_export_value: INTEGER is 1754

	Rpc_s_incomplete_name_text: STRING is
			"The entry name is incomplete."

	Rpc_s_incomplete_name_value: INTEGER is 1755

	Rpc_s_invalid_vers_option_text: STRING is
			"The version option is invalid."

	Rpc_s_invalid_vers_option_value: INTEGER is 1756

	Rpc_s_no_more_members_text: STRING is
			"There are no more members."

	Rpc_s_no_more_members_value: INTEGER is 1757

	Rpc_s_not_all_objs_unexported_text: STRING is
			"There is nothing to unexport."

	Rpc_s_not_all_objs_unexported_value: INTEGER is 1758

	Rpc_s_interface_not_found_text: STRING is
			"The interface was not found."

	Rpc_s_interface_not_found_value: INTEGER is 1759

	Rpc_s_entry_already_exists_text: STRING is
			"The entry already exists."

	Rpc_s_entry_already_exists_value: INTEGER is 1760

	Rpc_s_entry_not_found_text: STRING is
			"The entry is not found."

	Rpc_s_entry_not_found_value: INTEGER is 1761

	Rpc_s_name_service_unavailable_text: STRING is
			"The name service is unavailable."

	Rpc_s_name_service_unavailable_value: INTEGER is 1762

	Rpc_s_invalid_naf_id_text: STRING is
			"The network address family is invalid."

	Rpc_s_invalid_naf_id_value: INTEGER is 1763

	Rpc_s_cannot_support_text: STRING is
			"The requested operation is not supported."

	Rpc_s_cannot_support_value: INTEGER is 1764

	Rpc_s_no_context_available_text: STRING is
			"No security context is available to allow impersonation."

	Rpc_s_no_context_available_value: INTEGER is 1765

	Rpc_s_internal_error_text: STRING is
			"An internal error occurred in a remote procedure call (RPC)."

	Rpc_s_internal_error_value: INTEGER is 1766

	Rpc_s_zero_divide_text: STRING is
			"The RPC server attempted an integer division by zero."

	Rpc_s_zero_divide_value: INTEGER is 1767

	Rpc_s_address_error_text: STRING is
			"An addressing error occurred in the RPC server."

	Rpc_s_address_error_value: INTEGER is 1768

	Rpc_s_fp_div_zero_text: STRING is
			"A floating-point operation at the RPC server caused a division by zero."

	Rpc_s_fp_div_zero_value: INTEGER is 1769

	Rpc_s_fp_underflow_text: STRING is
			"A floating-point underflow occurred at the RPC server."

	Rpc_s_fp_underflow_value: INTEGER is 1770

	Rpc_s_fp_overflow_text: STRING is
			"A floating-point overflow occurred at the RPC server."

	Rpc_s_fp_overflow_value: INTEGER is 1771

	Rpc_x_no_more_entries_text: STRING is
			"The list of RPC servers available for the binding of auto handles has been exhausted."

	Rpc_x_no_more_entries_value: INTEGER is 1772

	Rpc_x_ss_char_trans_open_fail_text: STRING is
			"Unable to open the character translation table file."

	Rpc_x_ss_char_trans_open_fail_value: INTEGER is 1773

	Rpc_x_ss_char_trans_short_file_text: STRING is
			"The file containing the character translation table has fewer than 512 bytes."

	Rpc_x_ss_char_trans_short_file_value: INTEGER is 1774

	Rpc_x_ss_in_null_context_text: STRING is
			"A null context handle was passed from the client to the host during a remote procedure call."

	Rpc_x_ss_in_null_context_value: INTEGER is 1775

	Rpc_x_ss_context_damaged_text: STRING is
			"The context handle changed during a remote procedure call."

	Rpc_x_ss_context_damaged_value: INTEGER is 1777

	Rpc_x_ss_handles_mismatch_text: STRING is
			"The binding handles passed to a remote procedure call do not match."

	Rpc_x_ss_handles_mismatch_value: INTEGER is 1778

	Rpc_x_ss_cannot_get_call_handle_text: STRING is
			"The stub is unable to get the remote procedure call handle."

	Rpc_x_ss_cannot_get_call_handle_value: INTEGER is 1779

	Rpc_x_null_ref_pointer_text: STRING is
			"A null reference pointer was passed to the stub."

	Rpc_x_null_ref_pointer_value: INTEGER is 1780

	Rpc_x_enum_value_out_of_range_text: STRING is
			"The enumeration value is out of range."

	Rpc_x_enum_value_out_of_range_value: INTEGER is 1781

	Rpc_x_byte_count_too_small_text: STRING is
			"The byte count is too small."

	Rpc_x_byte_count_too_small_value: INTEGER is 1782

	Rpc_x_bad_stub_data_text: STRING is
			"The stub received bad data."

	Rpc_x_bad_stub_data_value: INTEGER is 1783

	Error_invalid_user_buffer_text: STRING is
			"The supplied user buffer is not valid for the requested operation."

	Error_invalid_user_buffer_value: INTEGER is 1784

	Error_unrecognized_media_text: STRING is
			"The disk media is not recognized. It may not be formatted."

	Error_unrecognized_media_value: INTEGER is 1785

	Error_no_trust_lsa_secret_text: STRING is
			"The workstation does not have a trust secret."

	Error_no_trust_lsa_secret_value: INTEGER is 1786

	Error_no_trust_sam_account_text: STRING is
			"The security database on the server does not have a computer account for this workstation trust relationship."

	Error_no_trust_sam_account_value: INTEGER is 1787

	Error_trusted_domain_failure_text: STRING is
			"The trust relationship between the primary domain and the trusted domain failed."

	Error_trusted_domain_failure_value: INTEGER is 1788

	Error_trusted_relationship_failure_text: STRING is
			"The trust relationship between this workstation and the primary domain failed."

	Error_trusted_relationship_failure_value: INTEGER is 1789

	Error_trust_failure_text: STRING is
			"The network logon failed."

	Error_trust_failure_value: INTEGER is 1790

	Rpc_s_call_in_progress_text: STRING is
			"A remote procedure call is already in progress for this thread."

	Rpc_s_call_in_progress_value: INTEGER is 1791

	Error_netlogon_not_started_text: STRING is
			"An attempt was made to logon, but the network logon service was not started."

	Error_netlogon_not_started_value: INTEGER is 1792

	Error_account_expired_text: STRING is
			"The user's account has expired."

	Error_account_expired_value: INTEGER is 1793

	Error_redirector_has_open_handles_text: STRING is
			"The redirector is in use and cannot be unloaded."

	Error_redirector_has_open_handles_value: INTEGER is 1794

	Error_printer_driver_already_installed_text: STRING is
			"The specified printer driver is already installed."

	Error_printer_driver_already_installed_value: INTEGER is 1795

	Error_unknown_port_text: STRING is
			"The specified port is unknown."

	Error_unknown_port_value: INTEGER is 1796

	Error_unknown_printer_driver_text: STRING is
			"The printer driver is unknown."

	Error_unknown_printer_driver_value: INTEGER is 1797

	Error_unknown_printprocessor_text: STRING is
			"The print processor is unknown."

	Error_unknown_printprocessor_value: INTEGER is 1798

	Error_invalid_separator_file_text: STRING is
			"The specified separator file is invalid."

	Error_invalid_separator_file_value: INTEGER is 1799

	Error_invalid_priority_text: STRING is
			"The specified priority is invalid."

	Error_invalid_priority_value: INTEGER is 1800

	Error_invalid_printer_name_text: STRING is
			"The printer name is invalid."

	Error_invalid_printer_name_value: INTEGER is 1801

	Error_printer_already_exists_text: STRING is
			"The printer already exists."

	Error_printer_already_exists_value: INTEGER is 1802

	Error_invalid_printer_command_text: STRING is
			"The printer command is invalid."

	Error_invalid_printer_command_value: INTEGER is 1803

	Error_invalid_datatype_text: STRING is
			"The specified datatype is invalid."

	Error_invalid_datatype_value: INTEGER is 1804

	Error_invalid_environment_text: STRING is
			"The environment specified is invalid."

	Error_invalid_environment_value: INTEGER is 1805

	Rpc_s_no_more_bindings_text: STRING is
			"There are no more bindings."

	Rpc_s_no_more_bindings_value: INTEGER is 1806

	Error_nologon_interdomain_trust_account_text: STRING is
			"The account used is an interdomain trust account. Use your global user account or local user account to access this server."

	Error_nologon_interdomain_trust_account_value: INTEGER is 1807

	Error_nologon_workstation_trust_account_text: STRING is
			"The account used is a computer account. Use your global user account or local user account to access this server."

	Error_nologon_workstation_trust_account_value: INTEGER is 1808

	Error_nologon_server_trust_account_text: STRING is
			"The account used is a server trust account. Use your global user account or local user account to access this server."

	Error_nologon_server_trust_account_value: INTEGER is 1809

	Error_domain_trust_inconsistent_text: STRING is
			"The name or security ID (SID) of the domain specified is inconsistent with the trust information for that domain."

	Error_domain_trust_inconsistent_value: INTEGER is 1810

	Error_server_has_open_handles_text: STRING is
			"The server is in use and cannot be unloaded."

	Error_server_has_open_handles_value: INTEGER is 1811

	Error_resource_data_not_found_text: STRING is
			"The specified image file did not contain a resource section."

	Error_resource_data_not_found_value: INTEGER is 1812

	Error_resource_type_not_found_text: STRING is
			"The specified resource type cannot be found in the image file."

	Error_resource_type_not_found_value: INTEGER is 1813

	Error_resource_name_not_found_text: STRING is
			"The specified resource name cannot be found in the image file."

	Error_resource_name_not_found_value: INTEGER is 1814

	Error_resource_lang_not_found_text: STRING is
			"The specified resource language ID cannot be found in the image file."

	Error_resource_lang_not_found_value: INTEGER is 1815

	Error_not_enough_quota_text: STRING is
			"Not enough quota is available to process this command."

	Error_not_enough_quota_value: INTEGER is 1816

	Rpc_s_no_interfaces_text: STRING is
			"No interfaces have been registered."

	Rpc_s_no_interfaces_value: INTEGER is 1817

	Rpc_s_call_cancelled_text: STRING is
			"The remote procedure call was cancelled."

	Rpc_s_call_cancelled_value: INTEGER is 1818

	Rpc_s_binding_incomplete_text: STRING is
			"The binding handle does not contain all required information."

	Rpc_s_binding_incomplete_value: INTEGER is 1819

	Rpc_s_comm_failure_text: STRING is
			"A communications failure occurred during a remote procedure call."

	Rpc_s_comm_failure_value: INTEGER is 1820

	Rpc_s_unsupported_authn_level_text: STRING is
			"The requested authentication level is not supported."

	Rpc_s_unsupported_authn_level_value: INTEGER is 1821

	Rpc_s_no_princ_name_text: STRING is
			"No principal name registered."

	Rpc_s_no_princ_name_value: INTEGER is 1822

	Rpc_s_not_rpc_error_text: STRING is
			"The error specified is not a valid Windows RPC error code."

	Rpc_s_not_rpc_error_value: INTEGER is 1823

	Rpc_s_uuid_local_only_text: STRING is
			"A UUID that is valid only on this computer has been allocated."

	Rpc_s_uuid_local_only_value: INTEGER is 1824

	Rpc_s_sec_pkg_error_text: STRING is
			"A security package specific error occurred."

	Rpc_s_sec_pkg_error_value: INTEGER is 1825

	Rpc_s_not_cancelled_text: STRING is
			"Thread is not canceled."

	Rpc_s_not_cancelled_value: INTEGER is 1826

	Rpc_x_invalid_es_action_text: STRING is
			"Invalid operation on the encoding/decoding handle."

	Rpc_x_invalid_es_action_value: INTEGER is 1827

	Rpc_x_wrong_es_version_text: STRING is
			"Incompatible version of the serializing package."

	Rpc_x_wrong_es_version_value: INTEGER is 1828

	Rpc_x_wrong_stub_version_text: STRING is
			"Incompatible version of the RPC stub."

	Rpc_x_wrong_stub_version_value: INTEGER is 1829

	Rpc_x_invalid_pipe_object_text: STRING is
			"The RPC pipe object is invalid or corrupted."

	Rpc_x_invalid_pipe_object_value: INTEGER is 1830

	Rpc_x_wrong_pipe_order_text: STRING is
			"An invalid operation was attempted on an RPC pipe object."

	Rpc_x_wrong_pipe_order_value: INTEGER is 1831

	Rpc_x_wrong_pipe_version_text: STRING is
			"Unsupported RPC pipe version."

	Rpc_x_wrong_pipe_version_value: INTEGER is 1832

	Rpc_s_group_member_not_found_text: STRING is
			"The group member was not found."

	Rpc_s_group_member_not_found_value: INTEGER is 1898

	Ept_s_cant_create_text: STRING is
			"The endpoint mapper database entry could not be created."

	Ept_s_cant_create_value: INTEGER is 1899

	Rpc_s_invalid_object_text: STRING is
			"The object universal unique identifier (UUID) is the nil UUID."

	Rpc_s_invalid_object_value: INTEGER is 1900

	Error_invalid_time_text: STRING is
			"The specified time is invalid."

	Error_invalid_time_value: INTEGER is 1901

	Error_invalid_form_name_text: STRING is
			"The specified form name is invalid."

	Error_invalid_form_name_value: INTEGER is 1902

	Error_invalid_form_size_text: STRING is
			"The specified form size is invalid."

	Error_invalid_form_size_value: INTEGER is 1903

	Error_already_waiting_text: STRING is
			"The specified printer handle is already being waited on"

	Error_already_waiting_value: INTEGER is 1904

	Error_printer_deleted_text: STRING is
			"The specified printer has been deleted."

	Error_printer_deleted_value: INTEGER is 1905

	Error_invalid_printer_state_text: STRING is
			"The state of the printer is invalid."

	Error_invalid_printer_state_value: INTEGER is 1906

	Error_password_must_change_text: STRING is
			"The user's password must be changed before logging on the first time."

	Error_password_must_change_value: INTEGER is 1907

	Error_domain_controller_not_found_text: STRING is
			"Could not find the domain controller for this domain."

	Error_domain_controller_not_found_value: INTEGER is 1908

	Error_account_locked_out_text: STRING is
			"The referenced account is currently locked out and may not be logged on to."

	Error_account_locked_out_value: INTEGER is 1909

	Or_invalid_oxid_text: STRING is
			"The object exporter specified was not found."

	Or_invalid_oxid_value: INTEGER is 1910

	Or_invalid_oid_text: STRING is
			"The object specified was not found."

	Or_invalid_oid_value: INTEGER is 1911

	Or_invalid_set_text: STRING is
			"The object resolver set specified was not found."

	Or_invalid_set_value: INTEGER is 1912

	Rpc_s_send_incomplete_text: STRING is
			"Some data remains to be sent in the request buffer."

	Rpc_s_send_incomplete_value: INTEGER is 1913

	Rpc_s_invalid_async_handle_text: STRING is
			"Invalid asynchronous remote procedure call handle."

	Rpc_s_invalid_async_handle_value: INTEGER is 1914

	Rpc_s_invalid_async_call_text: STRING is
			"Invalid asynchronous RPC call handle for this operation."

	Rpc_s_invalid_async_call_value: INTEGER is 1915

	Rpc_x_pipe_closed_text: STRING is
			"The RPC pipe object has already been closed."

	Rpc_x_pipe_closed_value: INTEGER is 1916

	Rpc_x_pipe_discipline_error_text: STRING is
			"The RPC call completed before all pipes were processed."

	Rpc_x_pipe_discipline_error_value: INTEGER is 1917

	Rpc_x_pipe_empty_text: STRING is
			"No more data is available from the RPC pipe."

	Rpc_x_pipe_empty_value: INTEGER is 1918

	Error_no_sitename_text: STRING is
			"No site name is available for this machine."

	Error_no_sitename_value: INTEGER is 1919

	Error_cant_access_file_text: STRING is
			"The file can not be accessed by the system."

	Error_cant_access_file_value: INTEGER is 1920

	Error_cant_resolve_filename_text: STRING is
			"The name of the file cannot be resolved by the system."

	Error_cant_resolve_filename_value: INTEGER is 1921

	Rpc_s_entry_type_mismatch_text: STRING is
			"The entry is not of the expected type."

	Rpc_s_entry_type_mismatch_value: INTEGER is 1922

	Rpc_s_not_all_objs_exported_text: STRING is
			"Not all object UUIDs could be exported to the specified entry."

	Rpc_s_not_all_objs_exported_value: INTEGER is 1923

	Rpc_s_interface_not_exported_text: STRING is
			"Interface could not be exported to the specified entry."

	Rpc_s_interface_not_exported_value: INTEGER is 1924

	Rpc_s_profile_not_added_text: STRING is
			"The specified profile entry could not be added."

	Rpc_s_profile_not_added_value: INTEGER is 1925

	Rpc_s_prf_elt_not_added_text: STRING is
			"The specified profile element could not be added."

	Rpc_s_prf_elt_not_added_value: INTEGER is 1926

	Rpc_s_prf_elt_not_removed_text: STRING is
			"The specified profile element could not be removed."

	Rpc_s_prf_elt_not_removed_value: INTEGER is 1927

	Rpc_s_grp_elt_not_added_text: STRING is
			"The group element could not be added."

	Rpc_s_grp_elt_not_added_value: INTEGER is 1928

	Rpc_s_grp_elt_not_removed_text: STRING is
			"The group element could not be removed."

	Rpc_s_grp_elt_not_removed_value: INTEGER is 1929

	Error_no_browser_servers_found_text: STRING is
			"The list of servers for this workgroup is not currently available"

	Error_no_browser_servers_found_value: INTEGER is 6118

	Error_invalid_pixel_format_text: STRING is
			"The pixel format is invalid."

	Error_invalid_pixel_format_value: INTEGER is 2000

	Error_bad_driver_text: STRING is
			"The specified driver is invalid."

	Error_bad_driver_value: INTEGER is 2001

	Error_invalid_window_style_text: STRING is
			"The window style or class attribute is invalid for this operation."

	Error_invalid_window_style_value: INTEGER is 2002

	Error_metafile_not_supported_text: STRING is
			"The requested metafile operation is not supported."

	Error_metafile_not_supported_value: INTEGER is 2003

	Error_transform_not_supported_text: STRING is
			"The requested transformation operation is not supported."

	Error_transform_not_supported_value: INTEGER is 2004

	Error_clipping_not_supported_text: STRING is
			"The requested clipping operation is not supported."

	Error_clipping_not_supported_value: INTEGER is 2005

	Error_invalid_cmm_text: STRING is
			"The specified color management module is invalid."

	Error_invalid_cmm_value: INTEGER is 2010

	Error_invalid_profile_text: STRING is
			"The specified color profile is invalid."

	Error_invalid_profile_value: INTEGER is 2011

	Error_tag_not_found_text: STRING is
			"The specified tag was not found."

	Error_tag_not_found_value: INTEGER is 2012

	Error_tag_not_present_text: STRING is
			"A required tag is not present."

	Error_tag_not_present_value: INTEGER is 2013

	Error_duplicate_tag_text: STRING is
			"The specified tag is already present."

	Error_duplicate_tag_value: INTEGER is 2014

	Error_profile_not_associated_with_device_text: STRING is
			"The specified color profile is not associated with any device."

	Error_profile_not_associated_with_device_value: INTEGER is 2015

	Error_profile_not_found_text: STRING is
			"The specified color profile was not found."

	Error_profile_not_found_value: INTEGER is 2016

	Error_invalid_colorspace_text: STRING is
			"The specified color space is invalid."

	Error_invalid_colorspace_value: INTEGER is 2017

	Error_icm_not_enabled_text: STRING is
			"Image Color Management is not enabled."

	Error_icm_not_enabled_value: INTEGER is 2018

	Error_deleting_icm_xform_text: STRING is
			"There was an error while deleting the color transform."

	Error_deleting_icm_xform_value: INTEGER is 2019

	Error_invalid_transform_text: STRING is
			"The specified color transform is invalid."

	Error_invalid_transform_value: INTEGER is 2020

	Error_colorspace_mismatch_text: STRING is
			"The specified transform does not match the bitmap's color space."

	Error_colorspace_mismatch_value: INTEGER is 2021

	Error_invalid_colorindex_text: STRING is
			"The specified named color index is not present in the profile."

	Error_invalid_colorindex_value: INTEGER is 2022

	Error_connected_other_password_text: STRING is
			"The network connection was made successfully, but the user had to be prompted for a password other than the one originally specified."

	Error_connected_other_password_value: INTEGER is 2108

	Error_bad_username_text: STRING is
			"The specified username is invalid."

	Error_bad_username_value: INTEGER is 2202

	Error_not_connected_text: STRING is
			"This network connection does not exist."

	Error_not_connected_value: INTEGER is 2250

	Error_open_files_text: STRING is
			"This network connection has files open or requests pending."

	Error_open_files_value: INTEGER is 2401

	Error_active_connections_text: STRING is
			"Active connections still exist."

	Error_active_connections_value: INTEGER is 2402

	Error_device_in_use_text: STRING is
			"The device is in use by an active process and cannot be disconnected."

	Error_device_in_use_value: INTEGER is 2404

	Error_unknown_print_monitor_text: STRING is
			"The specified print monitor is unknown."

	Error_unknown_print_monitor_value: INTEGER is 3000

	Error_printer_driver_in_use_text: STRING is
			"The specified printer driver is currently in use."

	Error_printer_driver_in_use_value: INTEGER is 3001

	Error_spool_file_not_found_text: STRING is
			"The spool file was not found."

	Error_spool_file_not_found_value: INTEGER is 3002

	Error_spl_no_startdoc_text: STRING is
			"A StartDocPrinter call was not issued."

	Error_spl_no_startdoc_value: INTEGER is 3003

	Error_spl_no_addjob_text: STRING is
			"An AddJob call was not issued."

	Error_spl_no_addjob_value: INTEGER is 3004

	Error_print_processor_already_installed_text: STRING is
			"The specified print processor has already been installed."

	Error_print_processor_already_installed_value: INTEGER is 3005

	Error_print_monitor_already_installed_text: STRING is
			"The specified print monitor has already been installed."

	Error_print_monitor_already_installed_value: INTEGER is 3006

	Error_invalid_print_monitor_text: STRING is
			"The specified print monitor does not have the required functions."

	Error_invalid_print_monitor_value: INTEGER is 3007

	Error_print_monitor_in_use_text: STRING is
			"The specified print monitor is currently in use."

	Error_print_monitor_in_use_value: INTEGER is 3008

	Error_printer_has_jobs_queued_text: STRING is
			"The requested operation is not allowed when there are jobs queued to the printer."

	Error_printer_has_jobs_queued_value: INTEGER is 3009

	Error_success_reboot_required_text: STRING is
			"The requested operation is successful. Changes will not be effective until the system is rebooted."

	Error_success_reboot_required_value: INTEGER is 3010

	Error_success_restart_required_text: STRING is
			"The requested operation is successful. Changes will not be effective until the service is restarted."

	Error_success_restart_required_value: INTEGER is 3011

	Error_printer_not_found_text: STRING is
			"No printers were found."

	Error_printer_not_found_value: INTEGER is 3012

	Error_wins_internal_text: STRING is
			"WINS encountered an error while processing the command."

	Error_wins_internal_value: INTEGER is 4000

	Error_can_not_del_local_wins_text: STRING is
			"The local WINS can not be deleted."

	Error_can_not_del_local_wins_value: INTEGER is 4001

	Error_static_init_text: STRING is
			"The importation from the file failed."

	Error_static_init_value: INTEGER is 4002

	Error_inc_backup_text: STRING is
			"The backup failed. Was a full backup done before?"

	Error_inc_backup_value: INTEGER is 4003

	Error_full_backup_text: STRING is
			"The backup failed. Check the directory to which you are backing the database."

	Error_full_backup_value: INTEGER is 4004

	Error_rec_non_existent_text: STRING is
			"The name does not exist in the WINS database."

	Error_rec_non_existent_value: INTEGER is 4005

	Error_rpl_not_allowed_text: STRING is
			"Replication with a nonconfigured partner is not allowed."

	Error_rpl_not_allowed_value: INTEGER is 4006

	Error_dhcp_address_conflict_text: STRING is
			"The DHCP client has obtained an IP address that is already in use on the network. The local interface will be disabled until the DHCP client can obtain a new address."

	Error_dhcp_address_conflict_value: INTEGER is 4100

	Error_wmi_guid_not_found_text: STRING is
			"The GUID passed was not recognized as valid by a WMI data provider."

	Error_wmi_guid_not_found_value: INTEGER is 4200

	Error_wmi_instance_not_found_text: STRING is
			"The instance name passed was not recognized as valid by a WMI data provider."

	Error_wmi_instance_not_found_value: INTEGER is 4201

	Error_wmi_itemid_not_found_text: STRING is
			"The data item ID passed was not recognized as valid by a WMI data provider."

	Error_wmi_itemid_not_found_value: INTEGER is 4202

	Error_wmi_try_again_text: STRING is
			"The WMI request could not be completed and should be retried."

	Error_wmi_try_again_value: INTEGER is 4203

	Error_wmi_dp_not_found_text: STRING is
			"The WMI data provider could not be located."

	Error_wmi_dp_not_found_value: INTEGER is 4204

	Error_wmi_unresolved_instance_ref_text: STRING is
			"The WMI data provider references an instance set that has not been registered."

	Error_wmi_unresolved_instance_ref_value: INTEGER is 4205

	Error_wmi_already_enabled_text: STRING is
			"The WMI data block or event notification has already been enabled."

	Error_wmi_already_enabled_value: INTEGER is 4206

	Error_wmi_guid_disconnected_text: STRING is
			"The WMI data block is no longer available."

	Error_wmi_guid_disconnected_value: INTEGER is 4207

	Error_wmi_server_unavailable_text: STRING is
			"The WMI data service is not available."

	Error_wmi_server_unavailable_value: INTEGER is 4208

	Error_wmi_dp_failed_text: STRING is
			"The WMI data provider failed to carry out the request."

	Error_wmi_dp_failed_value: INTEGER is 4209

	Error_wmi_invalid_mof_text: STRING is
			"The WMI MOF information is not valid."

	Error_wmi_invalid_mof_value: INTEGER is 4210

	Error_wmi_invalid_reginfo_text: STRING is
			"The WMI registration information is not valid."

	Error_wmi_invalid_reginfo_value: INTEGER is 4211

	Error_wmi_already_disabled_text: STRING is
			"The WMI data block or event notification has already been disabled."

	Error_wmi_already_disabled_value: INTEGER is 4212

	Error_wmi_read_only_text: STRING is
			"The WMI data item or data block is read only."

	Error_wmi_read_only_value: INTEGER is 4213

	Error_wmi_set_failure_text: STRING is
			"The WMI data item or data block could not be changed."

	Error_wmi_set_failure_value: INTEGER is 4214

	Error_invalid_media_text: STRING is
			"The media identifier does not represent a valid medium."

	Error_invalid_media_value: INTEGER is 4300

	Error_invalid_library_text: STRING is
			"The library identifier does not represent a valid library."

	Error_invalid_library_value: INTEGER is 4301

	Error_invalid_media_pool_text: STRING is
			"The media pool identifier does not represent a valid media pool."

	Error_invalid_media_pool_value: INTEGER is 4302

	Error_drive_media_mismatch_text: STRING is
			"The drive and medium are not compatible or exist in different libraries."

	Error_drive_media_mismatch_value: INTEGER is 4303

	Error_media_offline_text: STRING is
			"The medium currently exists in an offline library and must be online to perform this operation."

	Error_media_offline_value: INTEGER is 4304

	Error_library_offline_text: STRING is
			"The operation cannot be performed on an offline library."

	Error_library_offline_value: INTEGER is 4305

	Error_empty_text: STRING is
			"The library, drive, or media pool is empty."

	Error_empty_value: INTEGER is 4306

	Error_not_empty_text: STRING is
			"The library, drive, or media pool must be empty to perform this operation."

	Error_not_empty_value: INTEGER is 4307

	Error_media_unavailable_text: STRING is
			"No media is currently available in this media pool or library."

	Error_media_unavailable_value: INTEGER is 4308

	Error_resource_disabled_text: STRING is
			"A resource required for this operation is disabled."

	Error_resource_disabled_value: INTEGER is 4309

	Error_invalid_cleaner_text: STRING is
			"The media identifier does not represent a valid cleaner."

	Error_invalid_cleaner_value: INTEGER is 4310

	Error_unable_to_clean_text: STRING is
			"The drive cannot be cleaned or does not support cleaning."

	Error_unable_to_clean_value: INTEGER is 4311

	Error_object_not_found_text: STRING is
			"The object identifier does not represent a valid object."

	Error_object_not_found_value: INTEGER is 4312

	Error_database_failure_text: STRING is
			"Unable to read from or write to the database."

	Error_database_failure_value: INTEGER is 4313

	Error_database_full_text: STRING is
			"The database is full."

	Error_database_full_value: INTEGER is 4314

	Error_media_incompatible_text: STRING is
			"The medium is not compatible with the device or media pool."

	Error_media_incompatible_value: INTEGER is 4315

	Error_resource_not_present_text: STRING is
			"The resource required for this operation does not exist."

	Error_resource_not_present_value: INTEGER is 4316

	Error_invalid_operation_text: STRING is
			"The operation identifier is not valid."

	Error_invalid_operation_value: INTEGER is 4317

	Error_media_not_available_text: STRING is
			"The media is not mounted or ready for use."

	Error_media_not_available_value: INTEGER is 4318

	Error_device_not_available_text: STRING is
			"The device is not ready for use."

	Error_device_not_available_value: INTEGER is 4319

	Error_request_refused_text: STRING is
			"The operator or administrator has refused the request."

	Error_request_refused_value: INTEGER is 4320

	Error_invalid_drive_object_text: STRING is
			"The drive identifier does not represent a valid drive."

	Error_invalid_drive_object_value: INTEGER is 4321

	Error_library_full_text: STRING is
			"Library is full.  No slot is available for use."

	Error_library_full_value: INTEGER is 4322

	Error_medium_not_accessible_text: STRING is
			"The transport cannot access the medium."

	Error_medium_not_accessible_value: INTEGER is 4323

	Error_unable_to_load_medium_text: STRING is
			"Unable to load the medium into the drive."

	Error_unable_to_load_medium_value: INTEGER is 4324

	Error_unable_to_inventory_drive_text: STRING is
			"Unable to retrieve the drive status."

	Error_unable_to_inventory_drive_value: INTEGER is 4325

	Error_unable_to_inventory_slot_text: STRING is
			"Unable to retrieve the slot status."

	Error_unable_to_inventory_slot_value: INTEGER is 4326

	Error_unable_to_inventory_transport_text: STRING is
			"Unable to retrieve status about the transport."

	Error_unable_to_inventory_transport_value: INTEGER is 4327

	Error_transport_full_text: STRING is
			"Cannot use the transport because it is already in use."

	Error_transport_full_value: INTEGER is 4328

	Error_controlling_ieport_text: STRING is
			"Unable to open or close the inject/eject port."

	Error_controlling_ieport_value: INTEGER is 4329

	Error_unable_to_eject_mounted_media_text: STRING is
			"Unable to eject the medium because it is in a drive."

	Error_unable_to_eject_mounted_media_value: INTEGER is 4330

	Error_cleaner_slot_set_text: STRING is
			"A cleaner slot is already reserved."

	Error_cleaner_slot_set_value: INTEGER is 4331

	Error_cleaner_slot_not_set_text: STRING is
			"A cleaner slot is not reserved."

	Error_cleaner_slot_not_set_value: INTEGER is 4332

	Error_cleaner_cartridge_spent_text: STRING is
			"The cleaner cartridge has performed the maximum number of drive cleanings."

	Error_cleaner_cartridge_spent_value: INTEGER is 4333

	Error_unexpected_omid_text: STRING is
			"Unexpected on-medium identifier."

	Error_unexpected_omid_value: INTEGER is 4334

	Error_cant_delete_last_item_text: STRING is
			"The last remaining item in this group or resource cannot be deleted."

	Error_cant_delete_last_item_value: INTEGER is 4335

	Error_message_exceeds_max_size_text: STRING is
			"The message provided exceeds the maximum size allowed for this parameter."

	Error_message_exceeds_max_size_value: INTEGER is 4336

	Error_volume_contains_sys_files_text: STRING is
			"The volume contains system or paging files."

	Error_volume_contains_sys_files_value: INTEGER is 4337

	Error_indigenous_type_text: STRING is
			"The media type cannot be removed from this library since at least one drive in the library reports it can support this media type."

	Error_indigenous_type_value: INTEGER is 4338

	Error_no_supporting_drives_text: STRING is
			"This offline media cannot be mounted on this system since no enabled drives are present which can be used."

	Error_no_supporting_drives_value: INTEGER is 4339

	Error_file_offline_text: STRING is
			"The remote storage service was not able to recall the file."

	Error_file_offline_value: INTEGER is 4350

	Error_remote_storage_not_active_text: STRING is
			"The remote storage service is not operational at this time."

	Error_remote_storage_not_active_value: INTEGER is 4351

	Error_remote_storage_media_error_text: STRING is
			"The remote storage service encountered a media error."

	Error_remote_storage_media_error_value: INTEGER is 4352

	Error_not_a_reparse_point_text: STRING is
			"The file or directory is not a reparse point."

	Error_not_a_reparse_point_value: INTEGER is 4390

	Error_reparse_attribute_conflict_text: STRING is
			"The reparse point attribute cannot be set because it conflicts with an existing attribute."

	Error_reparse_attribute_conflict_value: INTEGER is 4391

	Error_invalid_reparse_data_text: STRING is
			"The data present in the reparse point buffer is invalid."

	Error_invalid_reparse_data_value: INTEGER is 4392

	Error_reparse_tag_invalid_text: STRING is
			"The tag present in the reparse point buffer is invalid."

	Error_reparse_tag_invalid_value: INTEGER is 4393

	Error_reparse_tag_mismatch_text: STRING is
			"There is a mismatch between the tag specified in the request and the tag present in the reparse point."

	Error_reparse_tag_mismatch_value: INTEGER is 4394

	Error_volume_not_sis_enabled_text: STRING is
			"Single Instance Storage is not available on this volume."

	Error_volume_not_sis_enabled_value: INTEGER is 4500

	Error_dependent_resource_exists_text: STRING is
			"The cluster resource cannot be moved to another group because other resources are dependent on it."

	Error_dependent_resource_exists_value: INTEGER is 5001

	Error_dependency_not_found_text: STRING is
			"The cluster resource dependency cannot be found."

	Error_dependency_not_found_value: INTEGER is 5002

	Error_dependency_already_exists_text: STRING is
			"The cluster resource cannot be made dependent on the specified resource because it is already dependent."

	Error_dependency_already_exists_value: INTEGER is 5003

	Error_resource_not_online_text: STRING is
			"The cluster resource is not online."

	Error_resource_not_online_value: INTEGER is 5004

	Error_host_node_not_available_text: STRING is
			"A cluster node is not available for this operation."

	Error_host_node_not_available_value: INTEGER is 5005

	Error_resource_not_available_text: STRING is
			"The cluster resource is not available."

	Error_resource_not_available_value: INTEGER is 5006

	Error_resource_not_found_text: STRING is
			"The cluster resource could not be found."

	Error_resource_not_found_value: INTEGER is 5007

	Error_shutdown_cluster_text: STRING is
			"The cluster is being shut down."

	Error_shutdown_cluster_value: INTEGER is 5008

	Error_cant_evict_active_node_text: STRING is
			"A cluster node cannot be evicted from the cluster while it is online."

	Error_cant_evict_active_node_value: INTEGER is 5009

	Error_object_already_exists_text: STRING is
			"The object already exists."

	Error_object_already_exists_value: INTEGER is 5010

	Error_object_in_list_text: STRING is
			"The object is already in the list."

	Error_object_in_list_value: INTEGER is 5011

	Error_group_not_available_text: STRING is
			"The cluster group is not available for any new requests."

	Error_group_not_available_value: INTEGER is 5012

	Error_group_not_found_text: STRING is
			"The cluster group could not be found."

	Error_group_not_found_value: INTEGER is 5013

	Error_group_not_online_text: STRING is
			"The operation could not be completed because the cluster group is not online."

	Error_group_not_online_value: INTEGER is 5014

	Error_host_node_not_resource_owner_text: STRING is
			"The cluster node is not the owner of the resource."

	Error_host_node_not_resource_owner_value: INTEGER is 5015

	Error_host_node_not_group_owner_text: STRING is
			"The cluster node is not the owner of the group."

	Error_host_node_not_group_owner_value: INTEGER is 5016

	Error_resmon_create_failed_text: STRING is
			"The cluster resource could not be created in the specified resource monitor."

	Error_resmon_create_failed_value: INTEGER is 5017

	Error_resmon_online_failed_text: STRING is
			"The cluster resource could not be brought online by the resource monitor."

	Error_resmon_online_failed_value: INTEGER is 5018

	Error_resource_online_text: STRING is
			"The operation could not be completed because the cluster resource is online."

	Error_resource_online_value: INTEGER is 5019

	Error_quorum_resource_text: STRING is
			"The cluster resource could not be deleted or brought offline because it is the quorum resource."

	Error_quorum_resource_value: INTEGER is 5020

	Error_not_quorum_capable_text: STRING is
			"The cluster could not make the specified resource a quorum resource because it is not capable of being a quorum resource."

	Error_not_quorum_capable_value: INTEGER is 5021

	Error_cluster_shutting_down_text: STRING is
			"The cluster software is shutting down."

	Error_cluster_shutting_down_value: INTEGER is 5022

	Error_invalid_state_text: STRING is
			"The group or resource is not in the correct state to perform the requested operation."

	Error_invalid_state_value: INTEGER is 5023

	Error_resource_properties_stored_text: STRING is
			"The properties were stored but not all changes will take effect until the next time the resource is brought online."

	Error_resource_properties_stored_value: INTEGER is 5024

	Error_not_quorum_class_text: STRING is
			"The cluster could not make the specified resource a quorum resource because it does not belong to a shared storage class."

	Error_not_quorum_class_value: INTEGER is 5025

	Error_core_resource_text: STRING is
			"The cluster resource could not be deleted since it is a core resource."

	Error_core_resource_value: INTEGER is 5026

	Error_quorum_resource_online_failed_text: STRING is
			"The quorum resource failed to come online."

	Error_quorum_resource_online_failed_value: INTEGER is 5027

	Error_quorumlog_open_failed_text: STRING is
			"The quorum log could not be created or mounted successfully."

	Error_quorumlog_open_failed_value: INTEGER is 5028

	Error_clusterlog_corrupt_text: STRING is
			"The cluster log is corrupt."

	Error_clusterlog_corrupt_value: INTEGER is 5029

	Error_clusterlog_record_exceeds_maxsize_text: STRING is
			"The record could not be written to the cluster log since it exceeds the maximum size."

	Error_clusterlog_record_exceeds_maxsize_value: INTEGER is 5030

	Error_clusterlog_exceeds_maxsize_text: STRING is
			"The cluster log exceeds its maximum size."

	Error_clusterlog_exceeds_maxsize_value: INTEGER is 5031

	Error_clusterlog_chkpoint_not_found_text: STRING is
			"No checkpoint record was found in the cluster log."

	Error_clusterlog_chkpoint_not_found_value: INTEGER is 5032

	Error_clusterlog_not_enough_space_text: STRING is
			"The minimum required disk space needed for logging is not available."

	Error_clusterlog_not_enough_space_value: INTEGER is 5033

	Error_quorum_owner_alive_text: STRING is
			"The cluster node failed to take control of the quorum resource because the resource is owned by another active node."

	Error_quorum_owner_alive_value: INTEGER is 5034

	Error_network_not_available_text: STRING is
			"A cluster network is not available for this operation."

	Error_network_not_available_value: INTEGER is 5035

	Error_node_not_available_text: STRING is
			"A cluster node is not available for this operation."

	Error_node_not_available_value: INTEGER is 5036

	Error_all_nodes_not_available_text: STRING is
			"All cluster nodes must be running to perform this operation."

	Error_all_nodes_not_available_value: INTEGER is 5037

	Error_resource_failed_text: STRING is
			"A cluster resource failed."

	Error_resource_failed_value: INTEGER is 5038

	Error_cluster_invalid_node_text: STRING is
			"The cluster node is not valid."

	Error_cluster_invalid_node_value: INTEGER is 5039

	Error_cluster_node_exists_text: STRING is
			"The cluster node already exists."

	Error_cluster_node_exists_value: INTEGER is 5040

	Error_cluster_join_in_progress_text: STRING is
			"A node is in the process of joining the cluster."

	Error_cluster_join_in_progress_value: INTEGER is 5041

	Error_cluster_node_not_found_text: STRING is
			"The cluster node was not found."

	Error_cluster_node_not_found_value: INTEGER is 5042

	Error_cluster_local_node_not_found_text: STRING is
			"The cluster local node information was not found."

	Error_cluster_local_node_not_found_value: INTEGER is 5043

	Error_cluster_network_exists_text: STRING is
			"The cluster network already exists."

	Error_cluster_network_exists_value: INTEGER is 5044

	Error_cluster_network_not_found_text: STRING is
			"The cluster network was not found."

	Error_cluster_network_not_found_value: INTEGER is 5045

	Error_cluster_netinterface_exists_text: STRING is
			"The cluster network interface already exists."

	Error_cluster_netinterface_exists_value: INTEGER is 5046

	Error_cluster_netinterface_not_found_text: STRING is
			"The cluster network interface was not found."

	Error_cluster_netinterface_not_found_value: INTEGER is 5047

	Error_cluster_invalid_request_text: STRING is
			"The cluster request is not valid for this object."

	Error_cluster_invalid_request_value: INTEGER is 5048

	Error_cluster_invalid_network_provider_text: STRING is
			"The cluster network provider is not valid."

	Error_cluster_invalid_network_provider_value: INTEGER is 5049

	Error_cluster_node_down_text: STRING is
			"The cluster node is down."

	Error_cluster_node_down_value: INTEGER is 5050

	Error_cluster_node_unreachable_text: STRING is
			"The cluster node is not reachable."

	Error_cluster_node_unreachable_value: INTEGER is 5051

	Error_cluster_node_not_member_text: STRING is
			"The cluster node is not a member of the cluster."

	Error_cluster_node_not_member_value: INTEGER is 5052

	Error_cluster_join_not_in_progress_text: STRING is
			"A cluster join operation is not in progress."

	Error_cluster_join_not_in_progress_value: INTEGER is 5053

	Error_cluster_invalid_network_text: STRING is
			"The cluster network is not valid."

	Error_cluster_invalid_network_value: INTEGER is 5054

	Error_cluster_node_up_text: STRING is
			"The cluster node is up."

	Error_cluster_node_up_value: INTEGER is 5056

	Error_cluster_ipaddr_in_use_text: STRING is
			"The cluster IP address is already in use."

	Error_cluster_ipaddr_in_use_value: INTEGER is 5057

	Error_cluster_node_not_paused_text: STRING is
			"The cluster node is not paused."

	Error_cluster_node_not_paused_value: INTEGER is 5058

	Error_cluster_no_security_context_text: STRING is
			"No cluster security context is available."

	Error_cluster_no_security_context_value: INTEGER is 5059

	Error_cluster_network_not_internal_text: STRING is
			"The cluster network is not configured for internal cluster communication."

	Error_cluster_network_not_internal_value: INTEGER is 5060

	Error_cluster_node_already_up_text: STRING is
			"The cluster node is already up."

	Error_cluster_node_already_up_value: INTEGER is 5061

	Error_cluster_node_already_down_text: STRING is
			"The cluster node is already down."

	Error_cluster_node_already_down_value: INTEGER is 5062

	Error_cluster_network_already_online_text: STRING is
			"The cluster network is already online."

	Error_cluster_network_already_online_value: INTEGER is 5063

	Error_cluster_network_already_offline_text: STRING is
			"The cluster network is already offline."

	Error_cluster_network_already_offline_value: INTEGER is 5064

	Error_cluster_node_already_member_text: STRING is
			"The cluster node is already a member of the cluster."

	Error_cluster_node_already_member_value: INTEGER is 5065

	Error_cluster_last_internal_network_text: STRING is
			"The cluster network is the only one configured for internal cluster communication between two or more active cluster nodes. The internal communication capability cannot be removed from the network."

	Error_cluster_last_internal_network_value: INTEGER is 5066

	Error_cluster_network_has_dependents_text: STRING is
			"One or more cluster resources depend on the network to provide service to clients. The client access capability cannot be removed from the network."

	Error_cluster_network_has_dependents_value: INTEGER is 5067

	Error_invalid_operation_on_quorum_text: STRING is
			"This operation cannot be performed on the cluster resource as it the quorum resource. You may not bring the quorum resource offline or modify its possible owners list."

	Error_invalid_operation_on_quorum_value: INTEGER is 5068

	Error_dependency_not_allowed_text: STRING is
			"The cluster quorum resource is not allowed to have any dependencies."

	Error_dependency_not_allowed_value: INTEGER is 5069

	Error_cluster_node_paused_text: STRING is
			"The cluster node is paused."

	Error_cluster_node_paused_value: INTEGER is 5070

	Error_node_cant_host_resource_text: STRING is
			"The cluster resource cannot be brought online. The owner node cannot run this resource."

	Error_node_cant_host_resource_value: INTEGER is 5071

	Error_cluster_node_not_ready_text: STRING is
			"The cluster node is not ready to perform the requested operation."

	Error_cluster_node_not_ready_value: INTEGER is 5072

	Error_cluster_node_shutting_down_text: STRING is
			"The cluster node is shutting down."

	Error_cluster_node_shutting_down_value: INTEGER is 5073

	Error_cluster_join_aborted_text: STRING is
			"The cluster join operation was aborted."

	Error_cluster_join_aborted_value: INTEGER is 5074

	Error_cluster_incompatible_versions_text: STRING is
			"The cluster join operation failed due to incompatible software versions between the joining node and its sponsor."

	Error_cluster_incompatible_versions_value: INTEGER is 5075

	Error_cluster_maxnum_of_resources_exceeded_text: STRING is
			"This resource cannot be created because the cluster has reached the limit on the number of resources it can monitor."

	Error_cluster_maxnum_of_resources_exceeded_value: INTEGER is 5076

	Error_cluster_system_config_changed_text: STRING is
			"The system configuration changed during the cluster join or form operation. The join or form operation was aborted."

	Error_cluster_system_config_changed_value: INTEGER is 5077

	Error_cluster_resource_type_not_found_text: STRING is
			"The specified resource type was not found."

	Error_cluster_resource_type_not_found_value: INTEGER is 5078

	Error_cluster_restype_not_supported_text: STRING is
			"The specified node does not support a resource of this type.  This may be due to version inconsistencies or due to the absence of the resource DLL on this node."

	Error_cluster_restype_not_supported_value: INTEGER is 5079

	Error_cluster_resname_not_found_text: STRING is
			"The specified resource name is not supported by this resource DLL. This may be due to a bad (or changed) name supplied to the resource DLL."

	Error_cluster_resname_not_found_value: INTEGER is 5080

	Error_cluster_no_rpc_packages_registered_text: STRING is
			"No authentication package could be registered with the RPC server."

	Error_cluster_no_rpc_packages_registered_value: INTEGER is 5081

	Error_cluster_owner_not_in_preflist_text: STRING is
			"You cannot bring the group online because the owner of the group is not in the preferred list for the group. To change the owner node for the group, move the group."

	Error_cluster_owner_not_in_preflist_value: INTEGER is 5082

	Error_cluster_database_seqmismatch_text: STRING is
			"The join operation failed because the cluster database sequence number has changed or is incompatible with the locker node. This may happen during a join operation if the cluster database was changing during the join."

	Error_cluster_database_seqmismatch_value: INTEGER is 5083

	Error_resmon_invalid_state_text: STRING is
			"The resource monitor will not allow the fail operation to be performed while the resource is in its current state. This may happen if the resource is in a pending state."

	Error_resmon_invalid_state_value: INTEGER is 5084

	Error_cluster_gum_not_locker_text: STRING is
			"A non locker code got a request to reserve the lock for making global updates."

	Error_cluster_gum_not_locker_value: INTEGER is 5085

	Error_quorum_disk_not_found_text: STRING is
			"The quorum disk could not be located by the cluster service."

	Error_quorum_disk_not_found_value: INTEGER is 5086

	Error_database_backup_corrupt_text: STRING is
			"The backed up cluster database is possibly corrupt."

	Error_database_backup_corrupt_value: INTEGER is 5087

	Error_cluster_node_already_has_dfs_root_text: STRING is
			"A DFS root already exists in this cluster node."

	Error_cluster_node_already_has_dfs_root_value: INTEGER is 5088

	Error_resource_property_unchangeable_text: STRING is
			"An attempt to modify a resource property failed because it conflicts with another existing property."

	Error_resource_property_unchangeable_value: INTEGER is 5089

	Error_encryption_failed_text: STRING is
			"The specified file could not be encrypted."

	Error_encryption_failed_value: INTEGER is 6000

	Error_decryption_failed_text: STRING is
			"The specified file could not be decrypted."

	Error_decryption_failed_value: INTEGER is 6001

	Error_file_encrypted_text: STRING is
			"The specified file is encrypted and the user does not have the ability to decrypt it."

	Error_file_encrypted_value: INTEGER is 6002

	Error_no_recovery_policy_text: STRING is
			"There is no valid encryption recovery policy configured for this system."

	Error_no_recovery_policy_value: INTEGER is 6003

	Error_no_efs_text: STRING is
			"The required encryption driver is not loaded for this system."

	Error_no_efs_value: INTEGER is 6004

	Error_wrong_efs_text: STRING is
			"The file was encrypted with a different encryption driver than is currently loaded."

	Error_wrong_efs_value: INTEGER is 6005

	Error_no_user_keys_text: STRING is
			"There are no EFS keys defined for the user."

	Error_no_user_keys_value: INTEGER is 6006

	Error_file_not_encrypted_text: STRING is
			"The specified file is not encrypted."

	Error_file_not_encrypted_value: INTEGER is 6007

	Error_not_export_format_text: STRING is
			"The specified file is not in the defined EFS export format."

	Error_not_export_format_value: INTEGER is 6008

	Error_file_read_only_text: STRING is
			"The specified file is read only."

	Error_file_read_only_value: INTEGER is 6009

	Error_dir_efs_disallowed_text: STRING is
			"The directory has been disabled for encryption."

	Error_dir_efs_disallowed_value: INTEGER is 6010

	Error_efs_server_not_trusted_text: STRING is
			"The server is not trusted for remote encryption operation."

	Error_efs_server_not_trusted_value: INTEGER is 6011

	Sched_e_service_not_localsystem_text: STRING is
			"The Task Scheduler service must be configured to run in the System account to function properly.  Individual tasks may be configured to run in other accounts."

	Sched_e_service_not_localsystem_value: INTEGER is 6200

	Error_ctx_winstation_name_invalid_text: STRING is
			"The specified session name is invalid."

	Error_ctx_winstation_name_invalid_value: INTEGER is 7001

	Error_ctx_invalid_pd_text: STRING is
			"The specified protocol driver is invalid."

	Error_ctx_invalid_pd_value: INTEGER is 7002

	Error_ctx_pd_not_found_text: STRING is
			"The specified protocol driver was not found in the system path."

	Error_ctx_pd_not_found_value: INTEGER is 7003

	Error_ctx_wd_not_found_text: STRING is
			"The specified terminal connection driver was not found in the system path."

	Error_ctx_wd_not_found_value: INTEGER is 7004

	Error_ctx_cannot_make_eventlog_entry_text: STRING is
			"A registry key for event logging could not be created for this session."

	Error_ctx_cannot_make_eventlog_entry_value: INTEGER is 7005

	Error_ctx_service_name_collision_text: STRING is
			"A service with the same name already exists on the system."

	Error_ctx_service_name_collision_value: INTEGER is 7006

	Error_ctx_close_pending_text: STRING is
			"A close operation is pending on the session."

	Error_ctx_close_pending_value: INTEGER is 7007

	Error_ctx_no_outbuf_text: STRING is
			"There are no free output buffers available."

	Error_ctx_no_outbuf_value: INTEGER is 7008

	Error_ctx_modem_inf_not_found_text: STRING is
			"The MODEM.INF file was not found."

	Error_ctx_modem_inf_not_found_value: INTEGER is 7009

	Error_ctx_invalid_modemname_text: STRING is
			"The modem name was not found in MODEM.INF."

	Error_ctx_invalid_modemname_value: INTEGER is 7010

	Error_ctx_modem_response_error_text: STRING is
			"The modem did not accept the command sent to it. Verify that the configured modem name matches the attached modem."

	Error_ctx_modem_response_error_value: INTEGER is 7011

	Error_ctx_modem_response_timeout_text: STRING is
			"The modem did not respond to the command sent to it. Verify that the modem is properly cabled and powered on."

	Error_ctx_modem_response_timeout_value: INTEGER is 7012

	Error_ctx_modem_response_no_carrier_text: STRING is
			"Carrier detect has failed or carrier has been dropped due to disconnect."

	Error_ctx_modem_response_no_carrier_value: INTEGER is 7013

	Error_ctx_modem_response_no_dialtone_text: STRING is
			"Dial tone not detected within the required time. Verify that the phone cable is properly attached and functional."

	Error_ctx_modem_response_no_dialtone_value: INTEGER is 7014

	Error_ctx_modem_response_busy_text: STRING is
			"Busy signal detected at remote site on callback."

	Error_ctx_modem_response_busy_value: INTEGER is 7015

	Error_ctx_modem_response_voice_text: STRING is
			"Voice detected at remote site on callback."

	Error_ctx_modem_response_voice_value: INTEGER is 7016

	Error_ctx_td_error_text: STRING is
			"Transport driver error"

	Error_ctx_td_error_value: INTEGER is 7017

	Error_ctx_winstation_not_found_text: STRING is
			"The specified session cannot be found."

	Error_ctx_winstation_not_found_value: INTEGER is 7022

	Error_ctx_winstation_already_exists_text: STRING is
			"The specified session name is already in use."

	Error_ctx_winstation_already_exists_value: INTEGER is 7023

	Error_ctx_winstation_busy_text: STRING is
			"The requested operation cannot be completed because the terminal connection is currently busy processing a connect, disconnect, reset, or delete operation."

	Error_ctx_winstation_busy_value: INTEGER is 7024

	Error_ctx_bad_video_mode_text: STRING is
			"An attempt has been made to connect to a session whose video mode is not supported by the current client."

	Error_ctx_bad_video_mode_value: INTEGER is 7025

	Error_ctx_graphics_invalid_text: STRING is
			"The application attempted to enable DOS graphics mode.  DOS graphics mode is not supported."

	Error_ctx_graphics_invalid_value: INTEGER is 7035

	Error_ctx_logon_disabled_text: STRING is
			"Your interactive logon privilege has been disabled.  Please contact your administrator."

	Error_ctx_logon_disabled_value: INTEGER is 7037

	Error_ctx_not_console_text: STRING is
			"The requested operation can be performed only on the system console.  This is most often the result of a driver or system DLL requiring direct console access."

	Error_ctx_not_console_value: INTEGER is 7038

	Error_ctx_client_query_timeout_text: STRING is
			"The client failed to respond to the server connect message."

	Error_ctx_client_query_timeout_value: INTEGER is 7040

	Error_ctx_console_disconnect_text: STRING is
			"Disconnecting the console session is not supported."

	Error_ctx_console_disconnect_value: INTEGER is 7041

	Error_ctx_console_connect_text: STRING is
			"Reconnecting a disconnected session to the console is not supported."

	Error_ctx_console_connect_value: INTEGER is 7042

	Error_ctx_shadow_denied_text: STRING is
			"The request to control another session remotely was denied."

	Error_ctx_shadow_denied_value: INTEGER is 7044

	Error_ctx_winstation_access_denied_text: STRING is
			"The requested session access is denied."

	Error_ctx_winstation_access_denied_value: INTEGER is 7045

	Error_ctx_invalid_wd_text: STRING is
			"The specified terminal connection driver is invalid."

	Error_ctx_invalid_wd_value: INTEGER is 7049

	Error_ctx_shadow_invalid_text: STRING is
			"The requested session cannot be controlled remotely.  This may be because the session is disconnected or does not currently have a user logged on. Also, you cannot control a session remotely from the system console or control the system console remotely. And you cannot remote control your own current session."

	Error_ctx_shadow_invalid_value: INTEGER is 7050

	Error_ctx_shadow_disabled_text: STRING is
			"The requested session is not configured to allow remote control."

	Error_ctx_shadow_disabled_value: INTEGER is 7051

	Error_ctx_client_license_in_use_text: STRING is
			"Your request to connect to this Terminal Server has been rejected. Your Terminal Server client license number is currently being used by another user.  Please call your system administrator to obtain a new copy of the Terminal Server client with a valid, unique license number."

	Error_ctx_client_license_in_use_value: INTEGER is 7052

	Error_ctx_client_license_not_set_text: STRING is
			"Your request to connect to this Terminal Server has been rejected. Your Terminal Server client license number has not been entered for this copy of the Terminal Server client.  Please call your system administrator for help in entering a valid, unique license number for this Terminal Server client."

	Error_ctx_client_license_not_set_value: INTEGER is 7053

	Error_ctx_license_not_available_text: STRING is
			"The system has reached its licensed logon limit.  Please try again later."

	Error_ctx_license_not_available_value: INTEGER is 7054

	Error_ctx_license_client_invalid_text: STRING is
			"The client you are using is not licensed to use this system.  Your logon request is denied."

	Error_ctx_license_client_invalid_value: INTEGER is 7055

	Error_ctx_license_expired_text: STRING is
			"The system license has expired.  Your logon request is denied."

	Error_ctx_license_expired_value: INTEGER is 7056

	Frs_err_invalid_api_sequence_text: STRING is
			"The file replication service API was called incorrectly."

	Frs_err_invalid_api_sequence_value: INTEGER is 8001

	Frs_err_starting_service_text: STRING is
			"The file replication service cannot be started."

	Frs_err_starting_service_value: INTEGER is 8002

	Frs_err_stopping_service_text: STRING is
			"The file replication service cannot be stopped."

	Frs_err_stopping_service_value: INTEGER is 8003

	Frs_err_internal_api_text: STRING is
			"The file replication service API terminated the request.  The event log may have more information."

	Frs_err_internal_api_value: INTEGER is 8004

	Frs_err_internal_text: STRING is
			"The file replication service terminated the request.  The event log may have more information."

	Frs_err_internal_value: INTEGER is 8005

	Frs_err_service_comm_text: STRING is
			"The file replication service cannot be contacted.  The event log may have more information."

	Frs_err_service_comm_value: INTEGER is 8006

	Frs_err_insufficient_priv_text: STRING is
			"The file replication service cannot satisfy the request because the user has insufficient privileges.  The event log may have more information."

	Frs_err_insufficient_priv_value: INTEGER is 8007

	Frs_err_authentication_text: STRING is
			"The file replication service cannot satisfy the request because authenticated RPC is not available.  The event log may have more information."

	Frs_err_authentication_value: INTEGER is 8008

	Frs_err_parent_insufficient_priv_text: STRING is
			"The file replication service cannot satisfy the request because the user has insufficient privileges on the domain controller.  The event log may have more information."

	Frs_err_parent_insufficient_priv_value: INTEGER is 8009

	Frs_err_parent_authentication_text: STRING is
			"The file replication service cannot satisfy the request because authenticated RPC is not available on the domain controller.  The event log may have more information."

	Frs_err_parent_authentication_value: INTEGER is 8010

	Frs_err_child_to_parent_comm_text: STRING is
			"The file replication service cannot communicate with the file replication service on the domain controller.  The event log may have more information."

	Frs_err_child_to_parent_comm_value: INTEGER is 8011

	Frs_err_parent_to_child_comm_text: STRING is
			"The file replication service on the domain controller cannot communicate with the file replication service on this computer.  The event log may have more information."

	Frs_err_parent_to_child_comm_value: INTEGER is 8012

	Frs_err_sysvol_populate_text: STRING is
			"The file replication service cannot populate the system volume because of an internal error.  The event log may have more information."

	Frs_err_sysvol_populate_value: INTEGER is 8013

	Frs_err_sysvol_populate_timeout_text: STRING is
			"The file replication service cannot populate the system volume because of an internal timeout.  The event log may have more information."

	Frs_err_sysvol_populate_timeout_value: INTEGER is 8014

	Frs_err_sysvol_is_busy_text: STRING is
			"The file replication service cannot process the request. The system volume is busy with a previous request."

	Frs_err_sysvol_is_busy_value: INTEGER is 8015

	Frs_err_sysvol_demote_text: STRING is
			"The file replication service cannot stop replicating the system volume because of an internal error.  The event log may have more information."

	Frs_err_sysvol_demote_value: INTEGER is 8016

	Frs_err_invalid_service_parameter_text: STRING is
			"The file replication service detected an invalid parameter."

	Frs_err_invalid_service_parameter_value: INTEGER is 8017

	Error_ds_not_installed_text: STRING is
			"An error occurred while installing the directory service. For more information, see the event log."

	Error_ds_not_installed_value: INTEGER is 8200

	Error_ds_membership_evaluated_locally_text: STRING is
			"The directory service evaluated group memberships locally."

	Error_ds_membership_evaluated_locally_value: INTEGER is 8201

	Error_ds_no_attribute_or_value_text: STRING is
			"The specified directory service attribute or value does not exist."

	Error_ds_no_attribute_or_value_value: INTEGER is 8202

	Error_ds_invalid_attribute_syntax_text: STRING is
			"The attribute syntax specified to the directory service is invalid."

	Error_ds_invalid_attribute_syntax_value: INTEGER is 8203

	Error_ds_attribute_type_undefined_text: STRING is
			"The attribute type specified to the directory service is not defined."

	Error_ds_attribute_type_undefined_value: INTEGER is 8204

	Error_ds_attribute_or_value_exists_text: STRING is
			"The specified directory service attribute or value already exists."

	Error_ds_attribute_or_value_exists_value: INTEGER is 8205

	Error_ds_busy_text: STRING is
			"The directory service is busy."

	Error_ds_busy_value: INTEGER is 8206

	Error_ds_unavailable_text: STRING is
			"The directory service is unavailable."

	Error_ds_unavailable_value: INTEGER is 8207

	Error_ds_no_rids_allocated_text: STRING is
			"The directory service was unable to allocate a relative identifier."

	Error_ds_no_rids_allocated_value: INTEGER is 8208

	Error_ds_no_more_rids_text: STRING is
			"The directory service has exhausted the pool of relative identifiers."

	Error_ds_no_more_rids_value: INTEGER is 8209

	Error_ds_incorrect_role_owner_text: STRING is
			"The requested operation could not be performed because the directory service is not the master for that type of operation."

	Error_ds_incorrect_role_owner_value: INTEGER is 8210

	Error_ds_ridmgr_init_error_text: STRING is
			"The directory service was unable to initialize the subsystem that allocates relative identifiers."

	Error_ds_ridmgr_init_error_value: INTEGER is 8211

	Error_ds_obj_class_violation_text: STRING is
			"The requested operation did not satisfy one or more constraints associated with the class of the object."

	Error_ds_obj_class_violation_value: INTEGER is 8212

	Error_ds_cant_on_non_leaf_text: STRING is
			"The directory service can perform the requested operation only on a leaf object."

	Error_ds_cant_on_non_leaf_value: INTEGER is 8213

	Error_ds_cant_on_rdn_text: STRING is
			"The directory service cannot perform the requested operation on the RDN attribute of an object."

	Error_ds_cant_on_rdn_value: INTEGER is 8214

	Error_ds_cant_mod_obj_class_text: STRING is
			"The directory service detected an attempt to modify the object class of an object."

	Error_ds_cant_mod_obj_class_value: INTEGER is 8215

	Error_ds_cross_dom_move_error_text: STRING is
			"The requested cross-domain move operation could not be performed."

	Error_ds_cross_dom_move_error_value: INTEGER is 8216

	Error_ds_gc_not_available_text: STRING is
			"Unable to contact the global catalog server."

	Error_ds_gc_not_available_value: INTEGER is 8217

	Error_shared_policy_text: STRING is
			"The policy object is shared and can only be modified at the root."

	Error_shared_policy_value: INTEGER is 8218

	Error_policy_object_not_found_text: STRING is
			"The policy object does not exist."

	Error_policy_object_not_found_value: INTEGER is 8219

	Error_policy_only_in_ds_text: STRING is
			"The requested policy information is only in the directory service."

	Error_policy_only_in_ds_value: INTEGER is 8220

	Error_promotion_active_text: STRING is
			"A domain controller promotion is currently active."

	Error_promotion_active_value: INTEGER is 8221

	Error_no_promotion_active_text: STRING is
			"A domain controller promotion is not currently active"

	Error_no_promotion_active_value: INTEGER is 8222

	Error_ds_operations_error_text: STRING is
			"An operations error occurred."

	Error_ds_operations_error_value: INTEGER is 8224

	Error_ds_protocol_error_text: STRING is
			"A protocol error occurred."

	Error_ds_protocol_error_value: INTEGER is 8225

	Error_ds_timelimit_exceeded_text: STRING is
			"The time limit for this request was exceeded."

	Error_ds_timelimit_exceeded_value: INTEGER is 8226

	Error_ds_sizelimit_exceeded_text: STRING is
			"The size limit for this request was exceeded."

	Error_ds_sizelimit_exceeded_value: INTEGER is 8227

	Error_ds_admin_limit_exceeded_text: STRING is
			"The administrative limit for this request was exceeded."

	Error_ds_admin_limit_exceeded_value: INTEGER is 8228

	Error_ds_compare_false_text: STRING is
			"The compare response was false."

	Error_ds_compare_false_value: INTEGER is 8229

	Error_ds_compare_true_text: STRING is
			"The compare response was true."

	Error_ds_compare_true_value: INTEGER is 8230

	Error_ds_auth_method_not_supported_text: STRING is
			"The requested authentication method is not supported by the server."

	Error_ds_auth_method_not_supported_value: INTEGER is 8231

	Error_ds_strong_auth_required_text: STRING is
			"A more secure authentication method is required for this server."

	Error_ds_strong_auth_required_value: INTEGER is 8232

	Error_ds_inappropriate_auth_text: STRING is
			"Inappropriate authentication."

	Error_ds_inappropriate_auth_value: INTEGER is 8233

	Error_ds_auth_unknown_text: STRING is
			"The authentication mechanism is unknown."

	Error_ds_auth_unknown_value: INTEGER is 8234

	Error_ds_referral_text: STRING is
			"A referral was returned from the server."

	Error_ds_referral_value: INTEGER is 8235

	Error_ds_unavailable_crit_extension_text: STRING is
			"The server does not support the requested critical extension."

	Error_ds_unavailable_crit_extension_value: INTEGER is 8236

	Error_ds_confidentiality_required_text: STRING is
			"This request requires a secure connection."

	Error_ds_confidentiality_required_value: INTEGER is 8237

	Error_ds_inappropriate_matching_text: STRING is
			"Inappropriate matching."

	Error_ds_inappropriate_matching_value: INTEGER is 8238

	Error_ds_constraint_violation_text: STRING is
			"A constraint violation occurred."

	Error_ds_constraint_violation_value: INTEGER is 8239

	Error_ds_no_such_object_text: STRING is
			"There is no such object on the server."

	Error_ds_no_such_object_value: INTEGER is 8240

	Error_ds_alias_problem_text: STRING is
			"There is an alias problem."

	Error_ds_alias_problem_value: INTEGER is 8241

	Error_ds_invalid_dn_syntax_text: STRING is
			"An invalid dn syntax has been specified."

	Error_ds_invalid_dn_syntax_value: INTEGER is 8242

	Error_ds_is_leaf_text: STRING is
			"The object is a leaf object."

	Error_ds_is_leaf_value: INTEGER is 8243

	Error_ds_alias_deref_problem_text: STRING is
			"There is an alias dereferencing problem."

	Error_ds_alias_deref_problem_value: INTEGER is 8244

	Error_ds_unwilling_to_perform_text: STRING is
			"The server is unwilling to process the request."

	Error_ds_unwilling_to_perform_value: INTEGER is 8245

	Error_ds_loop_detect_text: STRING is
			"A loop has been detected."

	Error_ds_loop_detect_value: INTEGER is 8246

	Error_ds_naming_violation_text: STRING is
			"There is a naming violation."

	Error_ds_naming_violation_value: INTEGER is 8247

	Error_ds_object_results_too_large_text: STRING is
			"The result set is too large."

	Error_ds_object_results_too_large_value: INTEGER is 8248

	Error_ds_affects_multiple_dsas_text: STRING is
			"The operation affects multiple DSAs"

	Error_ds_affects_multiple_dsas_value: INTEGER is 8249

	Error_ds_server_down_text: STRING is
			"The server is not operational."

	Error_ds_server_down_value: INTEGER is 8250

	Error_ds_local_error_text: STRING is
			"A local error has occurred."

	Error_ds_local_error_value: INTEGER is 8251

	Error_ds_encoding_error_text: STRING is
			"An encoding error has occurred."

	Error_ds_encoding_error_value: INTEGER is 8252

	Error_ds_decoding_error_text: STRING is
			"A decoding error has occurred."

	Error_ds_decoding_error_value: INTEGER is 8253

	Error_ds_filter_unknown_text: STRING is
			"The search filter cannot be recognized."

	Error_ds_filter_unknown_value: INTEGER is 8254

	Error_ds_param_error_text: STRING is
			"One or more parameters are illegal."

	Error_ds_param_error_value: INTEGER is 8255

	Error_ds_not_supported_text: STRING is
			"The specified method is not supported."

	Error_ds_not_supported_value: INTEGER is 8256

	Error_ds_no_results_returned_text: STRING is
			"No results were returned."

	Error_ds_no_results_returned_value: INTEGER is 8257

	Error_ds_control_not_found_text: STRING is
			"The specified control is not supported by the server."

	Error_ds_control_not_found_value: INTEGER is 8258

	Error_ds_client_loop_text: STRING is
			"A referral loop was detected by the client."

	Error_ds_client_loop_value: INTEGER is 8259

	Error_ds_referral_limit_exceeded_text: STRING is
			"The preset referral limit was exceeded."

	Error_ds_referral_limit_exceeded_value: INTEGER is 8260

	Error_ds_root_must_be_nc_text: STRING is
			"The root object must be the head of a naming context. The root object cannot have an instantiated parent."

	Error_ds_root_must_be_nc_value: INTEGER is 8301

	Error_ds_add_replica_inhibited_text: STRING is
			"The add replica operation cannot be performed. The naming context must be writable in order to create the replica."

	Error_ds_add_replica_inhibited_value: INTEGER is 8302

	Error_ds_att_not_def_in_schema_text: STRING is
			"A reference to an attribute that is not defined in the schema occurred."

	Error_ds_att_not_def_in_schema_value: INTEGER is 8303

	Error_ds_max_obj_size_exceeded_text: STRING is
			"The maximum size of an object has been exceeded."

	Error_ds_max_obj_size_exceeded_value: INTEGER is 8304

	Error_ds_obj_string_name_exists_text: STRING is
			"An attempt was made to add an object to the directory with a name that is already in use."

	Error_ds_obj_string_name_exists_value: INTEGER is 8305

	Error_ds_no_rdn_defined_in_schema_text: STRING is
			"An attempt was made to add an object of a class that does not have an RDN defined in the schema."

	Error_ds_no_rdn_defined_in_schema_value: INTEGER is 8306

	Error_ds_rdn_doesnt_match_schema_text: STRING is
			"An attempt was made to add an object using an RDN that is not the RDN defined in the schema."

	Error_ds_rdn_doesnt_match_schema_value: INTEGER is 8307

	Error_ds_no_requested_atts_found_text: STRING is
			"None of the requested attributes were found on the objects."

	Error_ds_no_requested_atts_found_value: INTEGER is 8308

	Error_ds_user_buffer_to_small_text: STRING is
			"The user buffer is too small."

	Error_ds_user_buffer_to_small_value: INTEGER is 8309

	Error_ds_att_is_not_on_obj_text: STRING is
			"The attribute specified in the operation is not present on the object."

	Error_ds_att_is_not_on_obj_value: INTEGER is 8310

	Error_ds_illegal_mod_operation_text: STRING is
			"Illegal modify operation. Some aspect of the modification is not permitted."

	Error_ds_illegal_mod_operation_value: INTEGER is 8311

	Error_ds_obj_too_large_text: STRING is
			"The specified object is too large."

	Error_ds_obj_too_large_value: INTEGER is 8312

	Error_ds_bad_instance_type_text: STRING is
			"The specified instance type is not valid."

	Error_ds_bad_instance_type_value: INTEGER is 8313

	Error_ds_masterdsa_required_text: STRING is
			"The operation must be performed at a master DSA."

	Error_ds_masterdsa_required_value: INTEGER is 8314

	Error_ds_object_class_required_text: STRING is
			"The object class attribute must be specified."

	Error_ds_object_class_required_value: INTEGER is 8315

	Error_ds_missing_required_att_text: STRING is
			"A required attribute is missing."

	Error_ds_missing_required_att_value: INTEGER is 8316

	Error_ds_att_not_def_for_class_text: STRING is
			"An attempt was made to modify an object to include an attribute that is not legal for its class."

	Error_ds_att_not_def_for_class_value: INTEGER is 8317

	Error_ds_att_already_exists_text: STRING is
			"The specified attribute is already present on the object."

	Error_ds_att_already_exists_value: INTEGER is 8318

	Error_ds_cant_add_att_values_text: STRING is
			"The specified attribute is not present, or has no values."

	Error_ds_cant_add_att_values_value: INTEGER is 8320

	Error_ds_single_value_constraint_text: STRING is
			"Multiple values were specified for an attribute that can have only one value."

	Error_ds_single_value_constraint_value: INTEGER is 8321

	Error_ds_range_constraint_text: STRING is
			"A value for the attribute was not in the acceptable range of values."

	Error_ds_range_constraint_value: INTEGER is 8322

	Error_ds_att_val_already_exists_text: STRING is
			"The specified value already exists."

	Error_ds_att_val_already_exists_value: INTEGER is 8323

	Error_ds_cant_rem_missing_att_text: STRING is
			"The attribute cannot be removed because it is not present on the object."

	Error_ds_cant_rem_missing_att_value: INTEGER is 8324

	Error_ds_cant_rem_missing_att_val_text: STRING is
			"The attribute value cannot be removed because it is not present on the object."

	Error_ds_cant_rem_missing_att_val_value: INTEGER is 8325

	Error_ds_root_cant_be_subref_text: STRING is
			"The specified root object cannot be a subref."

	Error_ds_root_cant_be_subref_value: INTEGER is 8326

	Error_ds_no_chaining_text: STRING is
			"Chaining is not permitted."

	Error_ds_no_chaining_value: INTEGER is 8327

	Error_ds_no_chained_eval_text: STRING is
			"Chained evaluation is not permitted."

	Error_ds_no_chained_eval_value: INTEGER is 8328

	Error_ds_no_parent_object_text: STRING is
			"The operation could not be performed because the object's parent is either uninstantiated or deleted."

	Error_ds_no_parent_object_value: INTEGER is 8329

	Error_ds_parent_is_an_alias_text: STRING is
			"Having a parent that is an alias is not permitted. Aliases are leaf objects."

	Error_ds_parent_is_an_alias_value: INTEGER is 8330

	Error_ds_cant_mix_master_and_reps_text: STRING is
			"The object and parent must be of the same type, either both masters or  both replicas."

	Error_ds_cant_mix_master_and_reps_value: INTEGER is 8331

	Error_ds_children_exist_text: STRING is
			"The operation cannot be performed because child objects exist. This operation can only be performed on a leaf object."

	Error_ds_children_exist_value: INTEGER is 8332

	Error_ds_obj_not_found_text: STRING is
			"Directory object not found."

	Error_ds_obj_not_found_value: INTEGER is 8333

	Error_ds_aliased_obj_missing_text: STRING is
			"The aliased object is missing."

	Error_ds_aliased_obj_missing_value: INTEGER is 8334

	Error_ds_bad_name_syntax_text: STRING is
			"The object name has bad syntax."

	Error_ds_bad_name_syntax_value: INTEGER is 8335

	Error_ds_alias_points_to_alias_text: STRING is
			"It is not permitted for an alias to refer to another alias."

	Error_ds_alias_points_to_alias_value: INTEGER is 8336

	Error_ds_cant_deref_alias_text: STRING is
			"The alias cannot be dereferenced."

	Error_ds_cant_deref_alias_value: INTEGER is 8337

	Error_ds_out_of_scope_text: STRING is
			"The operation is out of scope."

	Error_ds_out_of_scope_value: INTEGER is 8338

	Error_ds_cant_delete_dsa_obj_text: STRING is
			"The DSA object cannot be deleted."

	Error_ds_cant_delete_dsa_obj_value: INTEGER is 8340

	Error_ds_generic_error_text: STRING is
			"A directory service error has occurred."

	Error_ds_generic_error_value: INTEGER is 8341

	Error_ds_dsa_must_be_int_master_text: STRING is
			"The operation can only be performed on an internal master DSA object."

	Error_ds_dsa_must_be_int_master_value: INTEGER is 8342

	Error_ds_class_not_dsa_text: STRING is
			"The object must be of class DSA."

	Error_ds_class_not_dsa_value: INTEGER is 8343

	Error_ds_insuff_access_rights_text: STRING is
			"Insufficient access rights to perform the operation."

	Error_ds_insuff_access_rights_value: INTEGER is 8344

	Error_ds_illegal_superior_text: STRING is
			"The object cannot be added because the parent is not on the list of possible superiors."

	Error_ds_illegal_superior_value: INTEGER is 8345

	Error_ds_attribute_owned_by_sam_text: STRING is
			"Access to the attribute is not permitted because the attribute is owned by the Security Accounts Manager (SAM)."

	Error_ds_attribute_owned_by_sam_value: INTEGER is 8346

	Error_ds_name_too_many_parts_text: STRING is
			"The name has too many parts."

	Error_ds_name_too_many_parts_value: INTEGER is 8347

	Error_ds_name_too_long_text: STRING is
			"The name is too long."

	Error_ds_name_too_long_value: INTEGER is 8348

	Error_ds_name_value_too_long_text: STRING is
			"The name value is too long."

	Error_ds_name_value_too_long_value: INTEGER is 8349

	Error_ds_name_unparseable_text: STRING is
			"The directory service encountered an error parsing a name."

	Error_ds_name_unparseable_value: INTEGER is 8350

	Error_ds_name_type_unknown_text: STRING is
			"The directory service cannot get the attribute type for a name."

	Error_ds_name_type_unknown_value: INTEGER is 8351

	Error_ds_not_an_object_text: STRING is
			"The name does not identify an object; the name identifies a phantom."

	Error_ds_not_an_object_value: INTEGER is 8352

	Error_ds_sec_desc_too_short_text: STRING is
			"The security descriptor is too short."

	Error_ds_sec_desc_too_short_value: INTEGER is 8353

	Error_ds_sec_desc_invalid_text: STRING is
			"The security descriptor is invalid."

	Error_ds_sec_desc_invalid_value: INTEGER is 8354

	Error_ds_no_deleted_name_text: STRING is
			"Failed to create name for deleted object."

	Error_ds_no_deleted_name_value: INTEGER is 8355

	Error_ds_subref_must_have_parent_text: STRING is
			"The parent of a new subref must exist."

	Error_ds_subref_must_have_parent_value: INTEGER is 8356

	Error_ds_ncname_must_be_nc_text: STRING is
			"The object must be a naming context."

	Error_ds_ncname_must_be_nc_value: INTEGER is 8357

	Error_ds_cant_add_system_only_text: STRING is
			"It is not permitted to add an attribute which is owned by the system."

	Error_ds_cant_add_system_only_value: INTEGER is 8358

	Error_ds_class_must_be_concrete_text: STRING is
			"The class of the object must be structural; you cannot instantiate an abstract class."

	Error_ds_class_must_be_concrete_value: INTEGER is 8359

	Error_ds_invalid_dmd_text: STRING is
			"The schema object could not be found."

	Error_ds_invalid_dmd_value: INTEGER is 8360

	Error_ds_obj_guid_exists_text: STRING is
			"A local object with this GUID (dead or alive) already exists."

	Error_ds_obj_guid_exists_value: INTEGER is 8361

	Error_ds_not_on_backlink_text: STRING is
			"The operation cannot be performed on a back link."

	Error_ds_not_on_backlink_value: INTEGER is 8362

	Error_ds_no_crossref_for_nc_text: STRING is
			"The cross reference for the specified naming context could not be found."

	Error_ds_no_crossref_for_nc_value: INTEGER is 8363

	Error_ds_shutting_down_text: STRING is
			"The operation could not be performed because the directory service is shutting down."

	Error_ds_shutting_down_value: INTEGER is 8364

	Error_ds_unknown_operation_text: STRING is
			"The directory service request is invalid."

	Error_ds_unknown_operation_value: INTEGER is 8365

	Error_ds_invalid_role_owner_text: STRING is
			"The role owner attribute could not be read."

	Error_ds_invalid_role_owner_value: INTEGER is 8366

	Error_ds_couldnt_contact_fsmo_text: STRING is
			"The requested FSMO operation failed. The current FSMO holder could not be contacted."

	Error_ds_couldnt_contact_fsmo_value: INTEGER is 8367

	Error_ds_cross_nc_dn_rename_text: STRING is
			"Modification of a DN across a naming context is not permitted."

	Error_ds_cross_nc_dn_rename_value: INTEGER is 8368

	Error_ds_cant_mod_system_only_text: STRING is
			"The attribute cannot be modified because it is owned by the system."

	Error_ds_cant_mod_system_only_value: INTEGER is 8369

	Error_ds_replicator_only_text: STRING is
			"Only the replicator can perform this function."

	Error_ds_replicator_only_value: INTEGER is 8370

	Error_ds_obj_class_not_defined_text: STRING is
			"The specified class is not defined."

	Error_ds_obj_class_not_defined_value: INTEGER is 8371

	Error_ds_obj_class_not_subclass_text: STRING is
			"The specified class is not a subclass."

	Error_ds_obj_class_not_subclass_value: INTEGER is 8372

	Error_ds_name_reference_invalid_text: STRING is
			"The name reference is invalid."

	Error_ds_name_reference_invalid_value: INTEGER is 8373

	Error_ds_cross_ref_exists_text: STRING is
			"A cross reference already exists."

	Error_ds_cross_ref_exists_value: INTEGER is 8374

	Error_ds_cant_del_master_crossref_text: STRING is
			"It is not permitted to delete a master cross reference."

	Error_ds_cant_del_master_crossref_value: INTEGER is 8375

	Error_ds_subtree_notify_not_nc_head_text: STRING is
			"Subtree notifications are only supported on NC heads."

	Error_ds_subtree_notify_not_nc_head_value: INTEGER is 8376

	Error_ds_notify_filter_too_complex_text: STRING is
			"Notification filter is too complex."

	Error_ds_notify_filter_too_complex_value: INTEGER is 8377

	Error_ds_dup_rdn_text: STRING is
			"Schema update failed: duplicate RDN."

	Error_ds_dup_rdn_value: INTEGER is 8378

	Error_ds_dup_oid_text: STRING is
			"Schema update failed: duplicate OID."

	Error_ds_dup_oid_value: INTEGER is 8379

	Error_ds_dup_mapi_id_text: STRING is
			"Schema update failed: duplicate MAPI identifier."

	Error_ds_dup_mapi_id_value: INTEGER is 8380

	Error_ds_dup_schema_id_guid_text: STRING is
			"Schema update failed: duplicate schema-id GUID."

	Error_ds_dup_schema_id_guid_value: INTEGER is 8381

	Error_ds_dup_ldap_display_name_text: STRING is
			"Schema update failed: duplicate LDAP display name."

	Error_ds_dup_ldap_display_name_value: INTEGER is 8382

	Error_ds_semantic_att_test_text: STRING is
			"Schema update failed: range-lower less than range upper."

	Error_ds_semantic_att_test_value: INTEGER is 8383

	Error_ds_syntax_mismatch_text: STRING is
			"Schema update failed: syntax mismatch."

	Error_ds_syntax_mismatch_value: INTEGER is 8384

	Error_ds_exists_in_must_have_text: STRING is
			"Schema deletion failed: attribute is used in must-contain."

	Error_ds_exists_in_must_have_value: INTEGER is 8385

	Error_ds_exists_in_may_have_text: STRING is
			"Schema deletion failed: attribute is used in may-contain."

	Error_ds_exists_in_may_have_value: INTEGER is 8386

	Error_ds_nonexistent_may_have_text: STRING is
			"Schema update failed: attribute in may-contain does not exist."

	Error_ds_nonexistent_may_have_value: INTEGER is 8387

	Error_ds_nonexistent_must_have_text: STRING is
			"Schema update failed: attribute in must-contain does not exist."

	Error_ds_nonexistent_must_have_value: INTEGER is 8388

	Error_ds_aux_cls_test_fail_text: STRING is
			"Schema update failed: class in aux-class list does not exist or is not an auxiliary class."

	Error_ds_aux_cls_test_fail_value: INTEGER is 8389

	Error_ds_nonexistent_poss_sup_text: STRING is
			"Schema update failed: class in poss-superiors does not exist."

	Error_ds_nonexistent_poss_sup_value: INTEGER is 8390

	Error_ds_sub_cls_test_fail_text: STRING is
			"Schema update failed: class in subclassof list does not exist or does not satisfy hierarchy rules."

	Error_ds_sub_cls_test_fail_value: INTEGER is 8391

	Error_ds_bad_rdn_att_id_syntax_text: STRING is
			"Schema update failed: Rdn-Att-Id has wrong syntax."

	Error_ds_bad_rdn_att_id_syntax_value: INTEGER is 8392

	Error_ds_exists_in_aux_cls_text: STRING is
			"Schema deletion failed: class is used as auxiliary class."

	Error_ds_exists_in_aux_cls_value: INTEGER is 8393

	Error_ds_exists_in_sub_cls_text: STRING is
			"Schema deletion failed: class is used as sub class."

	Error_ds_exists_in_sub_cls_value: INTEGER is 8394

	Error_ds_exists_in_poss_sup_text: STRING is
			"Schema deletion failed: class is used as poss superior."

	Error_ds_exists_in_poss_sup_value: INTEGER is 8395

	Error_ds_recalcschema_failed_text: STRING is
			"Schema update failed in recalculating validation cache."

	Error_ds_recalcschema_failed_value: INTEGER is 8396

	Error_ds_tree_delete_not_finished_text: STRING is
			"The tree deletion is not finished.  The request must be made again to continue deleting the tree."

	Error_ds_tree_delete_not_finished_value: INTEGER is 8397

	Error_ds_cant_delete_text: STRING is
			"The requested delete operation could not be performed."

	Error_ds_cant_delete_value: INTEGER is 8398

	Error_ds_att_schema_req_id_text: STRING is
			"Cannot read the governs class identifier for the schema record."

	Error_ds_att_schema_req_id_value: INTEGER is 8399

	Error_ds_bad_att_schema_syntax_text: STRING is
			"The attribute schema has bad syntax."

	Error_ds_bad_att_schema_syntax_value: INTEGER is 8400

	Error_ds_cant_cache_att_text: STRING is
			"The attribute could not be cached."

	Error_ds_cant_cache_att_value: INTEGER is 8401

	Error_ds_cant_cache_class_text: STRING is
			"The class could not be cached."

	Error_ds_cant_cache_class_value: INTEGER is 8402

	Error_ds_cant_remove_att_cache_text: STRING is
			"The attribute could not be removed from the cache."

	Error_ds_cant_remove_att_cache_value: INTEGER is 8403

	Error_ds_cant_remove_class_cache_text: STRING is
			"The class could not be removed from the cache."

	Error_ds_cant_remove_class_cache_value: INTEGER is 8404

	Error_ds_cant_retrieve_dn_text: STRING is
			"The distinguished name attribute could not be read."

	Error_ds_cant_retrieve_dn_value: INTEGER is 8405

	Error_ds_missing_supref_text: STRING is
			"A required subref is missing."

	Error_ds_missing_supref_value: INTEGER is 8406

	Error_ds_cant_retrieve_instance_text: STRING is
			"The instance type attribute could not be retrieved."

	Error_ds_cant_retrieve_instance_value: INTEGER is 8407

	Error_ds_code_inconsistency_text: STRING is
			"An internal error has occurred."

	Error_ds_code_inconsistency_value: INTEGER is 8408

	Error_ds_database_error_text: STRING is
			"A database error has occurred."

	Error_ds_database_error_value: INTEGER is 8409

	Error_ds_governsid_missing_text: STRING is
			"The attribute GOVERNSID is missing."

	Error_ds_governsid_missing_value: INTEGER is 8410

	Error_ds_missing_expected_att_text: STRING is
			"An expected attribute is missing."

	Error_ds_missing_expected_att_value: INTEGER is 8411

	Error_ds_ncname_missing_cr_ref_text: STRING is
			"The specified naming context is missing a cross reference."

	Error_ds_ncname_missing_cr_ref_value: INTEGER is 8412

	Error_ds_security_checking_error_text: STRING is
			"A security checking error has occurred."

	Error_ds_security_checking_error_value: INTEGER is 8413

	Error_ds_schema_not_loaded_text: STRING is
			"The schema is not loaded."

	Error_ds_schema_not_loaded_value: INTEGER is 8414

	Error_ds_schema_alloc_failed_text: STRING is
			"Schema allocation failed. Please check if the machine is running low on memory."

	Error_ds_schema_alloc_failed_value: INTEGER is 8415

	Error_ds_att_schema_req_syntax_text: STRING is
			"Failed to obtain the required syntax for the attribute schema."

	Error_ds_att_schema_req_syntax_value: INTEGER is 8416

	Error_ds_gcverify_error_text: STRING is
			"The global catalog verification failed. The global catalog is not available or does not support the operation. Some part of the directory is currently not available."

	Error_ds_gcverify_error_value: INTEGER is 8417

	Error_ds_dra_schema_mismatch_text: STRING is
			"The replication operation failed because of a schema mismatch between the servers involved."

	Error_ds_dra_schema_mismatch_value: INTEGER is 8418

	Error_ds_cant_find_dsa_obj_text: STRING is
			"The DSA object could not be found."

	Error_ds_cant_find_dsa_obj_value: INTEGER is 8419

	Error_ds_cant_find_expected_nc_text: STRING is
			"The naming context could not be found."

	Error_ds_cant_find_expected_nc_value: INTEGER is 8420

	Error_ds_cant_find_nc_in_cache_text: STRING is
			"The naming context could not be found in the cache."

	Error_ds_cant_find_nc_in_cache_value: INTEGER is 8421

	Error_ds_cant_retrieve_child_text: STRING is
			"The child object could not be retrieved."

	Error_ds_cant_retrieve_child_value: INTEGER is 8422

	Error_ds_security_illegal_modify_text: STRING is
			"The modification was not permitted for security reasons."

	Error_ds_security_illegal_modify_value: INTEGER is 8423

	Error_ds_cant_replace_hidden_rec_text: STRING is
			"The operation cannot replace the hidden record."

	Error_ds_cant_replace_hidden_rec_value: INTEGER is 8424

	Error_ds_bad_hierarchy_file_text: STRING is
			"The hierarchy file is invalid."

	Error_ds_bad_hierarchy_file_value: INTEGER is 8425

	Error_ds_build_hierarchy_table_failed_text: STRING is
			"The attempt to build the hierarchy table failed."

	Error_ds_build_hierarchy_table_failed_value: INTEGER is 8426

	Error_ds_config_param_missing_text: STRING is
			"The directory configuration parameter is missing from the registry."

	Error_ds_config_param_missing_value: INTEGER is 8427

	Error_ds_counting_ab_indices_failed_text: STRING is
			"The attempt to count the address book indices failed."

	Error_ds_counting_ab_indices_failed_value: INTEGER is 8428

	Error_ds_hierarchy_table_malloc_failed_text: STRING is
			"The allocation of the hierarchy table failed."

	Error_ds_hierarchy_table_malloc_failed_value: INTEGER is 8429

	Error_ds_internal_failure_text: STRING is
			"The directory service encountered an internal failure."

	Error_ds_internal_failure_value: INTEGER is 8430

	Error_ds_unknown_error_text: STRING is
			"The directory service encountered an unknown failure."

	Error_ds_unknown_error_value: INTEGER is 8431

	Error_ds_root_requires_class_top_text: STRING is
			"A root object requires a class of 'top'."

	Error_ds_root_requires_class_top_value: INTEGER is 8432

	Error_ds_refusing_fsmo_roles_text: STRING is
			"This directory server is shutting down, and cannot take ownership of new floating single-master operation roles."

	Error_ds_refusing_fsmo_roles_value: INTEGER is 8433

	Error_ds_missing_fsmo_settings_text: STRING is
			"The directory service is missing mandatory configuration information, and is unable to determine the ownership of floating single-master operation roles."

	Error_ds_missing_fsmo_settings_value: INTEGER is 8434

	Error_ds_unable_to_surrender_roles_text: STRING is
			"The directory service was unable to transfer ownership of one or more floating single-master operation roles to other servers."

	Error_ds_unable_to_surrender_roles_value: INTEGER is 8435

	Error_ds_dra_generic_text: STRING is
			"The replication operation failed."

	Error_ds_dra_generic_value: INTEGER is 8436

	Error_ds_dra_invalid_parameter_text: STRING is
			"An invalid parameter was specified for this replication operation."

	Error_ds_dra_invalid_parameter_value: INTEGER is 8437

	Error_ds_dra_busy_text: STRING is
			"The directory service is too busy to complete the replication operation at this time."

	Error_ds_dra_busy_value: INTEGER is 8438

	Error_ds_dra_bad_dn_text: STRING is
			"The distinguished name specified for this replication operation is invalid."

	Error_ds_dra_bad_dn_value: INTEGER is 8439

	Error_ds_dra_bad_nc_text: STRING is
			"The naming context specified for this replication operation is invalid."

	Error_ds_dra_bad_nc_value: INTEGER is 8440

	Error_ds_dra_dn_exists_text: STRING is
			"The distinguished name specified for this replication operation already exists."

	Error_ds_dra_dn_exists_value: INTEGER is 8441

	Error_ds_dra_internal_error_text: STRING is
			"The replication system encountered an internal error."

	Error_ds_dra_internal_error_value: INTEGER is 8442

	Error_ds_dra_inconsistent_dit_text: STRING is
			"The replication operation encountered a database inconsistency."

	Error_ds_dra_inconsistent_dit_value: INTEGER is 8443

	Error_ds_dra_connection_failed_text: STRING is
			"The server specified for this replication operation could not be contacted."

	Error_ds_dra_connection_failed_value: INTEGER is 8444

	Error_ds_dra_bad_instance_type_text: STRING is
			"The replication operation encountered an object with an invalid instance type."

	Error_ds_dra_bad_instance_type_value: INTEGER is 8445

	Error_ds_dra_out_of_mem_text: STRING is
			"The replication operation failed to allocate memory."

	Error_ds_dra_out_of_mem_value: INTEGER is 8446

	Error_ds_dra_mail_problem_text: STRING is
			"The replication operation encountered an error with the mail system."

	Error_ds_dra_mail_problem_value: INTEGER is 8447

	Error_ds_dra_ref_already_exists_text: STRING is
			"The replication reference information for the target server already exists."

	Error_ds_dra_ref_already_exists_value: INTEGER is 8448

	Error_ds_dra_ref_not_found_text: STRING is
			"The replication reference information for the target server does not exist."

	Error_ds_dra_ref_not_found_value: INTEGER is 8449

	Error_ds_dra_obj_is_rep_source_text: STRING is
			"The naming context cannot be removed because it is replicated to another server."

	Error_ds_dra_obj_is_rep_source_value: INTEGER is 8450

	Error_ds_dra_db_error_text: STRING is
			"The replication operation encountered a database error."

	Error_ds_dra_db_error_value: INTEGER is 8451

	Error_ds_dra_no_replica_text: STRING is
			"The naming context is in the process of being removed or is not replicated from the specified server."

	Error_ds_dra_no_replica_value: INTEGER is 8452

	Error_ds_dra_access_denied_text: STRING is
			"Replication access was denied."

	Error_ds_dra_access_denied_value: INTEGER is 8453

	Error_ds_dra_not_supported_text: STRING is
			"The requested operation is not supported by this version of the directory service."

	Error_ds_dra_not_supported_value: INTEGER is 8454

	Error_ds_dra_rpc_cancelled_text: STRING is
			"The replication remote procedure call was cancelled."

	Error_ds_dra_rpc_cancelled_value: INTEGER is 8455

	Error_ds_dra_source_disabled_text: STRING is
			"The source server is currently rejecting replication requests."

	Error_ds_dra_source_disabled_value: INTEGER is 8456

	Error_ds_dra_sink_disabled_text: STRING is
			"The destination server is currently rejecting replication requests."

	Error_ds_dra_sink_disabled_value: INTEGER is 8457

	Error_ds_dra_name_collision_text: STRING is
			"The replication operation failed due to a collision of object names."

	Error_ds_dra_name_collision_value: INTEGER is 8458

	Error_ds_dra_source_reinstalled_text: STRING is
			"The replication source has been reinstalled."

	Error_ds_dra_source_reinstalled_value: INTEGER is 8459

	Error_ds_dra_missing_parent_text: STRING is
			"The replication operation failed because a required parent object is missing."

	Error_ds_dra_missing_parent_value: INTEGER is 8460

	Error_ds_dra_preempted_text: STRING is
			"The replication operation was preempted."

	Error_ds_dra_preempted_value: INTEGER is 8461

	Error_ds_dra_abandon_sync_text: STRING is
			"The replication synchronization attempt was abandoned because of a lack of updates."

	Error_ds_dra_abandon_sync_value: INTEGER is 8462

	Error_ds_dra_shutdown_text: STRING is
			"The replication operation was terminated because the system is shutting down."

	Error_ds_dra_shutdown_value: INTEGER is 8463

	Error_ds_dra_incompatible_partial_set_text: STRING is
			"The replication synchronization attempt failed as the destination partial attribute set is not a subset of source partial attribute set."

	Error_ds_dra_incompatible_partial_set_value: INTEGER is 8464

	Error_ds_dra_source_is_partial_replica_text: STRING is
			"The replication synchronization attempt failed because a master replica attempted to sync from a partial replica."

	Error_ds_dra_source_is_partial_replica_value: INTEGER is 8465

	Error_ds_dra_extn_connection_failed_text: STRING is
			"The server specified for this replication operation was contacted, but that server was unable to contact an additional server needed to complete the operation."

	Error_ds_dra_extn_connection_failed_value: INTEGER is 8466

	Error_ds_install_schema_mismatch_text: STRING is
			"A schema mismatch is detected between the source and the build used during a replica install. The replica cannot be installed."

	Error_ds_install_schema_mismatch_value: INTEGER is 8467

	Error_ds_dup_link_id_text: STRING is
			"Schema update failed: An attribute with the same link identifier already exists."

	Error_ds_dup_link_id_value: INTEGER is 8468

	Error_ds_name_error_resolving_text: STRING is
			"Name translation: Generic processing error."

	Error_ds_name_error_resolving_value: INTEGER is 8469

	Error_ds_name_error_not_found_text: STRING is
			"Name translation: Could not find the name or insufficient right to see name."

	Error_ds_name_error_not_found_value: INTEGER is 8470

	Error_ds_name_error_not_unique_text: STRING is
			"Name translation: Input name mapped to more than one output name."

	Error_ds_name_error_not_unique_value: INTEGER is 8471

	Error_ds_name_error_no_mapping_text: STRING is
			"Name translation: Input name found, but not the associated output format."

	Error_ds_name_error_no_mapping_value: INTEGER is 8472

	Error_ds_name_error_domain_only_text: STRING is
			"Name translation: Unable to resolve completely, only the domain was found."

	Error_ds_name_error_domain_only_value: INTEGER is 8473

	Error_ds_name_error_no_syntactical_mapping_text: STRING is
			"Name translation: Unable to perform purely syntactical mapping at the client without going out to the wire."

	Error_ds_name_error_no_syntactical_mapping_value: INTEGER is 8474

	Error_ds_constructed_att_mod_text: STRING is
			"Modification of a constructed att is not allowed."

	Error_ds_constructed_att_mod_value: INTEGER is 8475

	Error_ds_wrong_om_obj_class_text: STRING is
			"The OM-Object-Class specified is incorrect for an attribute with the specified syntax."

	Error_ds_wrong_om_obj_class_value: INTEGER is 8476

	Error_ds_dra_repl_pending_text: STRING is
			"The replication request has been posted; waiting for reply."

	Error_ds_dra_repl_pending_value: INTEGER is 8477

	Error_ds_ds_required_text: STRING is
			"The requested operation requires a directory service, and none was available."

	Error_ds_ds_required_value: INTEGER is 8478

	Error_ds_invalid_ldap_display_name_text: STRING is
			"The LDAP display name of the class or attribute contains non-ASCII characters."

	Error_ds_invalid_ldap_display_name_value: INTEGER is 8479

	Error_ds_non_base_search_text: STRING is
			"The requested search operation is only supported for base searches."

	Error_ds_non_base_search_value: INTEGER is 8480

	Error_ds_cant_retrieve_atts_text: STRING is
			"The search failed to retrieve attributes from the database."

	Error_ds_cant_retrieve_atts_value: INTEGER is 8481

	Error_ds_backlink_without_link_text: STRING is
			"The schema update operation tried to add a backward link attribute that has no corresponding forward link."

	Error_ds_backlink_without_link_value: INTEGER is 8482

	Error_ds_epoch_mismatch_text: STRING is
			"Source and destination of a cross-domain move do not agree on the object's epoch number.  Either source or destination does not have the latest version of the object."

	Error_ds_epoch_mismatch_value: INTEGER is 8483

	Error_ds_src_name_mismatch_text: STRING is
			"Source and destination of a cross-domain move do not agree on the object's current name.  Either source or destination does not have the latest version of the object."

	Error_ds_src_name_mismatch_value: INTEGER is 8484

	Error_ds_src_and_dst_nc_identical_text: STRING is
			"Source and destination for the cross-domain move operation are identical.  Caller should use local move operation instead of cross-domain move operation."

	Error_ds_src_and_dst_nc_identical_value: INTEGER is 8485

	Error_ds_dst_nc_mismatch_text: STRING is
			"Source and destination for a cross-domain move are not in agreement on the naming contexts in the forest.  Either source or destination does not have the latest version of the Partitions container."

	Error_ds_dst_nc_mismatch_value: INTEGER is 8486

	Error_ds_not_authoritive_for_dst_nc_text: STRING is
			"Destination of a cross-domain move is not authoritative for the destination naming context."

	Error_ds_not_authoritive_for_dst_nc_value: INTEGER is 8487

	Error_ds_src_guid_mismatch_text: STRING is
			"Source and destination of a cross-domain move do not agree on the identity of the source object.  Either source or destination does not have the latest version of the source object."

	Error_ds_src_guid_mismatch_value: INTEGER is 8488

	Error_ds_cant_move_deleted_object_text: STRING is
			"Object being moved across-domains is already known to be deleted by the destination server.  The source server does not have the latest version of the source object."

	Error_ds_cant_move_deleted_object_value: INTEGER is 8489

	Error_ds_pdc_operation_in_progress_text: STRING is
			"Another operation which requires exclusive access to the PDC FSMO is already in progress."

	Error_ds_pdc_operation_in_progress_value: INTEGER is 8490

	Error_ds_cross_domain_cleanup_reqd_text: STRING is
			"A cross-domain move operation failed such that two versions of the moved object exist - one each in the source and destination domains.  The destination object needs to be removed to restore the system to a consistent state."

	Error_ds_cross_domain_cleanup_reqd_value: INTEGER is 8491

	Error_ds_illegal_xdom_move_operation_text: STRING is
			"This object may not be moved across domain boundaries either because cross-domain moves for this class are disallowed, or the object has some special characteristics, eg: trust account or restricted RID, which prevent its move."

	Error_ds_illegal_xdom_move_operation_value: INTEGER is 8492

	Error_ds_cant_with_acct_group_membershps_text: STRING is
			"Can't move objects with memberships across domain boundaries as once moved, this would violate the membership conditions of the account group.  Remove the object from any account group memberships and retry."

	Error_ds_cant_with_acct_group_membershps_value: INTEGER is 8493

	Error_ds_nc_must_have_nc_parent_text: STRING is
			"A naming context head must be the immediate child of another naming context head, not of an interior node."

	Error_ds_nc_must_have_nc_parent_value: INTEGER is 8494

	Error_ds_cr_impossible_to_validate_text: STRING is
			"The directory cannot validate the proposed naming context name because it does not hold a replica of the naming context above the proposed naming context.  Please ensure that the domain naming master role is held by a server that is configured as a global catalog server, and that the server is up to date with its replication partners."

	Error_ds_cr_impossible_to_validate_value: INTEGER is 8495

	Error_ds_dst_domain_not_native_text: STRING is
			"Destination domain must be in native mode."

	Error_ds_dst_domain_not_native_value: INTEGER is 8496

	Error_ds_missing_infrastructure_container_text: STRING is
			"The operation can not be performed because the server does not have an infrastructure container in the domain of interest."

	Error_ds_missing_infrastructure_container_value: INTEGER is 8497

	Error_ds_cant_move_account_group_text: STRING is
			"Cross-domain move of account groups is not allowed."

	Error_ds_cant_move_account_group_value: INTEGER is 8498

	Error_ds_cant_move_resource_group_text: STRING is
			"Cross-domain move of resource groups is not allowed."

	Error_ds_cant_move_resource_group_value: INTEGER is 8499

	Error_ds_invalid_search_flag_text: STRING is
			"The search flags for the attribute are invalid. The ANR bit is valid only on attributes of Unicode or Teletex strings."

	Error_ds_invalid_search_flag_value: INTEGER is 8500

	Error_ds_no_tree_delete_above_nc_text: STRING is
			"Tree deletions starting at an object which has an NC head as a descendant are not allowed."

	Error_ds_no_tree_delete_above_nc_value: INTEGER is 8501

	Error_ds_couldnt_lock_tree_for_delete_text: STRING is
			"The directory service failed to lock a tree in preparation for a tree deletion because the tree was in use."

	Error_ds_couldnt_lock_tree_for_delete_value: INTEGER is 8502

	Error_ds_couldnt_identify_objects_for_tree_delete_text: STRING is
			"The directory service failed to identify the list of objects to delete while attempting a tree deletion."

	Error_ds_couldnt_identify_objects_for_tree_delete_value: INTEGER is 8503

	Error_ds_sam_init_failure_text: STRING is
			"Security Accounts Manager initialization failed because of the following error: %%1.  Error Status: 0x%%2. Click OK to shut down the system and reboot into Directory Services Restore Mode. Check the event log for detailed information."

	Error_ds_sam_init_failure_value: INTEGER is 8504

	Error_ds_sensitive_group_violation_text: STRING is
			"Only an administrator can modify the membership list of an administrative group."

	Error_ds_sensitive_group_violation_value: INTEGER is 8505

	Error_ds_cant_mod_primarygroupid_text: STRING is
			"Cannot change the primary group ID of a domain controller account."

	Error_ds_cant_mod_primarygroupid_value: INTEGER is 8506

	Error_ds_illegal_base_schema_mod_text: STRING is
			"An attempt is made to modify the base schema."

	Error_ds_illegal_base_schema_mod_value: INTEGER is 8507

	Error_ds_nonsafe_schema_change_text: STRING is
			"Adding a new mandatory attribute to an existing class, deleting a mandatory attribute from an existing class, or adding an optional attribute to the special class Top that is not a backlink attribute (directly or through inheritance, for example, by adding or deleting an auxiliary class) is not allowed."

	Error_ds_nonsafe_schema_change_value: INTEGER is 8508

	Error_ds_schema_update_disallowed_text: STRING is
			"Schema update is not allowed on this DC. Either the registry key is not set or the DC is not the schema FSMO Role Owner."

	Error_ds_schema_update_disallowed_value: INTEGER is 8509

	Error_ds_cant_create_under_schema_text: STRING is
			"An object of this class cannot be created under the schema container. You can only create attribute-schema and class-schema objects under the schema container."

	Error_ds_cant_create_under_schema_value: INTEGER is 8510

	Error_ds_install_no_src_sch_version_text: STRING is
			"The replica/child install failed to get the objectVersion attribute on the schema container on the source DC. Either the attribute is missing on the schema container or the credentials supplied do not have permission to read it."

	Error_ds_install_no_src_sch_version_value: INTEGER is 8511

	Error_ds_install_no_sch_version_in_inifile_text: STRING is
			"The replica/child install failed to read the objectVersion attribute in the SCHEMA section of the file schema.ini in the system32 directory."

	Error_ds_install_no_sch_version_in_inifile_value: INTEGER is 8512

	Error_ds_invalid_group_type_text: STRING is
			"The specified group type is invalid."

	Error_ds_invalid_group_type_value: INTEGER is 8513

	Error_ds_no_nest_globalgroup_in_mixeddomain_text: STRING is
			"You cannot nest global groups in a mixed domain if the group is security-enabled."

	Error_ds_no_nest_globalgroup_in_mixeddomain_value: INTEGER is 8514

	Error_ds_no_nest_localgroup_in_mixeddomain_text: STRING is
			"You cannot nest local groups in a mixed domain if the group is security-enabled."

	Error_ds_no_nest_localgroup_in_mixeddomain_value: INTEGER is 8515

	Error_ds_global_cant_have_local_member_text: STRING is
			"A global group cannot have a local group as a member."

	Error_ds_global_cant_have_local_member_value: INTEGER is 8516

	Error_ds_global_cant_have_universal_member_text: STRING is
			"A global group cannot have a universal group as a member."

	Error_ds_global_cant_have_universal_member_value: INTEGER is 8517

	Error_ds_universal_cant_have_local_member_text: STRING is
			"A universal group cannot have a local group as a member."

	Error_ds_universal_cant_have_local_member_value: INTEGER is 8518

	Error_ds_global_cant_have_crossdomain_member_text: STRING is
			"A global group cannot have a cross-domain member."

	Error_ds_global_cant_have_crossdomain_member_value: INTEGER is 8519

	Error_ds_local_cant_have_crossdomain_local_member_text: STRING is
			"A local group cannot have another cross domain local group as a member."

	Error_ds_local_cant_have_crossdomain_local_member_value: INTEGER is 8520

	Error_ds_have_primary_members_text: STRING is
			"A group with primary members cannot change to a security-disabled group."

	Error_ds_have_primary_members_value: INTEGER is 8521

	Error_ds_string_sd_conversion_failed_text: STRING is
			"The schema cache load failed to convert the string default SD on a class-schema object."

	Error_ds_string_sd_conversion_failed_value: INTEGER is 8522

	Error_ds_naming_master_gc_text: STRING is
			"Only DSAs configured to be Global Catalog servers should be allowed to hold the Domain Naming Master FSMO role."

	Error_ds_naming_master_gc_value: INTEGER is 8523

	Error_ds_dns_lookup_failure_text: STRING is
			"The DSA operation is unable to proceed because of a DNS lookup failure."

	Error_ds_dns_lookup_failure_value: INTEGER is 8524

	Error_ds_couldnt_update_spns_text: STRING is
			"While processing a change to the DNS Host Name for an object, the Service Principal Name values could not be kept in sync."

	Error_ds_couldnt_update_spns_value: INTEGER is 8525

	Error_ds_cant_retrieve_sd_text: STRING is
			"The Security Descriptor attribute could not be read."

	Error_ds_cant_retrieve_sd_value: INTEGER is 8526

	Error_ds_key_not_unique_text: STRING is
			"The object requested was not found, but an object with that key was found."

	Error_ds_key_not_unique_value: INTEGER is 8527

	Error_ds_wrong_linked_att_syntax_text: STRING is
			"The syntax of the linked attribute being added is incorrect. Forward links can only have syntax 2.5.5.1, 2.5.5.7, and 2.5.5.14, and backlinks can only have syntax 2.5.5.1"

	Error_ds_wrong_linked_att_syntax_value: INTEGER is 8528

	Error_ds_sam_need_bootkey_password_text: STRING is
			"Security Account Manager needs to get the boot password."

	Error_ds_sam_need_bootkey_password_value: INTEGER is 8529

	Error_ds_sam_need_bootkey_floppy_text: STRING is
			"Security Account Manager needs to get the boot key from floppy disk."

	Error_ds_sam_need_bootkey_floppy_value: INTEGER is 8530

	Error_ds_cant_start_text: STRING is
			"Directory Service cannot start."

	Error_ds_cant_start_value: INTEGER is 8531

	Error_ds_init_failure_text: STRING is
			"Directory Services could not start."

	Error_ds_init_failure_value: INTEGER is 8532

	Error_ds_no_pkt_privacy_on_connection_text: STRING is
			"The connection between client and server requires packet privacy or better."

	Error_ds_no_pkt_privacy_on_connection_value: INTEGER is 8533

	Error_ds_source_domain_in_forest_text: STRING is
			"The source domain may not be in the same forest as destination."

	Error_ds_source_domain_in_forest_value: INTEGER is 8534

	Error_ds_destination_domain_not_in_forest_text: STRING is
			"The destination domain must be in the forest."

	Error_ds_destination_domain_not_in_forest_value: INTEGER is 8535

	Error_ds_destination_auditing_not_enabled_text: STRING is
			"The operation requires that destination domain auditing be enabled."

	Error_ds_destination_auditing_not_enabled_value: INTEGER is 8536

	Error_ds_cant_find_dc_for_src_domain_text: STRING is
			"The operation couldn't locate a DC for the source domain."

	Error_ds_cant_find_dc_for_src_domain_value: INTEGER is 8537

	Error_ds_src_obj_not_group_or_user_text: STRING is
			"The source object must be a group or user."

	Error_ds_src_obj_not_group_or_user_value: INTEGER is 8538

	Error_ds_src_sid_exists_in_forest_text: STRING is
			"The source object's SID already exists in destination forest."

	Error_ds_src_sid_exists_in_forest_value: INTEGER is 8539

	Error_ds_src_and_dst_object_class_mismatch_text: STRING is
			"The source and destination object must be of the same type."

	Error_ds_src_and_dst_object_class_mismatch_value: INTEGER is 8540

	Error_sam_init_failure_text: STRING is
			"Security Accounts Manager initialization failed because of the following error: %%1.  Error Status: 0x%%2. Click OK to shut down the system and reboot into Safe Mode. Check the event log for detailed information."

	Error_sam_init_failure_value: INTEGER is 8541

	Error_ds_dra_schema_info_ship_text: STRING is
			"Schema information could not be included in the replication request."

	Error_ds_dra_schema_info_ship_value: INTEGER is 8542

	Error_ds_dra_schema_conflict_text: STRING is
			"The replication operation could not be completed due to a schema  incompatibility."

	Error_ds_dra_schema_conflict_value: INTEGER is 8543

	Error_ds_dra_earlier_schema_conflict_text: STRING is
			"The replication operation could not be completed due to a previous schema incompatibility."

	Error_ds_dra_earlier_schema_conflict_value: INTEGER is 8544

	Error_ds_dra_obj_nc_mismatch_text: STRING is
			"The replication update could not be applied because either the source or the destination has not yet received information regarding a recent cross-domain move operation."

	Error_ds_dra_obj_nc_mismatch_value: INTEGER is 8545

	Error_ds_nc_still_has_dsas_text: STRING is
			"The requested domain could not be deleted because there exist domain controllers that still host this domain."

	Error_ds_nc_still_has_dsas_value: INTEGER is 8546

	Error_ds_gc_required_text: STRING is
			"The requested operation can be performed only on a global catalog server."

	Error_ds_gc_required_value: INTEGER is 8547

	Error_ds_local_member_of_local_only_text: STRING is
			"A local group can only be a member of other local groups in the same domain."

	Error_ds_local_member_of_local_only_value: INTEGER is 8548

	Error_ds_no_fpo_in_universal_groups_text: STRING is
			"Foreign security principals cannot be members of universal groups."

	Error_ds_no_fpo_in_universal_groups_value: INTEGER is 8549

	Error_ds_cant_add_to_gc_text: STRING is
			"The attribute is not allowed to be replicated to the GC because of security reasons."

	Error_ds_cant_add_to_gc_value: INTEGER is 8550

	Error_ds_no_checkpoint_with_pdc_text: STRING is
			"The checkpoint with the PDC could not be taken because there too many modifications being processed currently."

	Error_ds_no_checkpoint_with_pdc_value: INTEGER is 8551

	Error_ds_source_auditing_not_enabled_text: STRING is
			"The operation requires that source domain auditing be enabled."

	Error_ds_source_auditing_not_enabled_value: INTEGER is 8552

	Error_ds_cant_create_in_nondomain_nc_text: STRING is
			"Security principal objects can only be created inside domain naming contexts."

	Error_ds_cant_create_in_nondomain_nc_value: INTEGER is 8553

	Error_ds_invalid_name_for_spn_text: STRING is
			"A Service Principal Name (SPN) could not be constructed because the provided hostname is not in the necessary format."

	Error_ds_invalid_name_for_spn_value: INTEGER is 8554

	Error_ds_filter_uses_contructed_attrs_text: STRING is
			"A Filter was passed that uses constructed attributes."

	Error_ds_filter_uses_contructed_attrs_value: INTEGER is 8555

	Error_ds_unicodepwd_not_in_quotes_text: STRING is
			"The unicodePwd attribute value must be enclosed in double quotes."

	Error_ds_unicodepwd_not_in_quotes_value: INTEGER is 8556

	Error_ds_machine_account_quota_exceeded_text: STRING is
			"Your computer could not be joined to the domain. You have exceeded the maximum number of computer accounts you are allowed to create in this domain. Contact your system administrator to have this limit reset or increased."

	Error_ds_machine_account_quota_exceeded_value: INTEGER is 8557

	Error_ds_must_be_run_on_dst_dc_text: STRING is
			"For security reasons, the operation must be run on the destination DC."

	Error_ds_must_be_run_on_dst_dc_value: INTEGER is 8558

	Error_ds_src_dc_must_be_sp4_or_greater_text: STRING is
			"For security reasons, the source DC must be Service Pack 4 or greater."

	Error_ds_src_dc_must_be_sp4_or_greater_value: INTEGER is 8559

	Error_ds_cant_tree_delete_critical_obj_text: STRING is
			"Critical Directory Service System objects cannot be deleted during tree delete operations.  The tree delete may have been partially performed."

	Error_ds_cant_tree_delete_critical_obj_value: INTEGER is 8560

	Dns_error_rcode_format_error_text: STRING is
			"DNS server unable to interpret format."

	Dns_error_rcode_format_error_value: INTEGER is 9001

	Dns_error_rcode_server_failure_text: STRING is
			"DNS server failure."

	Dns_error_rcode_server_failure_value: INTEGER is 9002

	Dns_error_rcode_name_error_text: STRING is
			"DNS name does not exist."

	Dns_error_rcode_name_error_value: INTEGER is 9003

	Dns_error_rcode_not_implemented_text: STRING is
			"DNS request not supported by name server."

	Dns_error_rcode_not_implemented_value: INTEGER is 9004

	Dns_error_rcode_refused_text: STRING is
			"DNS operation refused."

	Dns_error_rcode_refused_value: INTEGER is 9005

	Dns_error_rcode_yxdomain_text: STRING is
			"DNS name that ought not exist, does exist."

	Dns_error_rcode_yxdomain_value: INTEGER is 9006

	Dns_error_rcode_yxrrset_text: STRING is
			"DNS RR set that ought not exist, does exist."

	Dns_error_rcode_yxrrset_value: INTEGER is 9007

	Dns_error_rcode_nxrrset_text: STRING is
			"DNS RR set that ought to exist, does not exist."

	Dns_error_rcode_nxrrset_value: INTEGER is 9008

	Dns_error_rcode_notauth_text: STRING is
			"DNS server not authoritative for zone."

	Dns_error_rcode_notauth_value: INTEGER is 9009

	Dns_error_rcode_notzone_text: STRING is
			"DNS name in update or prereq is not in zone."

	Dns_error_rcode_notzone_value: INTEGER is 9010

	Dns_error_rcode_badsig_text: STRING is
			"DNS signature failed to verify."

	Dns_error_rcode_badsig_value: INTEGER is 9016

	Dns_error_rcode_badkey_text: STRING is
			"DNS bad key."

	Dns_error_rcode_badkey_value: INTEGER is 9017

	Dns_error_rcode_badtime_text: STRING is
			"DNS signature validity expired."

	Dns_error_rcode_badtime_value: INTEGER is 9018

	Dns_info_no_records_text: STRING is
			"No records found for given DNS query."

	Dns_info_no_records_value: INTEGER is 9501

	Dns_error_bad_packet_text: STRING is
			"Bad DNS packet."

	Dns_error_bad_packet_value: INTEGER is 9502

	Dns_error_no_packet_text: STRING is
			"No DNS packet."

	Dns_error_no_packet_value: INTEGER is 9503

	Dns_error_rcode_text: STRING is
			"DNS error, check rcode."

	Dns_error_rcode_value: INTEGER is 9504

	Dns_error_unsecure_packet_text: STRING is
			"Unsecured DNS packet."

	Dns_error_unsecure_packet_value: INTEGER is 9505

	Dns_error_invalid_type_text: STRING is
			"Invalid DNS type."

	Dns_error_invalid_type_value: INTEGER is 9551

	Dns_error_invalid_ip_address_text: STRING is
			"Invalid IP address."

	Dns_error_invalid_ip_address_value: INTEGER is 9552

	Dns_error_invalid_property_text: STRING is
			"Invalid property."

	Dns_error_invalid_property_value: INTEGER is 9553

	Dns_error_try_again_later_text: STRING is
			"Try DNS operation again later."

	Dns_error_try_again_later_value: INTEGER is 9554

	Dns_error_not_unique_text: STRING is
			"Record for given name and type is not unique."

	Dns_error_not_unique_value: INTEGER is 9555

	Dns_error_non_rfc_name_text: STRING is
			"DNS name does not comply with RFC specifications."

	Dns_error_non_rfc_name_value: INTEGER is 9556

	Dns_status_fqdn_text: STRING is
			"DNS name is a fully-qualified DNS name."

	Dns_status_fqdn_value: INTEGER is 9557

	Dns_status_dotted_name_text: STRING is
			"DNS name is dotted (multi-label)."

	Dns_status_dotted_name_value: INTEGER is 9558

	Dns_status_single_part_name_text: STRING is
			"DNS name is a single-part name."

	Dns_status_single_part_name_value: INTEGER is 9559

	Dns_error_invalid_name_char_text: STRING is
			"DNS name contains an invalid character."

	Dns_error_invalid_name_char_value: INTEGER is 9560

	Dns_error_numeric_name_text: STRING is
			"DNS name is entirely numeric."

	Dns_error_numeric_name_value: INTEGER is 9561

	Dns_error_zone_does_not_exist_text: STRING is
			"DNS zone does not exist."

	Dns_error_zone_does_not_exist_value: INTEGER is 9601

	Dns_error_no_zone_info_text: STRING is
			"DNS zone information not available."

	Dns_error_no_zone_info_value: INTEGER is 9602

	Dns_error_invalid_zone_operation_text: STRING is
			"Invalid operation for DNS zone."

	Dns_error_invalid_zone_operation_value: INTEGER is 9603

	Dns_error_zone_configuration_error_text: STRING is
			"Invalid DNS zone configuration."

	Dns_error_zone_configuration_error_value: INTEGER is 9604

	Dns_error_zone_has_no_soa_record_text: STRING is
			"DNS zone has no start of authority (SOA) record."

	Dns_error_zone_has_no_soa_record_value: INTEGER is 9605

	Dns_error_zone_has_no_ns_records_text: STRING is
			"DNS zone has no Name Server (NS) record."

	Dns_error_zone_has_no_ns_records_value: INTEGER is 9606

	Dns_error_zone_locked_text: STRING is
			"DNS zone is locked."

	Dns_error_zone_locked_value: INTEGER is 9607

	Dns_error_zone_creation_failed_text: STRING is
			"DNS zone creation failed."

	Dns_error_zone_creation_failed_value: INTEGER is 9608

	Dns_error_zone_already_exists_text: STRING is
			"DNS zone already exists."

	Dns_error_zone_already_exists_value: INTEGER is 9609

	Dns_error_autozone_already_exists_text: STRING is
			"DNS automatic zone already exists."

	Dns_error_autozone_already_exists_value: INTEGER is 9610

	Dns_error_invalid_zone_type_text: STRING is
			"Invalid DNS zone type."

	Dns_error_invalid_zone_type_value: INTEGER is 9611

	Dns_error_secondary_requires_master_ip_text: STRING is
			"Secondary DNS zone requires master IP address."

	Dns_error_secondary_requires_master_ip_value: INTEGER is 9612

	Dns_error_zone_not_secondary_text: STRING is
			"DNS zone not secondary."

	Dns_error_zone_not_secondary_value: INTEGER is 9613

	Dns_error_need_secondary_addresses_text: STRING is
			"Need secondary IP address."

	Dns_error_need_secondary_addresses_value: INTEGER is 9614

	Dns_error_wins_init_failed_text: STRING is
			"WINS initialization failed."

	Dns_error_wins_init_failed_value: INTEGER is 9615

	Dns_error_need_wins_servers_text: STRING is
			"Need WINS servers."

	Dns_error_need_wins_servers_value: INTEGER is 9616

	Dns_error_nbstat_init_failed_text: STRING is
			"NBTSTAT initialization call failed."

	Dns_error_nbstat_init_failed_value: INTEGER is 9617

	Dns_error_soa_delete_invalid_text: STRING is
			"Invalid delete of start of authority (SOA)"

	Dns_error_soa_delete_invalid_value: INTEGER is 9618

	Dns_error_primary_requires_datafile_text: STRING is
			"Primary DNS zone requires datafile."

	Dns_error_primary_requires_datafile_value: INTEGER is 9651

	Dns_error_invalid_datafile_name_text: STRING is
			"Invalid datafile name for DNS zone."

	Dns_error_invalid_datafile_name_value: INTEGER is 9652

	Dns_error_datafile_open_failure_text: STRING is
			"Failed to open datafile for DNS zone."

	Dns_error_datafile_open_failure_value: INTEGER is 9653

	Dns_error_file_writeback_failed_text: STRING is
			"Failed to write datafile for DNS zone."

	Dns_error_file_writeback_failed_value: INTEGER is 9654

	Dns_error_datafile_parsing_text: STRING is
			"Failure while reading datafile for DNS zone."

	Dns_error_datafile_parsing_value: INTEGER is 9655

	Dns_error_record_does_not_exist_text: STRING is
			"DNS record does not exist."

	Dns_error_record_does_not_exist_value: INTEGER is 9701

	Dns_error_record_format_text: STRING is
			"DNS record format error."

	Dns_error_record_format_value: INTEGER is 9702

	Dns_error_node_creation_failed_text: STRING is
			"Node creation failure in DNS."

	Dns_error_node_creation_failed_value: INTEGER is 9703

	Dns_error_unknown_record_type_text: STRING is
			"Unknown DNS record type."

	Dns_error_unknown_record_type_value: INTEGER is 9704

	Dns_error_record_timed_out_text: STRING is
			"DNS record timed out."

	Dns_error_record_timed_out_value: INTEGER is 9705

	Dns_error_name_not_in_zone_text: STRING is
			"Name not in DNS zone."

	Dns_error_name_not_in_zone_value: INTEGER is 9706

	Dns_error_cname_loop_text: STRING is
			"CNAME loop detected."

	Dns_error_cname_loop_value: INTEGER is 9707

	Dns_error_node_is_cname_text: STRING is
			"Node is a CNAME DNS record."

	Dns_error_node_is_cname_value: INTEGER is 9708

	Dns_error_cname_collision_text: STRING is
			"A CNAME record already exists for given name."

	Dns_error_cname_collision_value: INTEGER is 9709

	Dns_error_record_only_at_zone_root_text: STRING is
			"Record only at DNS zone root."

	Dns_error_record_only_at_zone_root_value: INTEGER is 9710

	Dns_error_record_already_exists_text: STRING is
			"DNS record already exists."

	Dns_error_record_already_exists_value: INTEGER is 9711

	Dns_error_secondary_data_text: STRING is
			"Secondary DNS zone data error."

	Dns_error_secondary_data_value: INTEGER is 9712

	Dns_error_no_create_cache_data_text: STRING is
			"Could not create DNS cache data."

	Dns_error_no_create_cache_data_value: INTEGER is 9713

	Dns_error_name_does_not_exist_text: STRING is
			"DNS name does not exist."

	Dns_error_name_does_not_exist_value: INTEGER is 9714

	Dns_warning_ptr_create_failed_text: STRING is
			"Could not create pointer (PTR) record."

	Dns_warning_ptr_create_failed_value: INTEGER is 9715

	Dns_warning_domain_undeleted_text: STRING is
			"DNS domain was undeleted."

	Dns_warning_domain_undeleted_value: INTEGER is 9716

	Dns_error_ds_unavailable_text: STRING is
			"The directory service is unavailable."

	Dns_error_ds_unavailable_value: INTEGER is 9717

	Dns_error_ds_zone_already_exists_text: STRING is
			"DNS zone already exists in the directory service."

	Dns_error_ds_zone_already_exists_value: INTEGER is 9718

	Dns_error_no_bootfile_if_ds_zone_text: STRING is
			"DNS server not creating or reading the boot file for the directory service integrated DNS zone."

	Dns_error_no_bootfile_if_ds_zone_value: INTEGER is 9719

	Dns_info_axfr_complete_text: STRING is
			"DNS AXFR (zone transfer) complete."

	Dns_info_axfr_complete_value: INTEGER is 9751

	Dns_error_axfr_text: STRING is
			"DNS zone transfer failed."

	Dns_error_axfr_value: INTEGER is 9752

	Dns_info_added_local_wins_text: STRING is
			"Added local WINS server."

	Dns_info_added_local_wins_value: INTEGER is 9753

	Dns_status_continue_needed_text: STRING is
			"Secure update call needs to continue update request."

	Dns_status_continue_needed_value: INTEGER is 9801

	Dns_error_no_tcpip_text: STRING is
			"TCP/IP network protocol not installed."

	Dns_error_no_tcpip_value: INTEGER is 9851

	Dns_error_no_dns_servers_text: STRING is
			"No DNS servers configured for local system."

	Dns_error_no_dns_servers_value: INTEGER is 9852

	Wsaeintr_text: STRING is
			"A blocking operation was interrupted by a call to WSACancelBlockingCall."

	Wsaeintr_value: INTEGER is 10004

	Wsaebadf_text: STRING is
			"The file handle supplied is not valid."

	Wsaebadf_value: INTEGER is 10009

	Wsaeacces_text: STRING is
			"An attempt was made to access a socket in a way forbidden by its access permissions."

	Wsaeacces_value: INTEGER is 10013

	Wsaefault_text: STRING is
			"The system detected an invalid pointer address in attempting to use a pointer argument in a call."

	Wsaefault_value: INTEGER is 10014

	Wsaeinval_text: STRING is
			"An invalid argument was supplied."

	Wsaeinval_value: INTEGER is 10022

	Wsaemfile_text: STRING is
			"Too many open sockets."

	Wsaemfile_value: INTEGER is 10024

	Wsaewouldblock_text: STRING is
			"A non-blocking socket operation could not be completed immediately."

	Wsaewouldblock_value: INTEGER is 10035

	Wsaeinprogress_text: STRING is
			"A blocking operation is currently executing."

	Wsaeinprogress_value: INTEGER is 10036

	Wsaealready_text: STRING is
			"An operation was attempted on a non-blocking socket that already had an operation in progress."

	Wsaealready_value: INTEGER is 10037

	Wsaenotsock_text: STRING is
			"An operation was attempted on something that is not a socket."

	Wsaenotsock_value: INTEGER is 10038

	Wsaedestaddrreq_text: STRING is
			"A required address was omitted from an operation on a socket."

	Wsaedestaddrreq_value: INTEGER is 10039

	Wsaemsgsize_text: STRING is
			"A message sent on a datagram socket was larger than the internal message buffer or some other network limit, or the buffer used to receive a datagram into was smaller than the datagram itself."

	Wsaemsgsize_value: INTEGER is 10040

	Wsaeprototype_text: STRING is
			"A protocol was specified in the socket function call that does not support the semantics of the socket type requested."

	Wsaeprototype_value: INTEGER is 10041

	Wsaenoprotoopt_text: STRING is
			"An unknown, invalid, or unsupported option or level was specified in a getsockopt or setsockopt call."

	Wsaenoprotoopt_value: INTEGER is 10042

	Wsaeprotonosupport_text: STRING is
			"The requested protocol has not been configured into the system, or no implementation for it exists."

	Wsaeprotonosupport_value: INTEGER is 10043

	Wsaesocktnosupport_text: STRING is
			"The support for the specified socket type does not exist in this address family."

	Wsaesocktnosupport_value: INTEGER is 10044

	Wsaeopnotsupp_text: STRING is
			"The attempted operation is not supported for the type of object referenced."

	Wsaeopnotsupp_value: INTEGER is 10045

	Wsaepfnosupport_text: STRING is
			"The protocol family has not been configured into the system or no implementation for it exists."

	Wsaepfnosupport_value: INTEGER is 10046

	Wsaeafnosupport_text: STRING is
			"An address incompatible with the requested protocol was used."

	Wsaeafnosupport_value: INTEGER is 10047

	Wsaeaddrinuse_text: STRING is
			"Only one usage of each socket address (protocol/network address/port)  is normally permitted."

	Wsaeaddrinuse_value: INTEGER is 10048

	Wsaeaddrnotavail_text: STRING is
			"The requested address is not valid in its context."

	Wsaeaddrnotavail_value: INTEGER is 10049

	Wsaenetdown_text: STRING is
			"A socket operation encountered a dead network."

	Wsaenetdown_value: INTEGER is 10050

	Wsaenetunreach_text: STRING is
			"A socket operation was attempted to an unreachable network."

	Wsaenetunreach_value: INTEGER is 10051

	Wsaenetreset_text: STRING is
			"The connection has been broken due to keep-alive activity detecting a failure while the operation was in progress."

	Wsaenetreset_value: INTEGER is 10052

	Wsaeconnaborted_text: STRING is
			"An established connection was aborted by the software in your host machine."

	Wsaeconnaborted_value: INTEGER is 10053

	Wsaeconnreset_text: STRING is
			"An existing connection was forcibly closed by the remote host."

	Wsaeconnreset_value: INTEGER is 10054

	Wsaenobufs_text: STRING is
			"An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full."

	Wsaenobufs_value: INTEGER is 10055

	Wsaeisconn_text: STRING is
			"A connect request was made on an already connected socket."

	Wsaeisconn_value: INTEGER is 10056

	Wsaenotconn_text: STRING is
			"A request to send or receive data was disallowed because the socket is not connected and (when sending on a datagram socket using a sendto call) no address was supplied."

	Wsaenotconn_value: INTEGER is 10057

	Wsaeshutdown_text: STRING is
			"A request to send or receive data was disallowed because the socket had already been shut down in that direction with a previous shutdown call."

	Wsaeshutdown_value: INTEGER is 10058

	Wsaetoomanyrefs_text: STRING is
			"Too many references to some kernel object."

	Wsaetoomanyrefs_value: INTEGER is 10059

	Wsaetimedout_text: STRING is
			"A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond."

	Wsaetimedout_value: INTEGER is 10060

	Wsaeconnrefused_text: STRING is
			"No connection could be made because the target machine actively refused it."

	Wsaeconnrefused_value: INTEGER is 10061

	Wsaeloop_text: STRING is
			"Cannot translate name."

	Wsaeloop_value: INTEGER is 10062

	Wsaenametoolong_text: STRING is
			"Name component or name was too long."

	Wsaenametoolong_value: INTEGER is 10063

	Wsaehostdown_text: STRING is
			"A socket operation failed because the destination host was down."

	Wsaehostdown_value: INTEGER is 10064

	Wsaehostunreach_text: STRING is
			"A socket operation was attempted to an unreachable host."

	Wsaehostunreach_value: INTEGER is 10065

	Wsaenotempty_text: STRING is
			"Cannot remove a directory that is not empty."

	Wsaenotempty_value: INTEGER is 10066

	Wsaeproclim_text: STRING is
			"A Windows Sockets implementation may have a limit on the number of applications that may use it simultaneously."

	Wsaeproclim_value: INTEGER is 10067

	Wsaeusers_text: STRING is
			"Ran out of quota."

	Wsaeusers_value: INTEGER is 10068

	Wsaedquot_text: STRING is
			"Ran out of disk quota."

	Wsaedquot_value: INTEGER is 10069

	Wsaestale_text: STRING is
			"File handle reference is no longer available."

	Wsaestale_value: INTEGER is 10070

	Wsaeremote_text: STRING is
			"Item is not available locally."

	Wsaeremote_value: INTEGER is 10071

	Wsasysnotready_text: STRING is
			"WSAStartup cannot function at this time because the underlying system it uses to provide network services is currently unavailable."

	Wsasysnotready_value: INTEGER is 10091

	Wsavernotsupported_text: STRING is
			"The Windows Sockets version requested is not supported."

	Wsavernotsupported_value: INTEGER is 10092

	Wsanotinitialised_text: STRING is
			"Either the application has not called WSAStartup, or WSAStartup failed."

	Wsanotinitialised_value: INTEGER is 10093

	Wsaediscon_text: STRING is
			"Returned by WSARecv or WSARecvFrom to indicate the remote party has initiated a graceful shutdown sequence."

	Wsaediscon_value: INTEGER is 10101

	Wsaenomore_text: STRING is
			"No more results can be returned by WSALookupServiceNext."

	Wsaenomore_value: INTEGER is 10102

	Wsaecancelled_text: STRING is
			"A call to WSALookupServiceEnd was made while this call was still processing. The call has been canceled."

	Wsaecancelled_value: INTEGER is 10103

	Wsaeinvalidproctable_text: STRING is
			"The procedure call table is invalid."

	Wsaeinvalidproctable_value: INTEGER is 10104

	Wsaeinvalidprovider_text: STRING is
			"The requested service provider is invalid."

	Wsaeinvalidprovider_value: INTEGER is 10105

	Wsaeproviderfailedinit_text: STRING is
			"The requested service provider could not be loaded or initialized."

	Wsaeproviderfailedinit_value: INTEGER is 10106

	Wsasyscallfailure_text: STRING is
			"A system call that should never fail has failed."

	Wsasyscallfailure_value: INTEGER is 10107

	Wsaservice_not_found_text: STRING is
			"No such service is known. The service cannot be found in the specified name space."

	Wsaservice_not_found_value: INTEGER is 10108

	Wsatype_not_found_text: STRING is
			"The specified class was not found."

	Wsatype_not_found_value: INTEGER is 10109

	Wsa_e_no_more_text: STRING is
			"No more results can be returned by WSALookupServiceNext."

	Wsa_e_no_more_value: INTEGER is 10110

	Wsa_e_cancelled_text: STRING is
			"A call to WSALookupServiceEnd was made while this call was still processing. The call has been canceled."

	Wsa_e_cancelled_value: INTEGER is 10111

	Wsaerefused_text: STRING is
			"A database query failed because it was actively refused."

	Wsaerefused_value: INTEGER is 10112

	Wsahost_not_found_text: STRING is
			"No such host is known."

	Wsahost_not_found_value: INTEGER is 11001

	Wsatry_again_text: STRING is
			"This is usually a temporary error during hostname resolution and means that the local server did not receive a response from an authoritative server."

	Wsatry_again_value: INTEGER is 11002

	Wsano_recovery_text: STRING is
			"A non-recoverable error occurred during a database lookup."

	Wsano_recovery_value: INTEGER is 11003

	Wsano_data_text: STRING is
			"The requested name is valid and was found in the database, but it does not have the correct associated data being resolved for."

	Wsano_data_value: INTEGER is 11004

	Wsa_qos_receivers_text: STRING is
			"At least one reserve has arrived."

	Wsa_qos_receivers_value: INTEGER is 11005

	Wsa_qos_senders_text: STRING is
			"At least one path has arrived."

	Wsa_qos_senders_value: INTEGER is 11006

	Wsa_qos_no_senders_text: STRING is
			"There are no senders."

	Wsa_qos_no_senders_value: INTEGER is 11007

	Wsa_qos_no_receivers_text: STRING is
			"There are no receivers."

	Wsa_qos_no_receivers_value: INTEGER is 11008

	Wsa_qos_request_confirmed_text: STRING is
			"Reserve has been confirmed."

	Wsa_qos_request_confirmed_value: INTEGER is 11009

	Wsa_qos_admission_failure_text: STRING is
			"Error due to lack of resources."

	Wsa_qos_admission_failure_value: INTEGER is 11010

	Wsa_qos_policy_failure_text: STRING is
			"Rejected for administrative reasons - bad credentials."

	Wsa_qos_policy_failure_value: INTEGER is 11011

	Wsa_qos_bad_style_text: STRING is
			"Unknown or conflicting style."

	Wsa_qos_bad_style_value: INTEGER is 11012

	Wsa_qos_bad_object_text: STRING is
			"Problem with some part of the filterspec or providerspecific buffer in general."

	Wsa_qos_bad_object_value: INTEGER is 11013

	Wsa_qos_traffic_ctrl_error_text: STRING is
			"Problem with some part of the flowspec."

	Wsa_qos_traffic_ctrl_error_value: INTEGER is 11014

	Wsa_qos_generic_error_text: STRING is
			"General QOS error."

	Wsa_qos_generic_error_value: INTEGER is 11015

	Wsa_qos_eservicetype_text: STRING is
			"An invalid or unrecognized service type was found in the flowspec."

	Wsa_qos_eservicetype_value: INTEGER is 11016

	Wsa_qos_eflowspec_text: STRING is
			"An invalid or inconsistent flowspec was found in the QOS structure."

	Wsa_qos_eflowspec_value: INTEGER is 11017

	Wsa_qos_eprovspecbuf_text: STRING is
			"Invalid QOS provider-specific buffer."

	Wsa_qos_eprovspecbuf_value: INTEGER is 11018

	Wsa_qos_efilterstyle_text: STRING is
			"An invalid QOS filter style was used."

	Wsa_qos_efilterstyle_value: INTEGER is 11019

	Wsa_qos_efiltertype_text: STRING is
			"An invalid QOS filter type was used."

	Wsa_qos_efiltertype_value: INTEGER is 11020

	Wsa_qos_efiltercount_text: STRING is
			"An incorrect number of QOS FILTERSPECs were specified in the FLOWDESCRIPTOR."

	Wsa_qos_efiltercount_value: INTEGER is 11021

	Wsa_qos_eobjlength_text: STRING is
			"An object with an invalid ObjectLength field was specified in the QOS provider-specific buffer."

	Wsa_qos_eobjlength_value: INTEGER is 11022

	Wsa_qos_eflowcount_text: STRING is
			"An incorrect number of flow descriptors was specified in the QOS structure."

	Wsa_qos_eflowcount_value: INTEGER is 11023

	Wsa_qos_eunkownpsobj_text: STRING is
			"An unrecognized object was found in the QOS provider-specific buffer."

	Wsa_qos_eunkownpsobj_value: INTEGER is 11024

	Wsa_qos_epolicyobj_text: STRING is
			"An invalid policy object was found in the QOS provider-specific buffer."

	Wsa_qos_epolicyobj_value: INTEGER is 11025

	Wsa_qos_eflowdesc_text: STRING is
			"An invalid QOS flow descriptor was found in the flow descriptor list."

	Wsa_qos_eflowdesc_value: INTEGER is 11026

	Wsa_qos_epsflowspec_text: STRING is
			"An invalid or inconsistent flowspec was found in the QOS provider specific buffer."

	Wsa_qos_epsflowspec_value: INTEGER is 11027

	Wsa_qos_epsfilterspec_text: STRING is
			"An invalid FILTERSPEC was found in the QOS provider-specific buffer."

	Wsa_qos_epsfilterspec_value: INTEGER is 11028

	Wsa_qos_esdmodeobj_text: STRING is
			"An invalid shape discard mode object was found in the QOS provider specific buffer."

	Wsa_qos_esdmodeobj_value: INTEGER is 11029

	Wsa_qos_eshaperateobj_text: STRING is
			"An invalid shaping rate object was found in the QOS provider-specific buffer."

	Wsa_qos_eshaperateobj_value: INTEGER is 11030

	Wsa_qos_reserved_petype_text: STRING is
			"A reserved policy element was found in the QOS provider-specific buffer."

	Wsa_qos_reserved_petype_value: INTEGER is 11031

end -- class WEL_WINDOWS_ERROR_MESSAGES