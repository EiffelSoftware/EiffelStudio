indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FORBIDDEN_NAMES

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_GENERAL_FUNCTION_NAMES
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

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
			Result.force ("class_name", "class_name")
			Result.force ("set_value", "set_value")
			Result.force ("recipient_name", "recipient_name")
			Result.force ("meaning", "meaning")
			Result.force ("raise", "raise")
			Result.force ("set_item", "set_item")
			Result.force ("create_item", "create_item")
			Result.force ("a_stub", "a_stub")
			Result.force ("assertion_violation", "assertion_violation")
			Result.force ("is_developer_exception", "is_developer_exception")
			Result.force ("is_developer_exception_of_name", "is_developer_exception_of_name")
			Result.force ("developer_exception_name", "developer_exception_name")
			Result.force ("is_signal", "is_signal")
			Result.force ("is_system_exception", "is_system_exception")
			Result.force ("tag_name", "tag_name")
			Result.force ("exception", "exception")
			Result.force ("exception_trace", "exception_trace")
			Result.force ("original_tag_name", "original_tag_name")
			Result.force ("original_recipient_name", "original_recipient_name")
			Result.force ("original_class_name", "original_class_name")
			Result.force ("catch", "catch")
			Result.force ("ignore", "ignore")
			Result.force ("die", "die")
			Result.force ("new_die", "new_die")
			Result.force ("message_on_failure", "message_on_failure")
			Result.force ("no_message_on_failure", "no_message_on_failure")
			Result.force ("exclear", "exclear")
			Result.force ("eraise", "eraise")
			Result.force ("c_trace_exception", "c_trace_exception")
			Result.force ("Void_call_target", "Void_call_target")
			Result.force ("No_more_memory", "No_more_memory")
			Result.force ("Precondition", "Precondition")
			Result.force ("Postcondition", "Postcondition")
			Result.force ("Floating_point_exception", "Floating_point_exception")
			Result.force ("Class_invariant", "Class_invariant")
			Result.force ("Check_instruction", "Check_instruction")
			Result.force ("Routine_failure", "Routine_failure")
			Result.force ("Incorrect_inspect_value", "Incorrect_inspect_value")
			Result.force ("Loop_variant", "Loop_variant")
			Result.force ("Loop_invariant", "Loop_invariant")
			Result.force ("Signal_exception", "Signal_exception")
			Result.force ("Rescue_exception", "Rescue_exception")
			Result.force ("External_exception", "External_exception")
			Result.force ("Void_assigned_to_expanded", "Void_assigned_to_expanded")
			Result.force ("Io_exception", "Io_exception")
			Result.force ("Operating_system_exception", "Operating_system_exception")
			Result.force ("Retrieve_exception", "Retrieve_exception")
			Result.force ("Developer_exception", "Developer_exception")
			Result.force ("Runtime_io_exception", "Runtime_io_exception")
			Result.force ("Com_exception", "Com_exception")
			Result.force ("error_messages", "error_messages")
		end

	c_keywords: HASH_TABLE [STRING, STRING] is
			-- List of C key words.
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
			Result.force ("interface", "interface")
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
			Result.force ("RGB", "RGB")
			Result.force (clone (Eof_word), clone (Eof_word))
		end

	generator_words: HASH_TABLE [STRING, STRING] is
			-- List of generator words.
		once
			create Result.make (100)
			Result.compare_objects
			Result.force ("hr", "hr")
			Result.force ("Formatter", "Formatter")
			Result.force ("value", "value")
			Result.force ("result", "result")
			Result.force ("IFont1", "IFont1")
			Result.force ("ITypeInfo", "ITypeInfo")
			Result.force ("ITypeLib", "ITypeLib")
			Result.force ("GetTypeInfo", "GetTypeInfo")
			Result.force ("GetTypeInfoCount", "GetTypeInfoCount")
			Result.force ("GetIDsOfNames", "GetIDsOfNames")
			Result.force ("LCID", "LCID")
		end

	eiffel_runtime_macros: HASH_TABLE [STRING, STRING] is
			-- List of Eiffel runtime macros.
		once
			create Result.make (1000)
			Result.compare_objects
			Result.force ("BPI", "BPI")
			Result.force ("FD_ZERO", "FD_ZERO")
			Result.force ("FD_SET", "FD_SET")
			Result.force ("FD_ISSET", "FD_ISSET")
			Result.force ("LENGTH", "LENGTH")
			Result.force ("ARENA", "ARENA")
			Result.force ("attribute_exists", "attribute_exists")
			Result.force ("Cecil", "Cecil")
			Result.force ("ABORTSIG SIGABRT", "ABORTSIG SIGABRT")
			Result.force ("MEM_ALIGNBYTES", "MEM_ALIGNBYTES")
			Result.force ("BYTEORDER", "BYTEORDER")
			Result.force ("CAT2", "CAT2")
			Result.force ("CAT3", "CAT3")
			Result.force ("CAT4", "CAT4")
			Result.force ("CAT5", "CAT5")
			Result.force ("STRINGIFY", "STRINGIFY")
			Result.force ("StGiFy", "StGiFy")
			Result.force ("SCAT2", "SCAT2")
			Result.force ("SCAT3", "SCAT3")
			Result.force ("SCAT4", "SCAT4")
			Result.force ("SCAT5", "SCAT5")
			Result.force ("VAL_NOFILE", "VAL_NOFILE")
			Result.force ("HAS_DUP2", "HAS_DUP2")
			Result.force ("HAS_FCNTL", "HAS_FCNTL")
			Result.force ("HAS_FTIME", "HAS_FTIME")
			Result.force ("Timeval", "Timeval")
			Result.force ("HAS_GETOPT", "HAS_GETOPT")
			Result.force ("PAGESIZE_VALUE", "PAGESIZE_VALUE")
			Result.force ("HAS_LSTAT", "HAS_LSTAT")
			Result.force ("HAS_MEMMOVE", "HAS_MEMMOVE")
			Result.force ("HAS_MKDIR", "HAS_MKDIR")
			Result.force ("HAS_READDIR", "HAS_READDIR")
			Result.force ("HAS_RENAME", "HAS_RENAME")
			Result.force ("HAS_RMDIR", "HAS_RMDIR")
			Result.force ("HAS_SOCKET", "HAS_SOCKET")
			Result.force ("USE_STRUCT_COPY", "USE_STRUCT_COPY")
			Result.force ("HAS_STRDUP", "HAS_STRDUP")
			Result.force ("Strerror", "Strerror")
			Result.force ("Time_t", "Time_t")
			Result.force ("Clock_t", "Clock_t")
			Result.force ("Signal_t", "Signal_t")
			Result.force ("Malloc_t", "Malloc_t")
			Result.force ("Pid_t", "Pid_t")
			Result.force ("Caddr_t", "Caddr_t")
			Result.force ("Uid_t", "Uid_t")
			Result.force ("index", "index")
			Result.force ("rindex", "rindex")
			Result.force ("Unknown_type", "Unknown_type")
			Result.force ("Character_type", "Character_type")
			Result.force ("Boolean_type", "Boolean_type")
			Result.force ("Integer_type", "Integer_type")
			Result.force ("Real_type", "Real_type")
			Result.force ("Double_type", "Double_type")
			Result.force ("Expanded_type", "Expanded_type")
			Result.force ("Bit_type", "Bit_type")
			Result.force ("String_type", "String_type")
			Result.force ("Local_reference", "Local_reference")
			Result.force ("Separate_reference", "Separate_reference")
			Result.force ("Expanded_object", "Expanded_object")
			Result.force ("constant_command_buffer_len", "constant_command_buffer_len")
			Result.force ("constant_crash_info_len", "constant_crash_info_len")
			Result.force ("constant_size_of_data_buf", "constant_size_of_data_buf")
			Result.force ("set_host_port", "set_host_port")
			Result.force ("set_oid", "set_oid")
			Result.force ("set_sock", "set_sock")
			Result.force ("set_proxy_id", "set_proxy_id")
			Result.force ("sep_obj_host", "sep_obj_host")
			Result.force ("sep_obj_port", "sep_obj_port")
			Result.force ("sep_obj_sock", "sep_obj_sock")
			Result.force ("sep_obj_oid", "sep_obj_oid")
			Result.force ("sep_obj_proxy_id", "sep_obj_proxy_id")
			Result.force ("is_sep_obj", "is_sep_obj")
			Result.force ("init_string", "init_string")
			Result.force ("def_resc", "def_resc")
			Result.force ("valuable_line", "valuable_line")
			Result.force ("valid_memory", "valid_memory")
			Result.force ("add_nl", "add_nl")
			Result.force ("get_cmd_data", "get_cmd_data")
			Result.force ("directly_get_cmd_data", "directly_get_cmd_data")
			Result.force ("adjust_parameter_array", "adjust_parameter_array")
			Result.force ("hostaddr_of_sep_obj", "hostaddr_of_sep_obj")
			Result.force ("pid_of_sep_obj", "pid_of_sep_obj")
			Result.force ("sock_of_sep_obj", "sock_of_sep_obj")
			Result.force ("oid_of_sep_obj", "oid_of_sep_obj")
			Result.force ("on_same_processor", "on_same_processor")
			Result.force ("hostaddr_of_sep_obj", "hostaddr_of_sep_obj")
			Result.force ("pid_of_sep_obj", "pid_of_sep_obj")
			Result.force ("sock_of_sep_obj", "sock_of_sep_obj")
			Result.force ("oid_of_sep_obj", "oid_of_sep_obj")
			Result.force ("on_same_processor", "on_same_processor")
			Result.force ("set_mask", "set_mask")
			Result.force ("unset_mask", "unset_mask")
			Result.force ("init_options", "init_options")
			Result.force ("set_with_rejection", "set_with_rejection")
			Result.force ("unset_with_rejection", "unset_with_rejection")
			Result.force ("is_with_rejection", "is_with_rejection")
			Result.force ("ise_ntohf", "ise_ntohf")
			Result.force ("safe_bcopy", "safe_bcopy")
			Result.force ("print_err_msg", "print_err_msg")
			Result.force ("ex_jbuf", "ex_jbuf")
			Result.force ("ex_id", "ex_id")
			Result.force ("ex_rout", "ex_rout")
			Result.force ("ex_orig", "ex_orig")
			Result.force ("ex_sig", "ex_sig")
			Result.force ("ex_errno", "ex_errno")
			Result.force ("ex_lvl", "ex_lvl")
			Result.force ("ex_name", "ex_name")
			Result.force ("ex_where", "ex_where")
			Result.force ("ex_from", "ex_from")
			Result.force ("ex_oid", "ex_oid")
			Result.force ("echmem", "echmem")
			Result.force ("echtg", "echtg")
			Result.force ("echval", "echval")
			Result.force ("echsig", "echsig")
			Result.force ("echlvl", "echlvl")
			Result.force ("echorg", "echorg")
			Result.force ("echotag", "echotag")
			Result.force ("echrt", "echrt")
			Result.force ("echort", "echort")
			Result.force ("echclass", "echclass")
			Result.force ("echoclass", "echoclass")
			Result.force ("db_stack", "db_stack")
			Result.force ("once_list", "once_list")
			Result.force ("d_data", "d_data")
			Result.force ("d_cxt", "d_cxt")
			Result.force ("ex_ign", "ex_ign")
			Result.force ("exdata", "exdata")
			Result.force ("print_history_table", "print_history_table")
			Result.force ("ex_string", "ex_string")
			Result.force ("db_ign", "db_ign")
			Result.force ("path_stack", "path_stack")
			Result.force ("parent_expanded_stack", "parent_expanded_stack")
			Result.force ("g_data", "g_data")
			Result.force ("g_stat", "g_stat")
			Result.force ("loc_stack", "loc_stack")
			Result.force ("loc_set", "loc_set")
			Result.force ("rem_set", "rem_set")
			Result.force ("moved_set", "moved_set")
			Result.force ("memory_set", "memory_set")
			Result.force ("special_rem_set", "special_rem_set")
			Result.force ("once_set", "once_set")
			Result.force ("age_table", "age_table")
			Result.force ("size_table", "size_table")
			Result.force ("tenure", "tenure")
			Result.force ("clsc_per", "clsc_per")
			Result.force ("plsc_per", "plsc_per")
			Result.force ("gc_running", "gc_running")
			Result.force ("last_gc_time", "last_gc_time")
			Result.force ("gc_ran", "gc_ran")
			Result.force ("spoilt_tbl", "spoilt_tbl")
			Result.force ("ps_from", "ps_from")
			Result.force ("ps_to", "ps_to")
			Result.force ("last_from", "last_from")
			Result.force ("th_alloc", "th_alloc")
			Result.force ("gc_monitor", "gc_monitor")
			Result.force ("root_obj", "root_obj")
			Result.force ("urgent_mem", "urgent_mem")
			Result.force ("urgent_index", "urgent_index")
			Result.force ("hec_stack", "hec_stack")
			Result.force ("hec_saved", "hec_saved")
			Result.force ("free_stack", "free_stack")
			Result.force ("op_stack", "op_stack")
			Result.force ("iregs", "iregs")
			Result.force ("iregsz", "iregsz")
			Result.force ("argnum", "argnum")
			Result.force ("locnum", "locnum")
			Result.force ("tagval", "tagval")
			Result.force ("inv_mark_table", "inv_mark_table")
			Result.force ("m_data", "m_data")
			Result.force ("c_data", "c_data")
			Result.force ("e_data", "e_data")
			Result.force ("cklst", "cklst")
			Result.force ("c_hlist", "c_hlist")
			Result.force ("e_hlist", "e_hlist")
			Result.force ("c_buffer", "c_buffer")
			Result.force ("e_buffer", "e_buffer")
			Result.force ("sc_from", "sc_from")
			Result.force ("sc_to", "sc_to")
			Result.force ("gen_scavenge", "gen_scavenge")
			Result.force ("eiffel_usage", "eiffel_usage")
			Result.force ("type_use", "type_use")
			Result.force ("c_mem", "c_mem")
			Result.force ("m_largest", "m_largest")
			Result.force ("mem_stats", "mem_stats")
			Result.force ("gc_stats", "gc_stats")
			Result.force ("gc_count", "gc_count")
			Result.force ("buffero", "buffero")
			Result.force ("tagged_out", "tagged_out")
			Result.force ("tagged_max", "tagged_max")
			Result.force ("tagged_len", "tagged_len")
			Result.force ("darray", "darray")
			Result.force ("nstcall", "nstcall")
			Result.force ("inv_mark_tablep", "inv_mark_tablep")
			Result.force ("sig_ign", "sig_ign")
			Result.force ("osig_ign", "osig_ign")
			Result.force ("esigblk", "esigblk")
			Result.force ("sig_stk", "sig_stk")
			Result.force ("in_assertion", "in_assertion")
			Result.force ("r_fides", "r_fides")
			Result.force ("s_fides", "s_fides")
			Result.force ("n_children", "n_children")
			Result.force ("last_child", "last_child")
			Result.force ("spfrozen", "spfrozen")
			Result.force ("it_char", "it_char")
			Result.force ("it_long", "it_long")
			Result.force ("it_float", "it_float")
			Result.force ("it_double", "it_double")
			Result.force ("it_ref", "it_ref")
			Result.force ("it_ptr", "it_ptr")
			Result.force ("it_bit", "it_bit")
			Result.force ("iget", "iget")
			Result.force ("Dtype", "Dtype")
			Result.force ("Deif_bid", "Deif_bid")
			Result.force ("Mapped_flags", "Mapped_flags")
			Result.force ("Dftype", "Dftype")
			Result.force ("xcalloc", "xcalloc")
			Result.force ("xmalloc", "xmalloc")
			Result.force ("xfree", "xfree")
			Result.force ("ov_next", "ov_next")
			Result.force ("ov_flags", "ov_flags")
			Result.force ("ov_fwd", "ov_fwd")
			Result.force ("ov_size", "ov_size")
			Result.force ("ovs_tid", "ovs_tid")
			Result.force ("chconv", "chconv")
			Result.force ("chcode", "chcode")
			Result.force ("conv_pi", "conv_pi")
			Result.force ("conv_ri", "conv_ri")
			Result.force ("conv_dr", "conv_dr")
			Result.force ("conv_di", "conv_di")
			Result.force ("chupper", "chupper")
			Result.force ("chlower", "chlower")
			Result.force ("chis_upper", "chis_upper")
			Result.force ("chis_lower", "chis_lower")
			Result.force ("chis_digit", "chis_digit")
			Result.force ("chis_alpha", "chis_alpha")
			Result.force ("esbool_size", "esbool_size")
			Result.force ("eschar_size", "eschar_size")
			Result.force ("esreal_size", "esreal_size")
			Result.force ("esint_size", "esint_size")
			Result.force ("esptr_size", "esptr_size")
			Result.force ("esdouble_size", "esdouble_size")
			Result.force ("float_cos", "float_cos")
			Result.force ("float_acos", "float_acos")
			Result.force ("float_fabs", "float_fabs")
			Result.force ("float_ceil", "float_ceil")
			Result.force ("float_floor", "float_floor")
			Result.force ("float_log10", "float_log10")
			Result.force ("float_log", "float_log")
			Result.force ("float_sqrt", "float_sqrt")
			Result.force ("float_tan", "float_tan")
			Result.force ("float_atan", "float_atan")
			Result.force ("float_sin", "float_sin")
			Result.force ("float_asin", "float_asin")
			Result.force ("prof_recording", "prof_recording")
			Result.force ("System", "System")
			Result.force ("References", "References")
			Result.force ("Dispose", "Dispose")
			Result.force ("Disp_rout", "Disp_rout")
			Result.force ("XCreate", "XCreate")
			Result.force ("_concur_sep_obj_dtype", "_concur_sep_obj_dtype")
			Result.force ("econfg", "econfg")
			Result.force ("estypeg", "estypeg")
			Result.force ("rmdir", "rmdir")
			Result.force ("unlink", "unlink")
			Result.force ("getenv", "getenv")
			Result.force ("putenv", "putenv")
			Result.force ("setenv", "setenv")
			Result.force ("strdup", "strdup")
			Result.force ("opendir", "opendir")
			Result.force ("closedir", "closedir")
			Result.force ("rewinddir", "rewinddir")
			Result.force ("readdir", "readdir")
			Result.force ("seekdir", "seekdir")
			Result.force ("telldir", "telldir")
			Result.force ("rt_public", "rt_public")
			Result.force ("rt_private static", "rt_private static")
			Result.force ("rt_shared", "rt_shared")
			Result.force ("rt_list", "rt_list")
			Result.force ("rt_obj", "rt_obj")
			Result.force ("rout_obj_call_procedure", "rout_obj_call_procedure")
			Result.force ("rout_obj_putb", "rout_obj_putb")
			Result.force ("rout_obj_putc", "rout_obj_putc")
			Result.force ("rout_obj_putd", "rout_obj_putd")
			Result.force ("rout_obj_putf", "rout_obj_putf")
			Result.force ("rout_obj_puti", "rout_obj_puti")
			Result.force ("rout_obj_putp", "rout_obj_putp")
			Result.force ("rout_obj_putr", "rout_obj_putr")
			Result.force ("signal_pending", "signal_pending")
			Result.force ("pthread_attr_setschedpolicy", "pthread_attr_setschedpolicy")
			Result.force ("pthread_attr_setschedpolicy", "pthread_attr_setschedpolicy")
			Result.force ("sem_t", "sem_t")
			Result.force ("sem_init", "sem_init")
			Result.force ("sem_post", "sem_post")
			Result.force ("sem_wait", "sem_wait")
			Result.force ("sem_trywait", "sem_trywait")
			Result.force ("sem_destroy", "sem_destroy")
			Result.force ("pthread_attr_init", "pthread_attr_init")
			Result.force ("pthread_key_create", "pthread_key_create")
			Result.force ("pthread_attr_setschedpolicy", "pthread_attr_setschedpolicy")
			Result.force ("pthread_attr_setschedparam", "pthread_attr_setschedparam")
			Result.force ("pthread_attr_destroy", "pthread_attr_destroy")
			Result.force ("pthread_cond_t", "pthread_cond_t")
			Result.force ("rewinddir", "rewinddir")
			Result.force ("CAttrOffs", "CAttrOffs")
			Result.force ("CBodyIdx", "CBodyIdx")
			Result.force ("CFeatType", "CFeatType")
			Result.force ("CGENFeatType", "CGENFeatTypeI")
			Result.force ("MPatId", "MPatId")
			Result.force ("FPatId", "FPatId")
			Result.force ("DLEMPatId", "DLEMPatId")
			Result.force ("DLEFPatId", "DLEFPatId")
		end

	windows_api: HASH_TABLE [STRING, STRING] is
			-- Standard Windows structures.
		local
			a_file: PLAIN_TEXT_FILE
			a_directory: DIRECTORY
			tmp_path, a_line: STRING
		once
			create Result.make (500)
			Result.compare_objects

			tmp_path := eiffel4_location + "\wizards\com\config\wizard_winapi_names.cfg"

			create a_directory.make (eiffel4_location + "\wizards\com\config")
			if a_directory.exists then
				a_directory.open_read
				if a_directory.has_entry ("wizard_winapi_names.cfg") then
					create a_file.make_open_read (tmp_path)

					from
						a_file.start
					until
						a_file.end_of_file
					loop
						a_file.read_line
						a_line := clone (a_file.last_string)
						if not a_line.empty then
							Result.put (a_line, a_line)
						end
					end
				end
			end
		ensure
			non_void_api: Result /= Void
		end

feature -- Measurement

feature -- Status report

	is_forbidden_c_word (a_name: STRING): BOOLEAN is
			-- Is `a_name' forbidden c word?
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			Result := c_keywords.has (a_name) or 
					eiffel_runtime_macros.has (a_name) or 
					windows_api.has (a_name) or
					generator_words.has (a_name) 
		end
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_FORBIDDEN_NAMES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
