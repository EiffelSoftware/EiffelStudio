/*

 #####    ####    ####    #####           ####    ####   #    #   ####    #####
 #    #  #    #  #          #            #    #  #    #  ##   #  #          #
 #    #  #    #   ####      #            #       #    #  # #  #   ####      #
 #####   #  # #       #     #            #       #    #  #  # #       #     #
 #   #   #   #   #    #     #            #    #  #    #  #   ##  #    #     #
 #    #   ### #   ####      #   #######   ####    ####   #    #   ####      #

	Constants shared with class REQUEST_CONST on the Eiffel side.
*/

#ifndef _rqst_const_h_
#define _rqst_const_h_

/* Out requests */
#define MOVE			9		/* Change active routine pointer */
#define BREAK			10		/* Add/delete breakpoint */
#define RESUME			11		/* Resume execution */
#define QUIT			12		/* Application must die immediately */
#define APPLICATION		14		/* Start up application (for ised) */

/* In requests */
#define APP_MSG			5
#define APP_BREAK		6
#define APP_EXECPT		7
#define APP_EXIT		8
#define APP_JOBSTATUS	9
#define IN_ADDRESS		0		/* Object at given address */
#define IN_LOCAL		1		/* Local variable by number */
#define IN_ARG			2		/* Argument by number */
#define IN_CURRENT		3		/* Current */
#define IN_RESULT		4		/* Result */


/* Internal constants */
#define OPAQUE			1		/* Opaque data request */
#define ACKNLGE			2		/* Acknowledgment (positive/negative) */
#define TRANSFER		3		/* Data transfer via daemon */
#define HELLO			4		/* Application's handshake with ewb */
#define STOPPED			5		/* Stop notification from app -> ewb */
#define INSPECT			6		/* Object inspection */
#define DUMP			7		/* A general stack dump request */
#define DUMPED			8		/* A dumped stack item */
#define CMD				13		/* Run a shell command (for ised) */
#define KPALIVE			15		/* Dummy request to keep connection alive */
#define ASYNCMD			16		/* Run command asynchronously */
#define ASYNACK			17		/* Status of the asynchronous job */

/* Acknowledgments codes */
#define AK_OK			0       /* Everything is ok */
#define AK_ERROR		1       /* General negative acknowledgment */

#define IN_RQST     (sizeof(Request))
#define OUT_RQST    (sizeof(Request))

#endif

