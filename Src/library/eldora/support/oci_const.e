indexing
	description: "OCI Constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_const.e $"

class
	OCI_CONST

feature -- Handle Types
	Oci_htype_first: INTEGER is 1
	Oci_htype_env: INTEGER is 1
	Oci_htype_error: INTEGER is 2
	Oci_htype_svcctx: INTEGER is 3
	Oci_htype_stmt: INTEGER is 4
	Oci_htype_bind: INTEGER is 5
	Oci_htype_define: INTEGER is 6
	Oci_htype_describe: INTEGER is 7
	Oci_htype_server: INTEGER is 8
	Oci_htype_session: INTEGER is 9
	Oci_htype_trans: INTEGER is 10
	Oci_htype_complexobject: INTEGER is 11
	Oci_htype_security: INTEGER is 12
	Oci_htype_subscription: INTEGER is 13
	Oci_htype_dirpath_ctx: INTEGER is 14
	Oci_htype_dirpath_column_array: INTEGER is 15
	Oci_htype_dirpath_stream: INTEGER is 16
	Oci_htype_proc: INTEGER is 17
	Oci_htype_last: INTEGER is 17
	
feature -- Descriptor Types
	Oci_dtype_first: INTEGER is 50
	Oci_dtype_lob: INTEGER is 50
	Oci_dtype_snap: INTEGER is 51
	Oci_dtype_rset: INTEGER is 52
	Oci_dtype_param: INTEGER is 53
	Oci_dtype_rowid: INTEGER is 54
	Oci_dtype_complexobjectcomp: INTEGER is 55
	Oci_dtype_file: INTEGER is 56
	Oci_dtype_aqenq_options: INTEGER is 57
	Oci_dtype_aqdeq_options: INTEGER is 58
	Oci_dtype_aqmsg_properties: INTEGER is 59
	Oci_dtype_aqagent: INTEGER is 60
	Oci_dtype_locator: INTEGER is 61
	Oci_dtype_interval_ym: INTEGER is 62
	Oci_dtype_interval_ds: INTEGER is 63
	Oci_dtype_aqnfy_descriptor: INTEGER is 64
	Oci_dtype_date: INTEGER is 65
	Oci_dtype_time: INTEGER is 66
	Oci_dtype_time_tz: INTEGER is 67
	Oci_dtype_timestamp: INTEGER is 68
	Oci_dtype_timestamp_tz: INTEGER is 69
	Oci_dtype_timestamp_ltz: INTEGER is 70
	Oci_dtype_ucb: INTEGER is 71
	Oci_dtype_last: INTEGER is 71
	
feature -- LOB types
	Oci_temp_blob: INTEGER is 1
	Oci_temp_clob: INTEGER is 2

feature -- Object Ptr Types
	Oci_otype_name: INTEGER_8 is 1
	Oci_otype_ref: INTEGER_8 is 2
	Oci_otype_ptr: INTEGER_8 is 3
	
