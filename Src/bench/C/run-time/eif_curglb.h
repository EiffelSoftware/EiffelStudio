/****************************************************************

                  I M P O R T A N T    N O T I C E
                  --------------------------------

    The include file is and only is included once by an application,
because it defines the globals used by concurrent run-time.
At present, we let "server.c" in concurrency include it. So no other
file can include the head files again.

****************************************************************/ 

#ifndef _CONCURRENT_GLOBALS_
#define _CONCURRENT_GLOBALS_

/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

/*     The file defines the global variables and the feature of 
 * functions used by Concurrency Eiffel. 
 *     It should be included only once(we may include it in "emain.c"
 * generated for an application).
*/

#include "eif_net.h"
#include "eif_constant.h"

#ifdef __cplusplus
extern "C" {
#endif
	
/*----------------------------------------------------*/
/* The following variables are used for communication */
/*----------------------------------------------------*/

EIF_INTEGER _concur_command=0;
EIF_INTEGER _concur_command_oid=0;
EIF_INTEGER _concur_command_ack=0;
EIF_INTEGER _concur_para_num=0;
char _concur_command_class[constant_max_class_name_len+1];
char _concur_command_feature[constant_max_feature_name_len+1];
PARAMETER *_concur_paras=NULL;
int _concur_paras_size=0;

#ifdef COMBINE_CREATION_WITH_INIT
PARAMETER *_concur_alt_paras=NULL;
int _concur_alt_paras_size=0;
EIF_INTEGER _concur_alt_para_num=0;
#endif

/*---------------------------------------------------------------------------*/
/* The following variables are used to keep the information of the PROCESSOR */
/*---------------------------------------------------------------------------*/

/* from SERVER */
char _concur_hostname[constant_max_host_name_len+1];
EIF_INTEGER _concur_hostaddr;
EIF_INTEGER _concur_pid=0;
EIF_INTEGER _concur_sock=-1;

/* for "client_list"  */
CLIENT *_concur_current_client=NULL;
CLIENT *_concur_cli_list=NULL;
CLIENT *_concur_end_of_cli_list=NULL;
EIF_INTEGER _concur_cli_list_count=0;

/* for "server_list"  */
SERVER *_concur_ser_list=NULL;
SERVER *_concur_end_of_ser_list=NULL;
EIF_INTEGER _concur_ser_list_count=0;

/* from CHILD_LIST for "child_list"  */
PARENT *_concur_parent=NULL;
CHILD *_concur_child_list=NULL;
CHILD *_concur_end_of_child_list=NULL;
EIF_INTEGER _concur_child_list_count=0;
char _concur_class_name_of_root_obj[constant_max_class_name_len+1];

/* for "req_list" */
/*
REQUEST *_concur_req_list=NULL;
REQUEST *_concur_end_of_req_list=NULL;
EIF_INTEGER _concur_req_list_count=0;
*/

/* from REF_TABLE  */
REF_TABLE_NODE *_concur_ref_table=NULL;
int _concur_ref_table_size=0;
EXPORTED_OBJ_LIST_NODE *_concur_exported_obj_list=NULL;
IMPORTED_OBJ_TABLE_NODE *_concur_imported_obj_tab=NULL;

/* for SEP_OBJ */
extern void c_send_unregister_request();

/* Not used now  */
EIF_INTEGER _concur_obj_type;


/*--------------------------------------*/
/* The following miscelleous variables  */
/*--------------------------------------*/

char _concur_user_name[constant_max_user_name_len+1];
char _concur_command_text[constant_max_command_text+1];
char _concur_options;
EIF_INTEGER _concur_waiting_time_of_rspf;
EIF_INTEGER _concur_waiting_time_of_cspf;


/*---------------------------------------------------------*/
/* The following variables are used as temporary variables */
/*---------------------------------------------------------*/

char _concur_class_name_of_root_obj[constant_max_class_name_len+1];
EIF_BOOLEAN _concur_terminatable;
EIF_BOOLEAN _concur_exception_has_happened;
EIF_OBJECT _concur_temp_sep_obj;
DAEMON  *_concur_scoop_dog;
EIF_INTEGER _concur_scoop_dog_port = constant_scoop_dog_port;



/*---------------------------------------------------------*/
/* The following variables are used in CONCURRENCY.C       */
/*---------------------------------------------------------*/

REMOTE_SERVER *_concur_rem_sers;

RESOURCE_LEVEL *_concur_host_groups;
RESOURCE_LEVEL *_concur_end_of_host_groups;

EIF_INTEGER _concur_resource_count;

EIF_INTEGER _concur_default_port;
EIF_INTEGER _concur_default_instance;

RESOURCE *_concur_host_index;
RESOURCE_LEVEL *_concur_group_index;
char *_concur_dispatched_host = NULL;
char *_concur_dispatched_directory = NULL;
char *_concur_dispatched_executable = NULL;
char _concur_executable[constant_max_directory_len+1];

/*---------------------------------------------------------*/
/* The following variables are used in SUBS.c              */
/*---------------------------------------------------------*/

EIF_INTEGER c_cmd, c_para_num, c_oid, c_ack;
char c_class[constant_max_class_name_len+1];
char c_feature[constant_max_feature_name_len+1];

char _concur_current_dir[constant_max_directory_len+1];

EIF_BOOLEAN _concur_server_list_released;
EIF_BOOLEAN _concur_current_client_reserved;

struct sockaddr_in _concur_caddr, _concur_saddr;
char *_concur_buffer = NULL;
int  _concur_buffer_len = 0;

char  _concur_crash_info[constant_crash_info_len];
#ifdef GC_ON_CPU_TIME
double  _concur_begin_tms;
#else
Timeval  _concur_begin_tms;
#endif

char _concur_error_msg[constant_errno_text_len+1];

char _concur_root_of_the_application=1;

char _concur_is_creating_sep_child = 0;
char _concur_invariant_checked = 1;

CONCUR_RESC_DECLARE;
int _concur_sys_mask = constant_invalid_signal_mask;

MY_STRING _concur_call_stack;

/*---------------------------------------------------------*/
/* The following are variables used for POLLing mechanism  */
/*---------------------------------------------------------*/

fd_set _concur_mask;
MASK_LIMIT _concur_mask_limit;

CLIENT *_concur_blk_cli_list = NULL;
CLIENT *_concur_end_of_blk_cli_list = NULL;
EIF_INTEGER _concur_blk_cli_list_count = 0;

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
