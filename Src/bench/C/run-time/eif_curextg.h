#ifndef _CONCURRENT_EXTERN_GLOBALS_
#define _CONCURRENT_EXTERN_GLOBALS_

/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_constant.h"

#ifdef __cplusplus
extern "C" {
#endif

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
extern EIF_OBJECT _concur_temp_sep_obj;
extern DAEMON  *_concur_scoop_dog;
extern EIF_INTEGER _concur_scoop_dog_port;



/*---------------------------------------------------------*/
/* The following variables are used in CONCURRENCY.C       */
/*---------------------------------------------------------*/

extern REMOTE_SERVER *_concur_rem_sers;

extern RESOURCE_LEVEL *_concur_host_groups;
extern RESOURCE_LEVEL *_concur_end_of_host_groups;

extern EIF_INTEGER _concur_resource_count;

EIF_INTEGER _concur_default_port;
EIF_INTEGER _concur_default_instance;

extern RESOURCE *_concur_host_index;
extern RESOURCE_LEVEL *_concur_group_index;
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

RT_LNK char *root_obj;
#ifndef WORKBENCH
extern struct ctable *ce_sep_pat;
#endif
			
#ifdef __cplusplus
}
#endif

#endif