feature -- Attribute Types
	Oci_attr_fncode: INTEGER is 1
	Oci_attr_object: INTEGER is 2
	Oci_attr_nonblocking_mode: INTEGER is 3
	Oci_attr_sqlcode: INTEGER is 4
	Oci_attr_env: INTEGER is 5
	Oci_attr_server: INTEGER is 6
	Oci_attr_session: INTEGER is 7
	Oci_attr_trans: INTEGER is 8
	Oci_attr_row_count: INTEGER is 9
	Oci_attr_sqlfncode: INTEGER is 10
	Oci_attr_prefetch_rows: INTEGER is 11
	Oci_attr_nested_prefetch_rows: INTEGER is 12
	Oci_attr_prefetch_memory: INTEGER is 13
	Oci_attr_nested_prefetch_memory: INTEGER is 14
	Oci_attr_char_count: INTEGER is 15
	Oci_attr_pdscl: INTEGER is 16
	Oci_attr_pdprc: INTEGER is 17
	Oci_attr_param_count: INTEGER is 18
	Oci_attr_rowid: INTEGER is 19
	Oci_attr_charset: INTEGER is 20
	Oci_attr_nchar: INTEGER is 21
	Oci_attr_username: INTEGER is 22
	Oci_attr_password: INTEGER is 23
	Oci_attr_stmt_type: INTEGER is 24
	Oci_attr_internal_name: INTEGER is 25
	Oci_attr_external_name: INTEGER is 26
	Oci_attr_xid: INTEGER is 27
	Oci_attr_trans_lock: INTEGER is 28
	Oci_attr_trans_name: INTEGER is 29
	Oci_attr_heapalloc: INTEGER is 30
	Oci_attr_charset_id: INTEGER is 31
	Oci_attr_charset_form: INTEGER is 32
	Oci_attr_maxdata_size: INTEGER is 33
	Oci_attr_cache_opt_size: INTEGER is 34
	Oci_attr_cache_max_size: INTEGER is 35
	Oci_attr_pinoption: INTEGER is 36
	Oci_attr_alloc_duration: INTEGER is 37
	Oci_attr_pin_duration: INTEGER is 38
	Oci_attr_fdo: INTEGER is 39
	Oci_attr_postprocessing_callback: INTEGER is 40
	Oci_attr_postprocessing_context: INTEGER is 41
	Oci_attr_rows_returned: INTEGER is 42
	Oci_attr_focbk: INTEGER is 43
	Oci_attr_in_v8_mode: INTEGER is 44
	Oci_attr_lobempty: INTEGER is 45
	Oci_attr_sesslang: INTEGER is 46
	Oci_attr_visibility: INTEGER is 47
	Oci_attr_relative_msgid: INTEGER is 48
	Oci_attr_sequence_deviation: INTEGER is 49
	Oci_attr_consumer_name: INTEGER is 50
	Oci_attr_deq_mode: INTEGER is 51
	Oci_attr_navigation: INTEGER is 52
	Oci_attr_wait: INTEGER is 53
	Oci_attr_deq_msgid: INTEGER is 54
	Oci_attr_priority: INTEGER is 55
	Oci_attr_delay: INTEGER is 56
	Oci_attr_expiration: INTEGER is 57
	Oci_attr_correlation: INTEGER is 58
	Oci_attr_attempts: INTEGER is 59
	Oci_attr_recipient_list: INTEGER is 60
	Oci_attr_exception_queue: INTEGER is 61
	Oci_attr_enq_time: INTEGER is 62
	Oci_attr_agent_name: INTEGER is 64
	Oci_attr_agent_address: INTEGER is 65
	Oci_attr_agent_protocol: INTEGER is 66
	Oci_attr_sender_id: INTEGER is 68
	Oci_attr_original_msgid: INTEGER is 69
	Oci_attr_queue_name: INTEGER is 70
	Oci_attr_nfy_msgid: INTEGER is 71
	Oci_attr_msg_prop: INTEGER is 72
	Oci_attr_num_dml_errors: INTEGER is 73
	Oci_attr_dml_row_offset: INTEGER is 74
	Oci_attr_dateformat: INTEGER is 75
	Oci_attr_buf_addr: INTEGER is 76
	Oci_attr_buf_size: INTEGER is 77
	Oci_attr_dirpath_mode: INTEGER is 78
	Oci_attr_dirpath_nolog: INTEGER is 79
	Oci_attr_dirpath_parallel: INTEGER is 80
	Oci_attr_num_rows: INTEGER is 81
	Oci_attr_col_count: INTEGER is 82
	Oci_attr_stream_offset: INTEGER is 83
	Oci_attr_shared_heapalloc: INTEGER is 84
	Oci_attr_server_group: INTEGER is 85
	Oci_attr_migsession: INTEGER is 86
	Oci_attr_nocache: INTEGER is 87
	Oci_attr_mempool_size: INTEGER is 88
	Oci_attr_mempool_instname: INTEGER is 89
	Oci_attr_mempool_appname: INTEGER is 90
	Oci_attr_mempool_homename: INTEGER is 91
	Oci_attr_mempool_model: INTEGER is 92
	Oci_attr_modes: INTEGER is 93
	Oci_attr_subscr_name: INTEGER is 94
	Oci_attr_subscr_callback: INTEGER is 95
	Oci_attr_subscr_ctx: INTEGER is 96
	Oci_attr_subscr_payload: INTEGER is 97
	Oci_attr_subscr_namespace: INTEGER is 98
	Oci_attr_proxy_credentials: INTEGER is 99
	Oci_attr_initial_client_roles: INTEGER is 100
	Oci_attr_unk: INTEGER is 101
	Oci_attr_num_cols: INTEGER is 102
	Oci_attr_list_columns: INTEGER is 103
	Oci_attr_rdba: INTEGER is 104
	Oci_attr_clustered: INTEGER is 105
	Oci_attr_partitioned: INTEGER is 106
	Oci_attr_index_only: INTEGER is 107
	Oci_attr_list_arguments: INTEGER is 108
	Oci_attr_list_subprograms: INTEGER is 109
	Oci_attr_ref_tdo: INTEGER is 110
	Oci_attr_link: INTEGER is 111
	Oci_attr_min: INTEGER is 112
	Oci_attr_max: INTEGER is 113
	Oci_attr_incr: INTEGER is 114
	Oci_attr_cache: INTEGER is 115
	Oci_attr_order: INTEGER is 116
	Oci_attr_hw_mark: INTEGER is 117
	Oci_attr_type_schema: INTEGER is 118
	Oci_attr_timestamp: INTEGER is 119
	Oci_attr_num_attrs: INTEGER is 120
	Oci_attr_num_params: INTEGER is 121
	Oci_attr_objid: INTEGER is 122
	Oci_attr_ptype: INTEGER is 123
	Oci_attr_param: INTEGER is 124
	Oci_attr_overload_id: INTEGER is 125
	Oci_attr_tablespace: INTEGER is 126
	Oci_attr_tdo: INTEGER is 127
	Oci_attr_ltype: INTEGER is 128
	Oci_attr_parse_error_offset: INTEGER is 129
	Oci_attr_is_temporary: INTEGER is 130
	Oci_attr_is_typed: INTEGER is 131
	Oci_attr_duration: INTEGER is 132
	Oci_attr_is_invoker_rights: INTEGER is 133
	Oci_attr_obj_name: INTEGER is 134
	Oci_attr_obj_schema: INTEGER is 135
	Oci_attr_obj_id: INTEGER is 136
	Oci_attr_dirpath_sorted_index: INTEGER is 137
	Oci_attr_dirpath_index_maint_method: INTEGER is 138
	Oci_attr_dirpath_file: INTEGER is 139
	Oci_attr_dirpath_storage_initial: INTEGER is 140
	Oci_attr_dirpath_storage_next: INTEGER is 141
	Oci_attr_trans_timeout: INTEGER is 142
	Oci_attr_server_status: INTEGER is 143
	Oci_attr_statement: INTEGER is 144
	Oci_attr_no_cache: INTEGER is 145
	Oci_attr_reserved_1: INTEGER is 146
	Oci_attr_server_busy: INTEGER is 147
	
