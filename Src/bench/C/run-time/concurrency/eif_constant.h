
/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#ifndef _CONCURRENT_CONSTANT_
#define _CONCURRENT_CONSTANT_

#define DELETE_SEP_OBJ

#define tDISP_LIST
/* if you want to display some run time information, such as
 * the contents in server list, 
 * client list, child list, exported object list, reference table 
 * and imported object table, define DISP_LIST, otherwise undefine it.
*/

#define tDISP_MSG
/* if you want to display the REQUESTs communicated, 
 * define DISP_MSG, otherwise undefine it.
*/

#define tSIGNAL
/* if you want to use our own mechanism to display error message of
 * concurrent applications, defines SIGNAL, otherwise undefine it.
*/

#define tGC_ON_CPU_TIME
/* Concurrent Eiffel call GC once after a certain period. If we 
 * want the period is calculated based on CPU time, define the symbol,
 * otherwise, undefine it.
*/

#ifdef EIF_WIN32
#include <winsock.h>
#else
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <string.h>
#include <pwd.h>
#include <signal.h>
#include <sys/times.h>
#endif
                                  
#include <setjmp.h>
#include "eif_plug.h"
#include "eif_concurnet.h"
#include "eif_curerrmsg.h"
#include "eif_cecil.h"
#include "eif_hector.h"
#include "eif_macros.h"
#include "eif_object_id.h"
#include "eif_timer.h"

