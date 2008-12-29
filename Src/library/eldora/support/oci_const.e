note
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
	Oci_htype_first: INTEGER = 1
	Oci_htype_env: INTEGER = 1
	Oci_htype_error: INTEGER = 2
	Oci_htype_svcctx: INTEGER = 3
	Oci_htype_stmt: INTEGER = 4
	Oci_htype_bind: INTEGER = 5
	Oci_htype_define: INTEGER = 6
	Oci_htype_describe: INTEGER = 7
	Oci_htype_server: INTEGER = 8
	Oci_htype_session: INTEGER = 9
	Oci_htype_trans: INTEGER = 10
	Oci_htype_complexobject: INTEGER = 11
	Oci_htype_security: INTEGER = 12
	Oci_htype_subscription: INTEGER = 13
	Oci_htype_dirpath_ctx: INTEGER = 14
	Oci_htype_dirpath_column_array: INTEGER = 15
	Oci_htype_dirpath_stream: INTEGER = 16
	Oci_htype_proc: INTEGER = 17
	Oci_htype_last: INTEGER = 17
	
feature -- Descriptor Types
	Oci_dtype_first: INTEGER = 50
	Oci_dtype_lob: INTEGER = 50
	Oci_dtype_snap: INTEGER = 51
	Oci_dtype_rset: INTEGER = 52
	Oci_dtype_param: INTEGER = 53
	Oci_dtype_rowid: INTEGER = 54
	Oci_dtype_complexobjectcomp: INTEGER = 55
	Oci_dtype_file: INTEGER = 56
	Oci_dtype_aqenq_options: INTEGER = 57
	Oci_dtype_aqdeq_options: INTEGER = 58
	Oci_dtype_aqmsg_properties: INTEGER = 59
	Oci_dtype_aqagent: INTEGER = 60
	Oci_dtype_locator: INTEGER = 61
	Oci_dtype_interval_ym: INTEGER = 62
	Oci_dtype_interval_ds: INTEGER = 63
	Oci_dtype_aqnfy_descriptor: INTEGER = 64
	Oci_dtype_date: INTEGER = 65
	Oci_dtype_time: INTEGER = 66
	Oci_dtype_time_tz: INTEGER = 67
	Oci_dtype_timestamp: INTEGER = 68
	Oci_dtype_timestamp_tz: INTEGER = 69
	Oci_dtype_timestamp_ltz: INTEGER = 70
	Oci_dtype_ucb: INTEGER = 71
	Oci_dtype_last: INTEGER = 71
	
feature -- LOB types
	Oci_temp_blob: INTEGER = 1
	Oci_temp_clob: INTEGER = 2

feature -- Object Ptr Types
	Oci_otype_name: INTEGER_8 = 1
	Oci_otype_ref: INTEGER_8 = 2
	Oci_otype_ptr: INTEGER_8 = 3
	