--	Oci_ucs2id: INTEGER is 1000
	
feature -- Server Handle Attribute Values
	Oci_server_not_connected: INTEGER is 0 
	Oci_server_normal: INTEGER is 1 

feature -- Supported Namespaces
	Oci_subscr_namespace_anonymous: INTEGER is 0
	Oci_subscr_namespace_aq: INTEGER is 1
	Oci_subscr_namespace_max: INTEGER is 2
	
feature -- Credential Types
	Oci_cred_rdbms: INTEGER is 1
	Oci_cred_ext: INTEGER is 2
	Oci_cred_proxy: INTEGER is 3
	
feature -- Error Return Values
	Oci_success: INTEGER is 0
	Oci_success_with_info: INTEGER is 1
	Oci_reserved_for_int_use: INTEGER is 200
	Oci_no_data: INTEGER is 100
	Oci_error: INTEGER is -1
	Oci_invalid_handle: INTEGER is -2
	Oci_need_data: INTEGER is 99
	Oci_still_executing: INTEGER is -3123
	Oci_continue: INTEGER is -24200

feature -- Parsing Syntax Types
	Oci_v7_syntax: INTEGER is 2
	Oci_v8_syntax: INTEGER is 3
	Oci_ntv_syntax: INTEGER is 1
	
feature -- Scrollable Cursor Options
	Oci_fetch_next: INTEGER_16 is 2                                -- next row 
	Oci_fetch_first: INTEGER_16 is 4            -- first row of the result set 
	Oci_fetch_last: INTEGER_16 is 8          -- the last row of the result set 
	Oci_fetch_prior: INTEGER_16 is 16  -- the previous row relative to current 
	Oci_fetch_absolute: INTEGER_16 is 32         -- absolute offset from first 
	Oci_fetch_relative: INTEGER_16 is 64         -- offset relative to current 
	Oci_fetch_reserved_1: INTEGER_16 is 128       -- reserved for internal use 

feature -- Bind and Define Options
	Oci_sb2_ind_ptr: INTEGER is 1                                 -- unused 
	Oci_data_at_exec: INTEGER is 2                  -- data at execute time 
	Oci_dynamic_fetch: INTEGER is 2                    -- fetch dynamically 
	Oci_piecewise: INTEGER is 4                  -- piecewise DMLs or fetch 
	Oci_define_reserved_1: INTEGER is 8        -- reserved for internal use 
	Oci_bind_reserved_2: INTEGER is 16         -- reserved for internal use 
	Oci_define_reserved_2: INTEGER is 32       -- reserved for internal use 

feature -- Various Modes
	Oci_default: INTEGER is 0 -- the default value for parameters and attributes 

feature -- OCIInitialize Modes / OCICreateEnvironment Modes
	Oci_threaded: INTEGER is 1 -- the application is in threaded environment 
	Oci_object: INTEGER is 2     -- the application is in object environment 
	Oci_events: INTEGER is 4        -- the application is enabled for events 
	Oci_reserved1: INTEGER is 8                 -- reserved for internal use 
	Oci_shared: INTEGER is 16           -- the application is in shared mode 
	Oci_reserved2: INTEGER is 32                -- reserved for internal use 