#ifdef __cplusplus
extern "C" {
#endif
		
/*----------------------------------------------------------*/
/*    CONSTANTS used only in SUBS.c                         */
/*----------------------------------------------------------*/

#define BUFFSIZE    2048
#define DATA_SIZE   sizeof(long)
#define CODE_SIZE   sizeof(long)
#define OP_SIZE     DATA_SIZE + CODE_SIZE
#define BOOL_SIZE       sizeof(EIF_INTEGER)
#define INT_SIZE        sizeof(EIF_INTEGER)
#define SIZEOFINT       sizeof(EIF_INTEGER)
#define SIZEOF2INT      sizeof(EIF_INTEGER) + sizeof(EIF_INTEGER)


/*----------------------------------------------------------*/
/*    The following define DATA TYPEs                       */
/*----------------------------------------------------------*/

/*
typedef long            EIF_INTEGER;
typedef unsigned char   EIF_CHARACTER;
typedef float           EIF_REAL;
typedef double          EIF_DOUBLE;
typedef char *          EIF_REFERENCE;
typedef char *          EIF_POINTER;
typedef unsigned char   EIF_BOOLEAN;
*/


/*----------------------------------------------------------*/
/*    The following define DATA TYPE CODEs                  */
/*----------------------------------------------------------*/

#define	Unknown_type		-1
#define	Pointer_type		0
#define	Reference_type		1
#define	Character_type		2
#define	Boolean_type		3
#define	Integer_type		4
#define	Real_type			5
#define	Double_type			6
#define	Expanded_type		7
#define	Bit_type			8
#define	String_type			101
#define	Local_reference		102
#define	Separate_reference	103
#define	Expanded_object		104

/*----------------------------------------------------------*/
/*    The following define DATA LENGTHes                    */
/*----------------------------------------------------------*/

#define constant_command_buffer_len		1024 /* buffer length for sending command */
#define constant_crash_info_len 		1024 /* buffer length for crash info */
#define constant_size_of_data_buf 		1024 /* data buffer length in con_make */
#define constant_size_of_line_buf 		1024 /* line buffer length in con_make */
#define constant_max_len_of_int_in_str 	30
#define constant_max_server_name_len 	50
#define constant_max_level_name_len 	50
#define constant_max_host_name_len 		100
#define constant_max_user_name_len		50
#define constant_max_class_name_len     80
#define constant_max_feature_name_len   80
#define constant_max_directory_len		200
#define constant_max_executable_len		50
#define constant_max_ref_table_size		200 /* not used any more. Now use list */
#define constant_max_command_text  		100
#define constant_errno_text_len    		100
#define constant_min_str_len       		11
#define constant_idx_length				100
#define constant_sizeofint				sizeof(EIF_INTEGER)
#define constant_sizeofreal				sizeof(EIF_REAL)
#define constant_sizeofdouble			sizeof(EIF_DOUBLE)
#define constant_sizeofpointer			sizeof(EIF_POINTER)


#define constant_max_number_of_sep_paras	10 /* the constant is used by the
												* interpreter of Concurrent Eiffel.
											   */

/*----------------------------------------------------------*/
/*    The following define COMMAND(REQUEST) CODEs           */
/*----------------------------------------------------------*/

#define	constant_reserve						-100
#define	constant_reserve_ack					-101
#define	constant_reserve_fail					-102
#define	constant_register_first_from_parent		-300
#define	constant_register						-301
#define	constant_register_ack					-302
#define	constant_register_ack_with_root_oid		-312 
/* ack for a register from a "remote client". */
#define	constant_unregister						-303
#define	constant_release						-304
#define	constant_query_result					-305
#define	constant_ack_for_procedure				-306
#define	constant_middle_result_of_importation	-307 /* Not used */
#define	constant_create_sep_obj					-601
#define	constant_end_of_request					-1
#define	constant_not_defined					-500
#define	constant_sep_child						-501 
/* the request should be removed, only `constant_sep_child_info' is enough! */
#define	constant_sep_child_info					-502
#define	constant_creation_feature_parameter     -503
#define	constant_message_ack					-700
#define	constant_query_result_ack				-701
/* Only Application command can have non-negative request code;
 * all system command must have negative request code.
 */
#define	constant_execute_procedure				100
#define	constant_execute_query					101

/*----------------------------------------------------------*/
/*    The following define COMMAND CODEs used in processing */
/* run-time errors.                                         */
/*----------------------------------------------------------*/

#define	constant_report_error					-1001
#define	constant_stop_execution					-1002
#define	constant_exit_ok						-1003
#define	constant_start_sep_obj_ok				-1004

/*----------------------------------------------------------*/
/*    The following define flags for Application Commands.  */
/*  In fact, they can be combined with the existing 2       */
/*  application commands. They are here only because that   */
/*  we don't want the hassels of modifying the existing     */
/*  run-time and Eiffel classes.                            */
/*----------------------------------------------------------*/
#define	constant_procedure_without_ack			0
#define	constant_procedure_with_ack				1
#define	constant_query							2
#define	constant_attribute						3
#define	constant_deep_import					4

/*----------------------------------------------------------*/
/*    The following define exception constants              */
/*----------------------------------------------------------*/

#define exception_configure_file_not_exist		1
#define exception_configure_syntax_error  		2
#define exception_unexpected_request			3
#define exception_fail_creating_sep_obj 		4
#define exception_network_connection_crash		5
#define exception_implementation_error   		6 
#define exception_invalid_parameter      		7 
#define exception_cant_set_up_connection		8
#define exception_out_of_memory         		9
#define exception_invalid_separate_object 		10
#define exception_void_separate_object  		11

#define CONCURRENT_CRASH        -101 
/* the Eiffel exception type raised by Concurrency-Library. */

/*----------------------------------------------------------*/
/*    The following define miscellaneous constants          */
/*----------------------------------------------------------*/

#define	constant_release_one					1
#define	constant_release_all					1000
#define	constant_int_val_of_bool_true			1
#define	constant_int_val_of_bool_false			0
#define	constant_max_para_num					100
#define	constant_min_port						5000
#define	constant_max_port						9999
#define	constant_port_model						1000
#define	constant_port_skip						13
#define	constant_remote_server					-1000
#define	constant_remote_client					-1001
#define	constant_normal_client					0
#define constant_scoop_dog_port                 8000
#define	constant_parent_type					-1
#define	constant_root_oid						0 /* any object's OID can't be 0 */ 		
#define	constant_scoop_dog_data_type			-1
#define	constant_scoop_dog_oid					-1
#define	constant_import_separate_object			10
#define	constant_cpu_period						1000		
#define	constant_absolute_period				10000		
/* the period to call "full_collect" to collect discarded SEP_OBJ
 * proxies.
*/
/* if the period is calculated in the application's cpu time, don't set 
 * it too big. The unit of the constant: Macro-Second(0.001 second).
*/
#ifdef GC_ON_CPU_TIME 
#define	constant_period							10*constant_cpu_period		
#else
#define	constant_period							constant_absolute_period		
#endif
#define constant_waiting_time_in_precondition	80000
#define constant_waiting_time_in_reservation	((_concur_pid % 2) * 10000 + (_concur_pid % 10) * 4000)
/* unit: Micro second (0.000001 second) */
#define	constant_client							0 /* Not Used anymore */
#define	constant_parent							1 /* Not Used anymore */
#define	constant_child							2 /* Not Used anymore */

#define	constant_retry_times_for_client			1 
/* the number of times of trying to connect with a server .  */
/* If you want to retry(after time out) until the connection */
/* with the server is set up, define the constant to be -1   */

#define constant_creation_flag					"creation"
#define constant_init_flag						"init"
#define constant_invalid_signal_mask    		-1
/* the constant defines a invalid signal mask */

#define constant_memory_increment 				1024	
/* the increment amount of memory allocated to MY_STRING */

#define constant_alive_socket					-100
/* The socket is logically openned but physically closed in order 
 * to reduce the number of sockets consumed by the application.
 */

/* Now, we define a SEP_OBJ's data as:
 *      EIF_INTEGER sep_obj[constant_sep_obj_size]
 * where
 *     sep_obj[0] -- Host's IP Address
 *     sep_obj[1] -- Port Number Corresponding to the Separate Object
 *     sep_obj[2] -- Network Connection(Socket) to the Separate Object
 *     sep_obj[3] -- The Separate Object's OID on the corresponding Processor
 *     sep_obj[4] -- The Separate Object's Proxy's OID on the Local Processor
 *
 */

#ifdef DELETE_SEP_OBJ
#define constant_sep_obj_size   5
 
#define set_host_port(obj, host, port)  \
            ((EIF_INTEGER *)(obj))[0] = host; \
            ((EIF_INTEGER *)(obj))[1] = port
#define set_oid(obj, oid)   ((EIF_INTEGER *)(obj))[3] = oid
#define set_sock(obj, sock) ((EIF_INTEGER *)(obj))[2] = sock
#define set_proxy_id(obj, proxy_id) ((EIF_INTEGER *)(obj))[4] = proxy_id
 
#define sep_obj_host(obj)       ((EIF_INTEGER *)(obj))[0]
#define sep_obj_port(obj)       ((EIF_INTEGER *)(obj))[1]
#define sep_obj_sock(obj)       ((EIF_INTEGER *)(obj))[2]
#define sep_obj_oid(obj)        ((EIF_INTEGER *)(obj))[3]
#define sep_obj_proxy_id(obj)   ((EIF_INTEGER *)(obj))[4]

/* "x" is direct address */
#define sep_obj_make_without_connection(x, y) \
	set_oid(x, y); \
	set_sock(x, -2)

#endif
 
#define is_sep_obj(ref) _concur_sep_obj_dtype == Dtype(ref)

/*----------------------------------------------------------*/
/*    The following define STRUCTUREs used by the C-library */
/*----------------------------------------------------------*/

typedef struct _request {
EIF_INTEGER command;
EIF_INTEGER command_oid;
EIF_INTEGER command_ack;
EIF_INTEGER para_num;
char command_class[constant_max_class_name_len+1];
char command_feature[constant_max_feature_name_len+1];
/* struct _request *next; */
} REQUEST;

typedef struct _para {
EIF_INTEGER type;
EIF_INTEGER str_len; 
/* the length of the buffer for STRING value. */
EIF_POINTER str_val;
/* the buffer for the string value */
/* NULL string value is represented in the following way: */
/*         type = String_type and str_len < 0             */
union {
EIF_POINTER	pointer_val;
EIF_INTEGER int_val;
EIF_REAL	real_val;
EIF_DOUBLE	double_val;
EIF_BOOLEAN bool_val;
EIF_REFERENCE s_obj;
EIF_REFERENCE obj_ref;
} uval;
} PARAMETER; /* the node's structure for the parameter array */

typedef struct _p {
/* char hostname[constant_max_host_name_len+1];*/
EIF_INTEGER hostaddr;
int pid;
int sock;  /* it can be -2 if the node is a SERVER and represents the 
			* local processor itself.
		 	*/
int count; /* For CLIENT: 
			* it represents the number of objects in the local processor which 
			* are referred by the processor identified by <hostaddr, pid>,
			* i.e, the number of PROXIES in the processor identified by
			* <hostaddr, pid> referring to the current processor.
			* For SERVER:
			* it represents the number of objects imported to the 
			* local processor from the processor identified by 
			* <hostaddr, pid>.
			* For other structure:
			* it does not make sense.
		 	*/
int type; 	/* Valid only for CLIENT. it indicates if the client is 
		     * a REMOTE client or a normal client. 
			*/
REQUEST req_buf; /* Only used by CLIENT: the next unprocessed request. */
int reservation; /* Valid only for CLIENT:
				  * the number of reservations to the separate object. 
				  * when the CLIENT does not reserve the current
				  * processor, it's 0.
				 */
struct _p *next;
} CONNECTION, PARENT, SERVER, CHILD, CLIENT, DAEMON;
/* used to represent "parent", SCOOP daemon and the nodes of "ser_list", 
 * "child_list" and "cli_list".
*/

typedef struct _rln {
int count; /* the number of proxies on the corresponding processor
			* (identified by <hostaddr, pid> in the corresponding
			* REF_TABLE_NODE). In fact, in our implementation, there
			* is only one proxy for each imported object(to keep the
			* semantics of `equal'), so the value should always be 1,
			* other value is invalid.
			*/
EIF_INTEGER oid;	/* the OID of the local exported object in
					 * "object_id_stack".
					*/
struct _rln *next;
} REF_LIST_NODE;

typedef struct _rtn {
/*char hostname[constant_max_host_name_len+1];*/
EIF_INTEGER hostaddr;
int pid;
REF_LIST_NODE *ref_list; 	/* the list of local objects exported to 
						 	 * the processor identified by <hostaddr, pid>
							*/
struct _rtn *next;
} REF_TABLE_NODE;

typedef struct _eoln {
EIF_INTEGER oid;
int count; /* the number of processors to which the corresponding object
			* (identified by `oid') is exported.
			*/
/*EIF_REFERENCE root;*/ /* indirect address of the object which has been protected */
int pending; /* the number of pending references(not REGISTERed yet). 
			  * Whenever a REGISTER request comes, its value must be
			  * greater than 0. At the end of an atomic application
			  * operation, it can be 0 or greater than 0(which happens
			  * in the following cases: 
			  * 1) the object is exported to the local processor itself;
			  * 2) the object has been exported more than once to another
			  * processor.
			  * In such case, we will clean up it when perform
			  * END_OF_REQUEST request.
			  * **** NO USE AT PRESENT: because all exported objects will
			  * be REGISTERED by the refering processor in the same 
			  * application operation(of the referring processor) or has
			  * been REGISTERed before.
			 */
struct _eoln *next;
} EXPORTED_OBJ_LIST_NODE;

typedef struct _pln {
EIF_INTEGER oid;		/* the object's OID represented by the separate
						 * object proxy.
						*/
EIF_INTEGER proxy_id;	/* the OID of the separate object proxy in 
						 * "object_id_stack".
						*/
struct _pln *next;
} PROXY_LIST_NODE;

typedef struct _ioln {
/*char hostname[constant_max_host_name_len+1];*/
EIF_INTEGER hostaddr;
EIF_INTEGER pid;
PROXY_LIST_NODE *list_root; /* list of imported objects from the indicated 
							 * processor 
							*/
struct _ioln *next;
} IMPORTED_OBJ_TABLE_NODE;


typedef struct _rs {
char name[constant_max_server_name_len+1];
char host[constant_max_host_name_len+1];
EIF_INTEGER port;
struct _rs *next;
} REMOTE_SERVER;

typedef struct _net_res {
char host[constant_max_host_name_len+1];
EIF_INTEGER capability;
char directory[constant_max_directory_len+1];
char executable[constant_max_executable_len+1];
struct _net_res  *next;
} RESOURCE;

typedef struct _rl {
char name[constant_max_level_name_len+1];
RESOURCE *host_list;
RESOURCE *end_of_host_list;
struct _rl *next;
} RESOURCE_LEVEL;

typedef struct _my_string {
    char *info; /* points to the area where the string is stored. */
    long used;  /* the length of the actual stored string.        */
    long size;  /* the total length of the area */
} MY_STRING ;

typedef struct _select_mask {
int low; /* the smallest socket identifier in the corresponding `fd_set' */
int up;  /* the biggest socket identifier in the corresponding `fd_set' */
} MASK_LIMIT; /* a struct used to specify the limits of a `fd_set' */

/*----------------------------------------------------------*/
/*    The following define MACROs used by the C-library     */
/*----------------------------------------------------------*/

#define init_string(s) s->used = 0

#define def_resc()	default_rescue()

#define valuable_line(x) ((int)(strlen(x))>=2 && !((x)[0]=='-' && (x)[1]=='-'))

#define valid_memory(x) \
	if ((x) == NULL) {\
		if (strlen(_concur_crash_info))\
			strcat(_concur_crash_info, "\n");\
		sprintf(_concur_crash_info, CURIMPERR15, error_info()); \
		c_raise_concur_exception(exception_out_of_memory); \
	}

#define add_nl {\
	if (strlen(_concur_crash_info)) \
		strcat(_concur_crash_info, "\n");\
}

