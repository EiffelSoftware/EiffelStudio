//*
// * description: "Apache module that sends request data to xebra server and receives page to be displayed."
// * date:		"$Date$"
// * revision:	"$Revision$"
// * copyright:	"Copyright (c) 1985-2007, Eiffel Software."
// * license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
// * licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
// * copying: ""
// * source: 	"[
// * 			Eiffel Software
// * 			5949 Hollister Ave #B, Goleta, CA 93117
// * 			Telephone 805-685-1006, Fax 805-685-6869
// * 			Website http://www.eiffel.com
// * 			Customer support http://support.eiffel.com
// * 			]"
// */

#include <stdio.h>
#include <stdlib.h>

#include <httpd.h>
#include <http_log.h>
#include <http_protocol.h>
#include <http_config.h>
#include "apr_strings.h"


//#include <unistd.h>
//#include <errno.h>
//#include <string.h>
//#include <sys/types.h>
#include <winsock2.h>

//#include <signal.h>

//#include <time.h>



#define REVISION "$Revision$"

/*======= Choose debug level here ======= */
#define DO_DEBUG
#define DO_DEBUG2

/*======= DEBUG MACRO ======= */
#ifdef DO_DEBUG
#define DEBUG(...) ap_log_rerror (APLOG_MARK, APLOG_DEBUG, 0, r, __VA_ARGS__);

#ifdef DO_DEBUG2
#define DEBUG2(...) ap_log_rerror (APLOG_MARK, APLOG_DEBUG, 0, r, __VA_ARGS__);
#else
#define DEBUG2(...)
#endif
#else
#define DEBUG(...)
#define DEBUG2(...)
#endif

/*======= SOCKET CONSTANTS =======*/

/* FRAG_SIZE:
*	Determines how large one fragment of the sent and received message should be.
*	Default is 65536. This has to be the same value as on the server.
*/
#define FRAG_SIZE 65536

/*======= PROTOCOL =======*/
/* The following strings represent delimiters for the message string that is sent to the server */

/* Send message */
#define ARG "#A#"

#define HEADERS_IN "#HI#"
#define HEADERS_OUT "#HO#"
#define SUBP_ENV "#SE#"
#define TABLECSEP "#$#"
#define TABLERSEP "#%#"
#define TABLEEND "#E#"

/* Return message */
#define COOKIE_START "#C#"
#define COOKIE_END "#CE"
#define HTML_START "#H#"
#define CONTENT_TYPE_START "#CT#"

/* MAX_POST_SIZE:
*	Defines a max size for reading the POST arguments
*/
#define MAX_POST_SIZE 10000

/*======= HEADERS ENCODING =======*/

#define SET_COOKIE "Set-Cookie"
#define SET_COOKIE2 "Set-Cookie2"
#define DEFAULT_ATTRS "HttpOnly;Version=1"
#define CLEAR_ATTRS "Version=1"
#define COOKIE_LOG_PREFIX "cookie"


/*======= ERROR HANDLING =======*/

#define ERROR_MSG_START "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>Xebra Module - Error Report</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><style type=\"text/css\"><!--body,td,th {	font-family: Geneva, Arial, Helvetica, sans-serif;	font-size: 12px;}h1 {	font-size: 18px;	background-color:#000000;	color: #FFFFFF;}h3 {	font-size: 14px;	background-color:#000000;	color: #FFFFFF;}.em {font-size: 14px;background-color:#000000;color: #FFFFFF;margin-right: 10px;font-weight: bold;}--></style></head><body><h1>Xebra Module - Error Report</h1><hr/><p><span class=\"em\">Message: </span> "

#define ERROR_MSG_END "</p><p><img src=\"http://www.yiyinglu.com/failwhale/images/failwhale.gif\" alt=\"fail whale image\" width=\"800\" height=\"432\" /></p><hr /><h3>Xebra Module for Apache (Win)</h3></body></html>"

#define PRINT_ERROR(a) ap_rputs (ERROR_MSG_START, r); ap_rputs (a, r); ap_rputs (ERROR_MSG_END, r);


/*======= END  =======*/

/* Registers the module within apache */
module AP_MODULE_DECLARE_DATA xebra_module;

/* Struct that contains config parameters read from httpd.conf */
typedef struct
{
	char * port;
	char * host;
} xebra_svr_cfg;