-- The following *TWO* are only valid for OCICreateEnvironment call 
	Oci_no_ucb: INTEGER is 64         -- no user callback called during init 
	Oci_no_mutex: INTEGER is 128       -- the environment handle will not be  
	                                     --  protected by a mutex internally 
	Oci_shared_ext: INTEGER is 256                  -- used for shared forms 
	Oci_cache: INTEGER is 512                              -- used by iCache 
	Oci_no_cache: INTEGER is 1024    -- turn off iCache mode, used by iCache 

feature -- OCIEnvInit Modes
	Oci_env_no_ucb: INTEGER is 1   -- a user callback will not be called in OCIEnvInit() 
	Oci_env_no_mutex: INTEGER is 8 -- the environment handle will not be protected
					 							 -- by a mutex internally
	
feature -- Parse Modes
	Oci_no_sharing: INTEGER is 1      -- turn off statement handle sharing 
	            -- This flag is only valid when process is in sharing mode 
	
feature -- Execution Modes
	Oci_batch_mode: INTEGER is 1  -- batch the oci statement for execution 
	Oci_exact_fetch: INTEGER is 2        -- fetch the exact rows specified 
	Oci_keep_fetch_state: INTEGER is 4                           -- unused 
	Oci_scrollable_cursor: INTEGER is 8               -- cursor scrollable 
	Oci_describe_only: INTEGER is 16        -- only describe the statement 
	Oci_commit_on_success: INTEGER is 32 -- commit, if successful execution 
	Oci_non_blocking: INTEGER is 64                        -- non-blocking 
	Oci_batch_errors: INTEGER is 128         -- batch errors in array dmls 
	Oci_parse_only: INTEGER is 256             -- only parse the statement 
	Oci_exact_fetch_reserved_1: INTEGER is 512 -- reserved for internal use 
	Oci_show_dml_warnings: INTEGER is 1024
	
feature -- Authentication Modes
	Oci_migrate: INTEGER is 1                   -- migratable auth context 
	Oci_sysdba: INTEGER is 2                   -- for SYSDBA authorization 
	Oci_sysoper: INTEGER is 4                 -- for SYSOPER authorization 
	Oci_prelim_auth: INTEGER is 8         -- for preliminary authorization 
	Ocip_icache: INTEGER is 16 -- Private OCI cache mode to notify cache db 
	
feature -- Attach Modes
	
	Oci_fastpath: INTEGER is 16			 -- Attach in fast path mode 
	
feature -- Piece Information
	Oci_param_in: INTEGER is 1                            -- in parameter 
	Oci_param_out: INTEGER is 2                          -- out parameter 

	Oci_enq_immediate: INTEGER is 1
	Oci_enq_on_commit: INTEGER is 2
	
	Oci_deq_browse: INTEGER is 1
	Oci_deq_locked: INTEGER is 2
	Oci_deq_remove: INTEGER is 3
	Oci_deq_remove_nodata: INTEGER is 4
	Oci_deq_first_msg: INTEGER is 1
	Oci_deq_next_msg: INTEGER is 3
	Oci_deq_next_transaction: INTEGER is 2
	
	Oci_msg_waiting: INTEGER is 1
	Oci_msg_ready: INTEGER is 0
	Oci_msg_processed: INTEGER is 2
	Oci_msg_expired: INTEGER is 3
	
	Oci_enq_before: INTEGER is 2
	Oci_enq_top: INTEGER is 3
	
	Oci_deq_immediate: INTEGER is 1
	Oci_deq_on_commit: INTEGER is 2
	Oci_deq_wait_forever: INTEGER is -1
	Oci_deq_no_wait: INTEGER is 0
	
	Oci_msg_no_delay: INTEGER is 0
	Oci_msg_no_expiration: INTEGER is -1

feature -- Deprecated
	Oci_otype_unk: INTEGER is 0
	Oci_otype_table: INTEGER is 1
	Oci_otype_view: INTEGER is 2
	Oci_otype_syn: INTEGER is 3
	Oci_otype_proc: INTEGER is 4
	Oci_otype_func: INTEGER is 5
	Oci_otype_pkg: INTEGER is 6
	Oci_otype_stmt: INTEGER is 7
	