#define crash_info _concur_crash_info+strlen(_concur_crash_info)

#define get_cmd_data(x) \
	get_command(x); \
	if (_concur_para_num) \
		get_data(x)

#define directly_get_cmd_data(x) \
	directly_get_command(x); \
	if (_concur_para_num) \
		get_data(x)

#define adjust_parameter_array(size) _concur_paras_size = adjust_array(&_concur_paras, _concur_paras_size, size)

#ifndef DELETE_SEP_OBJ
#define hostaddr_of_sep_obj(x) eif_field(x, "hostaddr", EIF_INTEGER)
#define pid_of_sep_obj(x) eif_field(x, "pid", EIF_INTEGER)
#define sock_of_sep_obj(x) eif_field(x, "sock", EIF_INTEGER)
#define oid_of_sep_obj(x) eif_field(x, "oid", EIF_INTEGER)
#define on_same_processor(s1, s2) \
	hostaddr_of_sep_obj(s1) == hostaddr_of_sep_obj(s2) && pid_of_sep_obj(s1) == pid_of_sep_obj(s2)
#else
#define hostaddr_of_sep_obj(x) sep_obj_host(x)
#define pid_of_sep_obj(x) sep_obj_port(x)
#define sock_of_sep_obj(x) sep_obj_sock(x)
#define oid_of_sep_obj(x) sep_obj_oid(x)
#define on_same_processor(s1, s2) \
	hostaddr_of_sep_obj(s1) == hostaddr_of_sep_obj(s2) && pid_of_sep_obj(s1) == pid_of_sep_obj(s2)