feature -- Attribute Types
	Oci_attr_fncode: INTEGER = 1
	Oci_attr_object: INTEGER = 2
	Oci_attr_nonblocking_mode: INTEGER = 3
	Oci_attr_sqlcode: INTEGER = 4
	Oci_attr_env: INTEGER = 5
	Oci_attr_server: INTEGER = 6
	Oci_attr_session: INTEGER = 7
	Oci_attr_trans: INTEGER = 8
	Oci_attr_row_count: INTEGER = 9
	Oci_attr_sqlfncode: INTEGER = 10
	Oci_attr_prefetch_rows: INTEGER = 11
	Oci_attr_nested_prefetch_rows: INTEGER = 12
	Oci_attr_prefetch_memory: INTEGER = 13
	Oci_attr_nested_prefetch_memory: INTEGER = 14
	Oci_attr_char_count: INTEGER = 15
	Oci_attr_pdscl: INTEGER = 16
	Oci_attr_pdprc: INTEGER = 17
	Oci_attr_param_count: INTEGER = 18
	Oci_attr_rowid: INTEGER = 19
	Oci_attr_charset: INTEGER = 20
	Oci_attr_nchar: INTEGER = 21
	Oci_attr_username: INTEGER = 22
	Oci_attr_password: INTEGER = 23
	Oci_attr_stmt_type: INTEGER = 24
	Oci_attr_internal_name: INTEGER = 25
	Oci_attr_external_name: INTEGER = 26
	Oci_attr_xid: INTEGER = 27
	Oci_attr_trans_lock: INTEGER = 28
	Oci_attr_trans_name: INTEGER = 29
	Oci_attr_heapalloc: INTEGER = 30
	Oci_attr_charset_id: INTEGER = 31
	Oci_attr_charset_form: INTEGER = 32
	Oci_attr_maxdata_size: INTEGER = 33
	Oci_attr_cache_opt_size: INTEGER = 34
	Oci_attr_cache_max_size: INTEGER = 35
	Oci_attr_pinoption: INTEGER = 36
	Oci_attr_alloc_duration: INTEGER = 37
	Oci_attr_pin_duration: INTEGER = 38
	Oci_attr_fdo: INTEGER = 39
	Oci_attr_postprocessing_callback: INTEGER = 40
	Oci_attr_postprocessing_context: INTEGER = 41
	Oci_attr_rows_returned: INTEGER = 42
	Oci_attr_focbk: INTEGER = 43
	Oci_attr_in_v8_mode: INTEGER = 44
	Oci_attr_lobempty: INTEGER = 45
	Oci_attr_sesslang: INTEGER = 46
	Oci_attr_visibility: INTEGER = 47
	Oci_attr_relative_msgid: INTEGER = 48
	Oci_attr_sequence_deviation: INTEGER = 49
	Oci_attr_consumer_name: INTEGER = 50
	Oci_attr_deq_mode: INTEGER = 51
	Oci_attr_navigation: INTEGER = 52
	Oci_attr_wait: INTEGER = 53
	Oci_attr_deq_msgid: INTEGER = 54
	Oci_attr_priority: INTEGER = 55
	Oci_attr_delay: INTEGER = 56
	Oci_attr_expiration: INTEGER = 57
	Oci_attr_correlation: INTEGER = 58
	Oci_attr_attempts: INTEGER = 59
	Oci_attr_recipient_list: INTEGER = 60
	Oci_attr_exception_queue: INTEGER = 61
	Oci_attr_enq_time: INTEGER = 62
	Oci_attr_agent_name: INTEGER = 64
	Oci_attr_agent_address: INTEGER = 65
	Oci_attr_agent_protocol: INTEGER = 66
	Oci_attr_sender_id: INTEGER = 68
	Oci_attr_original_msgid: INTEGER = 69
	Oci_attr_queue_name: INTEGER = 70
	Oci_attr_nfy_msgid: INTEGER = 71
	Oci_attr_msg_prop: INTEGER = 72
	Oci_attr_num_dml_errors: INTEGER = 73
	Oci_attr_dml_row_offset: INTEGER = 74
	Oci_attr_dateformat: INTEGER = 75
	Oci_attr_buf_addr: INTEGER = 76
	Oci_attr_buf_size: INTEGER = 77
	Oci_attr_dirpath_mode: INTEGER = 78
	Oci_attr_dirpath_nolog: INTEGER = 79
	Oci_attr_dirpath_parallel: INTEGER = 80
	Oci_attr_num_rows: INTEGER = 81
	Oci_attr_col_count: INTEGER = 82
	Oci_attr_stream_offset: INTEGER = 83
	Oci_attr_shared_heapalloc: INTEGER = 84
	Oci_attr_server_group: INTEGER = 85
	Oci_attr_migsession: INTEGER = 86
	Oci_attr_nocache: INTEGER = 87
	Oci_attr_mempool_size: INTEGER = 88
	Oci_attr_mempool_instname: INTEGER = 89
	Oci_attr_mempool_appname: INTEGER = 90
	Oci_attr_mempool_homename: INTEGER = 91
	Oci_attr_mempool_model: INTEGER = 92
	Oci_attr_modes: INTEGER = 93
	Oci_attr_subscr_name: INTEGER = 94
	Oci_attr_subscr_callback: INTEGER = 95
	Oci_attr_subscr_ctx: INTEGER = 96
	Oci_attr_subscr_payload: INTEGER = 97
	Oci_attr_subscr_namespace: INTEGER = 98
	Oci_attr_proxy_credentials: INTEGER = 99
	Oci_attr_initial_client_roles: INTEGER = 100
	Oci_attr_unk: INTEGER = 101
	Oci_attr_num_cols: INTEGER = 102
	Oci_attr_list_columns: INTEGER = 103
	Oci_attr_rdba: INTEGER = 104
	Oci_attr_clustered: INTEGER = 105
	Oci_attr_partitioned: INTEGER = 106
	Oci_attr_index_only: INTEGER = 107
	Oci_attr_list_arguments: INTEGER = 108
	Oci_attr_list_subprograms: INTEGER = 109
	Oci_attr_ref_tdo: INTEGER = 110
	Oci_attr_link: INTEGER = 111
	Oci_attr_min: INTEGER = 112
	Oci_attr_max: INTEGER = 113
	Oci_attr_incr: INTEGER = 114
	Oci_attr_cache: INTEGER = 115
	Oci_attr_order: INTEGER = 116
	Oci_attr_hw_mark: INTEGER = 117
	Oci_attr_type_schema: INTEGER = 118
	Oci_attr_timestamp: INTEGER = 119
	Oci_attr_num_attrs: INTEGER = 120
	Oci_attr_num_params: INTEGER = 121
	Oci_attr_objid: INTEGER = 122
	Oci_attr_ptype: INTEGER = 123
	Oci_attr_param: INTEGER = 124
	Oci_attr_overload_id: INTEGER = 125
	Oci_attr_tablespace: INTEGER = 126
	Oci_attr_tdo: INTEGER = 127
	Oci_attr_ltype: INTEGER = 128
	Oci_attr_parse_error_offset: INTEGER = 129
	Oci_attr_is_temporary: INTEGER = 130
	Oci_attr_is_typed: INTEGER = 131
	Oci_attr_duration: INTEGER = 132
	Oci_attr_is_invoker_rights: INTEGER = 133
	Oci_attr_obj_name: INTEGER = 134
	Oci_attr_obj_schema: INTEGER = 135
	Oci_attr_obj_id: INTEGER = 136
	Oci_attr_dirpath_sorted_index: INTEGER = 137
	Oci_attr_dirpath_index_maint_method: INTEGER = 138
	Oci_attr_dirpath_file: INTEGER = 139
	Oci_attr_dirpath_storage_initial: INTEGER = 140
	Oci_attr_dirpath_storage_next: INTEGER = 141
	Oci_attr_trans_timeout: INTEGER = 142
	Oci_attr_server_status: INTEGER = 143
	Oci_attr_statement: INTEGER = 144
	Oci_attr_no_cache: INTEGER = 145
	Oci_attr_reserved_1: INTEGER = 146
	Oci_attr_server_busy: INTEGER = 147
	