feature	-- Describe Handle Attributes
	Oci_attr_data_size: INTEGER is 1
	Oci_attr_data_type: INTEGER is 2
	Oci_attr_disp_size: INTEGER is 3
	Oci_attr_name: INTEGER is 4
	Oci_attr_precision: INTEGER is 5
	Oci_attr_scale: INTEGER is 6
	Oci_attr_is_null: INTEGER is 7
	Oci_attr_type_name: INTEGER is 8
	Oci_attr_schema_name: INTEGER is 9
	Oci_attr_sub_name: INTEGER is 10
	Oci_attr_position: INTEGER is 11
	Oci_attr_complexobjectcomp_type: INTEGER is 50
	Oci_attr_complexobjectcomp_type_level: INTEGER is 51
	Oci_attr_complexobject_level: INTEGER is 52
	Oci_attr_complexobject_coll_outofline: INTEGER is 53
	Oci_attr_disp_name: INTEGER is 100
	Oci_attr_overload: INTEGER is 210
	Oci_attr_level: INTEGER is 211
	Oci_attr_has_default: INTEGER is 212
	Oci_attr_iomode: INTEGER is 213
	Oci_attr_radix: INTEGER is 214
	Oci_attr_num_args: INTEGER is 215
	Oci_attr_typecode: INTEGER is 216
	Oci_attr_collection_typecode: INTEGER is 217
	Oci_attr_version: INTEGER is 218
	Oci_attr_is_incomplete_type: INTEGER is 219
	Oci_attr_is_system_type: INTEGER is 220
	Oci_attr_is_predefined_type: INTEGER is 221
	Oci_attr_is_transient_type: INTEGER is 222
	Oci_attr_is_system_generated_type: INTEGER is 223
	Oci_attr_has_nested_table: INTEGER is 224
	Oci_attr_has_lob: INTEGER is 225
	Oci_attr_has_file: INTEGER is 226
	Oci_attr_collection_element: INTEGER is 227
	Oci_attr_num_type_attrs: INTEGER is 228
	Oci_attr_list_type_attrs: INTEGER is 229
	Oci_attr_num_type_methods: INTEGER is 230
	Oci_attr_list_type_methods: INTEGER is 231
	Oci_attr_map_method: INTEGER is 232
	Oci_attr_order_method: INTEGER is 233
	Oci_attr_num_elems: INTEGER is 234
	Oci_attr_encapsulation: INTEGER is 235
	Oci_attr_is_selfish: INTEGER is 236
	Oci_attr_is_virtual: INTEGER is 237
	Oci_attr_is_inline: INTEGER is 238
	Oci_attr_is_constant: INTEGER is 239
	Oci_attr_has_result: INTEGER is 240
	Oci_attr_is_constructor: INTEGER is 241
	Oci_attr_is_destructor: INTEGER is 242
	Oci_attr_is_operator: INTEGER is 243
	Oci_attr_is_map: INTEGER is 244
	Oci_attr_is_order: INTEGER is 245
	Oci_attr_is_rnds: INTEGER is 246
	Oci_attr_is_rnps: INTEGER is 247
	Oci_attr_is_wnds: INTEGER is 248
	Oci_attr_is_wnps: INTEGER is 249
	Oci_attr_desc_public: INTEGER is 250
	Oci_attr_cache_client_context: INTEGER is 251
	Oci_attr_uci_construct: INTEGER is 252
	Oci_attr_uci_destruct: INTEGER is 253
	Oci_attr_uci_copy: INTEGER is 254
	Oci_attr_uci_pickle: INTEGER is 255
	Oci_attr_uci_unpickle: INTEGER is 256
	Oci_attr_uci_refresh: INTEGER is 257
	Oci_attr_is_subtype: INTEGER is 258
	Oci_attr_supertype_schema_name: INTEGER is 259
	Oci_attr_supertype_name: INTEGER is 260
	Oci_attr_list_objects: INTEGER is 261
	Oci_attr_ncharset_id: INTEGER is 262
	Oci_attr_list_schemas: INTEGER is 263
	Oci_attr_max_proc_len: INTEGER is 264
	Oci_attr_max_column_len: INTEGER is 265
	Oci_attr_cursor_commit_behavior: INTEGER is 266
	Oci_attr_max_catalog_namelen: INTEGER is 267
	Oci_attr_catalog_location: INTEGER is 268
	Oci_attr_savepoint_support: INTEGER is 269
	Oci_attr_nowait_support: INTEGER is 270
	Oci_attr_autocommit_ddl: INTEGER is 271
	Oci_attr_locking_mode: INTEGER is 272
	Oci_attr_appctx_size: INTEGER is 273
	Oci_attr_appctx_list: INTEGER is 274
	Oci_attr_appctx_name: INTEGER is 275
	Oci_attr_appctx_attr: INTEGER is 276
	Oci_attr_appctx_value: INTEGER is 277
	
	Oci_cursor_open: INTEGER is 0
	Oci_cursor_closed: INTEGER is 1
	
	Oci_cl_start: INTEGER is 0
	Oci_cl_end: INTEGER is 1
	
	Oci_sp_supported: INTEGER is 0
	Oci_sp_unsupported: INTEGER is 1
	
	Oci_nw_supported: INTEGER is 0
	Oci_nw_unsupported: INTEGER is 1
	
	Oci_ac_ddl: INTEGER is 0
	Oci_no_ac_ddl: INTEGER is 1
	
	Oci_lock_immediate: INTEGER is 0
	Oci_lock_delayed: INTEGER is 1
	
	Oci_max_fns: INTEGER is 100
	Oci_sqlstate_size: INTEGER is 5
	Oci_error_maxmsg_size: INTEGER is 1024
	Oci_rowid_len: INTEGER is 23
	Oci_fo_retry: INTEGER is 25410
	