#endif

#define CONCUR_RESC_DECLARE jmp_buf _concur_exenv1, _concur_exenv2, _concur_exenv3, _concur_exenv4
#define CONCUR_RESC_START1 start: if (setjmp(_concur_exenv1)) goto rescue
#define CONCUR_RESC_START2 start: if (setjmp(_concur_exenv2)) goto rescue
#define CONCUR_RESC_START3 start: if (setjmp(_concur_exenv3)) goto rescue
#define CONCUR_RESC_START4 start: if (setjmp(_concur_exenv4)) goto rescue
#define CONCUR_RESC_RETRY goto start 
#define CONCUR_RESC_FIRE1  longjmp(_concur_exenv1, 1)
#define CONCUR_RESC_FIRE2  longjmp(_concur_exenv2, 1)
#define CONCUR_RESC_FIRE3  longjmp(_concur_exenv3, 1)
#define CONCUR_RESC_FIRE4  longjmp(_concur_exenv4, 1)


#define set_mask(fd) \
	if (fd>0) { \
		FD_SET(fd, &_concur_mask); \
		if (fd < _concur_mask_limit.low) \
			_concur_mask_limit.low = fd; \
		if (fd > _concur_mask_limit.up) \
			_concur_mask_limit.up = fd; \
	}

#define unset_mask(fd) \
	if (fd>0) { \
		FD_CLR(fd, &_concur_mask); \
		if (fd == _concur_mask_limit.low) \
			_concur_mask_limit.low = fd + 1; \
		if (fd == _concur_mask_limit.up) \
			_concur_mask_limit.up = fd - 1; \
	}