/*
doc:    <routine name="create_srv_cfg" export="private">
doc:           <summary>Creates a default server config</summary>
doc:			<return>The xebra_svr_cfg</return>
doc:    </routine>
*/
static void* create_srv_cfg (apr_pool_t* pool, char* x);

/*
doc:    <routine name="set_srv_cfg_port" export="private">
doc:           <summary>Sets the port attribute to the xebra_svr_cfg instance</summary>
doc:			<return>NULL</return>
doc:    </routine>
*/
static const char *set_srv_cfg_port (cmd_parms *parms, void *mconfig,
									 const char *arg);

/*
doc:    <routine name="set_srv_cfg_host" export="private">
doc:            <summary>Sets the host attribute to the xebra_svr_cfg instance</summary>
doc:			 <return>NULL</return>
doc:    </routine>
*/
static const char *set_srv_cfg_host (cmd_parms *parms, void *mconfig,
									 const char *arg);

/*
doc:    <function name="read_from_POST" export="private">
doc:            <summary>Reads POST values and appends them to the buffer</summary>
doc:            <param name="r" type="request_rec*>The request</param>
doc:            <param name="buf" type="char**>A buffer to write the keys and values</param>
doc:			 <return>Returns an apache RESPONSE_CODE</return>
doc:    </routine>
*/
static int read_from_POST (request_rec* r, char **buf);

/*
doc:	<attribute name="table_buf" return_type="char*" export="private">
doc:		<summary>Print_item uses this to store post parameter values and keys </summary>
doc:	</attribute>
*/
char *table_buf;

/*
doc:    <routine name="print_item" export="private">
doc:            <summary>Callback function to be used with apr_table_do to process a table item. Appends all items to table_buf </summary>
doc:            <param name="rec" type="request_rec*>The request</param>
doc:            <param name="key" type="const char*>A key value from the table</param>
doc:            <param name="value" type="const char*>A value value from the table</param>
doc:			 <return>Returns 1 if the iteration should stop and 0 otherwise</return>
doc:    </routine>
*/
static int print_item (void* rec, const char *key, const char *value);

/*
doc:    <routine name="xebra_handler" export="private">
doc:            <summary>This is the main method that handles the request</summary>
doc:            <param name="rec" type="request_rec*>The request</param>
doc: 			 <return>Returns an apache RESPONSE_CODE</return>
doc:    </routine>
*/
static int xebra_handler (request_rec* r);

/*
doc:    <routine name="byteArrayToInt" export="private">
doc:            <summary>Converts an array of 4 bytes to an integer.</summary>
doc:            <param name="b" type="char*">The bytes to convert</param>
doc: 			 <return>Returns the integer</return>
doc:    </routine>
*/
int byteArrayToInt (char * b);

/*
doc:    <routine name="intToByteArray" export="private">
doc:            <summary>Converts an integer to an array of 4 bytes. Make sure you free the return value later.</summary>
doc:            <param name="i" type="int">The integer to convert</param>
doc: 			 <return>Returns the byte array</return>
doc:    </routine>
*/

char * intToByteArray (request_rec *r, int i);

/*
doc:    <routine name="encode_natural" export="private">
doc:            <summary>Encode i to include the flag. Use decode_natural to extract the original integer value and use decode_flag to extract the flag. I must not be bigger than 2^31</summary>
doc:            <param name="i" type="unsigned int">The integer value to encode</param>
doc:            <param name="flag" type="int">The flag value to encode</param>
doc: 			 <return>Returns the encoded unsigned integer</return>
doc:    </routine>
*/
unsigned int encode_natural (unsigned int i, int flag);

/*
doc:    <routine name="decode_natural" export="private">
doc:            <summary>Decode i and return original integer value. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="unsigned int">The integer value to decode</param>
doc: 			 <return>Returns the decoded unsigned integer</return>
doc:    </routine>
*/
unsigned int decode_natural (unsigned int i);

/*
doc:    <routine name="decode_flag" export="private">
doc:            <summary>Decode i and return flag. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="unsigned int">The integer value to decode</param>
doc: 			 <return>Returns the decoded boolean flag</return>
doc:    </routine>
*/
int decode_flag (unsigned int i);

/*
doc:    <routine name="get_in_addr" export="private">
doc:            <summary>Get socket address</summary>
doc:            <param name="sa" type="struct sockaddr *">The address to write</param>
doc: 			 <return>Returns the address</return>
doc:    </routine>
*/
void* get_in_addr (struct sockaddr *sa);