feature	-- Callback function codes
	Oci_fncode_initialize: INTEGER is 1
	Oci_fncode_handlealloc: INTEGER is 2
	Oci_fncode_handlefree: INTEGER is 3
	Oci_fncode_descriptoralloc: INTEGER is 4
	Oci_fncode_descriptorfree: INTEGER is 5
	Oci_fncode_envinit: INTEGER is 6
	Oci_fncode_serverattach: INTEGER is 7
	Oci_fncode_serverdetach: INTEGER is 8
	Oci_fncode_sessionbegin: INTEGER is 10
	Oci_fncode_sessionend: INTEGER is 11
	Oci_fncode_passwordchange: INTEGER is 12
	Oci_fncode_stmtprepare: INTEGER is 13
	Oci_fncode_binddynamic: INTEGER is 17
	Oci_fncode_bindobject: INTEGER is 18
	Oci_fncode_bindarrayofstruct: INTEGER is 20
	Oci_fncode_stmtexecute: INTEGER is 21
	Oci_fncode_defineobject: INTEGER is 25
	Oci_fncode_definedynamic: INTEGER is 26
	Oci_fncode_definearrayofstruct: INTEGER is 27
	Oci_fncode_stmtfetch: INTEGER is 28
	Oci_fncode_stmtgetbind: INTEGER is 29
	Oci_fncode_describeany: INTEGER is 32
	Oci_fncode_transstart: INTEGER is 33
	Oci_fncode_transdetach: INTEGER is 34
	Oci_fncode_transcommit: INTEGER is 35
	Oci_fncode_errorget: INTEGER is 37
	Oci_fncode_lobopenfile: INTEGER is 38
	Oci_fncode_lobclosefile: INTEGER is 39
	Oci_fncode_lobcopy: INTEGER is 42
	Oci_fncode_lobappend: INTEGER is 43
	Oci_fncode_loberase: INTEGER is 44
	Oci_fncode_loblength: INTEGER is 45
	Oci_fncode_lobtrim: INTEGER is 46
	Oci_fncode_lobread: INTEGER is 47
	Oci_fncode_lobwrite: INTEGER is 48
	Oci_fncode_svcctxbreak: INTEGER is 50
	Oci_fncode_serverversion: INTEGER is 51
	Oci_fncode_attrget: INTEGER is 54
	Oci_fncode_attrset: INTEGER is 55
	Oci_fncode_paramset: INTEGER is 56
	Oci_fncode_paramget: INTEGER is 57
	Oci_fncode_stmtgetpieceinfo: INTEGER is 58
	Oci_fncode_ldatosvcctx: INTEGER is 59
	Oci_fncode_stmtsetpieceinfo: INTEGER is 61
	Oci_fncode_transforget: INTEGER is 62
	Oci_fncode_transprepare: INTEGER is 63
	Oci_fncode_transrollback: INTEGER is 64
	Oci_fncode_definebypos: INTEGER is 65
	Oci_fncode_bindbypos: INTEGER is 66
	Oci_fncode_bindbyname: INTEGER is 67
	Oci_fncode_lobassign: INTEGER is 68
	Oci_fncode_lobisequal: INTEGER is 69
	Oci_fncode_lobisinit: INTEGER is 70
	Oci_fncode_lobenablebuffering: INTEGER is 71
	Oci_fncode_lobcharsetid: INTEGER is 72
	Oci_fncode_lobcharsetform: INTEGER is 73
	Oci_fncode_lobfilesetname: INTEGER is 74
	Oci_fncode_lobfilegetname: INTEGER is 75
	Oci_fncode_logon: INTEGER is 76
	Oci_fncode_logoff: INTEGER is 77
	Oci_fncode_lobdisablebuffering: INTEGER is 78
	Oci_fncode_lobflushbuffer: INTEGER is 79
	Oci_fncode_lobloadfromfile: INTEGER is 80
	Oci_fncode_lobopen: INTEGER is 81
	Oci_fncode_lobclose: INTEGER is 82
	Oci_fncode_lobisopen: INTEGER is 83
	Oci_fncode_lobfileisopen: INTEGER is 84
	Oci_fncode_lobfileexists: INTEGER is 85
	Oci_fncode_lobfilecloseall: INTEGER is 86
	Oci_fncode_lobcreatetemp: INTEGER is 87
	Oci_fncode_lobfreetemp: INTEGER is 88
	Oci_fncode_lobistemp: INTEGER is 89
	Oci_fncode_aqenq: INTEGER is 90
	Oci_fncode_aqdeq: INTEGER is 91
	Oci_fncode_reset: INTEGER is 92
	Oci_fncode_svcctxtolda: INTEGER is 93
	Oci_fncode_loblocatorassign: INTEGER is 94
	Oci_fncode_ubindbyname: INTEGER is 95
	Oci_fncode_aqlisten: INTEGER is 96
	Oci_fncode_svc2hst: INTEGER is 97
	Oci_fncode_svcrh: INTEGER is 98
	Oci_fncode_transmultiprepare: INTEGER is 99
	Oci_fncode_maxfcn: INTEGER is 99
	
	Oci_inthr_unk: INTEGER is 24
	Oci_adjust_unk: INTEGER is 10
	
	Oci_oracle_date: INTEGER is 0
	Oci_ansi_date: INTEGER is 1
	
	Oci_one_piece: INTEGER_8 is 0
	Oci_first_piece: INTEGER_8 is 1
	Oci_next_piece: INTEGER_8 is 2
	Oci_last_piece: INTEGER_8 is 3
	
	Oci_file_readonly: INTEGER is 1
	
	Oci_lob_readonly: INTEGER is 1
	Oci_lob_readwrite: INTEGER is 2
	
	Oci_lob_buffer_free: INTEGER is 1
	Oci_lob_buffer_nofree: INTEGER is 2
	