--	Oci_ucs2id: INTEGER is 1000
	
feature -- Server Handle Attribute Values
	Oci_server_not_connected: INTEGER = 0 
	Oci_server_normal: INTEGER = 1 

feature -- Supported Namespaces
	Oci_subscr_namespace_anonymous: INTEGER = 0
	Oci_subscr_namespace_aq: INTEGER = 1
	Oci_subscr_namespace_max: INTEGER = 2
	
feature -- Credential Types
	Oci_cred_rdbms: INTEGER = 1
	Oci_cred_ext: INTEGER = 2
	Oci_cred_proxy: INTEGER = 3
	
feature -- Error Return Values
	Oci_success: INTEGER = 0
	Oci_success_with_info: INTEGER = 1
	Oci_reserved_for_int_use: INTEGER = 200
	Oci_no_data: INTEGER = 100
	Oci_error: INTEGER = -1
	Oci_invalid_handle: INTEGER = -2
	Oci_need_data: INTEGER = 99
	Oci_still_executing: INTEGER = -3123
	Oci_continue: INTEGER = -24200

feature -- Parsing Syntax Types
	Oci_v7_syntax: INTEGER = 2
	Oci_v8_syntax: INTEGER = 3
	Oci_ntv_syntax: INTEGER = 1
	
feature -- Scrollable Cursor Options
	Oci_fetch_next: INTEGER_16 = 2                                -- next row 
	Oci_fetch_first: INTEGER_16 = 4            -- first row of the result set 
	Oci_fetch_last: INTEGER_16 = 8          -- the last row of the result set 
	Oci_fetch_prior: INTEGER_16 = 16  -- the previous row relative to current 
	Oci_fetch_absolute: INTEGER_16 = 32         -- absolute offset from first 
	Oci_fetch_relative: INTEGER_16 = 64         -- offset relative to current 
	Oci_fetch_reserved_1: INTEGER_16 = 128       -- reserved for internal use 

feature -- Bind and Define Options
	Oci_sb2_ind_ptr: INTEGER = 1                                 -- unused 
	Oci_data_at_exec: INTEGER = 2                  -- data at execute time 
	Oci_dynamic_fetch: INTEGER = 2                    -- fetch dynamically 
	Oci_piecewise: INTEGER = 4                  -- piecewise DMLs or fetch 
	Oci_define_reserved_1: INTEGER = 8        -- reserved for internal use 
	Oci_bind_reserved_2: INTEGER = 16         -- reserved for internal use 
	Oci_define_reserved_2: INTEGER = 32       -- reserved for internal use 

feature -- Various Modes
	Oci_default: INTEGER = 0 -- the default value for parameters and attributes 

feature -- OCIInitialize Modes / OCICreateEnvironment Modes
	Oci_threaded: INTEGER = 1 -- the application is in threaded environment 
	Oci_object: INTEGER = 2     -- the application is in object environment 
	Oci_events: INTEGER = 4        -- the application is enabled for events 
	Oci_reserved1: INTEGER = 8                 -- reserved for internal use 
	Oci_shared: INTEGER = 16           -- the application is in shared mode 
	Oci_reserved2: INTEGER = 32                -- reserved for internal use 