/*
doc:    <routine name="send_message_fraged" export="private">
doc:            <summary>Devides the message into fragments of length FRAG_SIZE. For each fragment it encodes the size of it in an array of 4 bytes, sends these 4 bytes and then sends the fragment. The 4 byte array contains also a flag that determines if there will be another fragment coming up.</summary>
doc:            <param name="message" type="char *">The message to be sent</param>
doc:            <param name="sockfd" type="int">The socket connection id</param>
doc: 			 <return>Returns 1 on success and 0 otherwise</return>
doc:    </routine>
*/
int send_message_fraged (char * message, SOCKET sockfd,
						 request_rec* r);

/**
doc:    <routine name="receive_message_fraged" export="private">
doc:            <summary>Receives a message that was send by send_message_fraged. For every incoming fragment, it first reads the 4 byte array determining the length of the fragment and if there will be another fragment coming up, then it calls recv until the whole fragment has been received.</summary>
doc:            <param name="msg_buf" type="char **">The buffer where the message will be stored</param>
doc:            <param name="sockfd" type="int">The socket connection id</param>
doc: 			 <return>Returns 1 on success and 0 otherwise</return>
doc:    </routine>
*/
int receive_message_fraged (char **msg_buf, SOCKET sockfd,
							request_rec* r);

/**
doc:    <routine name="register_hooks" export="private">
doc:            <summary>Registers the method xebra_handler as a hook in the module</summary>
doc:            <param name="pool" type="apr_pool_t**">The apr memory pool</param> doc:
doc:    </routine>
*/
static void register_hooks (apr_pool_t* pool);

/**
* Write an RFC2109 compliant cookie.
*
* @param r The request
* @param name The name of the cookie.
* @param val The value to place in the cookie.
* @param attrs The string containing additional cookie attributes. If NULL, the
*              DEFAULT_ATTRS will be used.
* @param maxage If non zero, a Max-Age header will be added to the cookie.
* @param ... A varargs array of zero or more (apr_table_t *) tables followed by NULL
*            to which the cookies should be added.
*/
apr_status_t cookie_write (request_rec * r, const char *name, const char *val,
						   const char *attrs, long maxage, ...);

/**
* Write an RFC2965 compliant cookie.
*
* @param r The request
* @param name2 The name of the cookie.
* @param val The value to place in the cookie.
* @param attrs2 The string containing additional cookie attributes. If NULL, the
*               DEFAULT_ATTRS will be used.
* @param maxage If non zero, a Max-Age header will be added to the cookie.
* @param ... A varargs array of zero or more (apr_table_t *) tables followed by NULL
*            to which the cookies should be added.
*/
apr_status_t cookie_write2 (request_rec * r, const char *name2,
							const char *val, const char *attrs2, long maxage, ...);

/**
* Remove an RFC2109 compliant cookie.
*
* @param r The request
* @param name The name of the cookie.
* @param attrs The string containing additional cookie attributes. If NULL, the
*              CLEAR_ATTRS will be used.
* @param ... A varargs array of zero or more (apr_table_t *) tables followed by NULL
*            to which the cookies should be added.
*/
apr_status_t cookie_remove (request_rec * r, const char *name,
							const char *attrs, ...);

/**
* Remove an RFC2965 compliant cookie.
*
* @param r The request
* @param name2 The name of the cookie.
* @param attrs2 The string containing additional cookie attributes. If NULL, the
*               CLEAR_ATTRS will be used.
* @param ... A varargs array of zero or more (apr_table_t *) tables followed by NULL
*            to which the cookies should be added.
*/
apr_status_t cookie_remove2 (request_rec * r, const char *name2,
							 const char *attrs2, ...);

/* The array of command_rec structures is passed to the httpd core by this module to declare a new configuration directive. */
static const command_rec xebra_cmds[] = { AP_INIT_TAKE1 ("XebraServer_port",
														 set_srv_cfg_port, NULL, RSRC_CONF,
														 "Mod_xebra: use e.g. 'Port \"1234\"'"), AP_INIT_TAKE1 (
														 "XebraServer_host", set_srv_cfg_host, NULL, RSRC_CONF,
														 "Mod_xebra: use e.g. 'Host \"localhost\"'"), { NULL } };