#define init_options \
	_concur_options = 0x80
/* Initially, "with rejection" is set */

#define set_with_rejection \
	_concur_options = _concur_options | 0x80

#define unset_with_rejection \
	_concur_options = _concur_options & 0x7f

#define is_with_rejection \
	_concur_options & 0x80

/* The following macros are used to
 * process REAL/DOUBLE between different platforms. We change all formats
 * into UNIX format. Because Eiffel run-time does not distinguish Linux
 * from Unix, we have to use "ntohl" to distinguish them in the
 * functions instead of defining different macros.
 */
 
#define ise_ntohf(x)    change_float_order(x)
#define ise_htonf(x)    change_float_order(x)
#define ise_ntohd(x)    change_double_order(x)
#define ise_htond(x)    change_double_order(x)


/*----------------------------------------------------------*/
/* The following MACROs are defined for Concurrent Compiler */
/*----------------------------------------------------------*/

/* CURIS initialize the local server. "config" is the
 *        configure file's name, "cur" is the container of the
 *        root object on the processor.
 * CURCCI(class, feature)  initialize for creating separate child 
 *        object.  "class" is the new
 *        separate object's class name, "feature" is the creation feature's
 *        name, "file" is the name of executable file to be run by daemon 
 *        to create the separate processor.
 * CURPCP(para_nb) put the actual parameters of the creation feature to
 *        the ALTERNATIVE parameter array. The parameters will be
 *        transferred to another processor to create a separate
 *        object.
 * CURCC(child) create a separate child. "child" is the place holding the
 *		  current object in "loc_set"(e.g, l[1]).
 * CURISO(ret, sep_obj, class) import a separate object and return
 *        the result to "ret". 
 * CURISOF(ret, sep_obj, field, class) import a separate object("sep_obj")'s 
 *        a field("field") and return the result to "ret". "class" is the
 *        class name of "sep_obj".
 * CURPSO(sep_obj, start) put a separate object "sep_obj" into the 
 *        cell of the parameter array indexed by "start".
 * CURPI(i_val, start) put an integer "i_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPR(r_val, start) put a real "r_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPD(d_val, start) put a double "d_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPS(s_val, start) put a string "s_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPC(c_val, start) put a character "c_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPB(b_val, start) put a boolean "b_val" into the cell of the parameter 
 *       array indexed by "start".
 * CURPO(exp_obj, start) put a Complex EXPANDED object "exp_obj" into the 
 *       cell of the  parameter array indexed by "start".
 * CURPP(ptr, start) put a POINTER into the cell of the parameter array indexed by "start".
 * CURGI(x) get the INTEHER stored in cell "x" of the parameter array.
 * CURGR(x) get the REAL    stored in cell "x" of the parameter array.
 * CURGD(x) get the DOUBLE  stored in cell "x" of the parameter array.
 * CURGB(x) get the BOOLEAN stored in cell "x" of the parameter array.
 * CURGSO(x) get the Separate Object stored in cell "x" of the parameter array.
 * CURGC(x) get the CHARACTER stored in cell "x" of the parameter array.
 * CURGS(x) get the STRING stored in cell "x" of the parameter array.
 * CURGO(x) get a reference to an object stored in cell "x" of the parameter array.
 * CURGP(x) get a POINTER stored in cell "x" of the parameter array.
 * CURSQRP(val) send back POINTER query result.
 * CURSQRI(val) send back INTEGER query result.
 * CURSQRR(val) send back REAL    query result.
 * CURSQRD(val) send back DOUBLE  query result.
 * CURSQRB(val) send back BOOLEAN query result.
 * CURSQRC(val) send back CHAR    query result.
 * CURSQRS(val) send back STRING  query result.
 * CURSQRSO(val) send back SEPARATE REFERENCE query result.
 * CURSQRO(val) send back COMPLEX Expanded Object query result.
 * CURRTLO(obj, ret) return a SEP_OBJ proxy(to "ret") for a local object
 *       "obj".
 * CUROBJ	get the object's address whose OID is stored in _concur_command_oid.
 * CURPROXY_OBJ(x)  get the object's address whose OID is stored in proxy "x".
 * CURLTS(loc_obj)  create a separate object proxy for a local object.
 * CURSARI(cmd, o_id, acknowledge, cls, fet, para_nb) initialization for a separate
 *		access request. 
 * CURSG(s_obj)	send command to "s_obj" and try to get a command from "s_obj".
 * CURSSRI(cmd, para_nb) initialization for sending a system request.
 * CURSPA(sock)  send procedure acknowledgement.
 * CURRSFW	whenever the Reservation Separate object Failed(rejected), Wait some time.
 *			Try again when wake up. 
 */ 

