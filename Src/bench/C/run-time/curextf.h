#ifndef _CONCURRENT_EXTERN_FUNCTIONS_
#define _CONCURRENT_EXTERN_FUNCTIONS_

/*---------------------------------------------------------*/
/* The following are functions in the concurrent C-library */
/*---------------------------------------------------------*/

/* From parameter.c */
extern EIF_INTEGER adjust_array();
extern void free_parameter_array();
extern void set_str_val_into_parameter();
extern EIF_POINTER get_c_format_of_eif_string();
/*extern char *eif_str_to_c_str(); */


/* From server.c */
extern void make_server();

/* utilities for client */
extern EIF_BOOLEAN on_local_processor();
extern CONNECTION  *setup_connection();
extern EIF_OBJ  create_child();
extern EIF_POINTER  create_sep_obj();
extern EIF_POINTER clone_sep_obj_proxy();
extern EIF_BOOLEAN reserve_sep_obj();
extern void free_sep_obj();
extern char *command_text();
extern char valid_command();

/* request primitives */
extern void get_command();
extern void get_data();
extern void send_register_ack();
extern void send_command();

extern void server_execute();

/* utilities for "remote_server" */
extern EIF_OBJ remote_server_by_name();
extern EIF_OBJ remote_server_by_index();
extern EIF_OBJ remote_server();

/* utilities for local server */
extern void register_a_ref();
extern void unregister_from_local_processor();
extern void unregister();
extern void tell_parent_info_of_myself();
extern void wait_sep_child_obj();
extern void to_register();

/* for "cli_list" */
extern void add_to_client_queue();
extern CLIENT *take_head_from_client_list();
extern void read_from_client_queue();

/* for "ser_list" */
extern EIF_BOOLEAN exist_in_server_list();
extern EIF_INTEGER get_sock_from_server_list();
extern void add_to_server_list();
extern SERVER *take_head_from_server_list();
extern void release_server_list();
extern void release_imported_objects();

/* for "child_list" */
extern void add_to_child_list();
extern CHILD *take_head_from_child_list();

/* for displaying RUN-TIME errors */
extern void wait_scoop_daemon();
extern void default_rescue();
extern void print_run_time_error_message();
extern void release_child_list();
extern void release_system_lists_in_rescue();
extern void sig_def_resc();
extern void sig_proc_child();
extern void sig_sys_list();
extern void sig_rels_child();
extern void def_res();
extern void c_my_concur_put_int();
extern void c_my_concur_put_stream();
extern void release_exported_objects();

/* for POLLING mechanism */
extern EIF_INTEGER process_exception();
extern EIF_INTEGER has_msg_from_pc();
extern void process_connection();
/* For blocked client list */
extern void add_to_blocked_client_queue();
extern CLIENT *take_head_from_blocked_client_list();

/* From ref_table.c */
extern EIF_INTEGER c_get_oid_from_addr();
extern EIF_INTEGER get_oid_from_address();
extern void change_ref_table_and_exported_obj_list();
extern EIF_INTEGER get_proxy_oid_of_imported_object();
extern void insert_into_imported_object_table();
extern void c_clear_proxy();
extern void cleanup_proxy();
extern void c_cleanup_proxy();
extern char exported_obj_to_processor_before();
extern void adjust_exported_objects();


/* From concurrency.c */
extern void con_make();
extern char read_a_line();
extern void adjust_a_line();
extern void get_default_values();
extern void get_remote_servers();
extern void get_network_resources();

extern char *dispatch_to();
extern void print_config();
extern void reset_by_host();
extern void reset_by_level(char *gname);
extern void cur_clear_configure_table();
extern void add_group(char *gname);
extern void add_host (char *gname, char *hname, EIF_INTEGER cap, char *dir, char *exe);
extern void change_capacity_of_host(char *gname, char *hname, EIF_INTEGER cap);


/* From "idle.c" */
extern void idle_usage();

/* From "stack.c" */
extern void extend_string();


/* From "subs.c" */
extern EIF_INTEGER inttoa();
extern EIF_INTEGER longtoa();
extern EIF_INTEGER realtoa();
extern EIF_INTEGER doutoa();
extern void c_get_host_name();
extern char * c_get_name_from_addr();
extern EIF_INTEGER c_get_addr_from_name();
extern char *c_get_current_directory();
extern int c_get_pid();
extern void set_block();
extern void set_non_block();
extern int c_try_to_get_command();
extern EIF_INTEGER c_get_command_code();
extern EIF_INTEGER c_get_oid();
extern EIF_INTEGER c_get_ack();
extern char *c_get_class_name();
extern char *c_get_feature_name();
extern EIF_INTEGER c_get_para_num();
extern void c_get_usrname();
extern void send_signal_to_scoop_dog();
extern EIF_INTEGER c_concur_bind();
extern void c_set_current_client_reserved();
extern EIF_INTEGER c_concur_make_client();
extern EIF_INTEGER c_concur_make_server();
extern EIF_INTEGER c_concur_accept();
extern EIF_POINTER c_concur_read_stream();
extern void c_send_default_crash_info();
extern void c_reset_timer();
extern EIF_DOUBLE c_wait_time();
extern EIF_BOOLEAN c_wait_long_enough();
extern void c_raise_concur_exception();
extern void c_process_ser_list_from_sep_obj();
extern void cur_usleep();
extern void cur_set_with_rejection();
extern void cur_unset_with_rejection();
extern void cur_set_daemon_port();
extern EIF_INTEGER cur_port_of_local_server();

extern void separate_call();

#ifdef DELETE_SEP_OBJ
/* From "sep_obj.c" */
extern EIF_REFERENCE sep_obj_create();
extern void sep_obj_make(EIF_REFERENCE s_obj, EIF_INTEGER haddr, EIF_INTEGER port, EIF_INTEGER oid);
extern void sep_obj_dispose(char *obj);
#endif


extern char *error_info();
extern void print_server_list() ;
extern void print_ref_table_and_exported_object();

extern void get_call_stack();

extern EIF_INTEGER get_pattern_id(struct ctable *ct, char *key);

#ifdef EIF_WIN32
/* For debuging */
extern void disp_info(char *, char *, long);
#endif

#endif
