
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>


#include <sys/wait.h>
#include <signal.h>


#include "rt_assert.h"
#include "eif_eiffel.h"

#include <httpd.h>
#include <http_log.h>
#include <http_protocol.h>
#include <http_config.h>



/*======= Choose debug level here ======= */
#define DO_DEBUG
#define DO_DEBUG2


/*======= DEBUG MACRO ======= */
#ifdef DO_DEBUG
	#define DEBUG(...) ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, __VA_ARGS__);

	#ifdef DO_DEBUG2
		#define DEBUG2(...) ap_log_rerror (APLOG_MARK, APLOG_ERR, 0, r, __VA_ARGS__);
	#else
		#define DEBUG2(...)
	#endif
#else
	#define DEBUG(...)
	#define DEBUG2(...)
#endif



/*======= SOCKET CONSTANTS =======*/


#define FRAG_SIZE 65536
#define HOSTNAME  "localhost"
#define PORT "3490"

//#define HOSTNAME "firenze.ise"


/*
doc:    <routine name="byteArrayToInt" export="public">
doc:            <summary>Converts an array of 4 bytes to an integer.</summary>
doc:            <param name="b" type="char*">The bytes to convert</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_INTEGER_32 byteArrayToInt (char * b);

/*
doc:    <routine name="intToByteArray" export="public">
doc:            <summary>Converts an integer to an array of 4 bytes. Make sure you free the return value later.</summary>
doc:            <param name="i" type="EIF_INTEGER_32">The integer to convert</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/

char * intToByteArray (EIF_INTEGER_32 i);

/*
doc:    <routine name="encode_natural" export="public">
doc:            <summary>Encode i to include the flag. Use decode_natural to extract the original integer value and use decode_flag to extract the flag. I must not be bigger than 2^31</summary>
doc:            <param name="i" type="EIF_NATURAL_32">The integer value to encode</param>
doc:            <param name="flag" type="EIF_BOOLEAN">The flag value to encode</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_NATURAL_32 encode_natural (EIF_NATURAL_32 i, EIF_BOOLEAN flag);

/*
doc:    <routine name="decode_natural" export="public">
doc:            <summary>Decode i and return original integer value. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="EIF_NATURAL_32">The integer value to decode</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_NATURAL_32 decode_natural (EIF_NATURAL_32 i);

/*
doc:    <routine name="decode_flag" export="public">
doc:            <summary>Decode i and return flag. i should be encoded with encode_natural</summary>
doc:            <param name="i" type="EIF_NATURAL_32">The integer value to decode</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_BOOLEAN decode_flag (EIF_NATURAL_32 i);

/*
doc:    <routine name="get_in_addr" export="public">
doc:            <summary>Get socket address</summary>
doc:            <param name="sa" type="struct sockaddr *">The address to write</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
void* get_in_addr (struct sockaddr *sa);

/*
doc:    <routine name="send_message_fraged" export="public">
doc:            <summary>Devides the message into fragments of length FRAG_SIZE. For each fragment it encodes the size of it in an array of 4 bytes, sends these 4 bytes and then sends the fragment. The 4 byte array contains also a flag that determines if there will be another fragment coming up.</summary>
doc:            <param name="message" type="char *">The message to be sent</param>
doc:            <param name="sockfd" type="EIF_INTEGER_32">The socket connection id</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_INTEGER_32 send_message_fraged (char * message, EIF_INTEGER_32 sockfd, request_rec* r);

/*
doc:    <routine name="receive_message_fraged" export="public">
doc:            <summary>Receives a message that was send by send_message_fraged. For every incoming fragment, it first reads the 4 byte array determining the length of the fragment and if there will be another fragment coming up, then it calls recv until the whole fragment has been received.</summary>
doc:            <param name="msg_buf" type="char **">The buffer where the message will be stored</param>
doc:            <param name="sockfd" type="EIF_INTEGER_32">The socket connection id</param>
doc:            <thread_safety></thread_safety>
doc:            <synchronization></synchronization>
doc:    </routine>
*/
EIF_INTEGER_32 receive_message_fraged (char **msg_buf, EIF_INTEGER_32 sockfd, request_rec* r);