#define CURIS \
	strcpy(_concur_executable, argv[0]); \
	if (_concur_root_of_the_application) { \
		make_server(); \
		strcpy(_concur_class_name_of_root_obj, eifname(Dtype(root_obj))); \
	} \
	else { \
/* #ifdef COMBINE_CREATION_WITH_INIT \
		PARAMETER *tmp_paras; \
        EIF_INTEGER tmp_paras_size, tmp_para_num; \
#endif  */\
 \
        _concur_command = 0; \
        strcpy(_concur_class_name_of_root_obj, argv[4]); \
        send_signal_to_scoop_dog(atoi(argv[6])); \
 \
        _concur_parent = setup_connection(atoi(argv[2]), atoi(argv[3])); \
 \
		make_server(); \
 \
        _concur_command = constant_sep_child; \
        _concur_para_num = 0; \
        send_command(_concur_parent->sock); \
/* #ifdef COMBINE_CREATION_WITH_INIT \
		get_cmd_data(_concur_parent->sock); \
 \
		tmp_paras = _concur_paras; \
		tmp_paras_size = _concur_paras_size; \
		tmp_para_num = _concur_para_num; \
		_concur_paras = NULL; \
		_concur_paras_size = 0; \
#endif */\
 \
        tell_parent_info_of_myself(argv[2], atoi(argv[3])); \
 \
/* #ifdef COMBINE_CREATION_WITH_INIT \
		free_parameter_array(_concur_paras, _concur_paras_size); \
		_concur_paras = tmp_paras; \
		_concur_paras_size = tmp_paras_size; \
		_concur_para_num = tmp_para_num; \
#endif */\
	}


	
#define CURCCI(class,feature) \
		_concur_is_creating_sep_child = 1; \
		if (!_concur_host_index) { \
			sprintf(_concur_crash_info, CURAPPERR43); \
			c_raise_concur_exception(exception_configure_syntax_error); \
		};  \
		sprintf(_concur_crash_info, CURERR9, _concur_host_index->host, _concur_scoop_dog_port); \
		_concur_scoop_dog = setup_connection(c_get_addr_from_name(dispatch_to()), _concur_scoop_dog_port); \
		_concur_crash_info[0] = '\0'; \
        _concur_command = constant_create_sep_obj; \
        _concur_para_num = 7; \
        adjust_parameter_array(_concur_para_num); \
