indexing
	description: "Shared generation environment"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_GENERATION_ENVIRONMENT

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_GENERAL_FUNCTION_NAMES
		export
			{NONE} all
		end

feature -- Access

	Shared_file_name_factory: WIZARD_FILE_NAME_FACTORY is
			-- Shared file name factory
		once
			create Result
		end

	system_descriptor: WIZARD_SYSTEM_DESCRIPTOR is
			-- System descriptor
		do
			Result := System_descriptor_cell.item
		end

	message_output: WIZARD_MESSAGE_OUTPUT is
			-- Shared message output
		do
			Result := message_output_cell.item
		end

	progress_report: WIZARD_PROGRESS_REPORT is
			-- Shared wizard progress report
		do
			Result := progress_report_cell.item
		end

	Ce_mapper: STRING is "rt_ce"
			-- C++ class holding C to Eiffel mappers

	Generated_ce_mapper: STRING is "rt_generated_ce"
			-- C++ class holding generated C to Eiffel mappers, object name.

	Generated_ce_class_name: STRING is "ecom_generated_ce"
			-- C++ class name for generated mapper functions C to Eiffel.

	Generated_ce_mapper_writer: WIZARD_WRITER_CPP_CLASS is
			-- Writer for generated C to Eiffel mappers class
		local
			a_header_file_name: STRING
			a_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR
			empty_string: STRING
			an_other_source: STRING
		once
			create Result.make
			Result.set_header ("Writer for generated C to Eiffel mappers class")
			a_header_file_name := clone (Generated_ce_class_name)
			Result.set_name (clone (a_header_file_name))
			a_header_file_name.append (Header_file_extension)
			Result.set_header_file_name (a_header_file_name)
			create a_constructor.make
			create empty_string.make (0)
			a_constructor.set_signature (empty_string)
			a_constructor.set_body (empty_string)
			Result.add_constructor (a_constructor)
			Result.add_import (Ecom_rt_globals_header_file_name)
			Result.add_import_after (Ecom_generated_rt_globals_header_file_name)
			create an_other_source.make (0)
			an_other_source.append (Generated_ce_class_name)
			an_other_source.append (Space)
			an_other_source.append (Generated_ce_mapper)
			an_other_source.append (Semicolon)
			Result.add_other_source (an_other_source)
		end

	Generated_ec_mapper_writer: WIZARD_WRITER_CPP_CLASS is
			-- Writer for generated Eiffel to C mappers class
		local
			a_header_file_name: STRING
			a_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR
			empty_string: STRING
			an_other_source: STRING
		once
			create Result.make
			Result.set_header ("Writer for generated Eiffel to C mappers class")
			a_header_file_name := clone (Generated_ec_class_name)
			Result.set_name (clone (a_header_file_name))
			a_header_file_name.append (Header_file_extension)
			Result.set_header_file_name (a_header_file_name)
			create a_constructor.make
			create empty_string.make (0)
			a_constructor.set_signature (empty_string)
			a_constructor.set_body (empty_string)
			Result.add_constructor (a_constructor)
			Result.add_import (Ecom_rt_globals_header_file_name)
			Result.add_import_after (Ecom_generated_rt_globals_header_file_name)
			create an_other_source.make (0)
			an_other_source.append (Generated_ec_class_name)
			an_other_source.append (Space)
			an_other_source.append (Generated_ec_mapper)
			an_other_source.append (Semicolon)
			Result.add_other_source (an_other_source)
		end

	Ecom_rt_globals_header_file_name: STRING is "ecom_rt_globals.h"
			-- C++ class holding runtime global variables

	Ecom_generated_rt_globals_header_file_name: STRING is "ecom_generated_rt_globals.h"
			-- C++ class header file contains information that all generated class require
			-- e.g. global variables, system header files etc.

	Ec_mapper: STRING is "rt_ec"
			-- C++ class holding Eiffel to C mappers

	Generated_ec_mapper: STRING is "rt_generated_ec"
			-- C++ class holding generated Eiffel to C mappers

	Generated_ec_class_name: STRING is "ecom_generated_ec"
			-- C++ class name for generated mapper functions Eiffel to C.

	Alias_header_file_name: STRING is "ecom_aliases.h"
			-- Name of common header file name for aliases.

	Alias_c_writer: WIZARD_WRITER_C_FILE is
			-- Shared alias C writer.
		once
			create Result.make
			Result.set_header_file_name (Alias_header_file_name)
			Result.set_header ("System's aliases")
		end

	Iunknown_guid: ECOM_GUID is
			-- IUnknown IID
		once
			create Result.make_from_string (clone (Iunknown_guid_string))
		end

	Iunknown_guid_string: STRING is "{00000000-0000-0000-C000-000000000046}"
			-- IUnknown IID

	Idispatch_guid: ECOM_GUID is
			-- IDispatch IID
		once
			create Result.make_from_string (clone (Idispatch_guid_string))
		end

	Idispatch_guid_string: STRING is "{00020400-0000-0000-C000-000000000046}"
			-- IDispatch IID

	vartype_namer: WIZARD_VARTYPE_NAMER is
			-- Vartype to string mapper
		once
			create Result.make
		end

	Shared_process_launcher: WIZARD_PROCESS_LAUNCHER is
			-- Process launcher
		require
			non_void_message_output: message_output /= Void
		once
			create Result.make (message_output)
		end

	Formatter: STRING is "f"
			-- Message formatter.

	Generation_Successful: STRING is "Generation terminated successfully"
			-- Successful ending message

	Generation_Aborted: STRING is "Generation aborted"
			-- Successful ending message

	eiffel_key_words: LINKED_LIST [STRING] is
			-- List of Eiffel key words.
		local
			tmp_string: STRING
		once
			create Result.make
			Result.compare_objects
			Result.force (clone (Alias_keyword))
			Result.force (clone (All_keyword))
			Result.force (clone (And_keyword))
			Result.force (clone (As_keyword))
			Result.force (clone (Check_keyword))
			Result.force (clone (Class_keyword))
			Result.force (clone (Create_keyword))
			Result.force (clone (Creation_keyword))
			Result.force (clone (Debug_keyword))
			Result.force (clone (Deferred_keyword))
			Result.force (clone (Do_keyword))
			Result.force (clone (Else_keyword))
			Result.force (clone (Elseif_keyword))
			Result.force (clone (End_keyword))
			Result.force (clone (Ensure_keyword))
			Result.force (clone (Expanded_keyword))
			Result.force (clone (Export_keyword))
			Result.force (clone (External_keyword))
			Result.force (clone (Feature_keyword))
			Result.force (clone (From_keyword))
			Result.force (clone (Frozen_keyword))
			Result.force (clone (If_keyword))
			Result.force (clone (Implies_keyword))
			Result.force (clone (Indexing_keyword))
			Result.force (clone (Infix_keyword))
			Result.force (clone (Inherit_keyword))
			Result.force (clone (Inspect_keyword))
			Result.force (clone (Invariant_keyword))
			Result.force (clone (Is_keyword))
			Result.force (clone (Like_keyword))
			Result.force (clone (Local_keyword))
			Result.force (clone (Loop_keyword))
			Result.force (clone (Not_keyword))
			Result.force (clone (Obsolete_keyword))
			Result.force (clone (Old_keyword))
			Result.force (clone (Once_keyword))
			Result.force (clone (Or_keyword))
			Result.force (clone (Prefix_keyword))
			Result.force (clone (Redefine_keyword))
			Result.force (clone (Rename_keyword))
			Result.force (clone (Require_keyword))
			Result.force (clone (Rescue_keyword))
			Result.force (clone (Retry_keyword))
			Result.force (clone (Select_keyword))
			Result.force (clone (Separate_keyword))
			Result.force (clone (Then_keyword))
			Result.force (clone (Undefine_keyword))
			Result.force (clone (Until_keyword))
			Result.force (clone (Variant_keyword))
			Result.force (clone (When_keyword))
			Result.force (clone (Xor_keyword))

  			tmp_string := clone (Bit_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

 			tmp_string := clone (Current_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

 			tmp_string := clone (False_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (Precursor_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (Result_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (Strip_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (True_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (Unique_keyword)
			tmp_string.to_lower
			Result.force (tmp_string)

			tmp_string := clone (Eof_word)
			tmp_string.to_lower
			Result.force (tmp_string)

			Result.force (clone (Make_word))
			Result.force (clone (Make_from_other))
			Result.force (clone (Make_from_pointer))
			Result.force (clone (Item_clause))
			Result.force (clone (Ccom_item_function_name))
			Result.force (clone (Last_error_code))
			Result.force (clone (Last_error_description))
			Result.force (clone (Last_error_help_file))
			Result.force (clone (Last_source_of_exception))
			Result.force (clone (Ccom_last_error_code))
			Result.force (clone (Ccom_last_error_description))
			Result.force (clone (Ccom_last_error_help_file))
			Result.force (clone (Ccom_last_source_of_exception))

			Result.force (clone (generated_type_routine))
			Result.force (clone (generator_routine))
			Result.force (clone (deep_equal_routine))
			Result.force (clone (equal_routine))
			Result.force (clone (is_equal_routine))
			Result.force (clone (standard_equal_routine))
			Result.force (clone (standard_is_equal_routine))
			Result.force (clone (conforms_to_routine))
			Result.force (clone (same_type_routine))
			Result.force (clone (clone_routine))
			Result.force (clone (copy_routine))
			Result.force (clone (deep_clone_routine))
			Result.force (clone (deep_copy_routine))
			Result.force (clone (standard_clone_routine))
			Result.force (clone (default_routine))
			Result.force (clone (default_create_routine))
			Result.force (clone (default_pointer_routine))
			Result.force (clone (default_rescue_routine))
			Result.force (clone (do_nothing_routine))
			Result.force (clone (io_routine))
			Result.force (clone (out_routine))
			Result.force (clone (print_routine))
			Result.force (clone (tagged_out_routine))

			Result.force (clone (tagged_out_routine))
			Result.force (clone (allocate_compact_routine))
			Result.force (clone (allocate_fast_routine))
			Result.force (clone (allocate_tiny_routine))
			Result.force (clone (chunk_size_routine))
			Result.force (clone (coalesce_period_routine))
			Result.force (clone (collect_routine))
			Result.force (clone (collecting_routine))
			Result.force (clone (collection_off_routine))
			Result.force (clone (collection_on_routine))
			Result.force (clone (collection_period_routine))
			Result.force (clone (disable_time_accounting_routine))
			Result.force (clone (dispose_routine))
			Result.force (clone (enable_time_accounting_routine))
			Result.force (clone (free_routine))
			Result.force (clone (full_coalesce_routine))
			Result.force (clone (full_collect_routine))
			Result.force (clone (gc_monitoring_routine))
			Result.force (clone (gc_statistics_routine))
			Result.force (clone (generation_object_limit_routine))
			Result.force (clone (largest_coalesced_block_routine))
			Result.force (clone (max_mem_routine))
			Result.force (clone (mem_free_routine))
			Result.force (clone (memory_statistics_routine))
			Result.force (clone (memory_threshold_routine))
			Result.force (clone (scavenge_zone_size_routine))
			Result.force (clone (set_coalesce_period_routine))
			Result.force (clone (set_collection_period_routine))
			Result.force (clone (set_max_mem_routine))
			Result.force (clone (set_memory_threshold_routine))
			Result.force (clone (tenure_routine))
		end

feature {WIZARD_MANAGER} -- Element Change

	set_system_descriptor (a_descriptor: like system_descriptor) is
			-- Set `system_descriptor' with `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		do
			System_descriptor_cell.replace (a_descriptor)
		ensure
			descriptor_set: system_descriptor = a_descriptor
		end

	set_message_output (a_window: like message_output) is
			-- Set `message_output' with `a_window'.
		require
			non_void_window: a_window /= Void
		do
			message_output_cell.replace (a_window)
		ensure
			message_output_set: message_output = a_window
		end

	set_progress_report (a_progress_report: like progress_report) is
			-- Set `progress_report' with `a_progress_report'.
		require
			non_void_progress_report: a_progress_report /= Void
		do
			progress_report_cell.replace (a_progress_report)
		ensure
			progress_report_set: progress_report = a_progress_report
		end

feature {NONE} -- Implementation

	System_descriptor_cell: CELL [WIZARD_SYSTEM_DESCRIPTOR] is
			-- System descriptor shell
		once
			create Result.put (Void)
		end

	message_output_cell: CELL [WIZARD_MESSAGE_OUTPUT] is
			-- Output window shell
		once
			create Result.put (Void)
		end

	progress_report_cell: CELL [WIZARD_PROGRESS_REPORT] is
			-- Progress report shell
		once
			create Result.put (Void)
		end

end -- class WIZARD_SHARED_GENERATION_ENVIRONMENT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  
