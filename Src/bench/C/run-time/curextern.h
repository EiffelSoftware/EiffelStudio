#ifndef _CONCURRENT_EXTERN_
#define _CONCURRENT_EXTERN_

/*****************************************************************
    In the C-programs, we use EIF_OBJ and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "constant.h"

/*----------------------------------------------------*/
/* The following variables are used for communication */
/*----------------------------------------------------*/

extern EIF_INTEGER _concur_command;
extern EIF_INTEGER _concur_command_oid;
extern EIF_INTEGER _concur_command_ack;
extern EIF_INTEGER _concur_para_num;
extern char _concur_command_class[constant_max_class_name_len+1];
extern char _concur_command_feature[constant_max_feature_name_len+1];
extern PARAMETER *_concur_paras;
/* parameter array */
extern int _concur_paras_size;
/* the total number of cells in parameter array */

#ifdef COMBINE_CREATION_WITH_INIT
extern PARAMETER *_concur_alt_paras;
extern int _concur_alt_paras_size;
extern EIF_INTEGER _concur_alt_para_num;
#endif

/*---------------------------------------------------------------------------*/
/* The following variables are used to keep the information of the PROCESSOR */
/*---------------------------------------------------------------------------*/

/* from SERVER */
extern char _concur_hostname[constant_max_host_name_len+1];
extern EIF_INTEGER _concur_hostaddr;
extern EIF_INTEGER _concur_pid;
extern EIF_INTEGER _concur_sock;

/* for "client_list"  */
extern CLIENT *_concur_current_client;
extern CLIENT *_concur_cli_list;
extern CLIENT *_concur_end_of_cli_list;
extern EIF_INTEGER _concur_cli_list_count;

/* for "server_list"  */
extern SERVER *_concur_ser_list;
extern SERVER *_concur_end_of_ser_list;
extern EIF_INTEGER _concur_ser_list_count;

/* from CHILD_LIST for "child_list"  */
extern PARENT *_concur_parent;
extern CHILD *_concur_child_list;
extern CHILD *_concur_end_of_child_list;
extern EIF_INTEGER _concur_child_list_count;

/* for "req_list" */
/*
extern REQUEST *_concur_req_list;
extern REQUEST *_concur_end_of_req_list;
extern EIF_INTEGER _concur_req_list_count;
*/

/* for POLLING mechanism */
extern EIF_INTEGER process_exception();
extern EIF_INTEGER has_msg_from_pc();
extern void process_connection();
/* For blocked client list */
extern void add_to_blocked_client_queue();
extern CLIENT *take_head_from_blocked_client_list();
                                           
/* from REF_TABLE  */
extern REF_TABLE_NODE *_concur_ref_table; /* each item in the list is a
processor which has imported objects from the current processor. */
extern int _concur_ref_table_size;
extern EXPORTED_OBJ_LIST_NODE *_concur_exported_obj_list;
extern IMPORTED_OBJ_TABLE_NODE *_concur_imported_obj_tab;

/* for SEP_OBJ */
extern void c_send_unregister_request();

/* Not used now  */
extern EIF_INTEGER _concur_obj_type;


/*--------------------------------------*/
/* The following miscelleous variables  */
/*--------------------------------------*/

extern char _concur_user_name[constant_max_user_name_len+1];
extern char _concur_command_text[constant_max_command_text+1];
extern char _concur_options;
extern EIF_INTEGER _concur_waiting_time_of_rspf;
extern EIF_INTEGER _concur_waiting_time_of_cspf;


/*---------------------------------------------------------*/
/* The following variables are used as temporary variables */
/*---------------------------------------------------------*/

extern char _concur_class_name_of_root_obj[constant_max_class_name_len+1];
extern EIF_BOOLEAN _concur_terminatable;
extern EIF_BOOLEAN _concur_exception_has_happened;
extern EIF_OBJ _concur_temp_sep_obj;
extern DAEMON  *_concur_scoop_dog;
extern EIF_INTEGER _concur_scoop_dog_port;



/*---------------------------------------------------------*/
/* The following variables are used in CONCURRENCY.C       */
/*---------------------------------------------------------*/

extern REMOTE_SERVER *_concur_rem_sers;
extern EIF_INTEGER   _concur_rem_ser_count;
extern EIF_INTEGER   _concur_rem_ser_size;

extern RESOURCE *_concur_hosts;
extern EIF_INTEGER _concur_host_count;
extern EIF_INTEGER _concur_host_size;

extern RESOURCE_LEVEL *_concur_host_levels;
extern EIF_INTEGER _concur_host_level_count;
extern EIF_INTEGER _concur_host_level_size;

extern EIF_INTEGER _concur_resource_index;
extern EIF_INTEGER _concur_resource_count;

extern char *_concur_dispatched_host;
extern char *_concur_dispatched_directory;
extern char *_concur_dispatched_executable;
extern char _concur_executable[constant_max_directory_len+1];

/*---------------------------------------------------------*/
/* The following variables are used in SUBS.c              */
/*---------------------------------------------------------*/

extern EIF_INTEGER c_cmd, c_para_num, c_oid, c_ack;
extern char c_class[constant_max_class_name_len+1];
extern char c_feature[constant_max_feature_name_len+1];

extern char _concur_current_dir[constant_max_directory_len+1];

extern EIF_BOOLEAN _concur_server_list_released;
extern EIF_BOOLEAN _concur_current_client_reserved;

extern struct sockaddr_in _concur_caddr, _concur_saddr;
extern char *_concur_buffer;
extern int  _concur_buffer_len;

extern char  _concur_crash_info[constant_crash_info_len];
#ifdef GC_ON_CPU_TIME
extern double _concur_begin_tms;
#else
extern Timeval _concur_begin_tms;
#endif

extern char _concur_error_msg[constant_errno_text_len+1];

extern char _concur_root_of_the_application;

extern char _concur_is_creating_sep_child;
extern char _concur_invariant_checked;

extern jmp_buf _concur_exenv1;
extern jmp_buf _concur_exenv2;
extern jmp_buf _concur_exenv3;
extern jmp_buf _concur_exenv4;
extern int _concur_sys_mask;

extern MY_STRING _concur_call_stack;

/*---------------------------------------------------------*/
/* The following are variables used in POLLing mechanism   */
/*---------------------------------------------------------*/

extern fd_set _concur_mask;
extern MASK_LIMIT _concur_mask_limit;

extern CLIENT *_concur_blk_cli_list;
extern CLIENT *_concur_end_of_blk_cli_list;
extern EIF_INTEGER _concur_blk_cli_list_count;

/*---------------------------------------------------------*/
/* The following are external variables                    */
/*---------------------------------------------------------*/

extern EIF_FN_POINTER eif_strtoc;
extern char *root_obj;

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
extern void separate_call();

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
extern void reset_by_host();


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
extern void c_process_ser_list_from_sep_obj();
extern void c_raise_concur_exception();
extern void cur_usleep();
extern void cur_set_with_rejection();
extern void cur_unset_with_rejection();
extern void cur_set_daemon_port();




extern char *error_info();
extern void print_server_list() ;
extern void print_ref_table_and_exported_object();

extern void get_call_stack();

#ifdef EIF_WIN32
/* For debuging */
extern void disp_info(char *, char *, long);
#endif

#endif