feature	-- SQL statement types
	Oci_stmt_select: INTEGER is 1
	Oci_stmt_update: INTEGER is 2
	Oci_stmt_delete: INTEGER is 3
	Oci_stmt_insert: INTEGER is 4
	Oci_stmt_create: INTEGER is 5
	Oci_stmt_drop: INTEGER is 6
	Oci_stmt_alter: INTEGER is 7
	Oci_stmt_begin: INTEGER is 8
	Oci_stmt_declare: INTEGER is 9
	
	Oci_ptype_unk: INTEGER is 0
	Oci_ptype_table: INTEGER_8 is 1
	Oci_ptype_view: INTEGER_8 is 2
	Oci_ptype_proc: INTEGER_8 is 3
	Oci_ptype_func: INTEGER_8 is 4
	Oci_ptype_pkg: INTEGER_8 is 5
	Oci_ptype_type: INTEGER_8 is 6
	Oci_ptype_syn: INTEGER_8 is 7
	Oci_ptype_seq: INTEGER_8 is 8
	Oci_ptype_col: INTEGER_8 is 9
	Oci_ptype_arg: INTEGER_8 is 10
	Oci_ptype_list: INTEGER_8 is 11
	Oci_ptype_type_attr: INTEGER_8 is 12
	Oci_ptype_type_coll: INTEGER_8 is 13
	Oci_ptype_type_method: INTEGER_8 is 14
	Oci_ptype_type_arg: INTEGER_8 is 15
	Oci_ptype_type_result: INTEGER_8 is 16
	Oci_ptype_schema: INTEGER_8 is 17
	Oci_ptype_database: INTEGER_8 is 18
	
	Oci_ltype_unk: INTEGER is 0
	Oci_ltype_column: INTEGER is 1
	Oci_ltype_arg_proc: INTEGER is 2
	Oci_ltype_arg_func: INTEGER is 3
	Oci_ltype_subprg: INTEGER is 4
	Oci_ltype_type_attr: INTEGER is 5
	Oci_ltype_type_method: INTEGER is 6
	Oci_ltype_type_arg_proc: INTEGER is 7
	Oci_ltype_type_arg_func: INTEGER is 8
	Oci_ltype_sch_obj: INTEGER is 9
	Oci_ltype_db_sch: INTEGER is 10
	
	Oci_memory_cleared: INTEGER is 1
	
	Oci_ucbtype_entry: INTEGER is 1
	Oci_ucbtype_exit: INTEGER is 2
	Oci_ucbtype_replace: INTEGER is 3
	
	Oci_nls_dayname1: INTEGER is 1
	Oci_nls_dayname2: INTEGER is 2
	Oci_nls_dayname3: INTEGER is 3
	Oci_nls_dayname4: INTEGER is 4
	Oci_nls_dayname5: INTEGER is 5
	Oci_nls_dayname6: INTEGER is 6
	Oci_nls_dayname7: INTEGER is 7
	Oci_nls_abdayname1: INTEGER is 8
	Oci_nls_abdayname2: INTEGER is 9
	Oci_nls_abdayname3: INTEGER is 10
	Oci_nls_abdayname4: INTEGER is 11
	Oci_nls_abdayname5: INTEGER is 12
	Oci_nls_abdayname6: INTEGER is 13
	Oci_nls_abdayname7: INTEGER is 14
	Oci_nls_monthname1: INTEGER is 15
	Oci_nls_monthname2: INTEGER is 16
	Oci_nls_monthname3: INTEGER is 17
	Oci_nls_monthname4: INTEGER is 18
	Oci_nls_monthname5: INTEGER is 19
	Oci_nls_monthname6: INTEGER is 20
	Oci_nls_monthname7: INTEGER is 21
	Oci_nls_monthname8: INTEGER is 22
	Oci_nls_monthname9: INTEGER is 23
	Oci_nls_monthname10: INTEGER is 24
	Oci_nls_monthname11: INTEGER is 25
	Oci_nls_monthname12: INTEGER is 26
	Oci_nls_abmonthname1: INTEGER is 27
	Oci_nls_abmonthname2: INTEGER is 28
	Oci_nls_abmonthname3: INTEGER is 29
	Oci_nls_abmonthname4: INTEGER is 30
	Oci_nls_abmonthname5: INTEGER is 31
	Oci_nls_abmonthname6: INTEGER is 32
	Oci_nls_abmonthname7: INTEGER is 33
	Oci_nls_abmonthname8: INTEGER is 34
	Oci_nls_abmonthname9: INTEGER is 35
	Oci_nls_abmonthname10: INTEGER is 36
	Oci_nls_abmonthname11: INTEGER is 37
	Oci_nls_abmonthname12: INTEGER is 38
	Oci_nls_yes: INTEGER is 39
	Oci_nls_no: INTEGER is 40
	Oci_nls_am: INTEGER is 41
	Oci_nls_pm: INTEGER is 42
	Oci_nls_ad: INTEGER is 43
	Oci_nls_bc: INTEGER is 44
	Oci_nls_decimal: INTEGER is 45
	Oci_nls_group: INTEGER is 46
	Oci_nls_debit: INTEGER is 47
	Oci_nls_credit: INTEGER is 48
	Oci_nls_dateformat: INTEGER is 49
	Oci_nls_int_currency: INTEGER is 50
	Oci_nls_loc_currency: INTEGER is 51
	Oci_nls_language: INTEGER is 52
	Oci_nls_ablanguage: INTEGER is 53
	Oci_nls_territory: INTEGER is 54
	Oci_nls_character_set: INTEGER is 55
	Oci_nls_linguistic_name: INTEGER is 56
	Oci_nls_calendar: INTEGER is 57
	Oci_nls_dual_currency: INTEGER is 78
	Oci_nls_maxbufsz: INTEGER is 100