-- The following *TWO* are only valid for OCICreateEnvironment call 
	Oci_no_ucb: INTEGER = 64         -- no user callback called during init 
	Oci_no_mutex: INTEGER = 128       -- the environment handle will not be  
	                                     --  protected by a mutex internally 
	Oci_shared_ext: INTEGER = 256                  -- used for shared forms 
	Oci_cache: INTEGER = 512                              -- used by iCache 
	Oci_no_cache: INTEGER = 1024    -- turn off iCache mode, used by iCache 

feature -- OCIEnvInit Modes
	Oci_env_no_ucb: INTEGER = 1   -- a user callback will not be called in OCIEnvInit() 
	Oci_env_no_mutex: INTEGER = 8 -- the environment handle will not be protected
					 							 -- by a mutex internally
	
feature -- Parse Modes
	Oci_no_sharing: INTEGER = 1      -- turn off statement handle sharing 
	            -- This flag is only valid when process is in sharing mode 
	
feature -- Execution Modes
	Oci_batch_mode: INTEGER = 1  -- batch the oci statement for execution 
	Oci_exact_fetch: INTEGER = 2        -- fetch the exact rows specified 
	Oci_keep_fetch_state: INTEGER = 4                           -- unused 
	Oci_scrollable_cursor: INTEGER = 8               -- cursor scrollable 
	Oci_describe_only: INTEGER = 16        -- only describe the statement 
	Oci_commit_on_success: INTEGER = 32 -- commit, if successful execution 
	Oci_non_blocking: INTEGER = 64                        -- non-blocking 
	Oci_batch_errors: INTEGER = 128         -- batch errors in array dmls 
	Oci_parse_only: INTEGER = 256             -- only parse the statement 
	Oci_exact_fetch_reserved_1: INTEGER = 512 -- reserved for internal use 
	Oci_show_dml_warnings: INTEGER = 1024
	
feature -- Authentication Modes
	Oci_migrate: INTEGER = 1                   -- migratable auth context 
	Oci_sysdba: INTEGER = 2                   -- for SYSDBA authorization 
	Oci_sysoper: INTEGER = 4                 -- for SYSOPER authorization 
	Oci_prelim_auth: INTEGER = 8         -- for preliminary authorization 
	Ocip_icache: INTEGER = 16 -- Private OCI cache mode to notify cache db 
	
feature -- Attach Modes
	
	Oci_fastpath: INTEGER = 16			 -- Attach in fast path mode 
	
feature -- Piece Information
	Oci_param_in: INTEGER = 1                            -- in parameter 
	Oci_param_out: INTEGER = 2                          -- out parameter 

	Oci_enq_immediate: INTEGER = 1
	Oci_enq_on_commit: INTEGER = 2
	
	Oci_deq_browse: INTEGER = 1
	Oci_deq_locked: INTEGER = 2
	Oci_deq_remove: INTEGER = 3
	Oci_deq_remove_nodata: INTEGER = 4
	Oci_deq_first_msg: INTEGER = 1
	Oci_deq_next_msg: INTEGER = 3
	Oci_deq_next_transaction: INTEGER = 2
	
	Oci_msg_waiting: INTEGER = 1
	Oci_msg_ready: INTEGER = 0
	Oci_msg_processed: INTEGER = 2
	Oci_msg_expired: INTEGER = 3
	
	Oci_enq_before: INTEGER = 2
	Oci_enq_top: INTEGER = 3
	
	Oci_deq_immediate: INTEGER = 1
	Oci_deq_on_commit: INTEGER = 2
	Oci_deq_wait_forever: INTEGER = -1
	Oci_deq_no_wait: INTEGER = 0
	
	Oci_msg_no_delay: INTEGER = 0
	Oci_msg_no_expiration: INTEGER = -1

feature -- Deprecated
	Oci_otype_unk: INTEGER = 0
	Oci_otype_table: INTEGER = 1
	Oci_otype_view: INTEGER = 2
	Oci_otype_syn: INTEGER = 3
	Oci_otype_proc: INTEGER = 4
	Oci_otype_func: INTEGER = 5
	Oci_otype_pkg: INTEGER = 6
	Oci_otype_stmt: INTEGER = 7
	
