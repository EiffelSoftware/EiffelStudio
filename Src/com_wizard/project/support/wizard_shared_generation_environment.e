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

	EXECUTION_ENVIRONMENT
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

	Ce_mapper: STRING is 
			-- C++ class holding C to Eiffel mappers
		do
			Result := "rt_ce"
		end

	Generated_ce_mapper: STRING is 
			-- C++ class holding generated C to Eiffel mappers, object name.
		do
			Result := "rt_generated_ce"
		end

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

	eiffel_key_words: HASH_TABLE [STRING, STRING] is
			-- List of Eiffel key words.
		local
			tmp_string: STRING
		once
			create Result.make (100)
			Result.compare_objects
			Result.force (clone (Alias_keyword), clone (Alias_keyword))
			Result.force (clone (All_keyword), clone (All_keyword))
			Result.force (clone (And_keyword), clone (And_keyword))
			Result.force (clone (As_keyword), clone (As_keyword))
			Result.force (clone (Check_keyword), clone (Check_keyword))
			Result.force (clone (Class_keyword), clone (Class_keyword))
			Result.force (clone (Create_keyword), clone (Create_keyword))
			Result.force (clone (Creation_keyword), clone (Creation_keyword))
			Result.force (clone (Debug_keyword), clone (Debug_keyword))
			Result.force (clone (Deferred_keyword), clone (Deferred_keyword))
			Result.force (clone (Do_keyword), clone (Do_keyword))
			Result.force (clone (Else_keyword), clone (Else_keyword))
			Result.force (clone (Elseif_keyword), clone (Elseif_keyword))
			Result.force (clone (End_keyword), clone (End_keyword))
			Result.force (clone (Ensure_keyword), clone (Ensure_keyword))
			Result.force (clone (Expanded_keyword), clone (Expanded_keyword))
			Result.force (clone (Export_keyword), clone (Export_keyword))
			Result.force (clone (External_keyword), clone (External_keyword))
			Result.force (clone (Feature_keyword), clone (Feature_keyword))
			Result.force (clone (From_keyword), clone (From_keyword))
			Result.force (clone (Frozen_keyword), clone (Frozen_keyword))
			Result.force (clone (If_keyword), clone (If_keyword))
			Result.force (clone (Implies_keyword), clone (Implies_keyword))
			Result.force (clone (Indexing_keyword), clone (Indexing_keyword))
			Result.force (clone (Infix_keyword), clone (Infix_keyword))
			Result.force (clone (Inherit_keyword), clone (Inherit_keyword))
			Result.force (clone (Inspect_keyword), clone (Inspect_keyword))
			Result.force (clone (Invariant_keyword), clone (Invariant_keyword))
			Result.force (clone (Is_keyword), clone (Is_keyword))
			Result.force (clone (Like_keyword), clone (Like_keyword))
			Result.force (clone (Local_keyword), clone (Local_keyword))
			Result.force (clone (Loop_keyword), clone (Loop_keyword))
			Result.force (clone (Not_keyword), clone (Not_keyword))
			Result.force (clone (Obsolete_keyword), clone (Obsolete_keyword))
			Result.force (clone (Old_keyword), clone (Old_keyword))
			Result.force (clone (Once_keyword), clone (Once_keyword))
			Result.force (clone (Or_keyword), clone (Or_keyword))
			Result.force (clone (Prefix_keyword), clone (Prefix_keyword))
			Result.force (clone (Redefine_keyword), clone (Redefine_keyword))
			Result.force (clone (Rename_keyword), clone (Rename_keyword))
			Result.force (clone (Require_keyword), clone (Require_keyword))
			Result.force (clone (Rescue_keyword), clone (Rescue_keyword))
			Result.force (clone (Retry_keyword), clone (Retry_keyword))
			Result.force (clone (Select_keyword), clone (Select_keyword))
			Result.force (clone (Separate_keyword), clone (Separate_keyword))
			Result.force (clone (Then_keyword), clone (Then_keyword))
			Result.force (clone (Undefine_keyword), clone (Undefine_keyword))
			Result.force (clone (Until_keyword), clone (Until_keyword))
			Result.force (clone (Variant_keyword), clone (Variant_keyword))
			Result.force (clone (When_keyword), clone (When_keyword))
			Result.force (clone (Xor_keyword), clone (Xor_keyword))

  			tmp_string := clone (Bit_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

 			tmp_string := clone (Current_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

 			tmp_string := clone (False_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (Precursor_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (Result_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (Strip_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (True_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (Unique_keyword)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			tmp_string := clone (Eof_word)
			tmp_string.to_lower
			Result.force (tmp_string, tmp_string)

			Result.force (clone (Make_word), clone (Make_word))
			Result.force (clone (Make_from_other), clone (Make_from_other))
			Result.force (clone (Make_from_pointer), clone (Make_from_pointer))
			Result.force (clone (Item_clause), clone (Item_clause))
			Result.force (clone (Ccom_item_function_name), clone (Ccom_item_function_name))
			Result.force (clone (Last_error_code), clone (Last_error_code))
			Result.force (clone (Last_error_description), clone (Last_error_description))
			Result.force (clone (Last_error_help_file), clone (Last_error_help_file))
			Result.force (clone (Last_source_of_exception), clone (Last_source_of_exception))
			Result.force (clone (Ccom_last_error_code), clone (Ccom_last_error_code))
			Result.force (clone (Ccom_last_error_description), clone (Ccom_last_error_description))
			Result.force (clone (Ccom_last_error_help_file), clone (Ccom_last_error_help_file))
			Result.force (clone (Ccom_last_source_of_exception), clone (Ccom_last_source_of_exception))

			Result.force (clone (generated_type_routine), clone (generated_type_routine))
			Result.force (clone (generator_routine), clone (generator_routine))
			Result.force (clone (deep_equal_routine), clone (deep_equal_routine))
			Result.force (clone (equal_routine), clone (equal_routine))
			Result.force (clone (is_equal_routine), clone (is_equal_routine))
			Result.force (clone (standard_equal_routine), clone (standard_equal_routine))
			Result.force (clone (standard_is_equal_routine), clone (standard_is_equal_routine))
			Result.force (clone (conforms_to_routine), clone (conforms_to_routine))
			Result.force (clone (same_type_routine), clone (same_type_routine))
			Result.force (clone (clone_routine), clone (clone_routine))
			Result.force (clone (copy_routine), clone (copy_routine))
			Result.force (clone (deep_clone_routine), clone (deep_clone_routine))
			Result.force (clone (deep_copy_routine), clone (deep_copy_routine))
			Result.force (clone (standard_clone_routine), clone (standard_clone_routine))
			Result.force (clone (default_routine), clone (default_routine))
			Result.force (clone (default_create_routine), clone (default_create_routine))
			Result.force (clone (default_pointer_routine), clone (default_pointer_routine))
			Result.force (clone (default_rescue_routine), clone (default_rescue_routine))
			Result.force (clone (do_nothing_routine), clone (do_nothing_routine))
			Result.force (clone (io_routine), clone (io_routine))
			Result.force (clone (out_routine), clone (out_routine))
			Result.force (clone (print_routine), clone (print_routine))
			Result.force (clone (tagged_out_routine), clone (tagged_out_routine))

			Result.force (clone (allocate_compact_routine), clone (allocate_compact_routine))
			Result.force (clone (allocate_fast_routine), clone (allocate_fast_routine))
			Result.force (clone (allocate_tiny_routine), clone (allocate_tiny_routine))
			Result.force (clone (chunk_size_routine), clone (chunk_size_routine))
			Result.force (clone (coalesce_period_routine), clone (coalesce_period_routine))
			Result.force (clone (collect_routine), clone (collect_routine))
			Result.force (clone (collecting_routine), clone (collecting_routine))
			Result.force (clone (collection_off_routine), clone (collection_off_routine))
			Result.force (clone (collection_on_routine), clone (collection_on_routine))
			Result.force (clone (collection_period_routine), clone (collection_period_routine))
			Result.force (clone (disable_time_accounting_routine), clone (disable_time_accounting_routine))
			Result.force (clone (dispose_routine), clone (dispose_routine))
			Result.force (clone (enable_time_accounting_routine), clone (enable_time_accounting_routine))
			Result.force (clone (free_routine), clone (free_routine))
			Result.force (clone (full_coalesce_routine), clone (full_coalesce_routine))
			Result.force (clone (full_collect_routine), clone (full_collect_routine))
			Result.force (clone (gc_monitoring_routine), clone (gc_monitoring_routine))
			Result.force (clone (gc_statistics_routine), clone (gc_statistics_routine))
			Result.force (clone (generation_object_limit_routine), clone (generation_object_limit_routine))
			Result.force (clone (largest_coalesced_block_routine), clone (largest_coalesced_block_routine))
			Result.force (clone (max_mem_routine), clone (max_mem_routine))
			Result.force (clone (mem_free_routine), clone (mem_free_routine))
			Result.force (clone (memory_statistics_routine), clone (memory_statistics_routine))
			Result.force (clone (memory_threshold_routine), clone (memory_threshold_routine))
			Result.force (clone (scavenge_zone_size_routine), clone (scavenge_zone_size_routine))
			Result.force (clone (set_coalesce_period_routine), clone (set_coalesce_period_routine))
			Result.force (clone (set_collection_period_routine), clone (set_collection_period_routine))
			Result.force (clone (set_max_mem_routine), clone (set_max_mem_routine))
			Result.force (clone (set_memory_threshold_routine), clone (set_memory_threshold_routine))
			Result.force (clone (tenure_routine), clone (tenure_routine))
			Result.force ("f", "f")
			Result.force (clone (exists_routine), clone (exists_routine))
		end

	c_keywords: HASH_TABLE [STRING, STRING] is
			-- List of C key words.
		local
			tmp_string: STRING
		once
			create Result.make (100)
			Result.compare_objects
			Result.force ("asm", "asm")
			Result.force ("auto", "auto")
			Result.force ("bool", "bool")
			Result.force ("break", "break")
			Result.force ("case", "case")
			Result.force ("catch", "catch")
			Result.force ("char", "char")
			Result.force ("class", "class")
			Result.force ("const", "const")
			Result.force ("const_cast", "const_cast")
			Result.force ("continue", "continue")
			Result.force ("default", "default")
			Result.force ("delete", "delete")
			Result.force ("do", "do")
			Result.force ("double", "double")
			Result.force ("dynamic_cast", "dynamic_cast")
			Result.force ("else", "else")
			Result.force ("enum", "enum")
			Result.force ("explicit", "explicit")
			Result.force ("export", "export")
			Result.force ("extern", "extern")
			Result.force ("false", "false")
			Result.force ("float", "float")
			Result.force ("for", "for")
			Result.force ("friend", "friend")
			Result.force ("goto", "goto")
			Result.force ("if", "if")
			Result.force ("inline", "inline")
			Result.force ("int", "int")
			Result.force ("long", "long")
			Result.force ("mutable", "mutable")
			Result.force ("namespace", "namespace")
			Result.force ("new", "new")
			Result.force ("operator", "operator")
			Result.force ("private", "private")
			Result.force ("protected", "protected")
			Result.force ("public", "public")
			Result.force ("register", "register")
			Result.force ("reinterpret_cast", "reinterpret_cast")
			Result.force ("return", "return")
			Result.force ("short", "short")
			Result.force ("signed", "signed")
			Result.force ("sizeof", "sizeof")
			Result.force ("static", "static")
			Result.force ("static_cast", "static_cast")
			Result.force ("struct", "struct")
			Result.force ("switch", "switch")
			Result.force ("template", "template")
			Result.force ("this", "this")
			Result.force ("throw", "throw")
			Result.force ("true", "true")
			Result.force ("try", "try")
			Result.force ("typedef", "typedef")
			Result.force ("typeid", "typeid")
			Result.force ("typename", "typename")
			Result.force ("union", "union")
			Result.force ("unsigned", "unsigned")
			Result.force ("using", "using")
			Result.force ("virtual", "virtual")
			Result.force ("void", "void")
			Result.force ("volatile", "volatile")
			Result.force ("wchar_t", "wchar_t")
			Result.force ("while", "while")
			Result.force ("min", "min")
			Result.force ("max", "max")

		end

	windows_structures: HASH_TABLE [WIZARD_WINDOWS_STRUCTURE, STRING] is
			-- Standard Windows structures.
		local
			a_file: PLAIN_TEXT_FILE
			a_directory: DIRECTORY
			eiffel4, tmp_path, a_line, tmp_string1, tmp_string2, tmp_string3: STRING
			a_count, i: INTEGER
			a_name, a_file_protector: BOOLEAN
			a_structure: WIZARD_WINDOWS_STRUCTURE
		once
			create Result.make (500)
			Result.compare_objects

			eiffel4 := clone (get ("EIFFEL4"))
			tmp_path := eiffel4 + "\wizards\com\config\wizard_struct.cfg"

			create a_directory.make_open_read (eiffel4 + "\wizards\com\config")
			if a_directory.has_entry ("wizard_struct.cfg") then
				create a_file.make_open_read (tmp_path)

				from
					a_file.start
				until
					a_file.end_of_file
				loop
					a_file.read_line
					a_line := clone (a_file.last_string)
					if not a_line.empty then
						create a_structure.make (a_line)
						Result.put (a_structure, a_structure.name)
					end
				end
			end
		end

	browse_directory: STRING is
			-- Browse directory.
		do
			if browse_directory_cell.item /= Void then
				Result := browse_directory_cell.item

			elseif (get (Eiffelcom_browse_directory) /= Void) then
				Result := get (Eiffelcom_browse_directory)
				set_browse_directory (Result)

			else
				Result := "c:\"
				set_browse_directory (Result)
			end
		end

feature -- Basic Operations

	set_browse_directory (a_directory: STRING) is
			-- Set browse directory.
		require
			non_void_directory: a_directory /= Void
			valid_directory: not a_directory.empty
		do
			browse_directory_cell.put (a_directory)
			put (a_directory, Eiffelcom_browse_directory)
		end

	safe_browse_directory_from_dialog (a_file_dialog: WEL_FILE_DIALOG) is
			-- Safe last open directory.
		local
			a_name, a_title: STRING	
		do
			a_name := clone (a_file_dialog.file_name)
			a_title := a_file_dialog.file_title
			a_name.head (a_name.count - a_title.count)
			set_browse_directory (a_name)
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

	browse_directory_cell: CELL [STRING] is
			-- Browse directory shell
		once
			create Result.put (Void)
		end

	Eiffelcom_browse_directory: STRING is "EIFFELCOM_PATH"
			-- Environment variable for browsing.

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
  