\
        _concur_paras[0].type = Integer_type; \
        _concur_paras[0].uval.int_val = _concur_hostaddr; \
\
        _concur_paras[1].type = Integer_type; \
        _concur_paras[1].uval.int_val = _concur_pid; \
\
        _concur_paras[2].type = String_type; \
		set_str_val_into_parameter(_concur_paras+2, class); \
\
        _concur_paras[3].type = String_type; \
		set_str_val_into_parameter(_concur_paras+3, feature); \
\
        _concur_paras[4].type = String_type; \
		set_str_val_into_parameter(_concur_paras+4, _concur_dispatched_directory); \
\
        _concur_paras[5].type = String_type; \
		set_str_val_into_parameter(_concur_paras+5, _concur_dispatched_executable); \
\
        _concur_paras[6].type = String_type; \
		set_str_val_into_parameter(_concur_paras+6, _concur_user_name)

#define CURPCP(para_nb) \
        _concur_alt_para_num = para_nb; \
		_concur_alt_paras_size = adjust_array(&_concur_alt_paras, _concur_alt_paras_size, _concur_alt_para_num)

#define CURCC(child) \
	sprintf(_concur_crash_info, CURERR11, _concur_dispatched_host); \
	send_command(_concur_scoop_dog->sock);\
	sprintf(_concur_crash_info, CURERR12, _concur_dispatched_host); \
	wait_scoop_daemon(); \
	_concur_crash_info[0] = '\0'; \
	child = create_child(); \
	wait_sep_child_obj(child); \
	_concur_is_creating_sep_child = 0

#define CURISS(ret, sep_str, class) \
    if (on_local_processor(sep_str)) \
        ret = clone(eif_separate_id_object(oid_of_sep_obj(sep_str))); \
    else { \
        _concur_command = constant_execute_query; \
        _concur_command_oid = oid_of_sep_obj(sep_str); \
        _concur_command_ack = constant_import_separate_object; \
        strcpy(_concur_command_class, class); \
        _concur_command_feature[0] = '\0'; \
        _concur_para_num = 0; \
        send_command(sock_of_sep_obj(sep_str)); \
        get_cmd_data(sock_of_sep_obj(sep_str)); \
        ret = RTMS(_concur_paras[0].str_val); \
    }

#define CURISSF(ret, s_obj, fld, cls) \
    if (on_local_processor(sep_str)) \
        ret = clone("the field" of eif_separate_id_object(oid_of_sep_obj(s_obj))); \
    else { \
        _concur_command = constant_execute_query; \
        _concur_command_oid = oid_of_sep_obj(s_obj); \
        _concur_command_ack = constant_import_separate_object; \
        strcpy(_concur_command_class, cls); \
        strcpy(_concur_command_feature, field); \
        _concur_para_num = 0; \
        send_command(sock_of_sep_obj(s_obj)); \
        get_cmd_data(sock_of_sep_obj(s_obj)); \
        ret = RTMS(_concur_paras[0].str_val); \
    }

#define CURPI(i_val, start) \
        _concur_paras[start].type = Integer_type; \
        _concur_paras[start].uval.int_val = i_val
	
#define CURPR(r_val, start) \
        _concur_paras[start].type = Real_type; \
        _concur_paras[start].uval.real_val = r_val
	
#define CURPD(d_val, start) \
        _concur_paras[start].type = Double_type; \
        _concur_paras[start].uval.double_val = d_val
	
#define CURPB(b_val, start) \
        _concur_paras[start].type = Boolean_type; \
        _concur_paras[start].uval.bool_val = b_val
	
#define CURPS(s_val, start) \
        _concur_paras[start].type = String_type; \
        set_str_val_into_parameter(_concur_paras+start, s_val)

#define CURPSO(sep_obj, start) \
        _concur_paras[start].type = Separate_reference; \
        _concur_paras[start].uval.s_obj = henter(sep_obj)
	
#define CURPC(c_val, start) \
        _concur_paras[start].type = Character_type; \
		c_class[0] = c_val;\
		c_class[1] = '\0'; \
		/* here, we use global variable as a temporary buffer */ \
        set_str_val_into_parameter(_concur_paras+start, c_class)

#define CURPO(exp_obj, start) \
        _concur_paras[start].type = Expanded_object; \
        _concur_paras[start].uval.obj_ref = henter(exp_obj)