feature	-- Describe Handle Attributes
	Oci_attr_data_size: INTEGER = 1
	Oci_attr_data_type: INTEGER = 2
	Oci_attr_disp_size: INTEGER = 3
	Oci_attr_name: INTEGER = 4
	Oci_attr_precision: INTEGER = 5
	Oci_attr_scale: INTEGER = 6
	Oci_attr_is_null: INTEGER = 7
	Oci_attr_type_name: INTEGER = 8
	Oci_attr_schema_name: INTEGER = 9
	Oci_attr_sub_name: INTEGER = 10
	Oci_attr_position: INTEGER = 11
	Oci_attr_complexobjectcomp_type: INTEGER = 50
	Oci_attr_complexobjectcomp_type_level: INTEGER = 51
	Oci_attr_complexobject_level: INTEGER = 52
	Oci_attr_complexobject_coll_outofline: INTEGER = 53
	Oci_attr_disp_name: INTEGER = 100
	Oci_attr_overload: INTEGER = 210
	Oci_attr_level: INTEGER = 211
	Oci_attr_has_default: INTEGER = 212
	Oci_attr_iomode: INTEGER = 213
	Oci_attr_radix: INTEGER = 214
	Oci_attr_num_args: INTEGER = 215
	Oci_attr_typecode: INTEGER = 216
	Oci_attr_collection_typecode: INTEGER = 217
	Oci_attr_version: INTEGER = 218
	Oci_attr_is_incomplete_type: INTEGER = 219
	Oci_attr_is_system_type: INTEGER = 220
	Oci_attr_is_predefined_type: INTEGER = 221
	Oci_attr_is_transient_type: INTEGER = 222
	Oci_attr_is_system_generated_type: INTEGER = 223
	Oci_attr_has_nested_table: INTEGER = 224
	Oci_attr_has_lob: INTEGER = 225
	Oci_attr_has_file: INTEGER = 226
	Oci_attr_collection_element: INTEGER = 227
	Oci_attr_num_type_attrs: INTEGER = 228
	Oci_attr_list_type_attrs: INTEGER = 229
	Oci_attr_num_type_methods: INTEGER = 230
	Oci_attr_list_type_methods: INTEGER = 231
	Oci_attr_map_method: INTEGER = 232
	Oci_attr_order_method: INTEGER = 233
	Oci_attr_num_elems: INTEGER = 234
	Oci_attr_encapsulation: INTEGER = 235
	Oci_attr_is_selfish: INTEGER = 236
	Oci_attr_is_virtual: INTEGER = 237
	Oci_attr_is_inline: INTEGER = 238
	Oci_attr_is_constant: INTEGER = 239
	Oci_attr_has_result: INTEGER = 240
	Oci_attr_is_constructor: INTEGER = 241
	Oci_attr_is_destructor: INTEGER = 242
	Oci_attr_is_operator: INTEGER = 243
	Oci_attr_is_map: INTEGER = 244
	Oci_attr_is_order: INTEGER = 245
	Oci_attr_is_rnds: INTEGER = 246
	Oci_attr_is_rnps: INTEGER = 247
	Oci_attr_is_wnds: INTEGER = 248
	Oci_attr_is_wnps: INTEGER = 249
	Oci_attr_desc_public: INTEGER = 250
	Oci_attr_cache_client_context: INTEGER = 251
	Oci_attr_uci_construct: INTEGER = 252
	Oci_attr_uci_destruct: INTEGER = 253
	Oci_attr_uci_copy: INTEGER = 254
	Oci_attr_uci_pickle: INTEGER = 255
	Oci_attr_uci_unpickle: INTEGER = 256
	Oci_attr_uci_refresh: INTEGER = 257
	Oci_attr_is_subtype: INTEGER = 258
	Oci_attr_supertype_schema_name: INTEGER = 259
	Oci_attr_supertype_name: INTEGER = 260
	Oci_attr_list_objects: INTEGER = 261
	Oci_attr_ncharset_id: INTEGER = 262
	Oci_attr_list_schemas: INTEGER = 263
	Oci_attr_max_proc_len: INTEGER = 264
	Oci_attr_max_column_len: INTEGER = 265
	Oci_attr_cursor_commit_behavior: INTEGER = 266
	Oci_attr_max_catalog_namelen: INTEGER = 267
	Oci_attr_catalog_location: INTEGER = 268
	Oci_attr_savepoint_support: INTEGER = 269
	Oci_attr_nowait_support: INTEGER = 270
	Oci_attr_autocommit_ddl: INTEGER = 271
	Oci_attr_locking_mode: INTEGER = 272
	Oci_attr_appctx_size: INTEGER = 273
	Oci_attr_appctx_list: INTEGER = 274
	Oci_attr_appctx_name: INTEGER = 275
	Oci_attr_appctx_attr: INTEGER = 276
	Oci_attr_appctx_value: INTEGER = 277
	
	Oci_cursor_open: INTEGER = 0
	Oci_cursor_closed: INTEGER = 1
	
	Oci_cl_start: INTEGER = 0
	Oci_cl_end: INTEGER = 1
	
	Oci_sp_supported: INTEGER = 0
	Oci_sp_unsupported: INTEGER = 1
	
	Oci_nw_supported: INTEGER = 0
	Oci_nw_unsupported: INTEGER = 1
	
	Oci_ac_ddl: INTEGER = 0
	Oci_no_ac_ddl: INTEGER = 1
	
	Oci_lock_immediate: INTEGER = 0
	Oci_lock_delayed: INTEGER = 1
	
	Oci_max_fns: INTEGER = 100
	Oci_sqlstate_size: INTEGER = 5
	Oci_error_maxmsg_size: INTEGER = 1024
	Oci_rowid_len: INTEGER = 23
	Oci_fo_retry: INTEGER = 25410
	
