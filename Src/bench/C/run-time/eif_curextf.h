#ifndef _CONCURRENT_EXTERN_FUNCTIONS_
#define _CONCURRENT_EXTERN_FUNCTIONS_

#ifdef __cplusplus
extern "C" {
#endif
	
/*---------------------------------------------------------*/
/* The following are functions in the concurrent C-library */
/*---------------------------------------------------------*/

/* From parameter.c */
extern EIF_INTEGER adjust_array(PARAMETER **, EIF_INTEGER, EIF_INTEGER);
extern void free_parameter_array(PARAMETER *, EIF_INTEGER);
extern void set_str_val_into_parameter(PARAMETER *, char *);
/*extern EIF_POINTER get_c_format_of_eif_string(); */
/*extern char *eif_str_to_c_str(); */


/* From server.c */
extern void make_server();

/* utilities for client */
extern EIF_BOOLEAN on_local_processor(EIF_OBJ);
extern CONNECTION  *setup_connection(EIF_INTEGER, EIF_INTEGER);
extern EIF_OBJ  create_child();
extern EIF_POINTER  create_sep_obj(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern EIF_POINTER clone_sep_obj_proxy(EIF_OBJ);
extern EIF_BOOLEAN reserve_sep_obj(EIF_OBJ);
extern void free_sep_obj(EIF_OBJ);
extern char *command_text(EIF_INTEGER);
extern char valid_command(EIF_INTEGER);

/* request primitives */
extern void get_command(EIF_INTEGER);
extern void get_data(EIF_INTEGER);
extern void send_register_ack(EIF_INTEGER);
extern void send_command(EIF_INTEGER);

extern void server_execute();

/* utilities for "remote_server" */
extern EIF_OBJ remote_server_by_name(char *);
extern EIF_OBJ remote_server_by_index(EIF_INTEGER);
extern EIF_OBJ remote_server(char *, EIF_INTEGER);

/* utilities for local server */
extern void register_a_ref(EIF_INTEGER, EIF_BOOLEAN);
extern void unregister_from_local_processor(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void unregister(EIF_INTEGER, EIF_INTEGER);
extern void tell_parent_info_of_myself(char *, EIF_INTEGER);
extern void wait_sep_child_obj(EIF_OBJ);
extern void to_register(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);

/* for "cli_list" */
extern void add_to_client_queue(CLIENT *);
extern CLIENT *take_head_from_client_list();
extern void read_from_client_queue();

/* for "ser_list" */
extern EIF_BOOLEAN exist_in_server_list(EIF_INTEGER, int);
extern EIF_INTEGER get_sock_from_server_list(EIF_INTEGER, int);
extern void add_to_server_list(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern SERVER *take_head_from_server_list();
extern void release_server_list();
extern void release_imported_objects();

/* for "child_list" */
extern void add_to_child_list(CHILD *);
extern CHILD *take_head_from_child_list();

/* for displaying RUN-TIME errors */
extern void wait_scoop_daemon();
extern void default_rescue();
extern void print_run_time_error_message();
extern void release_child_list();
extern void release_system_lists_in_rescue();
extern void sig_def_resc(int);
extern void sig_proc_child(int);
extern void sig_sys_list(int);
extern void sig_rels_child(int);
extern void def_res(int);
extern void c_my_concur_put_int(EIF_INTEGER, EIF_INTEGER);
extern void c_my_concur_put_stream(EIF_INTEGER, EIF_POINTER, EIF_INTEGER);
extern void release_exported_objects();

/* for POLLING mechanism */
extern EIF_INTEGER process_exception(fd_set *);
extern EIF_INTEGER has_msg_from_pc();
extern void process_connection();
/* For blocked client list */
extern void add_to_blocked_client_queue(CLIENT *);
extern CLIENT *take_head_from_blocked_client_list();

/* From ref_table.c */
extern EIF_INTEGER c_get_oid_from_addr(); /* NO USE ANY MORE */
extern EIF_INTEGER get_oid_from_address(char *);
extern void change_ref_table_and_exported_obj_list(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern EIF_INTEGER get_proxy_oid_of_imported_object(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void insert_into_imported_object_table(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void c_clear_proxy(); /* NO USE ANY MORE */
extern void cleanup_proxy(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void c_cleanup_proxy(); /* NO USE ANY MORE */
extern char exported_obj_to_processor_before(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void adjust_exported_objects(EIF_INTEGER, EIF_INTEGER);


/* From concurrency.c */
extern void con_make(char *);
extern char read_a_line(int, char *, int *, int, int *, char *);
extern void adjust_a_line(char *, char *);
extern void get_default_values(int, char *, int *, int, int *, char *, char *, char *);
extern void get_remote_servers(int, char *, int *, int, int *, char *, char *, char *);
extern void get_network_resources(int, char *, int *, int, int *, char *, char *, char *);

extern char *dispatch_to();
extern void print_config();
extern void reset_by_host(char *, char *);
extern void reset_by_level(char *gname);
extern void cur_clear_configure_table();
extern void add_group(char *gname);
extern void add_host (char *gname, char *hname, EIF_INTEGER cap, char *dir, char *exe);
extern void change_capacity_of_host(char *gname, char *hname, EIF_INTEGER cap);


/* From "idle.c" */
extern void idle_usage(int, fd_set *, EIF_BOOLEAN);

/* From "stack.c" */
extern void extend_string(MY_STRING *, char *);
extern void extend_string_with_length(MY_STRING *my_s, char *str, long len);


/* From "subs.c" */
extern EIF_INTEGER inttoa(int, char *, int);
extern EIF_INTEGER longtoa(EIF_INTEGER, char *, int);
extern EIF_INTEGER realtoa(float, char *, int);
extern EIF_INTEGER doutoa(EIF_DOUBLE, char *, int);
extern void c_get_host_name();
extern char * c_get_name_from_addr(EIF_INTEGER);
extern EIF_INTEGER c_get_addr_from_name(char *);
extern char *c_get_current_directory();
extern int c_get_pid();
extern void set_block(int);
extern void set_non_block(int);
extern int c_try_to_get_command(long);
extern EIF_INTEGER c_get_command_code();
extern EIF_INTEGER c_get_oid();
extern EIF_INTEGER c_get_ack();
extern char *c_get_class_name();
extern char *c_get_feature_name();
extern EIF_INTEGER c_get_para_num();
extern void c_get_usrname();
extern void send_signal_to_scoop_dog(int);
extern EIF_INTEGER c_concur_bind(long, char *, long);
extern void c_set_current_client_reserved(EIF_BOOLEAN);
extern EIF_INTEGER c_concur_make_client(EIF_INTEGER, EIF_INTEGER);
extern EIF_INTEGER c_concur_make_server(EIF_INTEGER);
extern EIF_INTEGER c_concur_accept(EIF_INTEGER);
extern EIF_POINTER c_concur_read_stream(EIF_INTEGER, EIF_INTEGER);
extern void c_send_default_crash_info(); /* NO USE ANY MORE */
extern void c_reset_timer();
extern EIF_DOUBLE c_wait_time();
extern EIF_BOOLEAN c_wait_long_enough(); /*NO USE ANY MORE */
extern void c_raise_concur_exception(int);
extern void c_process_ser_list_from_sep_obj(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
extern void cur_usleep(EIF_INTEGER);
extern void cur_set_with_rejection();
extern void cur_unset_with_rejection();
extern void cur_set_daemon_port(EIF_INTEGER);
extern EIF_INTEGER cur_port_of_local_server();

extern EIF_OBJ cur_deep_import(EIF_OBJ);

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
			
#ifdef __cplusplus
}
#endif

#endif