#define CURPP(ptr, start) \
        _concur_paras[start].type = Pointer_type; \
        _concur_paras[start].uval.pointer_val = ptr 

#define CURSSRI(cmd, para_nb) \
		_concur_command = cmd; \
		_concur_para_num = para_nb; \
		adjust_parameter_array(_concur_para_num)

#define CURSARI(cmd, o_id, acknowledge, cls, fet, para_nb) \
		_concur_command = cmd; \
		_concur_command_ack = acknowledge; \
		_concur_command_oid = o_id; \
		strcpy(_concur_command_class, cls); \
		strcpy(_concur_command_feature, fet); \
		_concur_para_num = para_nb; \
		adjust_parameter_array(_concur_para_num)
		
#define CURSQRP(p_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPP(p_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRI(i_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPI(i_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRR(r_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPR(r_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRD(d_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPD(d_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRB(b_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPB(b_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRC(c_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPC(c_val, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRS(s_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPS(s_val, 0); \
		send_command(_concur_current_client->sock)

#define CURSQRO(exp_obj) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPO(exp_obj, 0); \
		send_command(_concur_current_client->sock)
		
#define CURSQRSO(s_val) \
		_concur_command = constant_query_result; \
		_concur_para_num = 1; \
		CURPSO(s_val, 0); \
		send_command(_concur_current_client->sock)

/* "obj" is the direct address of the local object, "ret" is the place in
 * "loc_set" to hold the returned SEP_OBJ proxy.
*/
#define CURRTLO(obj, ret) \
	{ \
		EIF_INTEGER locoid = get_oid_from_address(obj); \
		ret = create_sep_obj(_concur_hostaddr, _concur_pid, locoid); \
	}

#define CURLTS(loc_obj)  create_sep_obj(_concur_hostaddr, _concur_pid,  get_oid_from_address(loc_obj))

#define CURGI(x) _concur_paras[x].uval.int_val
#define CURGR(x) _concur_paras[x].uval.real_val
#define CURGD(x) _concur_paras[x].uval.double_val
#define CURGB(x) _concur_paras[x].uval.bool_val
#define CURGSO(x) eif_wean(_concur_paras[x].uval.s_obj)
/* because the separate object has been protected by "henter" in "get_data()". */
#define CURGC(x) _concur_paras[x].str_val[0]
#define CURGS(x) _concur_paras[x].str_val
#define CURGO(x) eif_wean(_concur_paras[x].uval.obj_ref)
/* because the object reference has been protected by "henter" in "get_data()". */
#define CURGP(x) _concur_paras[x].uval.pointer_val

#define CUROBJ	eif_separate_id_object(_concur_command_oid)

#define CURPROXY_OBJ(x)	eif_separate_id_object(oid_of_sep_obj(x))

#define CURCSPF	goto check_sep_pre
#define CURCSPFW	cur_usleep(_concur_waiting_time_of_cspf)
/* Sleep some time when the precondition involving separate object(s) is evaluated 
 * to be False if user defined so.
 */

#define CURRSFW	cur_usleep(_concur_waiting_time_of_rspf)

		

#define CURSG(s_obj)	\
	send_command(sock_of_sep_obj(s_obj));\
	if (_concur_command_ack != constant_procedure_without_ack) { \
		get_cmd_data(sock_of_sep_obj(s_obj)); \
		if (_concur_command != constant_ack_for_procedure && _concur_command != constant_query_result) { \
			add_nl; \
			sprintf(crash_info, CURIMPERR16, command_text(_concur_command)); \
			c_raise_concur_exception(exception_unexpected_request); \
		} \
	}

#define CURSPA(sock, proc_ack) \
	if (proc_ack == constant_procedure_with_ack) { \
		_concur_command = constant_ack_for_procedure; \
		_concur_para_num = 0; \
		send_command(sock); \
	}

/* CURDSFC 	defines a local variable for a feature to indicate if a
 *	separate feature call has been called in the pe-condition testing;
 * CURSFC	access the local variable;
 * CURSSFC	set the local variable;
 * CURCSFC 	clear the local variable.
*/
#define CURDSFC	EIF_BOOLEAN has_called_separate_feature = 0
#define CURSFC	has_called_separate_feature
#define CURSSFC has_called_separate_feature = 1
#define CURCSFC has_called_separate_feature = 0

/* CURRSO(x)	try to reserve separate object `x'.
 * CURFSO(x)	free separate object `x'.
*/
#define CURRSO(x) reserve_sep_obj(x)
#define CURFSO(x) free_sep_obj(x)
			
#ifdef __cplusplus
	}
#endif

#endif