feature	-- Callback function codes
	Oci_fncode_initialize: INTEGER = 1
	Oci_fncode_handlealloc: INTEGER = 2
	Oci_fncode_handlefree: INTEGER = 3
	Oci_fncode_descriptoralloc: INTEGER = 4
	Oci_fncode_descriptorfree: INTEGER = 5
	Oci_fncode_envinit: INTEGER = 6
	Oci_fncode_serverattach: INTEGER = 7
	Oci_fncode_serverdetach: INTEGER = 8
	Oci_fncode_sessionbegin: INTEGER = 10
	Oci_fncode_sessionend: INTEGER = 11
	Oci_fncode_passwordchange: INTEGER = 12
	Oci_fncode_stmtprepare: INTEGER = 13
	Oci_fncode_binddynamic: INTEGER = 17
	Oci_fncode_bindobject: INTEGER = 18
	Oci_fncode_bindarrayofstruct: INTEGER = 20
	Oci_fncode_stmtexecute: INTEGER = 21
	Oci_fncode_defineobject: INTEGER = 25
	Oci_fncode_definedynamic: INTEGER = 26
	Oci_fncode_definearrayofstruct: INTEGER = 27
	Oci_fncode_stmtfetch: INTEGER = 28
	Oci_fncode_stmtgetbind: INTEGER = 29
	Oci_fncode_describeany: INTEGER = 32
	Oci_fncode_transstart: INTEGER = 33
	Oci_fncode_transdetach: INTEGER = 34
	Oci_fncode_transcommit: INTEGER = 35
	Oci_fncode_errorget: INTEGER = 37
	Oci_fncode_lobopenfile: INTEGER = 38
	Oci_fncode_lobclosefile: INTEGER = 39
	Oci_fncode_lobcopy: INTEGER = 42
	Oci_fncode_lobappend: INTEGER = 43
	Oci_fncode_loberase: INTEGER = 44
	Oci_fncode_loblength: INTEGER = 45
	Oci_fncode_lobtrim: INTEGER = 46
	Oci_fncode_lobread: INTEGER = 47
	Oci_fncode_lobwrite: INTEGER = 48
	Oci_fncode_svcctxbreak: INTEGER = 50
	Oci_fncode_serverversion: INTEGER = 51
	Oci_fncode_attrget: INTEGER = 54
	Oci_fncode_attrset: INTEGER = 55
	Oci_fncode_paramset: INTEGER = 56
	Oci_fncode_paramget: INTEGER = 57
	Oci_fncode_stmtgetpieceinfo: INTEGER = 58
	Oci_fncode_ldatosvcctx: INTEGER = 59
	Oci_fncode_stmtsetpieceinfo: INTEGER = 61
	Oci_fncode_transforget: INTEGER = 62
	Oci_fncode_transprepare: INTEGER = 63
	Oci_fncode_transrollback: INTEGER = 64
	Oci_fncode_definebypos: INTEGER = 65
	Oci_fncode_bindbypos: INTEGER = 66
	Oci_fncode_bindbyname: INTEGER = 67
	Oci_fncode_lobassign: INTEGER = 68
	Oci_fncode_lobisequal: INTEGER = 69
	Oci_fncode_lobisinit: INTEGER = 70
	Oci_fncode_lobenablebuffering: INTEGER = 71
	Oci_fncode_lobcharsetid: INTEGER = 72
	Oci_fncode_lobcharsetform: INTEGER = 73
	Oci_fncode_lobfilesetname: INTEGER = 74
	Oci_fncode_lobfilegetname: INTEGER = 75
	Oci_fncode_logon: INTEGER = 76
	Oci_fncode_logoff: INTEGER = 77
	Oci_fncode_lobdisablebuffering: INTEGER = 78
	Oci_fncode_lobflushbuffer: INTEGER = 79
	Oci_fncode_lobloadfromfile: INTEGER = 80
	Oci_fncode_lobopen: INTEGER = 81
	Oci_fncode_lobclose: INTEGER = 82
	Oci_fncode_lobisopen: INTEGER = 83
	Oci_fncode_lobfileisopen: INTEGER = 84
	Oci_fncode_lobfileexists: INTEGER = 85
	Oci_fncode_lobfilecloseall: INTEGER = 86
	Oci_fncode_lobcreatetemp: INTEGER = 87
	Oci_fncode_lobfreetemp: INTEGER = 88
	Oci_fncode_lobistemp: INTEGER = 89
	Oci_fncode_aqenq: INTEGER = 90
	Oci_fncode_aqdeq: INTEGER = 91
	Oci_fncode_reset: INTEGER = 92
	Oci_fncode_svcctxtolda: INTEGER = 93
	Oci_fncode_loblocatorassign: INTEGER = 94
	Oci_fncode_ubindbyname: INTEGER = 95
	Oci_fncode_aqlisten: INTEGER = 96
	Oci_fncode_svc2hst: INTEGER = 97
	Oci_fncode_svcrh: INTEGER = 98
	Oci_fncode_transmultiprepare: INTEGER = 99
	Oci_fncode_maxfcn: INTEGER = 99
	
	Oci_inthr_unk: INTEGER = 24
	Oci_adjust_unk: INTEGER = 10
	
	Oci_oracle_date: INTEGER = 0
	Oci_ansi_date: INTEGER = 1
	
	Oci_one_piece: INTEGER_8 = 0
	Oci_first_piece: INTEGER_8 = 1
	Oci_next_piece: INTEGER_8 = 2
	Oci_last_piece: INTEGER_8 = 3
	
	Oci_file_readonly: INTEGER = 1
	
	Oci_lob_readonly: INTEGER = 1
	Oci_lob_readwrite: INTEGER = 2
	
	Oci_lob_buffer_free: INTEGER = 1
	Oci_lob_buffer_nofree: INTEGER = 2
	