feature -- Object duration

	Oci_duration_default: INTEGER_16 is 8

	Oci_duration_null: INTEGER_16 is 9

	Oci_duration_session: INTEGER_16 is 10

	Oci_duration_trans: INTEGER_16 is 11

	Oci_duration_statement: INTEGER_16 is 13

feature -- Get options for tdo

  Oci_typeget_header: INTEGER_16 is 0
			-- load only the header portion of the TDO when getting type
  Oci_typeget_all: INTEGER_16 is 1
			-- load all attribute and method descriptors as well
			
feature -- Transaction Start Flags
-- NOTE: OCI_TRANS_JOIN and OCI_TRANS_NOMIGRATE not supported in 8.0.X
	Oci_trans_new: INTEGER is 1	-- starts a new transaction branch
	Oci_trans_join: INTEGER is 2	-- join an existing transaction
	Oci_trans_resume: INTEGER is 4	-- resume this transaction
	Oci_trans_startmask: INTEGER is 255

	Oci_trans_readonly: INTEGER is 256	-- starts a readonly transaction
	Oci_trans_readwrite: INTEGER is 512	-- starts a read-write transaction
	Oci_trans_serializable: INTEGER is 1024	-- starts a serializable transaction
	Oci_trans_isolmask: INTEGER is 65280

	Oci_trans_loose: INTEGER is 65536	-- a loosely coupled branch
	Oci_trans_tight: INTEGER is 131072	-- a tightly coupled branch
	Oci_trans_typemask: INTEGER is 983040

	Oci_trans_nomigrate: INTEGER is 1048576	-- non migratable transaction

feature -- Transaction End Flags
	Oci_trans_twophase: INTEGER is 16777216;	-- use two phase commit

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class OCI_CONST
