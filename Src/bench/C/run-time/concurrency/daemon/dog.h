/* #define EIF_WIN32 */


/*
#include <stdio.h>
#include <sys/types.h>
#include <errno.h>
#ifdef EIF_WIN32
#define EWOULDBLOCK WSAEWOULDBLOCK
#include <winsock.h>
#else
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <pwd.h>
#include <sys/ioctl.h>
#include <signal.h>
#endif
#include "eif_portable.h"
*/


#include "eif_config.h"
#include <stdio.h>
#include <sys/types.h>
#include <errno.h>
#include <ctype.h>
#include <sys/stat.h>
#include <signal.h>

#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <winsock.h>
#define EWOULDBLOCK WSAEWOULDBLOCK
#define EINPROGRESS WSAEINPROGRESS
#include <stdio.h>
#include "eif_except.h"
#else
#include <pwd.h>
#endif

#include <sys/types.h>
#ifndef EIF_WIN32
#include <sys/time.h>
#endif
#include <errno.h>
#ifndef BSD
#define BSD_COMP
#endif
#ifndef EIF_WIN32
#include <sys/ioctl.h>
#endif
#include "eif_cecil.h"
#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#endif

#ifdef I_FD_SET_SYS_SELECT
#include <sys/select.h>
#endif
#ifdef I_FD_SET_SYS_SELECT
#include <sys/select.h>
#endif

#ifdef I_NETINET_IN
#include <netinet/in.h>
#endif
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#ifndef EIF_WIN32
#include <sys/un.h>
#endif


#define DATA_SIZE   sizeof(EIF_INTEGER)
#define CODE_SIZE   sizeof(EIF_INTEGER)
#define OP_SIZE     DATA_SIZE + CODE_SIZE
#define BOOL_SIZE       sizeof(EIF_INTEGER)
#define INT_SIZE        sizeof(EIF_INTEGER)
#define SIZEOFINT       sizeof(EIF_INTEGER)
#define SIZEOF2INT      sizeof(EIF_INTEGER) + sizeof(EIF_INTEGER)

#define SCOOP_DOG_PORT          8000
#define USERNAME_LEN            100
#define MAX_DESCRIPTOR          100
#define MAX_EXEC_FILE_LEN       200
#define MAX_INT_STR_LEN         40
#define MAX_REAL_STR_LEN        40
#define MAX_DOU_STR_LEN         50
#define STRING_TYPE            101
#define CHARACTER_TYPE          2
#define INTEGER_TYPE            4
#define DOUBLE_TYPE             6
#define REAL_TYPE               5
#define BOOLEAN_TYPE            3
#define DATE_TYPE              11


#define tDISP                   
#define tTESTNAME               
#define DEAD               
/* If you want to get rid of defunct procedure, define DEAD */
#define tWAIT               

#define tTEST                   
/* if want to display some debug information, change the above item into "TEST" */
#define CHK_CHILD                   
/* if want to display some debug information for Eiffel Program , change the above item into "CHK_CHILD" */

#define CREATION_FLAG					"creation"
#define CREATE_SEP_OBJ                  -601
#define REPORT_ERROR                    -1001
#define START_SEP_OBJ_OK                -1004
#define constant_time_of_daemon_waiting_child	30
/* If time out for the period, daemon thinks that the new-created separate
 * object is dead . The time unit: second.
 */


#define HOSTNAME_LEN             50

extern int sock;

extern EIF_INTEGER inttoa(int, char *, int);
extern EIF_INTEGER longtoa(EIF_INTEGER, char *, int);
extern EIF_INTEGER rtoa(EIF_REAL, char *, int);
extern EIF_INTEGER dtoa(EIF_DOUBLE, char *, int);
extern void sig_proc(int);
extern void sig_chld(int);
extern char dog_get_data(int sock, char *buff, EIF_INTEGER *data_length) ;
extern char dog_get_command(int m_sock, EIF_INTEGER *m_code, EIF_INTEGER *m_para_num);
extern char dog_send_command(int m_sock, EIF_INTEGER m_code, EIF_INTEGER m_para_num);
extern char dog_send_data(int m_sock, EIF_INTEGER *type, char *buff, EIF_INTEGER *data_length);


extern char loc[100];

#define dog_get_data_info(m_sock, m_type, m_length) dog_get_command(m_sock, m_type, m_length)
	  