feature	-- SQL statement types
	Oci_stmt_select: INTEGER = 1
	Oci_stmt_update: INTEGER = 2
	Oci_stmt_delete: INTEGER = 3
	Oci_stmt_insert: INTEGER = 4
	Oci_stmt_create: INTEGER = 5
	Oci_stmt_drop: INTEGER = 6
	Oci_stmt_alter: INTEGER = 7
	Oci_stmt_begin: INTEGER = 8
	Oci_stmt_declare: INTEGER = 9
	
	Oci_ptype_unk: INTEGER = 0
	Oci_ptype_table: INTEGER_8 = 1
	Oci_ptype_view: INTEGER_8 = 2
	Oci_ptype_proc: INTEGER_8 = 3
	Oci_ptype_func: INTEGER_8 = 4
	Oci_ptype_pkg: INTEGER_8 = 5
	Oci_ptype_type: INTEGER_8 = 6
	Oci_ptype_syn: INTEGER_8 = 7
	Oci_ptype_seq: INTEGER_8 = 8
	Oci_ptype_col: INTEGER_8 = 9
	Oci_ptype_arg: INTEGER_8 = 10
	Oci_ptype_list: INTEGER_8 = 11
	Oci_ptype_type_attr: INTEGER_8 = 12
	Oci_ptype_type_coll: INTEGER_8 = 13
	Oci_ptype_type_method: INTEGER_8 = 14
	Oci_ptype_type_arg: INTEGER_8 = 15
	Oci_ptype_type_result: INTEGER_8 = 16
	Oci_ptype_schema: INTEGER_8 = 17
	Oci_ptype_database: INTEGER_8 = 18
	
	Oci_ltype_unk: INTEGER = 0
	Oci_ltype_column: INTEGER = 1
	Oci_ltype_arg_proc: INTEGER = 2
	Oci_ltype_arg_func: INTEGER = 3
	Oci_ltype_subprg: INTEGER = 4
	Oci_ltype_type_attr: INTEGER = 5
	Oci_ltype_type_method: INTEGER = 6
	Oci_ltype_type_arg_proc: INTEGER = 7
	Oci_ltype_type_arg_func: INTEGER = 8
	Oci_ltype_sch_obj: INTEGER = 9
	Oci_ltype_db_sch: INTEGER = 10
	
	Oci_memory_cleared: INTEGER = 1
	
	Oci_ucbtype_entry: INTEGER = 1
	Oci_ucbtype_exit: INTEGER = 2
	Oci_ucbtype_replace: INTEGER = 3
	
	Oci_nls_dayname1: INTEGER = 1
	Oci_nls_dayname2: INTEGER = 2
	Oci_nls_dayname3: INTEGER = 3
	Oci_nls_dayname4: INTEGER = 4
	Oci_nls_dayname5: INTEGER = 5
	Oci_nls_dayname6: INTEGER = 6
	Oci_nls_dayname7: INTEGER = 7
	Oci_nls_abdayname1: INTEGER = 8
	Oci_nls_abdayname2: INTEGER = 9
	Oci_nls_abdayname3: INTEGER = 10
	Oci_nls_abdayname4: INTEGER = 11
	Oci_nls_abdayname5: INTEGER = 12
	Oci_nls_abdayname6: INTEGER = 13
	Oci_nls_abdayname7: INTEGER = 14
	Oci_nls_monthname1: INTEGER = 15
	Oci_nls_monthname2: INTEGER = 16
	Oci_nls_monthname3: INTEGER = 17
	Oci_nls_monthname4: INTEGER = 18
	Oci_nls_monthname5: INTEGER = 19
	Oci_nls_monthname6: INTEGER = 20
	Oci_nls_monthname7: INTEGER = 21
	Oci_nls_monthname8: INTEGER = 22
	Oci_nls_monthname9: INTEGER = 23
	Oci_nls_monthname10: INTEGER = 24
	Oci_nls_monthname11: INTEGER = 25
	Oci_nls_monthname12: INTEGER = 26
	Oci_nls_abmonthname1: INTEGER = 27
	Oci_nls_abmonthname2: INTEGER = 28
	Oci_nls_abmonthname3: INTEGER = 29
	Oci_nls_abmonthname4: INTEGER = 30
	Oci_nls_abmonthname5: INTEGER = 31
	Oci_nls_abmonthname6: INTEGER = 32
	Oci_nls_abmonthname7: INTEGER = 33
	Oci_nls_abmonthname8: INTEGER = 34
	Oci_nls_abmonthname9: INTEGER = 35
	Oci_nls_abmonthname10: INTEGER = 36
	Oci_nls_abmonthname11: INTEGER = 37
	Oci_nls_abmonthname12: INTEGER = 38
	Oci_nls_yes: INTEGER = 39
	Oci_nls_no: INTEGER = 40
	Oci_nls_am: INTEGER = 41
	Oci_nls_pm: INTEGER = 42
	Oci_nls_ad: INTEGER = 43
	Oci_nls_bc: INTEGER = 44
	Oci_nls_decimal: INTEGER = 45
	Oci_nls_group: INTEGER = 46
	Oci_nls_debit: INTEGER = 47
	Oci_nls_credit: INTEGER = 48
	Oci_nls_dateformat: INTEGER = 49
	Oci_nls_int_currency: INTEGER = 50
	Oci_nls_loc_currency: INTEGER = 51
	Oci_nls_language: INTEGER = 52
	Oci_nls_ablanguage: INTEGER = 53
	Oci_nls_territory: INTEGER = 54
	Oci_nls_character_set: INTEGER = 55
	Oci_nls_linguistic_name: INTEGER = 56
	Oci_nls_calendar: INTEGER = 57
	Oci_nls_dual_currency: INTEGER = 78
	Oci_nls_maxbufsz: INTEGER = 100

feature -- Object duration

	Oci_duration_default: INTEGER_16 = 8

	Oci_duration_null: INTEGER_16 = 9

	Oci_duration_session: INTEGER_16 = 10

	Oci_duration_trans: INTEGER_16 = 11

	Oci_duration_statement: INTEGER_16 = 13

feature -- Get options for tdo

  Oci_typeget_header: INTEGER_16 = 0
			-- load only the header portion of the TDO when getting type
  Oci_typeget_all: INTEGER_16 = 1
			-- load all attribute and method descriptors as well
			
feature -- Transaction Start Flags
-- NOTE: OCI_TRANS_JOIN and OCI_TRANS_NOMIGRATE not supported in 8.0.X
	Oci_trans_new: INTEGER = 1	-- starts a new transaction branch
	Oci_trans_join: INTEGER = 2	-- join an existing transaction
	Oci_trans_resume: INTEGER = 4	-- resume this transaction
	Oci_trans_startmask: INTEGER = 255

	Oci_trans_readonly: INTEGER = 256	-- starts a readonly transaction
	Oci_trans_readwrite: INTEGER = 512	-- starts a read-write transaction
	Oci_trans_serializable: INTEGER = 1024	-- starts a serializable transaction
	Oci_trans_isolmask: INTEGER = 65280

	Oci_trans_loose: INTEGER = 65536	-- a loosely coupled branch
	Oci_trans_tight: INTEGER = 131072	-- a tightly coupled branch
	Oci_trans_typemask: INTEGER = 983040

	Oci_trans_nomigrate: INTEGER = 1048576	-- non migratable transaction

feature -- Transaction End Flags
	Oci_trans_twophase: INTEGER = 16777216;	-- use two phase commit

note
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
